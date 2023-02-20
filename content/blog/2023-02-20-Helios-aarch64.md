---
title: Porting Helios to aarch64 for my FOSDEM talk, part one
date: 2023-02-20
---

[Helios] is a microkernel written in the [Hare] programming language, and the
subject of a talk I did at FOSDEM earlier this month. You can watch the talk
here if you like:

[Helios]: https://sr.ht/~sircmpwn/helios
[Hare]: https://harelang.org

<iframe title="FOSDEM 2023: Introducing the Helios microkernel" src="https://spacepub.space/videos/embed/f6435a6c-34e0-4602-ad5d-f791643111ab" allowfullscreen="" sandbox="allow-same-origin allow-scripts allow-popups" width="560" height="315" frameborder="0"></iframe>

A while ago I promised someone that I would not do any talks on Helios until I
could present them from Helios itself, and at FOSDEM I made good on that
promise: my talk was presented from a Raspberry Pi 4 running Helios. The kernel
was originally designed for x86\_64 (though we were careful to avoid painting
ourselves into any corners so that we could port it to more architectures later
on), and I initially planned to write an Intel HD Graphics driver so that I
could drive the projector from my laptop. But, after a few days spent trying to
comprehend the IHD manuals, I decided it would be *much* easier to port the
entire system to aarch64 and write a driver for the much-simpler RPi GPU
instead. 42 days later the port was complete, and a week or so after that I
successfully presented the talk at FOSDEM. In a series of blog posts, I will
take a look at those 42 days of work and explain how the aarch64 port works.
Today's post focuses on the bootloader.

The Helios boot-up process is:

1. Bootloader starts up and loads the kernel, then jumps to it
2. The kernel configures the system and loads the init process
3. Kernel provides runtime services to init (and any subsequent processes)

In theory, the port to aarch64 would address these steps in order, but in
practice step (2) relies heavily on the runtime services provided by step (3),
so much of the work was ordered 1, 3, 2. This blog post focuses on part 1, I'll
cover parts 2 and 3 and all of the fun problems they caused in later posts.

In any case, the bootloader was the first step. Some basic changes to the build
system established boot/+aarch64 as the aarch64 bootloader, and a simple
qemu-specific ARM kernel was prepared which just gave a little "hello world" to
demonstrate the multi-arch build system was working as intended. More build
system refinements would come later, but it's off to the races from here.
Targeting qemu's aarch64 virt platform was useful for most of the initial
debugging and bring-up (and is generally useful at all times, as a much easier
platform to debug than real hardware); the first tests on real hardware came
much later.

Booting up is a sore point on most systems. It involves a lot of arch-specific
procedures, but also generally calls for custom binary formats and annoying
things like disk drivers &mdash; which don't belong in a microkernel. So the
Helios bootloaders are separated from the kernel proper, which is a simple ELF
executable. The bootloader loads this ELF file into memory, configures a few
simple things, then passes some information along to the kernel entry point. The
bootloader's memory and other resources are hereafter abandoned and are later
reclaimed for general use.

On aarch64 the boot story is pretty abysmal, and I wanted to avoid adding the
SoC-specific complexity which is endemic to the platform. Thus, two solutions
are called for: [EFI] and [device trees]. At the bootloader level, EFI is the
more important concern. For qemu-virt and Raspberry Pi, [edk2] is the
free-software implementation of choice when it comes to EFI. The first order of
business is producing an executable which can be loaded by EFI, which is, rather
unfortunately, based on the Windows [COFF/PE32+] format. I took inspiration from
Linux and made an disgusting EFI stub solution, which involves hand-writing a
PE32+ header in assembly and doing some truly horrifying things with binutils to
massage everything into order. Much of the header is lifted from Linux:

[EFI]: https://uefi.org/specifications
[device trees]: https://www.devicetree.org/specifications/
[edk2]: https://github.com/tianocore/edk2
[COFF/PE32+]: https://learn.microsoft.com/en-us/windows/win32/debug/pe-format

```
.section .text.head
.global base
base:
.L_head:
	/* DOS header */
	.ascii "MZ"
	.skip 58
	.short .Lpe_header - .L_head
	.align 4
.Lpe_header:
	.ascii "PE\0\0"
	.short 0xAA64                              /* Machine = AARCH64 */
	.short 2                                   /* NumberOfSections */
	.long 0                                    /* TimeDateStamp */
	.long 0                                    /* PointerToSymbolTable */
	.long 0                                    /* NumberOfSymbols */
	.short .Lsection_table - .Loptional_header /* SizeOfOptionalHeader */
	/* Characteristics:
	 * IMAGE_FILE_EXECUTABLE_IMAGE |
	 * IMAGE_FILE_LINE_NUMS_STRIPPED |
	 * IMAGE_FILE_DEBUG_STRIPPED */
	.short 0x206
.Loptional_header:
	.short 0x20b                     /* Magic = PE32+ (64-bit) */
	.byte 0x02                       /* MajorLinkerVersion */
	.byte 0x14                       /* MinorLinkerVersion */
	.long _data - .Lefi_header_end   /* SizeOfCode */
	.long __pecoff_data_size         /* SizeOfInitializedData */
	.long 0                          /* SizeOfUninitializedData */
	.long _start - .L_head           /* AddressOfEntryPoint */
	.long .Lefi_header_end - .L_head /* BaseOfCode */
.Lextra_header:
	.quad 0                          /* ImageBase */
	.long 4096                       /* SectionAlignment */
	.long 512                        /* FileAlignment */
	.short 0                         /* MajorOperatingSystemVersion */
	.short 0                         /* MinorOperatingSystemVersion */
	.short 0                         /* MajorImageVersion */
	.short 0                         /* MinorImageVersion */
	.short 0                         /* MajorSubsystemVersion */
	.short 0                         /* MinorSubsystemVersion */
	.long 0                          /* Reserved */

	.long _end - .L_head             /* SizeOfImage */

	.long .Lefi_header_end - .L_head /* SizeOfHeaders */
	.long 0                          /* CheckSum */
	.short 10                        /* Subsystem = EFI application */
	.short 0                         /* DLLCharacteristics */
	.quad 0                          /* SizeOfStackReserve */
	.quad 0                          /* SizeOfStackCommit */
	.quad 0                          /* SizeOfHeapReserve */
	.quad 0                          /* SizeOfHeapCommit */
	.long 0                          /* LoaderFlags */
	.long 6                          /* NumberOfRvaAndSizes */

	.quad 0 /* Export table */
	.quad 0 /* Import table */
	.quad 0 /* Resource table */
	.quad 0 /* Exception table */
	.quad 0 /* Certificate table */
	.quad 0 /* Base relocation table */

.Lsection_table:
	.ascii ".text\0\0\0"              /* Name */
	.long _etext - .Lefi_header_end   /* VirtualSize */
	.long .Lefi_header_end - .L_head  /* VirtualAddress */
	.long _etext - .Lefi_header_end   /* SizeOfRawData */
	.long .Lefi_header_end - .L_head  /* PointerToRawData */
	.long 0                           /* PointerToRelocations */
	.long 0                           /* PointerToLinenumbers */
	.short 0                          /* NumberOfRelocations */
	.short 0                          /* NumberOfLinenumbers */
	/* IMAGE_SCN_CNT_CODE | IMAGE_SCN_MEM_READ | IMAGE_SCN_MEM_EXECUTE */
	.long 0x60000020

	.ascii ".data\0\0\0"        /* Name */
	.long __pecoff_data_size    /* VirtualSize */
	.long _data - .L_head       /* VirtualAddress */
	.long __pecoff_data_rawsize /* SizeOfRawData */
	.long _data - .L_head       /* PointerToRawData */
	.long 0                     /* PointerToRelocations */
	.long 0                     /* PointerToLinenumbers */
	.short 0                    /* NumberOfRelocations */
	.short 0                    /* NumberOfLinenumbers */
	/* IMAGE_SCN_CNT_INITIALIZED_DATA | IMAGE_SCN_MEM_READ | IMAGE_SCN_MEM_WRITE */
	.long 0xc0000040

.balign 0x10000
.Lefi_header_end:

.global _start
_start:
	stp x0, x1, [sp, -16]!

	adrp x0, base
	add x0, x0, #:lo12:base
	adrp x1, _DYNAMIC
	add x1, x1, #:lo12:_DYNAMIC
	bl relocate
	cmp w0, #0
	bne 0f

	ldp x0, x1, [sp], 16

	b bmain

0:
	/* relocation failed */
	add sp, sp, -16
	ret
```

The specific details about how any of this works are complex and unpleasant,
I'll refer you to the spec if you're curious, and offer a general suggestion
that cargo-culting my work here would be a lot easier than understanding it
should you need to build something similar.[^1]

[^1]: A cursory review of this code while writing this blog post draws my
  attention to a few things that ought to be improved as well.

Note the entry point for later; we store two arguments from EFI (x0 and x1) on
the stack and eventually branch to bmain.

This file is assisted by the linker script:

```
ENTRY(_start)
OUTPUT_FORMAT(elf64-littleaarch64)

SECTIONS {
	/DISCARD/ : {
		*(.rel.reloc)
		*(.eh_frame)
		*(.note.GNU-stack)
		*(.interp)
		*(.dynsym .dynstr .hash .gnu.hash)
	}

	. = 0xffff800000000000;

	.text.head : {
		_head = .;
		KEEP(*(.text.head))
	}

	.text : ALIGN(64K) {
		_text = .;
		KEEP(*(.text))
		*(.text.*)
		. = ALIGN(16);
		*(.got)
	}

	. = ALIGN(64K);
	_etext = .;

	.dynamic : {
		*(.dynamic)
	}

	.data : ALIGN(64K) {
		_data = .;
		KEEP(*(.data))
		*(.data.*)

		/* Reserve page tables */
		. = ALIGN(4K);
		L0 = .;
		. += 512 * 8;
		L1_ident = .;
		. += 512 * 8;
		L1_devident = .;
		. += 512 * 8;
		L1_kernel = .;
		. += 512 * 8;
		L2_kernel = .;
		. += 512 * 8;
		L3_kernel = .;
		. += 512 * 8;
	}

	.rela.text : {
		*(.rela.text)
		*(.rela.text*)
	}
	.rela.dyn : {
		*(.rela.dyn)
	}
	.rela.plt : {
		*(.rela.plt)
	}
	.rela.got : {
		*(.rela.got)
	}
	.rela.data : {
		*(.rela.data)
		*(.rela.data*)
	}

	.pecoff_edata_padding : {
		BYTE(0);
		. = ALIGN(512);
	}
	__pecoff_data_rawsize = ABSOLUTE(. - _data);
	_edata = .;

	.bss : ALIGN(4K) {
		KEEP(*(.bss))
		*(.bss.*)
		*(.dynbss)
	}

	. = ALIGN(64K);
	__pecoff_data_size = ABSOLUTE(. - _data);
	_end = .;
}
```

Items of note here are the careful treatment of relocation sections
(cargo-culted from earlier work on RISC-V with Hare; not actually necessary as
qbe generates PIC for aarch64)[^2] and the extra symbols used to gather
information for the PE32+ header. Padding is also added in the required places,
and static aarch64 page tables are defined for later use.

[^2]: PIC stands for "position independent code". EFI can load executables at
  any location in memory and the code needs to be prepared to deal with that;
  PIC is the tool we use for this purpose.

This is built as a shared object, and the Makefile ~~mutilates~~ reformats the
resulting ELF file to produce a PE32+ executable:

```
$(BOOT)/bootaa64.so: $(BOOT_OBJS) $(BOOT)/link.ld
	$(LD) -Bsymbolic -shared --no-undefined \
		-T $(BOOT)/link.ld \
		$(BOOT_OBJS) \
		-o $@

$(BOOT)/bootaa64.efi: $(BOOT)/bootaa64.so
	$(OBJCOPY) -Obinary \
		-j .text.head -j .text -j .dynamic -j .data \
		-j .pecoff_edata_padding \
		-j .dynstr -j .dynsym \
		-j .rel -j .rel.* -j .rel* \
		-j .rela -j .rela.* -j .rela* \
		$< $@
```

With all of this mess sorted, and the PE32+ entry point branching to bmain, we
can finally enter some Hare code:

```
export fn bmain(
	image_handle: efi::HANDLE,
	systab: *efi::SYSTEM_TABLE,
) efi::STATUS = {
    // ...
};
```

Getting just this far took 3 full days of work.

Initially, the Hare code incorporated a lot of proof-of-concept work from Alexey
Yerin's "carrot" kernel prototype for RISC-V, which also booted via EFI.
Following the early bringing-up of the bootloader environment, this was
refactored into a more robust and general-purpose EFI support layer for Helios,
which will be applicable to future ports. You can review the EFI support
module's haredocs [here](https://mirror.drewdevault.com/efi.html). The purpose
of this module is to provide an idiomatic Hare-oriented interface to the EFI
boot services, which the bootloader makes use of mainly to read files from the
boot media and examine the system's memory map.

Let's take a look at the first few lines of bmain:

```
efi::init(image_handle, systab)!;

const eficons = eficons_init(systab);
log::setcons(&eficons);
log::printfln("Booting Helios aarch64 via EFI");

if (readel() == el::EL3) {
	log::printfln("Booting from EL3 is not supported");
	return efi::STATUS::LOAD_ERROR;
};

let mem = allocator { ... };
init_mmap(&mem);
init_pagetables();
```

Significant build system overhauls were required such that Hare modules from
the kernel like log (and, later, other modules like elf) could be incorporated
into the bootloader, simplifying the process of implementing more complex
bootloaders. The first call of note here is init\_mmap, which scans the EFI
memory map and prepares a simple high-watermark allocator to be used by the
bootloader to allocate memory for the kernel image and other items of interest.
It's quite simple, it just finds the largest area of general-purpose memory and
sets up an allocator with it:

```
// Loads the memory map from EFI and initializes a page allocator using the
// largest area of physical memory.
fn init_mmap(mem: *allocator) void = {
	const iter = efi::iter_mmap()!;
	let maxphys: uintptr = 0, maxpages = 0u64;
	for (true) {
		const desc = match (efi::mmap_next(&iter)) {
		case let desc: *efi::MEMORY_DESCRIPTOR =>
			yield desc;
		case void =>
			break;
		};
		if (desc.DescriptorType != efi::MEMORY_TYPE::CONVENTIONAL) {
			continue;
		};
		if (desc.NumberOfPages > maxpages) {
			maxphys = desc.PhysicalStart;
			maxpages = desc.NumberOfPages;
		};
	};
	assert(maxphys != 0, "No suitable memory area found for kernel loader");
	assert(maxpages <= types::UINT_MAX);
	pagealloc_init(mem, maxphys, maxpages: uint);
};
```

init\_pagetables is next. This populates the page tables reserved by the linker
with the desired higher-half memory map, illustrated in the comments shown here:

```
fn init_pagetables() void = {
	// 0xFFFF0000xxxxxxxx - 0xFFFF0200xxxxxxxx: identity map
	// 0xFFFF0200xxxxxxxx - 0xFFFF0400xxxxxxxx: identity map (dev)
	// 0xFFFF8000xxxxxxxx - 0xFFFF8000xxxxxxxx: kernel image
	//
	// L0[0x000]    => L1_ident
	// L0[0x004]    => L1_devident
	// L1_ident[*]  => 1 GiB identity mappings
	// L0[0x100]    => L1_kernel
	// L1_kernel[0] => L2_kernel
	// L2_kernel[0] => L3_kernel
	// L3_kernel[0] => 4 KiB kernel pages
	L0[0x000] = PT_TABLE | &L1_ident: uintptr | PT_AF;
	L0[0x004] = PT_TABLE | &L1_devident: uintptr | PT_AF;
	L0[0x100] = PT_TABLE | &L1_kernel: uintptr | PT_AF;
	L1_kernel[0] = PT_TABLE | &L2_kernel: uintptr | PT_AF;
	L2_kernel[0] = PT_TABLE | &L3_kernel: uintptr | PT_AF;
	for (let i = 0u64; i < len(L1_ident): u64; i += 1) {
		L1_ident[i] = PT_BLOCK | (i * 0x40000000): uintptr |
			PT_NORMAL | PT_AF | PT_ISM | PT_RW;
	};
	for (let i = 0u64; i < len(L1_devident): u64; i += 1) {
		L1_devident[i] = PT_BLOCK | (i * 0x40000000): uintptr |
			PT_DEVICE | PT_AF | PT_ISM | PT_RW;
	};
};
```

In short, we want three larger memory regions to be available: an identity map,
where physical memory addresses correlate 1:1 with virtual memory, an identity
map configured for device MMIO (e.g. with caching disabled), and an area to load
the kernel image. The first two are straightforward, they use uniform 1 GiB
mappings to populate their respective page tables. The latter is slightly more
complex, ultimately the kernel is loaded in 4 KiB pages so we need to set up
intermediate page tables for that purpose.

We cannot actually enable these page tables until we're finished making use of
the EFI boot services &mdash; the EFI specification requires us to preserve the
online memory map at this stage of affairs. However, this does lay the
groundwork for the kernel loader: we have an allocator to provide pages of
memory, and page tables to set up virtual memory mappings that can be activated
once we're done with EFI. bmain thus proceeds with loading the kernel:

```
const kernel = match (efi::open("\\helios", efi::FILE_MODE::READ)) {
case let file: *efi::FILE_PROTOCOL =>
	yield file;
case let err: efi::error =>
	log::printfln("Error: no kernel found at /helios");
	return err: efi::STATUS;
};

log::printfln("Load kernel /helios");
const kentry = match (load(&mem, kernel)) {
case let err: efi::error =>
	return err: efi::STATUS;
case let entry: uintptr =>
	yield entry: *kentry;
};
efi::close(kernel)!;
```

The loader itself (the "load" function here) is a relatively straightforward ELF
loader; if you've seen one you've seen them all. Nevertheless, you may browse it
[online][0] if you so wish. The only item of note here is the function used for
mapping kernel pages:

[0]: https://git.sr.ht/~sircmpwn/helios/tree/02d0490487c7a0fb4b0367b95819e808b98f87fb/item/boot/%2Baarch64/loader.ha

```
// Maps a physical page into the kernel's virtual address space.
fn kmmap(virt: uintptr, phys: uintptr, flags: uintptr) void = {
	assert(virt & ~0x1ff000 == 0xffff800000000000: uintptr);
	const offs = (virt >> 12) & 0x1ff;
	L3_kernel[offs] = PT_PAGE | PT_NORMAL | PT_AF | PT_ISM | phys | flags;
};
```

The assertion enforces a constraint which is implemented by our kernel linker
script, namely that all loadable kernel program headers are located within the
kernel's reserved address space. With this constraint in place, the
implementation is simpler than many mmap implementations; we can assume that
L3\_kernel is the correct page table and just load it up with the desired
physical address and mapping flags.

Following the kernel loader, the bootloader addresses other items of interest,
such as loading the device tree and boot modules &mdash; which includes, for
instance, the init process image and an initramfs. It also allocates & populates
data structures with information which will be of later use to the kernel,
including the memory map. This code is relatively straightforward and not
particularly interesting; most of these processes takes advantage of the same
straightforward Hare function:

```
// Loads a file into continuous pages of memory and returns its physical
// address.
fn load_file(
	mem: *allocator,
	file: *efi::FILE_PROTOCOL,
) (uintptr | efi::error) = {
	const info = efi::file_info(file)?;
	const fsize = info.FileSize: size;
	let npage = fsize / PAGESIZE;
	if (fsize % PAGESIZE != 0) {
		npage += 1;
	};

	let base: uintptr = 0;
	for (let i = 0z; i < npage; i += 1) {
		const phys = pagealloc(mem);
		if (base == 0) {
			base = phys;
		};

		const nbyte = if ((i + 1) * PAGESIZE > fsize) {
			yield fsize % PAGESIZE;
		} else {
			yield PAGESIZE;
		};
		let dest = (phys: *[*]u8)[..nbyte];
		const n = efi::read(file, dest)?;
		assert(n == nbyte);
	};

	return base;
};
```

It is not necessary to map these into virtual memory anywhere, the kernel later
uses the identity-mapped physical memory region in the higher half to read
them. Tasks of interest resume at the end of bmain:

```
efi::exit_boot_services();
init_mmu();
enter_kernel(kentry, ctx);
```

Once we exit boot services, we are free to configure the MMU according to our
desired specifications and make good use of all of the work done earlier to
prepare a kernel memory map. Thus, init\_mmu:

```
// Initializes the ARM MMU to our desired specifications. This should take place
// *after* EFI boot services have exited because we're going to mess up the MMU
// configuration that it depends on.
fn init_mmu() void = {
	// Disable MMU
	const sctlr_el1 = rdsctlr_el1();
	wrsctlr_el1(sctlr_el1 & ~SCTLR_EL1_M);

	// Configure MAIR
	const mair: u64 =
		(0xFF << 0) | // Attr0: Normal memory; IWBWA, OWBWA, NTR
		(0x00 << 8);  // Attr1: Device memory; nGnRnE, OSH
	wrmair_el1(mair);

	const tsz: u64 = 64 - 48;
	const ips = rdtcr_el1() & TCR_EL1_IPS_MASK;
	const tcr_el1: u64 =
		TCR_EL1_IPS_42B_4T |	// 4 TiB IPS
		TCR_EL1_TG1_4K |	// Higher half: 4K granule size
		TCR_EL1_SH1_IS |	// Higher half: inner shareable
		TCR_EL1_ORGN1_WB |	// Higher half: outer write-back
		TCR_EL1_IRGN1_WB |	// Higher half: inner write-back
		(tsz << TCR_EL1_T1SZ) |	// Higher half: 48 bits
		TCR_EL1_TG0_4K |	// Lower half: 4K granule size
		TCR_EL1_SH0_IS |	// Lower half: inner sharable
		TCR_EL1_ORGN0_WB |	// Lower half: outer write-back
		TCR_EL1_IRGN0_WB |	// Lower half: inner write-back
		(tsz << TCR_EL1_T0SZ);	// Lower half: 48 bits
	wrtcr_el1(tcr_el1);

	// Load page tables
	wrttbr0_el1(&L0[0]: uintptr);
	wrttbr1_el1(&L0[0]: uintptr);
	invlall();

	// Enable MMU
	const sctlr_el1: u64 =
		SCTLR_EL1_M |		// Enable MMU
		SCTLR_EL1_C |		// Enable cache
		SCTLR_EL1_I |		// Enable instruction cache
		SCTLR_EL1_SPAN |	// SPAN?
		SCTLR_EL1_NTLSMD |	// NTLSMD?
		SCTLR_EL1_LSMAOE |	// LSMAOE?
		SCTLR_EL1_TSCXT |	// TSCXT?
		SCTLR_EL1_ITD;		// ITD?
	wrsctlr_el1(sctlr_el1);
};
```

There are a lot of bits here! Figuring out which ones to enable or disable was a
project in and of itself. One of the major challenges, funnily enough, was
finding the correct ARM manual to reference to understand all of these
registers. I'll save you some time and [link to it][1] directly, should you ever
find yourself writing similar code. Some question marks in comments towards the
end point out some flags that I'm still not sure about. The ARM CPU is *very*
configurable and identifying the configuration that produces the desired
behavior for a general-purpose kernel requires some effort.

[1]: https://mirror.drewdevault.com/ARMARM.pdf

After this function completes, the MMU is initialized and we are up and running
with the kernel memory map we prepared earlier; the kernel is loaded in the
higher half and the MMU is prepared to service it. So, we can jump to the kernel
via enter\_kernel:

```
@noreturn fn enter_kernel(entry: *kentry, ctx: *bootctx) void = {
	const el = readel();
	switch (el) {
	case el::EL0 =>
		abort("Bootloader running in EL0, breaks EFI invariant");
	case el::EL1 =>
		// Can boot immediately
		entry(ctx);
	case el::EL2 =>
		// Boot from EL2 => EL1
		//
		// This is the bare minimum necessary to get to EL1. Future
		// improvements might be called for here if anyone wants to
		// implement hardware virtualization on aarch64. Good luck to
		// this future hacker.

		// Enable EL1 access to the physical counter register
		const cnt = rdcnthctl_el2();
		wrcnthctl_el2(cnt | 0b11);

		// Enable aarch64 in EL1 & SWIO, disable most other EL2 things
		// Note: I bet someday I'll return to this line because of
		// Problems
		const hcr: u64 = (1 << 1) | (1 << 31);
		wrhcr_el2(hcr);

		// Set up SPSR for EL1
		// XXX: Magic constant I have not bothered to understand
		wrspsr_el2(0x3c4);

		enter_el1(ctx, entry);
	case el::EL3 =>
		// Not supported, tested earlier on
		abort("Unsupported boot configuration");
	};
};
```

Here we see the detritus from one of many battles I fought to port this kernel:
the EL2 => EL1 transition. aarch64 has several "exception levels", which are
semantically similar to the x86\_64 concept of protection rings. EL0 is used for
userspace code, which is not applicable under these circumstances; an assertion
sanity-checks this invariant. EL1 is the simplest case, this is used for normal
kernel code and in this situation we can jump directly to the kernel. The EL2
case is used for hypervisor code, and this presented me with a challenge. When I
tested my bootloader in qemu-virt, it worked initially, but on real hardware it
failed. After much wailing and gnashing of teeth, the cause was found to be that
our bootloader was started in EL2 on real hardware, and EL1 on qemu-virt. qemu
can be configured to boot in EL2, which was crucial in debugging this problem,
via -M virt,virtualization=on. From this environment I was able to identify a
few important steps to drop to EL1 and into the kernel, though from the comments
you can probably ascertain that this process was not well-understood. I do have
a better understanding of it now than I did when this code was written, but the
code is still serviceable and I see no reason to change it at this stage.

At this point, 14 days into the port, I successfully reached kmain on qemu-virt.
Some initial kernel porting work was done after this, but when I was prepared to
test it on real hardware I ran into this EL2 problem &mdash; the first kmain on
real hardware ran at T+18.

That sums it up for the aarch64 EFI bootloader work. 24 days later the kernel
and userspace ports would be complete, and a couple of weeks after that it was
running on stage at FOSDEM. The next post will cover the kernel port (maybe more
than one post will be required, we'll see), and the final post will address the
userspace port and the inner workings of the slidedeck demo that was shown on
stage. Look forward to it, and thanks for reading!
