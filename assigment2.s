;******************************************************************************
; file: assignment2.s
; author: Basant Kumar, CS18M514
; Guide: Prof. Madhumutyam IITM, PACE
;*****************************************************************************/

@ BSS section
  .bss

@ DATA SECTION
  .data
data_items: .word 10, 4, 28, 100, 8, 0 ;0 is used to terminate the data
data_max: .word 0
data_min: .word 0
data_count: .word 0

@ TEXT section
  .text

.globl _main

_main:
  ldr r2, =data_items ;load addr of data_items in r2
  ldr r3, [r2]        ;read 1st element of data_items
  cmp r3, #0          ;if 1st element is zero then skip whole algorithm and update output with zero
  beq out
  mov r0, r3          ;hold min value
  mov r1, r3          ;hold max value
  mov r4, #1          ;hold count, init with 1 as already read 1st element
  b next              ;read next element to start comparision

checkmin:
  add r4, r4, #1
  cmp r0, r3          ;if r0 is greater than element of data_items
  BPL min             ;jump to label min if control bit N=0

checkmax:
  cmp r1, r3          ;if r1 is smaller than element of data_items
  BMI max             ;jump to label max if control bit N=1
  b   next            ;else goto next

min:
  mov r0, r3          ;update r0 with element to get min
  b checkmax

max:
  mov r1, r3          ;update r1 with element to get max

next:
  add r2, r2, #4      ;jump to addr of next element
  ldr r3, [r2]        ;load next element in r3
  cmp r3, #0          ;if r3 not equal to zero then jump to checkmin label
  bne checkmin

out:
  ldr r2, =data_min   ;store min value at data_min
  str r0, [r2]
  ldr r2, =data_max   ;store min value at data_max
  str r1, [r2]
  ldr r2, =data_count   ;store min value at data_count
  str r4, [r2]

.end
