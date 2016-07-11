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

#define  PANEL                            1
#define  PANEL_TREE_QueryProjectList      2       /* control type: tree, callback function: QueryProjectList */
#define  PANEL_GRAPH_QueryMesureData      3       /* control type: graph, callback function: (none) */
#define  PANEL_CB_HistoryQuery            4       /* control type: command, callback function: HistoryQuery */
#define  PANEL_STRING_QRecoilImpulse      5       /* control type: string, callback function: (none) */
#define  PANEL_STRING_QRecoilTime         6       /* control type: string, callback function: (none) */
#define  PANEL_STRING_QAverageRecoil      7       /* control type: string, callback function: (none) */
#define  PANEL_STRING_QMaxRecoil          8       /* control type: string, callback function: (none) */
#define  PANEL_CB_QueryReturn             9       /* control type: command, callback function: QueryReturn */
#define  PANEL_CALENDAR_TestDate          10      /* control type: activeX, callback function: (none) */
#define  PANEL_CB_EndDate                 11      /* control type: command, callback function: ChooseEndDate */
#define  PANEL_TEXTMSG_EndDate            12      /* control type: textMsg, callback function: (none) */
#define  PANEL_CB_StartDate               13      /* control type: command, callback function: ChooseStartDate */
#define  PANEL_STRING_TestUnit            14      /* control type: string, callback function: (none) */
#define  PANEL_STRING_TestWeapon          15      /* control type: string, callback function: (none) */
#define  PANEL_STRING_TestTask            16      /* control type: string, callback function: (none) */
#define  PANEL_TEXTMSG_StartDate          17      /* control type: textMsg, callback function: (none) */


     /* Control Arrays: */

          /* (no control arrays in the resource file) */


     /* Menu Bars, Menus, and Menu Items: */

          /* (no menu bars in the resource file) */


     /* Callback Prototypes: */

int  CVICALLBACK ChooseEndDate(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK ChooseStartDate(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK HistoryQuery(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK QueryProjectList(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK QueryReturn(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);


#ifdef __cplusplus
    }
#endif
