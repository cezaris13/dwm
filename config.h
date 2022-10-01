/* appearance */
static const unsigned int borderpx  = 1;  /* border pixel of windows */
static const unsigned int gappx     = 10;
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static int floatposgrid_x           = 5;        /* float grid columns */
static int floatposgrid_y           = 5;        /* float grid rows */
static const char *fonts[]          = {"monospace:size=10", "JoyPixels:pixelsize=10:antialias=true:autohint=true"};
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#07171B";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#982F33";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeInv]  = { col_gray1, col_gray3, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "1: terminal  ", "2: chromium ", "3: programming ", "4: teams ", "5: Latex ", "6: mail ", "7: messages ", "8: spotify ", "9" };

static const Rule rules[] = {
	/* class      		              instance    title       						tags mask   iscentered 		isfloating   floatpos   				monitor */
	{ "XTerm",			              NULL,		 NULL,								0,			0,  			1,		   	 "83% 20% 31% 37%",		-1 },
	{ "SonyHeadphonesClient",	      NULL,		 "Sony Headphones App v1.3.1",		0,			0,  			1,		   	 "83% 20% 31% 37%",		-1 },
	{ "Codeblocks",					  NULL,		 NULL,								0,			1,  			0,		  	 NULL,					-1 },
	{ "discord",	 	              NULL,		 NULL,								0,			1,  			0,		  	 NULL,					-1 },
	{ NULL,	 			              NULL,		 "LibreOffice",						0,			1,  			0,		  	 NULL,					-1 },
	{ NULL, 			              NULL,		 "Loading Microsoft Teams",			0,			1,  			0,		  	 NULL,					-1 },
	{ "Mailspring", 	              NULL,		 NULL,                              0,			1,  			0,		  	 NULL,					-1 },
	//android studio
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]    = { "rofi", "-show", "drun", NULL };
static const char *termcmd[]  = { "termite", NULL };
static const char scratchpadname[] = "stratchpad";
static const char *scratchpadcmd[] = { "st", "-t", scratchpadname, "-g", "120x34", NULL };
#include <X11/XF86keysym.h>
static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY,						XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,         	XK_j,      pushdown,       {0} },
	{ MODKEY|ShiftMask,          	XK_k,      pushup,         {0} },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_u,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_grave,  focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_s,	   togglescratch,  {.v = scratchpadcmd } },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY|ControlMask,           XK_comma,  tagswapmon,     {.i = +1 } },
	{ MODKEY|ControlMask,           XK_period, tagswapmon,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_f,      togglefullscr,  {0} },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },
	{ MODKEY,                       XK_equal,  setgaps,        {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = gappx  } },
	// { MODKEY|ShiftMask,         	XK_r,      restore,        {0} }, todo this function!!!
	{ MODKEY,						XK_w, 	   spawn,		   SHCMD("$HOME/.config/dwm/scripts/misc/./manga.sh") },
	{ MODKEY,						XK_e, 	   spawn,		   SHCMD("$HOME/.config/dwm/scripts/misc/./emoji_script.sh") },
	{ MODKEY,		     			XK_y, 	   spawn,		   SHCMD("$HOME/.config/dwm/scripts/misc/./memes.sh") },
 	{ MODKEY,						XK_c, 	   spawn,		   SHCMD("$HOME/.config/dwm/scripts/misc/./corona.sh") },
	{ MODKEY|ShiftMask, 			XK_b, 	   spawn,		   SHCMD("$HOME/.config/dwm/scripts/dwm_specific/bluetooth/./bluetooth.sh connect_headphones") },
	{ MODKEY,						XK_F2,	   spawn,		   SHCMD("chromium")  },
	{ MODKEY,						XK_F3,	   spawn,	 	   SHCMD("dolphin") },
	{ MODKEY,						XK_F4,	   spawn,	 	   SHCMD("$HOME/Desktop/Projects/Tsoding_sowon/sowon/./sowon") },
	{ MODKEY,						XK_F6,	   spawn,	 	   SHCMD("mailspring") },
	{ Mod1Mask, XK_F3,				     	   spawn,		   SHCMD("$HOME/.config/dwm/scripts/dwm_specific/./sleep.sh") },//F3
	{ Mod1Mask, XK_F4,				    	   spawn,		   SHCMD("$HOME/.config/dwm/scripts/dwm_specific/./keyboard.sh") },//F4
	{ 0, XK_Print,							   spawn,          SHCMD("$HOME/.config/dwm/scripts/dwm_specific/./screenshot.sh") },
	{ MODKEY,						XK_F12,	   spawn,		   SHCMD("i3lock -f -o") },
	{ MODKEY|ShiftMask,				XK_m, 	   spawn,		   SHCMD("$HOME/.config/dwm/scripts/dwm_specific/./monitors.sh") },
	{ MODKEY,						XK_F5, 	   spawn,		   SHCMD("$HOME/.config/dwm/scripts/dwm_specific/./monitors.sh change_wallpaper") },
	{ MODKEY,						XK_F7, 	   spawn,		   SHCMD("$HOME/.config/dwm/scripts/dwm_specific/./monitors.sh change_orientation") },
	{ MODKEY,						XK_F8, 	   spawn,		   SHCMD("$HOME/.config/dwm/scripts/dwm_specific/./mic.sh") },
	{ 0, XF86XK_AudioMute,					   spawn,		   SHCMD("$HOME/.config/dwm/scripts/dwm_specific/volume/./volume_control.sh set_volume toggleSound") },
	{ 0, XF86XK_AudioRaiseVolume,			   spawn,		   SHCMD("$HOME/.config/dwm/scripts/dwm_specific/volume/./volume_control.sh set_volume +3%") },
	{ 0, XF86XK_AudioLowerVolume,			   spawn,		   SHCMD("$HOME/.config/dwm/scripts/dwm_specific/volume/./volume_control.sh set_volume -3%") },
	{ 0, XF86XK_MonBrightnessUp,			   spawn,		   SHCMD("$HOME/.config/dwm/scripts/dwm_specific/./brightness.sh +10") },
	{ 0, XF86XK_MonBrightnessDown,			   spawn,		   SHCMD("$HOME/.config/dwm/scripts/dwm_specific/./brightness.sh -10") },
	{ 0, XF86XK_AudioPlay,					   spawn,		   SHCMD("playerctl play-pause") },
	{ 0, XF86XK_AudioPause,					   spawn,		   SHCMD("playerctl play-pause") },
	{ 0, XF86XK_AudioPrev,					   spawn,		   SHCMD("playerctl previous") },
	{ 0, XF86XK_AudioNext,					   spawn,		   SHCMD("playerctl next") },
	{ MODKEY|ShiftMask,             XK_e,      spawn,          SHCMD("$HOME/.config/dwm/scripts/dwm_specific/./exit.sh") },
	{ MODKEY,                       XK_Down,   spawn,		   SHCMD("playerctl play-pause") },
	{ MODKEY,                       XK_Left,   spawn,		   SHCMD("playerctl previous") },
	{ MODKEY,                       XK_Right,  spawn,		   SHCMD("playerctl next") },

	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	TAGKEYS(                        XK_KP_End,                 0)
	TAGKEYS(                        XK_KP_Down,                1)
	TAGKEYS(                        XK_KP_Page_Down,           2)
	TAGKEYS(                        XK_KP_Left,                3)
	TAGKEYS(                        XK_KP_Begin,               4)
	TAGKEYS(                        XK_KP_Right,               5)
	TAGKEYS(                        XK_KP_Home,                6)
	TAGKEYS(                        XK_KP_Up,                  7)
	TAGKEYS(                        XK_KP_Page_Up,             8)
};
/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button1,        sigdwmblocks,   {.i = 1} },
	{ ClkStatusText,        0,              Button2,        sigdwmblocks,   {.i = 2} },
	{ ClkStatusText,        0,              Button3,        sigdwmblocks,   {.i = 3} },
	{ ClkStatusText,        0,              Button4,        sigdwmblocks,   {.i = 4} },
	{ ClkStatusText,        0,              Button5,        sigdwmblocks,   {.i = 5} },
	{ ClkStatusText,        ShiftMask,      Button1,        sigdwmblocks,   {.i = 6} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
