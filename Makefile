LCC=$(GBDK_HOME)/bin/lcc

TARGETS=gb gbc pocket megaduck # sms gg

# https://gbdk-2020.github.io/gbdk-2020/docs/api/docs_toolchain_settings.html
LCCFLAGS_gb     = -Wl-yt0x1B -Wm-yc -Wm-ys -Wm-yj # Set an MBC for banking
LCCFLAGS_gbc    = -Wl-yt0x1B -Wm-yc -Wm-ys -Wm-yj # Same as .gb with: -Wm-yc (gb & gbc) or Wm-yC (gbc exclusive)
LCCFLAGS_pocket = -Wl-yt0x1B # Usually the same as required for .gb
LCCFLAGS_duck   = -Wl-yt0x1B # Usually the same as required for .gb
LCCFLAGS_sms    =
LCCFLAGS_gg     =

LCCFLAGS += $(LCCFLAGS_$(EXT)) # This adds the current platform specific LCC Flags
LCCFLAGS += -Wm-yn"HEIRSOFNYX"
LCCFLAGS += -Wm-yo2 # simple 32KB (2 x 16KB ROM banks) game
LCCFLAGS += -Wm-ya1 # 1 RAM bank for saving
LCCFLAGS += -Wm-yp0x014C=0x00 # rom mask version $00
LCCFLAGS += -Wf--opt-code-size -Wf-SO3 -Wf--max-allocs-per-node200000 -Wf--peep-asm -Wf--peep-return # Optimization flags
LCCFLAGS += -Wl-l"res/hUGEDriver.lib" # hugedriver library for music

# Debugging flags
LCCFLAGS += -Wl-j # Creates .map files
LCCFLAGS += -v # Uncomment for lcc verbose output
# LCCFLAGS += -debug # Uncomment to enable debug output

# You can set the name of the ROM file here
PROJECTNAME = Heirs\ of\ Nyx

# EXT?   = gb # Only sets extension to default (game boy .gb) if not populated
SRCDIR = src
OBJDIR = .obj/$(EXT)
RESDIR = res
BINDIR = build/$(EXT)
MKDIRS = $(OBJDIR) $(BINDIR) # See bottom of Makefile for directory auto-creation

BINS       = $(OBJDIR)/$(PROJECTNAME).$(EXT)
CSOURCES   = $(foreach dir,$(SRCDIR),$(notdir $(wildcard $(dir)/*.c))) $(foreach dir,$(RESDIR),$(notdir $(wildcard $(dir)/*.c)))
ASMSOURCES = $(foreach dir,$(SRCDIR),$(notdir $(wildcard $(dir)/*.s)))
OBJS       = $(CSOURCES:%.c=$(OBJDIR)/%.o) $(ASMSOURCES:%.s=$(OBJDIR)/%.o)

# Builds all targets sequentially
all: $(TARGETS)

# Compile .c files in "src/" to .o object files
$(OBJDIR)/%.o:	$(SRCDIR)/%.c
	$(LCC) $(CFLAGS) -c -o $@ $<

# Compile .c files in "res/" to .o object files
$(OBJDIR)/%.o:	$(RESDIR)/%.c
	$(LCC) $(CFLAGS) -c -o $@ $<

# Compile .s assembly files in "src/" to .o object files
$(OBJDIR)/%.o:	$(SRCDIR)/%.s
	$(LCC) $(CFLAGS) -c -o $@ $<

# If needed, compile .c files in "src/" to .s assembly files
# (not required if .c is compiled directly to .o)
$(OBJDIR)/%.s:	$(SRCDIR)/%.c
	$(LCC) $(CFLAGS) -S -o $@ $<

# Link the compiled object files into a ROM file
$(BINS):	$(OBJS)
	$(LCC) $(LCCFLAGS) $(CFLAGS) -o $(BINDIR)/$(PROJECTNAME).$(EXT) $(OBJS)

clean:
	@echo Cleaning
	@for target in $(TARGETS); do \
		$(MAKE) $$target-clean; \
	done
	rm -rf .obj

# Include available build targets
include Makefile.targets

# create necessary directories after Makefile is parsed but before build
# info prevents the command from being pasted into the makefile
ifneq ($(strip $(EXT)),) # Only make the directories if EXT has been set by a target
$(info $(shell mkdir -p $(MKDIRS)))
endif
