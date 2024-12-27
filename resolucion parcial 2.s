.data
pos_x: .word 7
pos_y: .word 7
gano: .asciiz "Ganaste"
salio: .asciiz "Perdiste"
no_llego: .asciiz "Te quedaste sin movimientos"
control: .word32 0x10000
data: .word32 0x10008
.code
lwu $s6, pos_y($zero)
lwu $s5, pos_x($zero)
lwu $s2, control($zero)
lwu $s3, data($zero)
sd $a0, 4($s3)
sd $a1, 5($s3)
daddi $s4, $zero, 5
sd $s4, 0($s2)
daddi $a0, $zero, 15
daddi $a1, $zero, 5
daddi $s0, $zero, 1
loop: slti $t0, $s0, 15
      beqz $t0, fin
      daddi $s1, $zero, 8
      sd $s1, 0($s2)
      ld $a2, 0($s3)
      jal mover
      daddi $s0, $s0, 1
      dadd $a0, $zero, $v0
      dadd $a1, $zero, $v1
      jal check
      beqz $v2, fin3
      sd $v0, 4($s3)
      sd $v1, 5($s3)
      sd $s4, 0($s2)
      beq $v0, $s6, si
      j loop
  si: beq $v1, $s5, fin2
      j loop
 fin: daddi $t1, $zero, 4
      daddi $t2, $zero, no_llego
      sd $t2, 0($s3)
      sd $t1, 0($s2)
      halt
fin3: daddi $t1, $zero, 4
       daddi $t2, $zero, salio
       sd $t2, 0($s3)
       sd $t1, 0($s2)
       halt
fin2: daddi $t1, $zero, 4
       daddi $t2, $zero, gano
       sd $t2, 0($s3)
       sd $t1, 0($s2)
       halt
mover: daddi $t0, $zero, 98
       beq $a2, $t0, esa
       daddi $t0, $zero, 101
       beq $a2, $t0, esd
       daddi $t0, $zero, 118
       beq $a2, $t0, esu
 esa: daddi $v0, $s0, 1
       dadd $v1, $v1, $zero
       jr $ra
 esd: daddi $v0, $s0, -1
       dadd $v1, $v1, $zero
       jr $ra
 esu: daddi $v0, $s0, 1
       daddi $v1, $s1, 1
       jr $ra
check: daddi $v2, $zero, 0
       slti $t0, $a0, 50
       beqz $t0, finr
       slti $t0, $a0, 0
       bnez $t0, finr
       slti $t0, $a1, 50
       beqz $t0, finr
       slti $t0, $a1, 0
       bnez $t0, finr
       daddi $v2, $v2, 1
finr: jr $ra
