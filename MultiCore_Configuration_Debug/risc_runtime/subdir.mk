################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_SRCS += \
../risc_runtime/risc_interrupt_handler.s 

C_SRCS += \
../risc_runtime/risc_cp0_timer.c \
../risc_runtime/risc_interrupt.c \
../risc_runtime/risc_timer.c \
../risc_runtime/system.c 

OBJS_RISC_o += \
./risc_runtime/risc_cp0_timer.o \
./risc_runtime/risc_interrupt.o \
./risc_runtime/risc_interrupt_handler.o \
./risc_runtime/risc_timer.o \
./risc_runtime/system.o 


# Each subdirectory must supply rules for building sources it contributes
risc_runtime/%.o: ../risc_runtime/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: RISC C Compiler - mipsel-elf32-gcc'
	"c:\\elvees\\MCStudio_MC-30SF6_2023.08_66"/ToolsMGCC/bin/mipsel-elf32-gcc -DLIB_ELCORE_SDK -DTARGET_MC30SF6 -O0 -g -gdwarf-2 -Wall -EL -mhard-float -DARCH_HAVE_FPU -Wa,-adhlns="$@.lst",-mfix-mc24r2 -c -fmessage-length=0 -G0 -mips32 -ffixed-k0 -ffixed-k1 -mno-check-zero-division -fno-delayed-branch -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

risc_runtime/%.o: ../risc_runtime/%.s
	@echo 'Building file: $<'
	@echo 'Invoking: RISC Assembler - mipsel-elf32-as'
	"c:\\elvees\\MCStudio_MC-30SF6_2023.08_66"/ToolsMGCC/bin/mipsel-elf32-as -G0 -mips32 -mfix-mc24r2 --defsym LIB_ELCORE_SDK=1 --defsym TARGET_MC30SF6=1 -EL -mhard-float -g --gdwarf-2 -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


