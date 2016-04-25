#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

Global $hGUI = GUICreate('CRBot - @astranberg', 500, 680)
GUISetState(@SW_SHOW, $hGUI)

GUICtrlCreateTab(10, 8, 55, 16)
GUICtrlCreateButton("OK", 70, 50, 60)

Sleep(5000)
GUIDelete($hGUI)


