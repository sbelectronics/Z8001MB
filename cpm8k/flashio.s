!------------------------------------------------------------------------------
! flashio.s
!   Disk I/O subroutines 
!
!   Copyright(c) 2022 smbaker

	.include "biosdef.s"

    .extern	_sysseg,
	.extern puts, puthex16, putln

	.global	flashrd, flashwr

	unsegm
	sect	.text
	
!------------------------------------------------------------------------------
!  flashrd
!    One sector read
!    input  rr2 --- LBA
!	    r4  --- Buffer Address
!    destroys
!       r2  --- segment is shifted left 8 bits
!       r7  --- used as a counter
!       r4  --- set to system segment
!       r5  --- has the offset to the secbuf

flashrd:
    ! Diagnostics
	!pushl   @r15, rr4   ! save r4/r5
    !lda	    r4, rdlbamsg
	!call	puts
	!ld      r5, r2
	!call    puthex16
	!ld      r5, r3
	!call    puthex16
	!call    putln
	!popl    rr4, @r15   ! restore r4/r5

    slll    rr2, #9        ! Convert LBA addr to byte addr
 
    ! rr2 is now 000000ddd-dttttttt-ttsssss0-00000000

    add     r2, #0x40      ! Flash is at segment 40
    sll     r2, #8         ! Shift the segment into the uuper 8 bits
	ld      r7, #0x200     ! Transfer 0x200 bytes = 512 bytes = 4 sectors
	ld      r5, r4         ! Move destination offset to lower half of 32-bit reg
	ld      r4, _sysseg    ! Destination is in the system segment

	SEG
	ldirb   @r4,  @r2, r7  ! Transfer from flash to _sysseg:buffer
	NONSEG

	!pushl   @r15, rr4   ! save r4/r5
    !lda	    r4, rdretmsg
	!call	puts
	!popl    rr4, @r15   ! restore r4/r5

	ret
	
!------------------------------------------------------------------------------
!  flashwr
!    One sector write
!    input rr2 --- LBA
!	    r4 --- Buffer Address

flashwr:
    ! Figure out how to return an error... is this it?
	ldb	rl0, #1
	ret

!------------------------------------------------------------------------------
	sect	.rodata
rdlbamsg:
	.asciz	"Flash Read LBA "
rdretmsg:
	.asciz	"Flash Read return\r\n" 
