.data
cad_msg: .asciiz "Cadena con reemplazos"
minu_msg: .asciiz "Letras convertidas a minuscula"
aa: .asciiz "Cadena <--enTRADa-->!!!"
bb: .asciiz ""
control: .word32 0x10000
data: .word32 0x10008
.code
daddi $a0, $zero, aa
daddi $a1, $zero, bb
jal procesos_cadena
lwu $a0, control($zero)
lwu $a1, data($zero)
daddi $a2, $zero, cad_msg
daddi $a3, $zero, aa
jal imprimir
daddi $a2, $zero, minu_msg
daddi $a3, $zero, bb
jal imprimir
halt

procesos_cadena: daddi $sp, $zero, 0x400
                 daddi $sp, $sp, -8
                 sd $ra, 0($sp)
           loop: lbu $a2, 0($a0)
                 beqz $a2, fin
                 dadd $s0, $zero, $a0
                 daddi $a0, $a0, 1
                 jal es_mayu
                 beqz $v0, loop
                 jal convertir_minu
                 sb $v0, 0($s0)
                 sb $v0, 0($a1)
                 daddi $a1, $a1, 1
                 j loop
            fin: ld $ra, 0($sp)
                 daddi $sp, $sp, 8
                 jr $ra
es_mayu: daddi $v0, $zero, 0
         slti $t0, $a2, 90
         beqz $t0, no_es
         slti $t0, $a2, 65
         bnez $t0, no_es
         daddi $v0, $v0, 1
  no_es: jr $ra

convertir_minu: daddi $v0, $a2, 32
                jr $ra

imprimir: daddi $t0, $zero, 4
          sd $a2, 0($a1)
          sd $t0, 0($a0)
          sd $a3, 0($a1)
          sd $t0, 0($a0)
          jr $ra
