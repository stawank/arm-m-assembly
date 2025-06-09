/* Linker Script */
/*
This script tells linker to put sections defined in aseembly
to populate at specific memory locations
*/
MEMORY{
    MEM : ORIGIN = 0x00, LENGTH = 0x4000
    /*The LENGTH ideally should be the size that the board supports
     randomyl chosen 16Kb*/
}
/*
Typical sections
text
bss
data
*/
SECTIONS{
    .text : {
        *(.vectors*)
        *(.text*)
    }   > MEM
}