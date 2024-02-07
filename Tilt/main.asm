;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Assembly language file for Lab 2: Tilt
; Spring ECE:3360. The University of Iowa.
;
; PROJECT SPECIFICATIONS:
;	- Buzzer off and green LED on when tilt is closed
;   - Buzzer on and green LED off when tilt is  open
;   - PB3 is the output to the green LED
;   - PB4 is the output to the buzzer
;   - PB0 is the input from the tilt switch
;
; Rabi Alaya
; Alex Banning

.include "tn45def.inc"
.cseg
.org 0

; Configure pins using the Data Direction Register
more:
	sbi DDRB, 3 ; PB3 is output
	sbi DDRB, 4 ; PB4 is output
	cbi DDRB, 0 ; PB0 is input

; Main loop. 
	loop:
		sbi PORTB, 3 ; Set PB3 to High, meaning that the Green LED is ON
		sbis PINB, 0 ; Skip next if PB0 is high, meaning that the skip next if the switch is closed
		rcall alarm
		rjmp loop


	alarm:
		cbi PORTB, 3 ; Turn OFF Green LED
		rcall buzz
		ret

; Tilt switch is activated. Turn off LED and turn on buzzer.
	buzz:
		cbi PORTB, 4
		rcall delay
		sbi PORTB, 4
		rcall delay
		sbis PINB, 0 ; Skip next if PB0 is high, meaning that the switch is closed
		rjmp buzz
		ret
		
	
	delay:
  d1: ldi   r24, 3     ; r24 <-- Counter for upper loop 
  d2: ldi   r25,172     ; r25 <-- Counter for inner loop
      nop               ; no operation
	  nop
	  nop
  d3: dec   r25
      brne  d3 
      dec   r24
      brne  d2
      brne  d1
      ret

.exit
		



	