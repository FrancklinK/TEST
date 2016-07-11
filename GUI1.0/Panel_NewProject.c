#include <ansi_c.h>
#include <cvirte.h>		
#include <userint.h>
#include <string.h>
#include <time.h>
#include <stdlib.h>
#include "Panel_NewProject.h"

#include "global.h"
#include "Database.h"
#include "Panel_Main.h"
#include <utility.h>

/*
int main (int argc, char *argv[])
{
	if (InitCVIRTE (0, argv, 0) == 0)
		return -1;	// out of memory 
	if ((panel_newproject = LoadPanel (0, "Panel_NewProject.uir", NPPANEL)) < 0)
		return -1;
	DisplayPanel (panel_newproject);
	RunUserInterface ();
	DiscardPanel (panel_newproject);
	return 0;
}
*/
int CVICALLBACK NewProjectSaveParamSetting (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_COMMIT:
			char buffer[BUFFERLEN] = "";
			GetCtrlVal(panel_newproject,NPPANEL_NUMERIC_TMNEG,&newproject.ParameterSetting.TestMeasurementsNumberEachGroup);
			sprintf(buffer,"%d",newproject.ParameterSetting.TestMeasurementsNumberEachGroup);
//			MessagePopup("每组测量次数",buffer);

			GetCtrlVal(panel_newproject,NPPANEL_RINGKNOB_FSMR,&newproject.ParameterSetting.ForceSensorMeasurementRange);
			sprintf(buffer,"%f",newproject.ParameterSetting.ForceSensorMeasurementRange);
//			MessagePopup("力传感器量程",buffer);

			GetCtrlVal(panel_newproject,NPPANEL_RINGKNOB_PMF,&newproject.ParameterSetting.PreMagnificationFactor);
			sprintf(buffer,"%f",newproject.ParameterSetting.PreMagnificationFactor);
//			MessagePopup("前置放大系数",buffer);

			GetCtrlVal(panel_newproject,NPPANEL_RINGKNOB_DSTR,&newproject.ParameterSetting.DigitalSamplingTerminalRange);
			sprintf(buffer,"%f",newproject.ParameterSetting.DigitalSamplingTerminalRange);
//			MessagePopup("数采终端量程",buffer);
			
			newproject.ParameterSetting.ShockThreshold = 
				1;
//			newproject.ParameterSetting.TestProjectReportLocation = 
//				;
			//恢复“下一步”按钮可用
			SetCtrlAttribute(panel_newproject,NPPANEL_CB_NPNext,ATTR_DIMMED,0);
			break;
	}
	return 0;
}

int CVICALLBACK NewProjectNext (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_COMMIT:
			switch (state_newproject)
			{
				case 0:
					//读取并记录新建项目信息
					GetCtrlVal(panel_newproject,NPPANEL_STRING_TaskName,newproject.TestTaskName);
					GetCtrlVal(panel_newproject,NPPANEL_STRING_TaskCode,newproject.TestTaskCode);
					GetCtrlVal(panel_newproject,NPPANEL_STRING_TestUnit,newproject.TestUnit);
					GetCtrlVal(panel_newproject,NPPANEL_STRING_TestWeapon,newproject.TestWeapon);
					GetCtrlVal(panel_newproject,NPPANEL_STRING_TestWeaponType,newproject.TestEquipmentType);
					GetCtrlVal(panel_newproject,NPPANEL_STRING_TestCreator,newproject.TestCreator);
					if (strcmp(newproject.TestTaskName, "") == 0 ||
						strcmp(newproject.TestUnit, "") == 0 ||
						strcmp(newproject.TestWeapon, "") == 0 ||
						strcmp(newproject.TestEquipmentType, "") == 0 ||
						strcmp(newproject.TestCreator, "") == 0)
					{
						MessagePopup("新建项目错误！","项目信息不能为空！");
						break;
					}
					//界面控件显示
					next();
					state_newproject ++;
					break;
				case 1:
					//读取并记录参数配置信息
				//*--- get local time	
					time_t rawtime;
					struct tm * timeinfo;
					time( &rawtime );
					timeinfo = localtime ( &rawtime );
				//*---	end get local time
					char buffer[BUFFERLEN] = "";
//					sprintf ( buffer, "%4d-%02d-%02d %02d:%02d:%02d", 1900+timeinfo->tm_year, 1+timeinfo->tm_mon,timeinfo->tm_mday,timeinfo->tm_hour,timeinfo->tm_min,timeinfo->tm_sec);
//					MessagePopup("riqishijian",buffer);																																				
//					break;
					sprintf(buffer,"%4d/%02d/%02d",1900+timeinfo->tm_year, 1+timeinfo->tm_mon,timeinfo->tm_mday);
					readdate(&newproject.TestCreateDate,buffer);
					sprintf(buffer,"%02d:%02d:%02d",timeinfo->tm_hour,timeinfo->tm_min,timeinfo->tm_sec);
					readtime(&newproject.TestCreateTime,buffer);
					sprintf(buffer,"projects\\%s",newproject.TestTaskName);
					strcpy(newproject.TestProjectLocation,buffer);
//					MessagePopup(buffer,buffer);
					MakeDir(buffer);
//					sprintf(buffer,"mkdir projects\\%s",newproject.TestTaskName);
//					system(buffer);
					addProjectRecord(newproject);
					//界面控件显示
					next();
					state_newproject ++;
					operatingproject = newproject;
					openproject();
					break;
				case 2:
					//界面控件显示																										 	
					initpanelnewproject();
					HidePanel (panel_newproject);
					DisplayPanel (panel_main);
					break;
			}
			break;
	}
	return 0;
}

int CVICALLBACK NewProjectBack (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_COMMIT:
			switch (state_newproject)
			{
				case 0:
					//界面控件显示
					break;
				case 1:	
					//界面控件显示
					back();
					state_newproject --;
					break;
				case 2:
					//界面控件显示
					back();
					state_newproject --;
					break;
			}
			break;
	}
	return 0;
}

int CVICALLBACK NewProjectCancel (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_COMMIT:
			state_newproject = 0;
			back();
			HidePanel (panel_newproject);
			DisplayPanel (panel_main);			
			break;
	}
	return 0;
}

//其他函数
int initpanelnewproject()
{
	//initialize variable & status
	InitProjectInfo(&newproject);
	
	state_newproject = 0;
	
	SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestWeaponType,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestCreator,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestWeapon,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestUnit,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TaskName,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TaskCode,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_newproject,NPPANEL_PICTURE_NPWelcome,ATTR_VISIBLE,1);
	
	SetCtrlAttribute(panel_newproject,NPPANEL_NUMERIC_TMNEG,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_newproject,NPPANEL_GRAPH_PS,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_newproject,NPPANEL_CB_ParamSetting,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_FSMR,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_DSTR,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_PMF,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_newproject,NPPANEL_TEXTMSG_Warning,ATTR_VISIBLE,0);
	
	SetCtrlAttribute(panel_newproject,NPPANEL_TEXTMSG_NPSuccess,ATTR_VISIBLE,0);

	SetCtrlAttribute(panel_newproject,NPPANEL_CB_NPBack,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_newproject,NPPANEL_CB_NPBack,ATTR_DIMMED,1);
	SetCtrlAttribute(panel_newproject,NPPANEL_CB_NPNext,ATTR_LABEL_TEXT,"下一步 >");
	return 0;
}

int next()
{
		switch (state_newproject)
		{
			case 0:
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestWeaponType,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestCreator,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestWeapon,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestUnit,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TaskName,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TaskCode,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_PICTURE_NPWelcome,ATTR_VISIBLE,0);
				
				SetCtrlAttribute(panel_newproject,NPPANEL_NUMERIC_TMNEG,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_GRAPH_PS,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_CB_ParamSetting,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_FSMR,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_DSTR,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_PMF,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_TEXTMSG_Warning,ATTR_VISIBLE,1);
				
				SetCtrlAttribute(panel_newproject,NPPANEL_TEXTMSG_NPSuccess,ATTR_VISIBLE,0);

				SetCtrlAttribute(panel_newproject,NPPANEL_CB_NPBack,ATTR_DIMMED,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_CB_NPNext,ATTR_DIMMED,1);
				break;
			case 1:	
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestWeaponType,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestCreator,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestWeapon,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestUnit,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TaskName,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TaskCode,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_PICTURE_NPWelcome,ATTR_VISIBLE,0);
				
				SetCtrlAttribute(panel_newproject,NPPANEL_NUMERIC_TMNEG,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_GRAPH_PS,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_CB_ParamSetting,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_FSMR,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_DSTR,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_PMF,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_TEXTMSG_Warning,ATTR_VISIBLE,0);
				
				SetCtrlAttribute(panel_newproject,NPPANEL_TEXTMSG_NPSuccess,ATTR_VISIBLE,1);

				SetCtrlAttribute(panel_newproject,NPPANEL_CB_NPBack,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_CB_NPNext,ATTR_LABEL_TEXT,"完成");
				break;
			case 2:
				break;
		}
	return 0;
}

int back()
{
		switch (state_newproject)
		{
			case 0:
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestWeaponType,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestCreator,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestWeapon,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestUnit,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TaskName,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TaskCode,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_PICTURE_NPWelcome,ATTR_VISIBLE,1);
				
				SetCtrlAttribute(panel_newproject,NPPANEL_NUMERIC_TMNEG,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_GRAPH_PS,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_CB_ParamSetting,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_FSMR,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_DSTR,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_PMF,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_TEXTMSG_Warning,ATTR_VISIBLE,0);
				
				SetCtrlAttribute(panel_newproject,NPPANEL_TEXTMSG_NPSuccess,ATTR_VISIBLE,0);

				SetCtrlAttribute(panel_newproject,NPPANEL_CB_NPBack,ATTR_DIMMED,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_CB_NPNext,ATTR_DIMMED,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_CB_NPNext,ATTR_LABEL_TEXT,"下一步 >");
				break;
			case 1:
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestWeaponType,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestCreator,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestWeapon,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestUnit,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TaskName,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TaskCode,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_PICTURE_NPWelcome,ATTR_VISIBLE,1);
				
				SetCtrlAttribute(panel_newproject,NPPANEL_NUMERIC_TMNEG,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_GRAPH_PS,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_CB_ParamSetting,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_FSMR,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_DSTR,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_PMF,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_TEXTMSG_Warning,ATTR_VISIBLE,0);
				
				SetCtrlAttribute(panel_newproject,NPPANEL_TEXTMSG_NPSuccess,ATTR_VISIBLE,0);

				SetCtrlAttribute(panel_newproject,NPPANEL_CB_NPBack,ATTR_DIMMED,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_CB_NPNext,ATTR_DIMMED,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_CB_NPNext,ATTR_LABEL_TEXT,"下一步 >");
				break;
			case 2:
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestWeaponType,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestCreator,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestWeapon,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TestUnit,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TaskName,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_STRING_TaskCode,ATTR_VISIBLE,0);
				SetCtrlAttribute(panel_newproject,NPPANEL_PICTURE_NPWelcome,ATTR_VISIBLE,0);
				
				SetCtrlAttribute(panel_newproject,NPPANEL_NUMERIC_TMNEG,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_GRAPH_PS,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_CB_ParamSetting,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_FSMR,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_DSTR,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_RINGKNOB_PMF,ATTR_VISIBLE,1);
				SetCtrlAttribute(panel_newproject,NPPANEL_TEXTMSG_Warning,ATTR_VISIBLE,1);
				
				SetCtrlAttribute(panel_newproject,NPPANEL_TEXTMSG_NPSuccess,ATTR_VISIBLE,0);

				SetCtrlAttribute(panel_newproject,NPPANEL_CB_NPNext,ATTR_LABEL_TEXT,"下一步 >");
				break;
		}

	return 0;
}







