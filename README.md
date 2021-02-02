# DWM

## Keybindings
| Command | Description |
| --- | --- |
|mod+Return|launch terminal|
|mod+d|launch rofi|
|mod+b|toggle bar|
|mod+j|move to next window|
|mod+k|move to previous window|
|mod+i|increase amount of windows in the master area|
|mod+u|decrease amount of windows in the master area|
|mod+h|decrease master area size|
|mod+l|increase master area size|
|mod+Shift+Return|toggle a window between the master and stack area|
|mod+Tab|toggle previous tag|
|mod+Shift+q|kill window|
|mod+s|toggle scratchpad|
|mod+t|change to tiling layout mode|
|mod+f|change to floating layout mode|
|mod+m|change to monocle layout mode|
|mod+Space|toggle previous layout mode|
|mod+Shift+Space|toggle floating mode|
|mod+0|show all tags|
|mod+Shift+0|tag window to all workspaces|
|mod+,|go to left monitor|
|mod+.|to to right monitor|
|mod+Shift+,|move window to left monitor|
|mod+Shift+.|move window to right monitor|
|mod+Shift+f|toggle fullscreen|
|mod+-|decrease gaps size|
|mod+=|increase gap size|
|mod+Shift+=|remove gaps|
|mod+w|manga script|
|mod+e|emoji script|
|mod+y|memes script|
|mod+c|corona script|
|mod+F2|launch chromium|
|mod+F3|launch dolphin|
|mod+F12|lock screen|
|mod+Shift+m|monitor script|
|mod+F7|change monitor orientation|
|mod+F8|change mic source|
|XF86XK_AudioMute|toggle mute|
|XK_Print|print screen script|
## Patches

- autostart 
    * This patch will make dwm run "~/.dwm/autostart_blocking.sh" and "~/.dwm/autostart.sh &" before entering the handler loop.
- actualfullscreen
	* Actually toggle fullscreen for a window, instead of toggling the status bar and the monocle layout.
- fullgaps
    * This patch adds gaps between client windows.
- hide_vacant_tags
    * This patch prevents dwm from drawing tags with no clients (i.e. vacant) on the bar.
- pertag
    * This patch enables one layout per tag in contrast of one layout for all tags.
- savefloats
    * This patch saves size and position of every floating window before it is forced into tiled mode. If the window is made floating again, the old dimensions will be restored.
- scratchpad
    * The scratchpad patch allows you to spawn or restore a floating terminal window.
- statuscmd
    * This patch adds the ability to execute shell commands based on the mouse button and position when clicking the status bar.
- floatpos
    * this patch makes "floating rules" patch work using relative coordinates on multi monitor setup 
- center
    * this patch starts program in the center of the current screen
- warp
    * This patch warps the mouse cursor to the center of the currently focused window
