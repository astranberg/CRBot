; #FUNCTION# ====================================================================================================================
; Name ..........: CRBot
; Description ...: This file contains all coding for CRBot.
; Author ........:  astranberg (2016)
; Modified ......:
; Remarks .......: No Copyright yet
;                  It will hopefully be distributed under the terms of the GNU GPL
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
#RequireAdmin

#include <ScreenCapture.au3>
#include <lib/ImageSearch.au3>
#include <GDIPlus.au3>
#include <AutoItConstants.au3>
#include <Array.au3>
#include <StringConstants.au3>
#include <WinAPIGdi.au3>

#Region Declare Variables
Global $aPixel_cards[48][5] = [["archer", 0, 14389367, 0, 0], _
		["arrows", 13557486, 0, 0, 0], _
		["baby_dragon", 0, 0, 0, 0], _
		["balloon", 16749667, 14188120, 10906443, 16049102], _
		["barbarian_hut", 0, 0, 0, 0], _
		["barbarians", 15312398, 8866055, 7028993, 5978368], _
		["bomber", 0, 0, 0, 0], _
		["bomb_tower", 7758193, 7021830, 8072200, 9121032], _
		["cannon", 1645590, 1644823, 1645840, 1648656], _
		["dark_prince", 5594467, 6512994, 6975867, 13026238], _
		["elixir_collector", 0, 0, 0, 0], _
		["fireball", 0, 0, 0, 0], _
		["freeze", 0, 0, 0, 0], _
		["giant", 14060387, 13006682, 11757641, 8142113], _
		["giant_skeleton", 7825243, 13020827, 14600886, 12955292], _
		["goblin_barrel", 0, 0, 0, 0], _
		["goblin_hut", 0, 0, 0, 0], _
		["goblins", 10273101, 5975302, 7941152, 6432784], _
		["golem", 0, 0, 0, 0], _
		["hog", 2892307, 7094837, 984064, 1050624], _
		["ice_wizard", 5780531, 5254444, 5452851, 6041904], _
		["inferno_tower", 0, 9396057, 0, 0], _
		["knight", 0, 0, 0, 0], _
		["lightening", 0, 0, 0, 0], _
		["mini_pekka", 0, 0, 0, 0], _
		["minion_horde", 0, 0, 0, 0], _
		["minions", 0, 0, 0, 0], _
		["mirror", 0, 0, 0, 0], _
		["mortar", 0, 0, 5927333, 0], _
		["musketeer", 4858944, 1189965, 14535357, 8079682], _
		["pekka", 0, 0, 0, 0], _
		["poison", 0, 0, 0, 0], _
		["prince", 4928552, 7164482, 6570547, 5454378], _
		["princeess", 0, 0, 0, 0], _
		["rage", 0, 0, 0, 0], _
		["rocket", 0, 0, 0, 15580546], _
		["royale_giant", 0, 0, 0, 0], _
		["skeleton_army", 0, 0, 0, 0], _
		["skeletons", 0, 0, 0, 0], _
		["spear_goblins", 10800172, 5852974, 6973803, 6972514], _
		["tesla", 0, 0, 0, 0], _
		["three_musketeers", 0, 0, 0, 0], _
		["tombstone", 0, 0, 0, 0], _
		["valkerie", 0, 0, 0, 0], _
		["witch", 0, 0, 0, 0], _
		["wizard", 8276282, 4200478, 5842985, 6369321], _
		["xbow", 0, 0, 0, 0], _
		["zap", 0, 0, 0, 0]]
Global $aCardSlots[4]


;--> Misc. Pixel stuff
Global $aPixel_trainer_button[3] = [445, 343, Dec('B0E4FF')]
Global $aPixel_yes_button[3] = [345, 506, Dec('67BAFF')]
Global $aPixel_river[3] = [250, 392, Dec('00AAD6')]
Global $aPixel_game_ended[3] = [200, 750, Dec('67B8FF')]
Global $aPixel_in_a_clan[3] = [480, 120, Dec('FFBC2C')]

;--> Menu locations
Global $aMenuOrder[5] = ['shop', 'cards', 'battle', 'clan', 'tvroyale']

Global $aPixel_in_shop[3] = [80, 816, Dec('B2D6EF')]
Global $aPixel_in_cards[3] = [168, 816, Dec('5F5F60')]
Global $aPixel_in_battle[3] = [263, 816, Dec('9CACB0')]
Global $aPixel_in_clan[3] = [334, 816, Dec('26A0FF')]
Global $aPixel_in_tvroyale[3] = [408, 816, Dec('FFF6B8')]

;Global $aPixel_cardsreceived = [,,Dec('')]

;--> Chest pixels
Global $aPixel_freechest_notready[3] = [62, 162, Dec('583D25')]
Global $aPixel_freechest_ready[3] = [148, 173, Dec('FFFFFF')]
Global $aPixel_freechest_beingopened[3] = [295, 484, Dec('B82E2B')]
Global $aPixel_startunlock[3] = [50, 350, Dec('636A7C')]
Global $aPixel_arenachests_locked[7][5] = [["Wooden", 0, 0, 0, 0], _
		["Silver", 8429748, 5007741, 8429748, 5531767], _
		["Gold", 13997568, 14720000, 15246336, 11170830], _
		["Giant", 0, 0, 4152167, 0], _
		["Magical", 0, 0, 0, 0], _
		["Super Magical", 0, 0, 0, 0]]

Global $aPixel_arenachests_unlocking[7][5] = [["Wooden", 0, 0, 0, 0], _
		["Silver", 5536916, 7509418, 5537170, 6456987], _
		["Gold", 0, 0, 0, 7623936], _
		["Giant", 0, 0, 8086555, 0], _
		["Magical", 0, 0, 0, 0], _
		["Super Magical", 0, 0, 0, 0]]

Global $aPixel_arenachests_unlocked[7][5] = [["Wooden", 0, 0, 0, 0], _
		["Silver", 8034990, 9482432, 7575206, 6588570], _
		["Gold", 3443620, 0, 0, 4093310], _
		["Giant", 0, 0, 7374736, 0], _
		["Magical", 0, 0, 0, 0], _
		["Super Magical", 0, 0, 0, 0]]

Global $aPixel_emptychest[5] = ["Empty", 1989510, 1989253, 1989253, 1988482]

;---------------------------->[Chest Type, Chest Status, Chest Arena]
Global $aChestSlots[4][4] = [["", "", ""], _
		["", "", ""], _
		["", "", ""], _
		["", "", ""]]

;---> Troop Donations
Global $aPixel_donate_button[3] = [320, 583, Dec('38E448')] ;--> need to somehow find within a column
Global $aPixel_donate_scroll_indicator[3] = [15, 180, Dec('FFFFFF')]

;--> Card Requests
Global $aPixel_requestcards_cooldown[3] = [25, 775, Dec('DADADA')]
Global $aPixel_requestcards_ready[3] = [103, 789, Dec('FFBC28')]

$iChest1x = 60
$iChest1y = 750
$iChest2x = 190
$iChest2y = 750
$iChest3x = 310
$iChest3y = 750
$iChest4x = 430
$iChest4y = 750

;--> Elixir
;------------------------> Elixir amt, color for filled, x pos, y pos
Global $aPixel_elixir[10][4] = [[1, Dec('F088F4'), 161, 870], _
		[2, Dec('F088F4'), 200, 870], _
		[3, Dec('F088F4'), 227, 870], _
		[4, Dec('F088F4'), 263, 870], _
		[5, Dec('F088F4'), 305, 870], _
		[6, Dec('F088F4'), 340, 870], _
		[7, Dec('F088F4'), 375, 870], _
		[8, Dec('F088F4'), 410, 870], _
		[9, Dec('F088F4'), 445, 870], _
		[10, Dec('FFFFFF'), 154, 862]]

;--> Popup menus
Global $aPixel_connectionlost[3] = [250, 500, Dec('282828')]
Global $aPixel_donation_received[3] = [448, 212, Dec('E42424')]


;----------------------------------CHANGES NEEDED
;---Clean up code and extra junk
;---Troop donation feature w/ options of what to donate
;---Troop request feature w/ options of what to request for
;----x-including request only for cards you can't upgrade right now
;---Implement a UI for user preferences
;---Work on the actual game vs. the trainer
;----a-Any way to recognize computers deployed troops to counter?
;----b-Have attack formations
;----------------------------------CHANGES NEEDED


;--> Crowns and score
;--------> need to figure these pixels out..
Global $aPixel_crowns_0[3] = [468, 464, Dec('66CCFF')]
Global $aPixel_crowns_1[3] = [468, 464, Dec('66CCFF')]
Global $aPixel_crowns_2[3] = [468, 464, Dec('66CCFF')]
Global $aPixel_crowns_3[3] = [468, 464, Dec('66CCFF')]
#EndRegion

#Region Launch BlueStacks and CR
;--> Check if already launched
$AndroidHWND = WinGetHandle("BlueStacks Android Plugin")
ConsoleWrite('Searching for Clash Royale' & @CRLF)
If $AndroidHWND <> 0 Then
	If _FindMenu('battle', 2000) = 0 Then
		_SendADB("connect localhost:5555")
		Sleep(1000)
		_SendADB("-a shell am start -n com.supercell.clashroyale/.GameApp")
		Sleep(1000)
	EndIf
EndIf
If _FindMenu('battle', 5000) = 0 Then
	;-->Set correct resolution and close Bluestacks
	ConsoleWrite('Setting correct resolution and closing Bluestacks' & @CRLF)
	ShellExecute(@ScriptDir & "\BluestacksResolution\resolution.bat")
	Sleep(2000)

	;--> Launch BlueStacks
	ConsoleWrite('Launching Bluestacks' & @CRLF)
	Global $AndroidPID = ShellExecute("C:\Program Files (x86)\BlueStacks\" & "HD-Frontend.exe", "Android")

	;--> Wait Bluestacks loaded
	Global $aBluestacksNotLoaded[3] = [100, 100, Dec('2393D5')]
	While _CanFindPixel($aBluestacksNotLoaded) = 1
	WEnd

	;--> Launch ClashRoyale
	ConsoleWrite('Launching Clash Royale' & @CRLF)
	Sleep(1000)
	_SendADB("connect localhost:5555")
	Sleep(1000)
	_SendADB("-a shell am start -n com.supercell.clashroyale/.GameApp")
Else
	_SendADB("connect localhost:5555")
EndIf

;--> Wait for it to load
Global $AndroidHWND = False
While $AndroidHWND = False
	$AndroidHWND = WinGetHandle("BlueStacks Android Plugin")
	Sleep(1000)
WEnd

;--> Resize
ConsoleWrite('Resizing and moving Bluestacks' & @CRLF)
WinActivate($AndroidHWND)
;~ WinMove($AndroidHWND, '', 0, 0, 425, 765)
WinMove($AndroidHWND, '', 0, 0, 500, 900)

Sleep(1000)

;--> Get positions
Global $AndroidPos = WinGetPos($AndroidHWND) ;--> [0] = X pos, [1] = Y pos; [2] = Width; [3] = Height

;--> Get card positions
Global $iCard1x = 150
Global $iCard1y = 800
Global $iCard2x = 250
Global $iCard2y = 800
Global $iCard3x = 350
Global $iCard3y = 800
Global $iCard4x = 450
Global $iCard4y = 800
#EndRegion

#Region User Preferences
;--> Get user preferences (not yet implimented)
ConsoleWrite('Reading user preferences' & @CRLF)
$iChest_unlock_order = "Quickest"
$openunlockedchests = True
#EndRegion

#Region Loop through doing stuff with Clash Royale
;--> Loop through script
While 1
	ConsoleWrite('Finding Battle Menu' & @CRLF)
	_FindMenu('battle')

	ConsoleWrite('Opening Free Chests' & @CRLF)
	While _OpenFreeChest() = 1 ;--> If there's one free chest there could be another
		Sleep(1000)
	WEnd

	;temp stufffffz
	ConsoleWrite("Chest 1 Pixel Color: " & PixelGetColor($iChest1x, $iChest1y) & @CRLF)
	ConsoleWrite("Chest 2 Pixel Color: " & PixelGetColor($iChest2x, $iChest2y) & @CRLF)
	ConsoleWrite("Chest 3 Pixel Color: " & PixelGetColor($iChest3x, $iChest3y) & @CRLF)
	ConsoleWrite("Chest 4 Pixel Color: " & PixelGetColor($iChest4x, $iChest4y) & @CRLF)

	ConsoleWrite('Opening Arena Chests' & @CRLF)
	_OpenArenaChest()

	ConsoleWrite('Requesting Cards' & @CRLF)
	_RequestCards()

	ConsoleWrite('Donating Troops' & @CRLF)
	_DonateTroops()

	ConsoleWrite('Playing Game' & @CRLF)
	_PlayGame()

	ConsoleWrite('Game Finished; sleeping for 5 seconds' & @CRLF)
	Sleep(5000)
WEnd
#EndRegion


#Region Functions
Func _SendADB($command)
	ShellExecute("C:\Program Files (x86)\BlueStacks\HD-Adb.exe", $command, '', '', @SW_HIDE)
EndFunc   ;==>_SendADB

;Global $aMenuOrder[5] = ['shop', 'cards', 'battle', 'clan', 'tvroyale']
Func _FindMenu($sMenuToFind, $timeout = 0)
	$timer = TimerInit()
	;--> Get to main menu
	While _CanFindPixel(Eval('aPixel_in_' & $sMenuToFind)) = 0
		;--> Figure out which tab we're in
		$sMenuCurrent = ''
		For $i = 0 To UBound($aMenuOrder) - 1
			If _CanFindPixel(Eval('aPixel_in_' & $aMenuOrder[$i])) = 1 Then
				$sMenuCurrent = $aMenuOrder[$i]
				ExitLoop
			EndIf
		Next

		;--> Swipe left or right according to if we're before or after the tab we want
		If $sMenuCurrent <> '' Then
			For $i = 0 To UBound($aMenuOrder) - 1
				If $aMenuOrder[$i] = $sMenuToFind Then
					_SwipeRight()
					ExitLoop
				ElseIf $aMenuOrder[$i] = $sMenuCurrent Then
					_SwipeLeft()
					ExitLoop
				EndIf
			Next
		EndIf

		;--> Check for disconnection menu
		If _CanFindPixel($aPixel_connectionlost) = 1 Then
			_ClickPixel($aPixel_connectionlost)
		EndIf

		;--> Check for donatios received button.
		If _CanFindPixel($aPixel_donation_received) = 1 Then
			_ClickPixel($aPixel_donation_received)
		EndIf

		;--> Check for time out
		If TimerDiff($timer) >= $timeout And $timeout > 0 Then
			Return 0
			ExitLoop
		EndIf

		Sleep(1000)
	WEnd

	_WaitForPixel(Eval('aPixel_in_' & $sMenuToFind))
	Sleep(1000)
	Return 1
EndFunc   ;==>_FindMenu

Func _OpenFreeChest()
	_FindMenu('Battle')
	If _CanFindPixel($aPixel_freechest_notready) Then
		Return 0
	ElseIf _CanFindPixel($aPixel_freechest_ready) = 1 Then
		_ClickPixel($aPixel_freechest_ready)
		Sleep(2000)
		;--> click some more to get stuff
		While _CanFindPixel($aPixel_in_battle) = 0
			_ClickCoords(100, 100)
			Sleep(2000)
		WEnd
		Return 1
	Else
		MsgBox(0, '_OpenFreeChest', 'error')
		Return 0
	EndIf
EndFunc   ;==>_OpenFreeChest

Func _OpenArenaChest()
	;--> Find what's in each chest slot
	$bOneAlreadyBeingOpened = False
	For $iChestSlot = 1 To 4
		For $iChestType = 0 To UBound($aPixel_arenachests_unlocking, 1) - 1
			Dim $aLockedChest = [Eval("iChest" & $iChestSlot & "x"), Eval("iChest" & $iChestSlot & "y"), $aPixel_arenachests_locked[$iChestType][$iChestSlot]]
			Dim $aUnlockingChest = [Eval("iChest" & $iChestSlot & "x"), Eval("iChest" & $iChestSlot & "y"), $aPixel_arenachests_unlocking[$iChestType][$iChestSlot]]
			Dim $aUnlockedChest = [Eval("iChest" & $iChestSlot & "x"), Eval("iChest" & $iChestSlot & "y"), $aPixel_arenachests_unlocked[$iChestType][$iChestSlot]]
			Dim $aEmptyChest = [Eval("iChest" & $iChestSlot & "x"), Eval("iChest" & $iChestSlot & "y"), $aPixel_emptychest[$iChestSlot]]
			If _CanFindPixel($aLockedChest) Then
				$aChestSlots[$iChestSlot - 1][0] = $aPixel_arenachests_locked[$iChestType][0]
				$aChestSlots[$iChestSlot - 1][1] = "Locked"
				$aChestSlots[$iChestSlot - 1][2] = 8
			ElseIf _CanFindPixel($aUnlockingChest) Then
				$aChestSlots[$iChestSlot - 1][0] = $aPixel_arenachests_unlocking[$iChestType][0]
				$aChestSlots[$iChestSlot - 1][1] = "Unlocking"
				$aChestSlots[$iChestSlot - 1][2] = 8
				$bOneAlreadyBeingOpened = True
			ElseIf _CanFindPixel($aUnlockedChest) Then
				$aChestSlots[$iChestSlot - 1][0] = $aPixel_arenachests_unlocked[$iChestType][0]
				$aChestSlots[$iChestSlot - 1][1] = "Unlocked"
				$aChestSlots[$iChestSlot - 1][2] = 8
			ElseIf _CanFindPixel($aEmptyChest) Then
				$aChestSlots[$iChestSlot - 1][0] = "Empty"
				$aChestSlots[$iChestSlot - 1][1] = "Empty"
				$aChestSlots[$iChestSlot - 1][2] = 0
			EndIf
		Next
		ConsoleWrite($iChestSlot & ": " & $aChestSlots[$iChestSlot - 1][0] & " " & $aChestSlots[$iChestSlot - 1][1] & "   ")
	Next
	ConsoleWrite(@CRLF)

	;--> Unlock according to user specifications (Quickest first, lowest arena first, longest first, highest arena first)
	;---------> NOTE: Unlock refers starting the timer to be able to Open (see below) the chest.
	If Not $bOneAlreadyBeingOpened Then
		If $iChest_unlock_order = "Quickest" Then ;--> Wooden, Silver, Golden, Giant, Magical, Super Magical
			;----------> By Type: order
			Dim $aUnlockOrder = [0, 'Wooden', 'Silver', 'Golden', 'Giant', 'Magical', 'Super Magical']
		ElseIf $iChest_unlock_order = "Longest" Then ;--> Super Magical, Magical, Giant, Golden, Silver
			;----------> By Type: order
			Dim $aUnlockOrder = [0, 'Super Magical', 'Magical', 'Giant', 'Golden', 'Silver', 'Wooden']
		ElseIf $iChest_unlock_order = "Highest" Then ;--> Arenas 8-1
			;----------> By Arena: order
			Dim $aUnlockOrder = [2, 8, 7, 6, 5, 4, 3, 2, 1]
		ElseIf $iChest_unlock_order = "Lowest" Then ;--> Arenas 1-8
			;----------> By Arena: order
			Dim $aUnlockOrder = [2, 1, 2, 3, 4, 5, 6, 7, 8]
		EndIf

		If $aUnlockOrder[0] = 0 Then $iIndex_ChestSlots = 0
		If $aUnlockOrder[0] = 2 Then $iIndex_ChestSlots = 2
		For $iUnlockOrder = 1 To UBound($aUnlockOrder) - 1
			For $iChestSlot = 1 To 4
				;MsgBox(0,0,$aChestSlots[$iChestSlot - 1][$iIndex_ChestSlots] & @CRLF & $aUnlockOrder[$iUnlockOrder])
				If $aChestSlots[$iChestSlot - 1][$iIndex_ChestSlots] = $aUnlockOrder[$iUnlockOrder] And $aChestSlots[$iChestSlot - 1][1] = "Locked" Then
					;MsgBox(0,0,'GOING TO UNLOCK CHEST!!!')
					_ClickCoords(Eval("iChest" & $iChestSlot & "x"), Eval("iChest" & $iChestSlot & "y"))
;~ 					_WaitForPixel($aPixel_startunlock)
					Sleep(2000)
					_ClickCoords(250, 575)
					Return 1
					ExitLoop
				EndIf
			Next
		Next
	EndIf

	;--> Open arena chests according to user specifications (one slot must be clear, open all, )
	;---------> NOTE: Open refers to actually receiving the cards inside the chest after it has already been unlocked (see above).
	If $openunlockedchests Then
		Sleep(1000)
		For $iChestSlot = 1 To 4
			If $aChestSlots[$iChestSlot - 1][1] = "Unlocked" Then
				_ClickCoords(Eval("iChest" & $iChestSlot & "x"), Eval("iChest" & $iChestSlot & "y"))
				;--> click some more to get stuff
				Dim $atemp = [260, 360, Dec('0C3055')]
				_WaitForPixel($atemp)
				While _CanFindPixel($aPixel_in_battle) = 0
					_ClickCoords(400, 400)
					Sleep(2000)
				WEnd
			EndIf
		Next
	EndIf

	Return 1

EndFunc   ;==>_OpenArenaChest

Func _DonateTroops()
	;--> Get to the clan tab
	_FindMenu('clan')

	;--> Check if you're apart of a clan
	Sleep(500)
	If _CanFindPixel($aPixel_in_a_clan) = 0 Then
		Return 0
	EndIf

	;--> Scroll if indicator present (loop back up)
	$bDonate = 1
	While $bDonate = 1
		;--> Search for donate button on y-axis
		For $y = 150 To 600 Step 4
			Dim $a[3] = [400, $y, Dec('38E448')]
			;--> As long as there is a donate button.....
			While _CanFindPixel($a) = 1
				;--> Click donate button
				_ClickPixel($a)
				Sleep(1000)
			WEnd
		Next

		;--> Check if scroll indicator present
		$bDonate = _CanFindPixel($aPixel_donate_scroll_indicator)

		;--> Click indicator to scroll up
		_ClickPixel($aPixel_donate_scroll_indicator)
		Sleep(1000)
	WEnd

	;--> Click to donate (eventually build filter for type of troop requested)
EndFunc   ;==>_DonateTroops

Func _RequestCards()
	_FindMenu('clan')
	If _CanFindPixel($aPixel_requestcards_ready) = 1 Then
		_ClickPixel($aPixel_requestcards_ready)

		Return 1
	ElseIf _CanFindPixel($aPixel_requestcards_cooldown) = 1 Then
		Return 1
	Else
		MsgBox(0, 'Request Cards', 'Error.')
		Return 0
	EndIf
EndFunc   ;==>_RequestCards

Func _SwipeLeft()
;~ 	MouseClickDrag($MOUSE_CLICK_PRIMARY, $AndroidPos[0] + 450, $AndroidPos[1] + 400, $AndroidPos[0] + 50, $AndroidPos[1] + 400)
	_SendADB("-a shell input swipe 450 400 50 400")
	Sleep(100)
EndFunc   ;==>_SwipeLeft

Func _SwipeRight()
;~ 	MouseClickDrag($MOUSE_CLICK_PRIMARY, $AndroidPos[0] + 50, $AndroidPos[1] + 400, $AndroidPos[0] + 450, $AndroidPos[1] + 400)
	_SendADB("-a shell input swipe 50 400 450 400")
	Sleep(100)
EndFunc   ;==>_SwipeRight

Func _SwipeUp()
;~ 	MouseClickDrag($MOUSE_CLICK_PRIMARY, $AndroidPos[0] + 250, $AndroidPos[1] + 700, $AndroidPos[0] + 250, $AndroidPos[1] + 200)
	_SendADB("-a shell input swipe 250 700 250 200")
	Sleep(100)
EndFunc   ;==>_SwipeUp

Func _SwipeDown()
;~ 	MouseClickDrag($MOUSE_CLICK_PRIMARY, $AndroidPos[0] + 250, $AndroidPos[1] + 200, $AndroidPos[0] + 250, $AndroidPos[1] + 700)
	_SendADB("-a shell input swipe 250 200 250 700")
	Sleep(100)
EndFunc   ;==>_SwipeDown

Func _PlayGame()

	;--> Launch game vs. trainer
	_FindMenu('battle')
	_ClickPixel($aPixel_trainer_button)
	Sleep(1000)
	_WaitForPixel($aPixel_yes_button)
	_ClickPixel($aPixel_yes_button)
	_WaitForPixel($aPixel_river)

	;--> Drop positions
	$drop_leftlanex = 118
	$drop_leftlaney = 461
	$drop_rightlanex = 380
	$drop_rightlaney = 461

	$drop_leftlaneforwardx = 118
	$drop_leftlaneforwardy = 161
	$drop_rightlaneforwardx = 380
	$drop_rightlaneforwardy = 161

	;--> Play game
	$game_ended = 0
	$sCrowns = 0
	While $game_ended = 0

		MsgBox(0, 0, 'press ok when ready for pixels')
		ConsoleWrite('Card 1 pixel color: ' & PixelGetColor($iCard1x, $iCard1y) & @CRLF)
		ConsoleWrite('Card 2 pixel color: ' & PixelGetColor($iCard2x, $iCard2y) & @CRLF)
		ConsoleWrite('Card 3 pixel color: ' & PixelGetColor($iCard3x, $iCard3y) & @CRLF)
		ConsoleWrite('Card 4 pixel color: ' & PixelGetColor($iCard4x, $iCard4y) & @CRLF)

		;--> Check number of crowns  (NEED TO REDO IN PIXEL)
		If _CanFindPixel($aPixel_crowns_0) = 1 Then
			$sCrowns = 0
		ElseIf _CanFindPixel($aPixel_crowns_1) = 1 And $sCrowns < 1 Then
			$sCrowns = 1
		ElseIf _CanFindPixel($aPixel_crowns_2) = 1 And $sCrowns < 2 Then
			$sCrowns = 2
		ElseIf _CanFindPixel($aPixel_crowns_3) = 1 And $sCrowns < 3 Then
			$sCrowns = 3
		EndIf

		;-->Determine what cards we have
		$timer = TimerInit()
		$aCardSlots[0] = ''
		$aCardSlots[1] = ''
		$aCardSlots[2] = ''
		$aCardSlots[3] = ''
		For $iTroop = 0 To UBound($aPixel_cards, 1) - 1
			For $iCardSlot = 1 To 4
				Dim $iCardarr = [Eval("iCard" & $iCardSlot & "x"), Eval("iCard" & $iCardSlot & "y"), $aPixel_cards[$iTroop][$iCardSlot]]
				;MsgBox(0,0,$iCardarr[0] & @CRLF & $iCardarr[1] & @CRLF & $iCardarr[2] & @CRLF & $aPixel_cards[$iTroop][0] & @CRLF)
				If _CanFindPixel($iCardarr) = 1 Then
					$aCardSlots[$iCardSlot - 1] = $aPixel_cards[$iTroop][0]
					ExitLoop
					;MouseClick($MOUSE_CLICK_PRIMARY, $iCard1x, $iCard1y)
					;MouseClick($MOUSE_CLICK_PRIMARY, $drop_leftlanex, $drop_leftlaney)
				EndIf
			Next
		Next

		;--> Determine amount of elixir
		$iElixirAmt = 0
		For $i = 1 To 10
			Dim $aPixel_arr = [$aPixel_elixir[$i - 1][2], $aPixel_elixir[$i - 1][3], $aPixel_elixir[$i - 1][1]]
;~ 			ConsoleWrite('Elixir ' & $i & ': ' & PixelGetColor($aPixel_elixir[$i - 1][2], $aPixel_elixir[$i - 1][3], $AndroidHWND) & ' = ' & _CanFindPixel($aPixel_arr) & @CRLF)
			If _CanFindPixel($aPixel_arr) = 1 Then
				$iElixirAmt = $i
			EndIf
		Next

		ConsoleWrite($aCardSlots[0] & @CRLF & $aCardSlots[1] & @CRLF & $aCardSlots[2] & @CRLF & $aCardSlots[3] & @CRLF & "Elixir: " & $iElixirAmt)

		;--> Search for opponent troops (definitely a long-shot...but here goes nothin')
;~ 		_ScreenCapture_CaptureWnd(@ScriptDir & '\images\temp_screenshot.png', $AndroidHWND)
;~ 		$aImage =_GDIPlus_ImageLoadFromFile(@ScriptDir & '\images\temp_screenshot.png')
;~ 		$aBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($aImage)

		;--> Send appropriate troop attack
		;(not built yet...) Something like tank + splash + range + delayed small troops. Use elixir calculations.
		;--------) 19 pixels is the height of each lawn square. 24 is the width. Center on defensive side is 249, 498
		MsgBox(0, 0, 'deploying troop')
		_DeployTroop(1, 4, 7)

		Sleep(100) ;--> pause so loop doesn't go insane ;-)

		;--> Check if game has ended
		$game_ended = _CanFindPixel($aPixel_game_ended)
	WEnd

	_WaitForPixel($aPixel_game_ended)
	Sleep(1000)
	_ClickPixel($aPixel_game_ended)

	Return 1 ;--> Should add func. to return 1 if you won, 0 if you lost
EndFunc   ;==>_PlayGame

Func _DeployTroop($iCardNo, $x_offset, $y_offset)
	;--> Click on card
	_ClickCoords(Eval('iCard' & $iCardNo & 'x'), Eval('iCard' & $iCardNo & 'y'))

	;--> Click on deployment spot
	MsgBox(0, 0, 249 + (24 * $x_offset) & @CRLF & 498 + (19 * $y_offset))
	_ClickCoords(249 + (24 * $x_offset), 498 + (19 * $y_offset))

EndFunc   ;==>_DeployTroop

Func _WaitForPixel($a, $timeout = 0)

	$timer = TimerInit()
	$result = _CanFindPixel($a)

	While $result = 0
		Sleep(100)
		$result = _CanFindPixel($a)
;~ 		ConsoleWrite($result & @CRLF)
		If TimerDiff($timer) >= $timeout And $timeout > 0 Then
			ExitLoop
		EndIf
	WEnd

	Return $result

EndFunc   ;==>_WaitForPixel

Func _CanFindPixel($a, $sVari = 5, $Ignore = "")

	;--> Convert dec to hex
	$nColor1 = Hex(PixelGetColor($a[0], $a[1], $AndroidHWND))
	$nColor2 = Hex($a[2])


	$Red1 = _WinAPI_GetRValue($nColor1)
	$Blue1 = _WinAPI_GetBValue($nColor1)
	$Green1 = _WinAPI_GetGValue($nColor1)

	$Red2 = _WinAPI_GetRValue($nColor2)
	$Blue2 = _WinAPI_GetBValue($nColor2)
	$Green2 = _WinAPI_GetGValue($nColor2)

	Switch $Ignore
		Case "Red" ; mask RGB - Red
			If Abs($Blue1 - $Blue2) > $sVari Then Return False
			If Abs($Green1 - $Green2) > $sVari Then Return False
		Case "Heroes" ; mask RGB - Green
			If Abs($Blue1 - $Blue2) > $sVari Then Return False
			If Abs($Red1 - $Red2) > $sVari Then Return False
		Case Else
			If Abs($Blue1 - $Blue2) > $sVari Then Return False
			If Abs($Green1 - $Green2) > $sVari Then Return False
			If Abs($Red1 - $Red2) > $sVari Then Return False
	EndSwitch

	Return True

EndFunc   ;==>_CanFindPixel

Func _ClickPixel($a)

	If _CanFindPixel($a) Then
;~ 		MouseClick($MOUSE_CLICK_PRIMARY, $AndroidPos[0] + $a[0], $AndroidPos[1] + $a[1])
		_SendADB("-a shell input tap " & $a[0] & " " & $a[1])
		Return 1
	Else
		Return 0
	EndIf

EndFunc   ;==>_ClickPixel

Func _ClickCoords($x, $y)

	_SendADB("-a shell input tap " & $x & " " & $y)
	Return 1

EndFunc   ;==>_ClickCoords

#EndRegion

#Region Outdated Functions

;~ ; #FUNCTION# ====================================================================================================================
;~ ; Name ..........: _ColorCheck
;~ ; Description ...: Checks if the color components exceed $sVari and returns true if they are below $sVari.
;~ ; Syntax ........: _ColorCheck($nColor1, $nColor2, $sVari = 5, $Ignore = "")
;~ ; Parameters ....: $nColor1, $nColor2: a Hex string color code eg: "FFFFFF", $sVari: a tolerance level, $Ignore : Ignore eg: "Red" to ignore the "Red" RGB component
;~ ; Return values .: True or False
;~ ; Author ........:
;~ ; Modified ......: Hervidero (2015)
;~ ; Remarks .......: This file is part of MyBot, previously known as ClashGameBot. Copyright 2015-2016
;~ ;                  MyBot is distributed under the terms of the GNU GPL
;~ ; Related .......:
;~ ; Link ..........: https://github.com/MyBotRun/MyBot/wiki
;~ ; Example .......: No
;~ ; ===============================================================================================================================

;~ Func _ColorCheck($nColor1, $nColor2, $sVari = 5, $Ignore = "")
;~ 	Local $Red1, $Red2, $Blue1, $Blue2, $Green1, $Green2

;~ 	$Red1 = Dec(StringMid(String($nColor1), 1, 2))
;~ 	$Blue1 = Dec(StringMid(String($nColor1), 3, 2))
;~ 	$Green1 = Dec(StringMid(String($nColor1), 5, 2))

;~ 	$Red2 = Dec(StringMid(String($nColor2), 1, 2))
;~ 	$Blue2 = Dec(StringMid(String($nColor2), 3, 2))
;~ 	$Green2 = Dec(StringMid(String($nColor2), 5, 2))

;~ 	Switch $Ignore
;~ 		Case "Red" ; mask RGB - Red
;~ 			If Abs($Blue1 - $Blue2) > $sVari Then Return False
;~ 			If Abs($Green1 - $Green2) > $sVari Then Return False
;~ 		Case "Heroes" ; mask RGB - Green
;~ 			If Abs($Blue1 - $Blue2) > $sVari Then Return False
;~ 			If Abs($Red1 - $Red2) > $sVari Then Return False
;~ 		Case Else
;~ 			If Abs($Blue1 - $Blue2) > $sVari Then Return False
;~ 			If Abs($Green1 - $Green2) > $sVari Then Return False
;~ 			If Abs($Red1 - $Red2) > $sVari Then Return False
;~ 	EndSwitch

;~ 	Return True
;~ EndFunc   ;==>_ColorCheck
;----------> Don't use anymore. We use pixels instead now.
;~ Func _ClickPicture($filename)
;~ 	_GDIPlus_Startup()

;~ 	$hImage =_GDIPlus_ImageLoadFromFile($filename)
;~ 	$hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)

;~ 	_ScreenCapture_CaptureWnd(@ScriptDir & '\images\temp_screenshot.png', $AndroidHWND)
;~ 	$aImage =_GDIPlus_ImageLoadFromFile(@ScriptDir & '\images\temp_screenshot.png')
;~ 	$aBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($aImage)

;~ 	$x = 0
;~ 	$y = 0

;~ 	;$result = _ImageSearch($hBitmap, 1, $x, $y, 20, 0) ;Zero will search against your active screen
;~ 	$result = _ImageSearchArea($hBitmap, 1, $AndroidPos[0], $AndroidPos[1], $AndroidPos[2], $AndroidPos[3], $x, $y, 100)
;~ 	If $result > 0 Then
;~ 		MouseMove($x, $y)
;~ 		MouseClick($MOUSE_CLICK_PRIMARY, $x, $y)
;~ 	EndIf

;~ 	_GDIPlus_ImageDispose($hImage)
;~ 	_GDIPlus_Shutdown()

;~ 	Return $result

;~ EndFunc ;--end function _ClickPicture


;~ Func _CanFindPicture($filename)
;~ 	_GDIPlus_Startup()

;~ 	$hImage =_GDIPlus_ImageLoadFromFile($filename)
;~ 	$hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)

;~ 	_ScreenCapture_CaptureWnd(@ScriptDir & '\images\temp_screenshot.png', $AndroidHWND)
;~ 	$aImage =_GDIPlus_ImageLoadFromFile(@ScriptDir & '\images\temp_screenshot.png')
;~ 	$aBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($aImage)

;~ 	$x = 0
;~ 	$y = 0

;~ 	;$result = _ImageSearch($hBitmap, 1, $x, $y, 20, 0) ;Zero will search against your active screen
;~ 	$result = _ImageSearchArea($hBitmap, 1, $AndroidPos[0], $AndroidPos[1], $AndroidPos[2], $AndroidPos[3], $x, $y, 100)

;~ 	_GDIPlus_ImageDispose($hImage)
;~ 	_GDIPlus_Shutdown()

;~ 	Return $result

;~ EndFunc ;--end function _ClickPicture

;~ Func _WaitForPicture($filename, $timeout = 0)
;~ 	$result = _CanFindPicture($filename)
;~ 	$timer = TimerInit()
;~ 	While $result = 0
;~ 		Sleep(250)
;~ 		$result = _CanFindPicture($filename)
;~ 		ConsoleWrite ($result & @CRLF)
;~ 		If TimerDiff($timer) >= $timeout and $timeout > 0 Then
;~ 			ExitLoop
;~ 		EndIf
;~ 	WEnd

;~ 	Return $result
;~ EndFunc ;--end function _ClickPicture

;~ Func _WaitForNoPicture($filename, $timeout = 0)
;~ 	$result = _CanFindPicture($filename)
;~ 	$timer = TimerInit()
;~ 	While $result = 1
;~ 		Sleep(250)
;~ 		$x = 0
;~ 		$y = 0
;~ 		$result = _CanFindPicture($filename)
;~ 		If TimerDiff($timer) >= $timeout and $timeout > 0 Then
;~ 			ExitLoop
;~ 		EndIf
;~ 	WEnd

;~ 	Return $result
;~ EndFunc ;--end function _ClickPicture
#EndRegion