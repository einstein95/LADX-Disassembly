.POSIX:
.SUFFIXES:
.PRECIOUS: %.2bpp oam_%.2bpp
.PHONY: default build build-all test test-all all clean tidy

# Recursive `wildcard` function.
rwildcard = $(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

#
# Dev tools binaries and options
#

RGBDS   :=

2BPP    := $(RGBDS)rgbgfx
2BFLAGS := \
  --colors dmg \
  -Weverything

ASM     := $(RGBDS)rgbasm
ASFLAGS := \
  --export-all \
  -Weverything \
  -Wtruncation=1

LD      := $(RGBDS)rgblink
LDFLAGS := \
  -Weverything \
  -Wtruncation=1

FX      := $(RGBDS)rgbfix
FXFLAGS := \
  --ram-size 0x02 \
  --old-licensee 0x01 \
  --mbc-type 0x03 \
  --pad-value 0xFF \
  --validate \
  -Weverything

# Default target: build and test only the US 1.0 revision.
# (Use `make all` to build and test all targets.)
default: build test

#
# Generic rules
#

# Dependencies for the base version (English 1.0)
asm_files :=  $(call rwildcard,src,*.asm)
# this is the only .inc file in the repo
asm_files +=  src/constants/hardware.inc
gfx_files :=  $(call rwildcard,src/gfx,*.png)
bin_files :=  $(wildcard src/data/backgrounds/*.tilemap.encoded)
bin_files +=  $(wildcard src/data/backgrounds/*.attrmap.encoded)

# Compile an PNG file for OAM memory to a 2BPP file
# (inverting the palette and de-interleaving the tiles).
oam_%.2bpp: oam_%.png
	tools/gfx/gfx.py --invert --interleave --out $@ 2bpp $<

# Compile a PNG file to a 2BPP file, without any special conversion.
# (This uses `rgbgfx`, which is much faster than `tools/gfx/gfx.py`.)
%.2bpp: %.png
	$(2BPP) $(2BFLAGS) -o $@ $<

# Compile all dependencies (ASM, 2BPP) into an single object file.
# (This means all the source code is always fully recompiled: for now,
# we don't compile the different ASM files separately.)
# Locale-specific rules below (e.g. `src/main.azlj.o`) will add their own
# pre-requisites to the ones defined by this rule.
src/main.%.o: src/main.asm $(asm_files) $(gfx_files:.png=.2bpp) $(bin_files)
	$(ASM) $(ASFLAGS) $($*_ASFLAGS) -I src/ -o $@ $<

# Link object files into a GB executable rom
# The arguments used are both the global options (e.g. `LDFLAGS`) and the
# locale-specific options (e.g. `azlg-r1_LDFLAGS`).
%.gb: src/main.%.o
	$(LD) $(LDFLAGS) $($*_LDFLAGS) -n $*.sym -o $@ $^
	$(FX) $(FXFLAGS) $($*_FXFLAGS) $@

# Make may attempt to re-generate the Makefile; prevent this.
Makefile: ;
#
# English
#

games += azle.gb
src/main.azle.o:
azle_ASFLAGS = -DLANG=EN -DVERSION=0
azle_FXFLAGS = --rom-version 0 --non-japanese --title "ZELDA"

#
# Main targets
#

# By default, build the US 1.0 revision.
build: azle.gb

# Test the default revision.
test: build
# 	@tools/compare.sh ladx.md5 azle.gb

all: build-all test-all

tidy:
	rm -f $(games)
	rm -f $(games:%.gb=src/main.%.o)
	rm -f $(games:.gb=.map)
	rm -f $(games:.gb=.sym)

clean: tidy
	rm -f $(gfx_files:.png=.2bpp)
	rm -f $(azlj_gfx:.png=.2bpp)
	rm -f $(azlg_gfx:.png=.2bpp)
	rm -f $(azlf_gfx:.png=.2bpp)

### Debug Print ###

print-% : ; $(info $* is a $(flavor $*) variable set to [$($*)]) @true
