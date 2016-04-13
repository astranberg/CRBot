;--------------
;This is used in finding pixels for the various cards while in-game vs. trainer
;-Add results to $pixel_cards in CRBot.au3
;--------------
;--> Get card positions
Global $card1x = 150
Global $card1y = 800
Global $card2x = 250
Global $card2y = 800
Global $card3x = 350
Global $card3y = 800
Global $card4x = 450
Global $card4y = 800

	$AndroidHWND = WinGetHandle("BlueStacks Android Plugin")
		ConsoleWrite('Card 1 pixel color: ' & PixelGetColor($card1x, $card1y) & @CRLF)
		ConsoleWrite('Card 2 pixel color: ' & PixelGetColor($card2x, $card2y) & @CRLF)
		ConsoleWrite('Card 3 pixel color: ' & PixelGetColor($card3x, $card3y) & @CRLF)
		ConsoleWrite('Card 4 pixel color: ' & PixelGetColor($card4x, $card4y) & @CRLF)