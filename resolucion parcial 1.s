.data
cadena: .asciiz "3a?7eN"
digitos: .asciiz ""
cod_msg: .asciiz "cadena de reemplazos"
digi_msg: .ascii "cadena de digitos+1"
control: .word32 0x10000
data: .word32 0x10008
.code
daddi $a0, $zero, cadena
daddi $a1, $zero, digitos
jal procesar_cadena
lwu $a0, control($zero)
lwu $a1, data($zero)
daddi $a2, $zero, cadena
daddi $a3, $zero, cod_msg
jal imprimir
daddi $a2, $zero, digitos
daddi $a3, $zero, digi_msg
jal imprimir
halt
procesar_cadena: daddi $sp, $zero, 0x400
                 daddi $sp, $sp, -8
                 sd $ra, 0($sp)
           loop: lbu $a2, 0($a0)
                 beqz $a2, fin
                 dadd $s0, $a0, $zero
                 daddi $a0, $a0, 1
                 jal es_digito
                 beqz $v0, loop
                 jal obtener_digito
                 sb $v1, 0($s0)
                 sb $v1, 0($a1)
                 daddi $a1, $a1, 1
                 j loop
            fin: ld $ra, 0($sp)
                 daddi $sp, $sp, 8
                 jr $ra
es_digito: daddi $v0, $zero, 0
           slti $t0, $s2, 0x38
           beqz $t0, no_es
           slti $t0, $s2, 0x30
           bnez $t0, no_es
           daddi $v0, $v0, 1
    no_es: jr $ra
obtener_digito: daddi $v1, $a2, 1
                jr $ra
imprimir: daddi $t0, $zero, 4
          sd $a3, 0($a1)
          sb $t0, 0($a0)
          sd $a2, 0($a1)
          sb $t0, 0($a0)
          jr $ra
