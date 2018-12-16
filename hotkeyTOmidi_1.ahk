
/* 
; Last edited 12/15/2018 4:38 PM by genmce
adding comments for clarity
speeding up timer for faster move
; ===============need to revise to use sendcc method instead of midioutshort message for clarity

	1st method for generating CC's from keystroke.

	All the code to generate the hotkey, besides the midioutshort function (located in Midi_In_Out_Library.ahk), is contained within each hotkey definition.	
	
	While this method is easy to use, and reproduce more controls with, 
	I think more flexibility as well as simultanous controls are possible with the second method (see other file hotkeyTOmidi_2.ahk)
	Choose yours and test out the merits yourself.
	
	The example below will generate volume cc#7,  
	CC# 7 will decrease when F7 key is pressed  unitl 0 is reached
	CC#7 will increase when F8 is pressed until 127 is reached

*/

;*************************************************
;* 			HOTKEY TO MIDI GENERATION 
;*		1st method - easiest to replicate
;*************************************************

f7::	; hotkey subtracting CC  (data byte 2) value.
Loop	; loop to detect the state of the hotkey, held down.	
{
	if !GetKeyState("f7","P") 	; if key is not down, or, if key is released   
	  break						; break out of the loop and do nothing else.
    cc_num = 7 				; What CC (data byte1) do you wish to send?
    CCIntVal := CCIntVal > 0 ? CCIntVal-1 : 0          ;Subtract 1 from byte 2 until min value of 0 is reached.
   ; stb := "CC"
	;	statusbyte := 176
	;	chan = %channel%
	;	byte1 = %cc_num%			; set value of the byte1 to the above cc_num for display on the midi out window (only needed if you want to see output)	
	;	byte2 = %CCIntVal%			; see above for display of the value of the cc
	gosub, SendCC
	;midiOutShortMsg(h_midiout, (Channel+175), CC_num, CCIntVal) 	; Send midi output (h_midiout=port, (channel+CC statusbyte), CC_num=2lines up, CCIntVal) function located in Midi_In_Out_Library.ahk
		; =============== below is only needed MidiMonitor output gui display only
		;stb := "CC"
		;statusbyte := 176
		;chan = %channel%
		;byte1 = %cc_num%			; set value of the byte1 to the above cc_num for display on the midi out window (only needed if you want to see output)	
		;byte2 = %CCIntVal%			; see above for display of the value of the cc
		;gosub, ShowMidiOutMessage   ; run the display label to show the midi output
		; =============== end 		
    sleep, 20         				; adjust this for speed 20ms is fast
   
}
Return


f8:: 	; hotkey adding CC (data byte 2 ) value 
Loop 	; loop to detect the state of the hotkey, held down.
{
    if !GetKeyState("f8","P") 	; if key is not down, or, if key is released    
      break						; break out of the loop and do nothing else.	
    cc_num = 7 					; What CC (data byte 1) do you wish to send?
	CCIntVal := CCIntVal < 127 ? CCIntVal+1 : 127   ; Add 1 to data byte 2 until  max value 127, reached.
	gosub, SendCC
	;midiOutShortMsg(h_midiout, (Channel+175), CCnum, CCIntVal)    ; midiport, cc = 176, CCmod is var above, CCIntVal in vars above
		; =============== needed for output gui display only
		stb := "CC"
		statusbyte := 176
		chan = %channel%
		byte1 = %cc_num%			; set value of the byte1 to the above cc_num for display on the midi out window (only needed if you want to see output)	
		byte2 = %CCIntVal%			; see above for display of the value of the cc
		gosub, ShowMidiOutMessage   ; run the display label to show the midi output
		; =============== end   
   Sleep, 20                                         
   
}
Return
