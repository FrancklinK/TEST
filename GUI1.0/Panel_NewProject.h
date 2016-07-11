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

#define  NPPANEL                          1
#define  NPPANEL_NUMERIC_TMNEG            2       /* control type: numeric, callback function: (none) */
#define  NPPANEL_GRAPH_PS                 3       /* control type: graph, callback function: (none) */
#define  NPPANEL_STRING_TaskName          4       /* control type: string, callback function: (none) */
#define  NPPANEL_STRING_TaskCode          5       /* control type: string, callback function: (none) */
#define  NPPANEL_STRING_TestUnit          6       /* control type: string, callback function: (none) */
#define  NPPANEL_STRING_TestWeapon        7       /* control type: string, callback function: (none) */
#define  NPPANEL_STRING_TestWeaponType    8       /* control type: string, callback function: (none) */
#define  NPPANEL_STRING_TestCreator       9       /* control type: string, callback function: (none) */
#define  NPPANEL_CB_NPNext                10      /* control type: command, callback function: NewProjectNext */
#define  NPPANEL_CB_NPCancel              11      /* control type: command, callback function: NewProjectCancel */
#define  NPPANEL_CB_NPBack                12      /* control type: command, callback function: NewProjectBack */
#define  NPPANEL_CB_ParamSetting          13      /* control type: command, callback function: NewProjectSaveParamSetting */
#define  NPPANEL_RINGKNOB_FSMR            14      /* control type: slide, callback function: (none) */
#define  NPPANEL_RINGKNOB_DSTR            15      /* control type: slide, callback function: (none) */
#define  NPPANEL_RINGKNOB_PMF             16      /* control type: slide, callback function: (none) */
#define  NPPANEL_SPLITTER                 17      /* control type: splitter, callback function: (none) */
#define  NPPANEL_TEXTMSG_NPSuccess        18      /* control type: textMsg, callback function: (none) */
#define  NPPANEL_TEXTMSG_Warning          19      /* control type: textMsg, callback function: (none) */
#define  NPPANEL_PICTURE_NPWelcome        20      /* control type: picture, callback function: (none) */


     /* Control Arrays: */

          /* (no control arrays in the resource file) */


     /* Menu Bars, Menus, and Menu Items: */

          /* (no menu bars in the resource file) */


     /* Callback Prototypes: */

int  CVICALLBACK NewProjectBack(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK NewProjectCancel(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK NewProjectNext(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK NewProjectSaveParamSetting(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);

//ÆäËûº¯Êý
int initpanelnewproject();
int next();
int back();

#ifdef __cplusplus
    }
#endif
