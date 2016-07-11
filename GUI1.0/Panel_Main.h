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

#define  MAINPANEL                        1       /* callback function: MainPanelCallBack */
#define  MAINPANEL_STRING_MRecoilImpulse  2       /* control type: string, callback function: (none) */
#define  MAINPANEL_GRAPH_MesuredData      3       /* control type: graph, callback function: (none) */
#define  MAINPANEL_STRING_MRecoilTime     4       /* control type: string, callback function: (none) */
#define  MAINPANEL_STRING_MAverageRecoil  5       /* control type: string, callback function: (none) */
#define  MAINPANEL_STRING_MMaxRecoil      6       /* control type: string, callback function: (none) */
#define  MAINPANEL_TREE_MeasuredDataList  7       /* control type: tree, callback function: (none) */
#define  MAINPANEL_TB_StartPause          8       /* control type: textButton, callback function: AutoMeasureButton */
#define  MAINPANEL_STRING_MeasureNum      9       /* control type: string, callback function: (none) */
#define  MAINPANEL_STRING_GroupNum        10      /* control type: string, callback function: (none) */
#define  MAINPANEL_STRING_Environment     11      /* control type: string, callback function: (none) */
#define  MAINPANEL_CB_DeleteResult        12      /* control type: command, callback function: DeleteResult */
#define  MAINPANEL_CB_SaveAllResults      13      /* control type: command, callback function: SaveAllResults */
#define  MAINPANEL_LED_MeasureState       14      /* control type: LED, callback function: (none) */
#define  MAINPANEL_TEXTMSG_Welcome        15      /* control type: textMsg, callback function: (none) */
#define  MAINPANEL_PICTURE_Welcome        16      /* control type: picture, callback function: (none) */
#define  MAINPANEL_TIMER_DAQ              17      /* control type: timer, callback function: autoSampling */
#define  MAINPANEL_TEXTMSG_OpenedProject  18      /* control type: textMsg, callback function: (none) */
#define  MAINPANEL_STRIPCHART_SensorData  19      /* control type: strip, callback function: (none) */


     /* Control Arrays: */

          /* (no control arrays in the resource file) */


     /* Menu Bars, Menus, and Menu Items: */

#define  MENUBAR                          1
#define  MENUBAR_MENU_Project             2
#define  MENUBAR_MENU_Project_ITEM_NewProject 3   /* callback function: Menu_NewProject */
#define  MENUBAR_MENU_Project_ITEM_OpenProject 4  /* callback function: Menu_OpenProject */
#define  MENUBAR_MENU_Project_ITEM_CloseProject 5 /* callback function: Menu_CloseProject */
#define  MENUBAR_MENU_Project_SEPARATOR   6
#define  MENUBAR_MENU_Project_ITEM_NewGroup 7     /* callback function: Menu_NewMeasureGroup */
#define  MENUBAR_MENU_Project_ITEM_OpenGroup 8    /* callback function: Menu_OpenMeasureGroup */
#define  MENUBAR_MENU_Project_SEPARATOR_2 9
#define  MENUBAR_MENU_Project_ITEM_Quit   10      /* callback function: Menu_Exit */
#define  MENUBAR_MENU_Data                11
#define  MENUBAR_MENU_Data_ITEM_Query     12      /* callback function: Menu_HistoryQuery */
#define  MENUBAR_MENU_Data_SEPARATOR_4    13
#define  MENUBAR_MENU_Data_ITEM_GroupReport 14    /* callback function: Menu_GenerateMeasureGroupReport */
#define  MENUBAR_MENU_Data_ITEM_ProjectReport 15  /* callback function: Menu_GenerateProjectReport */
#define  MENUBAR_MENU_Help                16
#define  MENUBAR_MENU_Help_ITEM_Help      17      /* callback function: Menu_Help */
#define  MENUBAR_MENU_Help_SEPARATOR_3    18
#define  MENUBAR_MENU_Help_ITEM_About     19      /* callback function: Menu_About */


     /* Callback Prototypes: */

int  CVICALLBACK AutoMeasureButton(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK autoSampling(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK DeleteResult(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK MainPanelCallBack(int panel, int event, void *callbackData, int eventData1, int eventData2);
void CVICALLBACK Menu_About(int menubar, int menuItem, void *callbackData, int panel);
void CVICALLBACK Menu_CloseProject(int menubar, int menuItem, void *callbackData, int panel);
void CVICALLBACK Menu_Exit(int menubar, int menuItem, void *callbackData, int panel);
void CVICALLBACK Menu_GenerateMeasureGroupReport(int menubar, int menuItem, void *callbackData, int panel);
void CVICALLBACK Menu_GenerateProjectReport(int menubar, int menuItem, void *callbackData, int panel);
void CVICALLBACK Menu_Help(int menubar, int menuItem, void *callbackData, int panel);
void CVICALLBACK Menu_HistoryQuery(int menubar, int menuItem, void *callbackData, int panel);
void CVICALLBACK Menu_NewMeasureGroup(int menubar, int menuItem, void *callbackData, int panel);
void CVICALLBACK Menu_NewProject(int menubar, int menuItem, void *callbackData, int panel);
void CVICALLBACK Menu_OpenMeasureGroup(int menubar, int menuItem, void *callbackData, int panel);
void CVICALLBACK Menu_OpenProject(int menubar, int menuItem, void *callbackData, int panel);
int  CVICALLBACK SaveAllResults(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);

//初始化主窗口显示控件
int initpanelmain();
//打开项目后显示测量相关控件
int openproject();
//关闭项目后显示欢迎界面
int closeproject();
//打开测量组，激活测量相关控件
int openmeasuregroup();
//更新界面控件显示内容
int update();

#ifdef __cplusplus
    }
#endif
