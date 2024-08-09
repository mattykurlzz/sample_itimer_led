################################################################################
# Automatically-generated file. Do not edit!
################################################################################

-include ../makefile.init

RM := rm -f

# All of the sources participating in the build are defined here
-include sources.mk
-include risc_runtime/subdir.mk
-include subdir.mk
-include objects.mk

-include ../makefile.defs

# Add inputs and outputs from these tool invocations to the build variables 
OBJS_LINK_o0 += \
__DSP0__.o0 \

OBJS_DSP0 += \
__DSP0__.o \

OBJS_LINK_o1 += \
__DSP1__.o1 \

OBJS_DSP1 += \
__DSP1__.o \

OBJS_LINK_o2 += \
__DSP2__.o2 \

OBJS_DSP2 += \
__DSP2__.o \

OBJS_LINK_o3 += \
__DSP3__.o3 \

OBJS_DSP3 += \
__DSP3__.o \


# All Target
all: sample_itimer_led.elf

# Tool invocations
sample_itimer_led.elf: $(OBJS_RISC_o) $(OBJS_DSP0) $(OBJS_DSP1) $(OBJS_DSP2) $(OBJS_DSP3)
	@echo 'Building target: $@'
	@echo 'Invoking: MultiCore Linker - mipsel-elf32-gcc'
	"c:\\elvees\\MCStudio_MC-30SF6_2023.08_66"/ToolsMGCC/bin/mipsel-elf32-gcc -T Project.xl -Xlinker -Map=output.map -EL -mhard-float -o "sample_itimer_led.elf" $(OBJS_RISC_o) $(OBJS_DSP0) $(OBJS_DSP1) $(OBJS_DSP2) $(OBJS_DSP3) -lm -lc -lnosys -lgcc
	@echo 'Finished building target: $@'
	@echo ' '
	$(MAKE) --no-print-directory post-build

__DSP0__.o0: $(OBJS_ASM_x0)
	@echo 'Invoking: DSP0 Linker - elcore-elvis-elf-ld'
	"c:\\elvees\\MCStudio_MC-30SF6_2023.08_66"/ToolsDSP/bin/elcore-elvis-elf-ld -e 0 -t -N  --no-warn-mismatch -T  DSP0.xl __DSPX__.xx -o "__DSP0__.o0" $(OBJS_ASM_x0)
	@echo 'Finished building: $@'
	@echo ' '

__DSP0__.o: $(OBJS_LINK_o0)
	@echo 'Invoking: DSP0 Objcopy - elcopy'
	"c:\\elvees\\MCStudio_MC-30SF6_2023.08_66"/ToolsDSP/bin/elcopy -L xxx --strip-debug $(OBJS_LINK_o0)  "__DSP0__.o"
	@echo 'Finished building: $@'
	@echo ' '

__DSP1__.o1: $(OBJS_ASM_x1)
	@echo 'Invoking: DSP1 Linker - elcore-elvis-elf-ld'
	"c:\\elvees\\MCStudio_MC-30SF6_2023.08_66"/ToolsDSP/bin/elcore-elvis-elf-ld -e 0 -t -N  --no-warn-mismatch -T  DSP1.xl __DSPX__.xx -o "__DSP1__.o1" $(OBJS_ASM_x1)
	@echo 'Finished building: $@'
	@echo ' '

__DSP1__.o: $(OBJS_LINK_o1)
	@echo 'Invoking: DSP1 Objcopy - elcopy'
	"c:\\elvees\\MCStudio_MC-30SF6_2023.08_66"/ToolsDSP/bin/elcopy -L xxx --strip-debug $(OBJS_LINK_o1)  "__DSP1__.o"
	@echo 'Finished building: $@'
	@echo ' '

__DSP2__.o2: $(OBJS_ASM_x2)
	@echo 'Invoking: DSP2 Linker - elcore-elvis-elf-ld'
	"c:\\elvees\\MCStudio_MC-30SF6_2023.08_66"/ToolsDSP/bin/elcore-elvis-elf-ld -e 0 -t -N  --no-warn-mismatch -T DSP2.xl __DSPX__.xx -o "__DSP2__.o2" $(OBJS_ASM_x2)
	@echo 'Finished building: $@'
	@echo ' '

__DSP2__.o: $(OBJS_LINK_o2)
	@echo 'Invoking: DSP2 Objcopy - elcopy'
	"c:\\elvees\\MCStudio_MC-30SF6_2023.08_66"/ToolsDSP/bin/elcopy -L xxx --strip-debug $(OBJS_LINK_o2)  "__DSP2__.o"
	@echo 'Finished building: $@'
	@echo ' '

__DSP3__.o3: $(OBJS_ASM_x3)
	@echo 'Invoking: DSP3 Linker - elcore-elvis-elf-ld'
	"c:\\elvees\\MCStudio_MC-30SF6_2023.08_66"/ToolsDSP/bin/elcore-elvis-elf-ld -e 0 -t -N  --no-warn-mismatch -T DSP3.xl __DSPX__.xx -o "__DSP3__.o3" $(OBJS_ASM_x3)
	@echo 'Finished building: $@'
	@echo ' '

__DSP3__.o: $(OBJS_LINK_o3)
	@echo 'Invoking: DSP3 Objcopy - elcopy'
	"c:\\elvees\\MCStudio_MC-30SF6_2023.08_66"/ToolsDSP/bin/elcopy -L xxx --strip-debug $(OBJS_LINK_o3)  "__DSP3__.o"
	@echo 'Finished building: $@'
	@echo ' '

# Other Targets
clean:
	-$(RM) $(OBJS_ASM_x0)$(OBJS_DSP2)$(OBJS_DSP3)$(OBJS_DSP0)$(OBJS_DSP1)$(MULTICORE_LINKER_OUTPUT_OUTPUTS)$(OBJS_RISC_o)$(OBJS_LINK_o1)$(OBJS_LINK_o2)$(OBJS_LINK_o3)$(OBJS_ASM_x2)$(OBJS_ASM_x1)$(OBJS_ASM_x3)$(OBJS_LINK_o0) sample_itimer_led.elf
	-@echo ' '

post-build:
	-"c:\\elvees\\MCStudio_MC-30SF6_2023.08_66"/ToolsMGCC/bin/mipsel-elf32-readelf -S sample_itimer_led.elf; echo "Heap base:"; "c:\\elvees\\MCStudio_MC-30SF6_2023.08_66"/ToolsMGCC/bin/mipsel-elf32-readelf -s sample_itimer_led.elf | grep "_end" || true
	-@echo ' '

.PHONY: all clean dependents post-build

-include ../makefile.targets
