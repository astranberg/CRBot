$AndroidHWND = WinGetHandle("BlueStacks Android Plugin")

For $y = 745 To 755
	For $x = 1 to 500
		If PixelGetColor($x, $y, $AndroidHWND) = 8429748 Then
			ConsoleWrite('$x = ' & $x & '; ' & '$y = ' & $y & @CRLF)
		EndIf
	Next
Next

;--> For Gold Locked chest slots 1 and 2, color = 13997568
;~ $x = 60; $y = 750 = this is the original!
;------------------------------------------------difference in $x is 105
;~ $x = 165; $y = 751 = should we add a +/- 1 for y?
;~ $x = 146; $y = 753

;--> For Silver Locked chest slot 4, color = 8429748
;~ $x = 60; $y = 750 = this is the original!
;~ $x = 294; $y = 745
;~ $x = 451; $y = 745
;~ $x = 451; $y = 746
;~ $x = 436; $y = 748
;~ $x = 430; $y = 749
;~ $x = 436; $y = 749
;~ $x = 437; $y = 749
;~ $x = 437; $y = 750