/**************************************************************************/
/* LabWindows/CVI User Interface Resource (UIR) Include File              */
/* Copyright (c) National Instruments 2016. All Rights Reserved.          */
/*                                                                        */
/* WARNING: Do not add to, delete from, or otherwise modify the contents  */
/*          of this include file.                                         */
/**************************************************************************/

#include <userint.h>

#ifdef __cplusplus
    extern "C" {
#endif

     /* Panels and Controls: */

#define  OPPANEL                          1
#define  OPPANEL_TREE_ProjectList         2       /* control type: tree, callback function: (none) */
#define  OPPANEL_CB_CancelOpenProject     3       /* control type: command, callback function: OpenProjectCancel */
#define  OPPANEL_CB_OpenProject           4       /* control type: command, callback function: OpenProjectConfirm */
#define  OPPANEL_PICTURE_OPWelcome        5       /* control type: picture, callback function: (none) */
#define  OPPANEL_SPLITTER                 6       /* control type: splitter, callback function: (none) */


     /* Control Arrays: */

          /* (no control arrays in the resource file) */


     /* Menu Bars, Menus, and Menu Items: */

          /* (no menu bars in the resource file) */


     /* Callback Prototypes: */

int  CVICALLBACK OpenProjectCancel(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK OpenProjectConfirm(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);

//ÆäËûº¯Êý
int loadprojects();
int loadmeasuregroups();

#ifdef __cplusplus
    }
#endif
