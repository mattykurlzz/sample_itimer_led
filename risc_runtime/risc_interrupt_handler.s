.globl int_return

.set noat
.section ".textI", "ax"
Interrupt:

#---------------------------------------
# Macro: flush cache
#
    .macro FLUSH_CACHE
        li  $k0, 0xB82F4008
        lw  $k1, 0($k0)
        ori $k1, 0x5000
        sw  $k1, 0($k0)
        nop
        lw  $k1, 0($k0)
        nop
    .endm

#---------------------------------------
.section ".textI", "ax"

#---------------------------------------
# Macro: save all registers in stack
#
 .macro SAVE_REGS

# Сместить указатель стека на 32*4 байта вниз 
    addi       $sp, (-32*4)
# Сохранить в стеке регистры 1-25,28,30,31 
#.set noat #Warning if use AT-reg
    sw         $1,(0)($sp) #R1
    sw         $2,(4)($sp) #R2
    sw         $3,(8)($sp) #R3
    sw         $4,(12)($sp) #R4
    sw         $5,(16)($sp) #R5
    sw         $6,(20)($sp) #..
    sw         $7,(24)($sp)
    sw         $8,(28)($sp)
    sw         $9,(32)($sp)
    sw         $10,(36)($sp)
    sw         $11,(40)($sp)
    sw         $12,(44)($sp)
    sw         $13,(48)($sp)
    sw         $14,(52)($sp)
    sw         $15,(56)($sp)
    sw         $16,(60)($sp)
    sw         $17,(64)($sp)
    sw         $18,(68)($sp)
    sw         $19,(72)($sp)
    sw         $20,(76)($sp)
    sw         $21,(80)($sp)
    sw         $22,(84)($sp)
    sw         $23,(88)($sp)
    sw         $24,(92)($sp)
    sw         $25,(96)($sp)
# Skip $k0, $k1
  #  sw         $28,(100)($sp) #context GP
# Skip SP $sp
    sw         $30,(104)($sp)
    sw         $31,(108)($sp)
    .set at #Enable using AT-reg
# Save special registers
# Save HI
    mfhi    $k0
    sw      $k0, (116) ($sp)
    nop
# Save LO
    mflo    $k0
    sw      $k0, (112) ($sp)
    nop
# Save CO_EPC (exeption return addres)
  #  mfc0    $k1, $14
  #  sw      $k1, (124) ($sp)
  #  nop
# Save CO_Status
  #  mfc0    $k0, $12
  #  sw      $k0, (120) ($sp)
  #  nop
 .endm

# Exception vector at 0x....0180
#.org    0x0180


        FLUSH_CACHE
        mfc0    $k0, $13          # Get CAUSE
        nop
        andi    $k0, 0x0000007c   # Extract exception code
        li      $k1, (8 << 2)           # Is it syscall?
        bne     $k1, $k0, exception     # No - jump to handler.
        nop                             # (delay slot)
        #SYSCALL HANDLER START

        mfc0    $k0, $14                # Get EPC
        nop
        add     $k0, 4                  # Return to next instruction
        mtc0    $k0, $14                # Put EPC back

        #
        # Инструкция SYSCALL: чтение регистра STATUS и запрет прерываний.
        #
        mfc0    $a0, $12         	# Get Status
        nop
        li      $k0, -1 - 0x1         	# Prepare bitmask
        and     $k0, $a0                # Clear IE bit
        mtc0    $k0, $12         	# Put SR back
        xori    $a0, 0x2             	# Clear EXL for user

        # Return from exception
        .set mips3
        sync                            # Settle things down
        eret                            # PC <= EPC; EXL <= 0
        nop                             # just to be safe
        mfc0  $k1,  $14                 # save epc in gp 27
        and     $k0, $a0                # Set IE bit?
        mtc0    $k0, $12                # Put back
        nop
        jr    $k1                       # go continue TODO SYSCALL Heandler
        nop
        .set mips0
        #SYSCALL HANDLER END

exception:
	# li      $k1, 0x0                 # Is it interrupt?
	# bne     $k1, $k0, fault_exeption # No - jump to handler

    SAVE_REGS                            # Save all registers in stack

    move    $a0, $sp                     # Arg0: pointer to saved state
    lui     $gp, 0xb800                  # Set global pointer #0x9800 -CRAM
    la      $k0, risc_common_handler             # exception code can be far away from internal memory
    jalr      $k0                        # Jump to C code, no return
    nop
    j       _restore_regs_
    nop

_restore_regs_:
        lw      $k0, (112) ($sp)         # Load HI, LO registers
        mtlo    $k0
        lw      $k1, (116) ($sp)
        mthi    $k1

    #    lw      $k0, (124) ($sp)         #
    #    mtc0    $k0, $14                 # put PC in EPC

        .set    noat
        lw  $1, (0) ($sp)                # Load general registers
        lw  $2, (4) ($sp)
        lw  $3, (8) ($sp)
        lw  $4, (12) ($sp)
        lw  $5, (16) ($sp)
        lw  $6, (20) ($sp)
        lw  $7, (24) ($sp)
        lw  $8, (28) ($sp)
        lw  $9, (32) ($sp)
        lw  $10, (36) ($sp)
        lw  $11, (40) ($sp)
        lw  $12, (44) ($sp)
        lw  $13, (48) ($sp)
        lw  $14, (52) ($sp)
        lw  $15, (56) ($sp)
        lw  $16, (60) ($sp)
        lw  $17, (64) ($sp)
        lw  $18, (68) ($sp)
        lw  $19, (72) ($sp)
        lw  $20, (76) ($sp)
        lw  $21, (80) ($sp)
        lw  $22, (84) ($sp)
        lw  $23, (88) ($sp)
        lw  $24, (92) ($sp)
        lw  $25, (96) ($sp)
        # Skip $26 - K0
        # Skip $27 - K1
        lw  $28, (100) ($sp)
        # Skip $29 - SP
        lw  $30, (104) ($sp)
        lw  $31, (108) ($sp)
        .set    at

       # mfc0    $k0, $12               # Get STATUS
       # li      $k1, -1 - 0x1          # Prepare bitmask
       # and     $k0, $k1               # Clear IE bit
       # ori     $k0, 0x2               # Prevent interrupts until eret
       # lw      $k1, (120) ($sp)       # K0 = saved status, only IE bit
       # andi    $k1, 0x1               # Restore only IE bit
       # or      $k0, $k1               # Add saved IE bit
       # mtc0    $k0, $12               # put SR back
       # nop
        nop

        addi    $sp, 32*4              # Deallocate saved context

        # Return from exception
        .set mips3
        sync                            # settle things down
        eret                            # PC <= EPC; EXL <= 0
        nop                             # just to be safe
        mfc0    $k1,  $14                 # save epc in gp 27
        mfc0    $k0, $12                # Get STATUS
        xori    $k0, 0x2                # allow interupts after eret
        mtc0    $k0, $12                # Put SR back
        nop
        j    $k1                        #go continue
        nop
        .set mips0

