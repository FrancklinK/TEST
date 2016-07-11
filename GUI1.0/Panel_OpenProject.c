#include <ansi_c.h>
#include <cvirte.h>		
#include <userint.h>
//#include <windows.h>
#include "Panel_OpenProject.h"

#include "global.h"
#include "Panel_Main.h"
	/*
int main (int argc, char *argv[])
{
	if (InitCVIRTE (0, argv, 0) == 0)
		return -1;	// out of memory
	if ((panel_open = LoadPanel (0, "Panel_OpenProject.uir", OPPANEL)) < 0)
		return -1;
	DisplayPanel (panel_open);
	RunUserInterface ();
	DiscardPanel (panel_open);
	return 0;
}
*/
int CVICALLBACK OpenProjectCancel (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_COMMIT:
			HidePanel (panel_open);
			DisplayPanel (panel_main);
			break;
	}
	return 0;
}

int CVICALLBACK OpenProjectConfirm (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_COMMIT:
			int i, checked;
/*			for (i = 0; i < projectlist.number; i++)
			{
				IsListItemChecked(panel_open,OPPANEL_TREE_ProjectList,i,&checked);
				if (checked)
				{
					MessagePopup("Number of Projects","checked");
					operatingproject = projectlist.projects[i];
					break;
				}
			}*/
			GetTreeItem(panel_open,OPPANEL_TREE_ProjectList,VAL_ALL,0,0,VAL_NEXT_PLUS_SELF,VAL_SELECTED,&i);
			if (i == -1)
			{
				MessagePopup("打开时出错！","请选中某项后再点击打开按钮");
				return -1;
			}
			if (state_open == 1)
			{
				operatingproject = projectlist.projects[i];
				getDetails(&operatingproject);
				openproject();
			}
			else
			{
				operatinggroupnum = i+1;
				openmeasuregroup();
			}
			HidePanel (panel_open);
			state_open = 0;
			DisplayPanel (panel_main);
			break;
	}
	return 0;
}

int loadprojects()
{
	int i,j,resCode;
	char Tag[32] = "";
//	SetWindowText("打开项目");
	SetPanelAttribute(panel_open,ATTR_TITLE,"打开项目");
	SetCtrlAttribute(panel_open,OPPANEL_TREE_ProjectList,ATTR_LABEL_TEXT,"测试项目列表");
	ClearListCtrl(panel_open, OPPANEL_TREE_ProjectList);
	SetTreeColumnAttribute(panel_open,OPPANEL_TREE_ProjectList,0,ATTR_LABEL_TEXT,"测试项目名称");
	SetTreeColumnAttribute(panel_open,OPPANEL_TREE_ProjectList,1,ATTR_LABEL_TEXT,"项目创建日期");
	SetTreeColumnAttribute(panel_open,OPPANEL_TREE_ProjectList,2,ATTR_LABEL_TEXT,"项目创建时间");
	SetTreeColumnAttribute(panel_open,OPPANEL_TREE_ProjectList,3,ATTR_LABEL_TEXT,"已有测量组数");
	SetTreeColumnAttribute(panel_open,OPPANEL_TREE_ProjectList,0,ATTR_COLUMN_WIDTH,125);
	SetTreeColumnAttribute(panel_open,OPPANEL_TREE_ProjectList,1,ATTR_COLUMN_WIDTH,80);
	SetTreeColumnAttribute(panel_open,OPPANEL_TREE_ProjectList,2,ATTR_COLUMN_WIDTH,80);
	SetTreeColumnAttribute(panel_open,OPPANEL_TREE_ProjectList,3,ATTR_COLUMN_WIDTH,80);
	for (i = 0; i < projectlist.number; i++)
	{
		j = InsertTreeItem(panel_open,OPPANEL_TREE_ProjectList,VAL_SIBLING,i-1,VAL_LAST,projectlist.projects[i].TestTaskName,projectlist.projects[i].TestTaskName,Tag,i+1);
		resCode = SetTreeCellAttribute(panel_open,OPPANEL_TREE_ProjectList,j,1,ATTR_LABEL_TEXT,projectlist.projects[i].TestCreateDate.DateSTR);
		resCode = SetTreeCellAttribute(panel_open,OPPANEL_TREE_ProjectList,j,2,ATTR_LABEL_TEXT,projectlist.projects[i].TestCreateTime.TimeSTR);
		char buffer[BUFFERLEN] = "";
		sprintf(buffer,"%d",projectlist.projects[i].TestedGroupNumber);
		resCode = SetTreeCellAttribute(panel_open,OPPANEL_TREE_ProjectList,j,3,ATTR_LABEL_TEXT,buffer);
//		MessagePopup("",Tag);
	}
	state_open = 1;
	return 0;
}

int loadmeasuregroups()
{
	int i,j,resCode;
	char Tag[32], buffer[BUFFERLEN] = "";
//	SetWindowText("打开测量组");
	SetPanelAttribute(panel_open,ATTR_TITLE,"打开测量组");
	sprintf(buffer,"%s项目测量组列表",operatingproject.TestTaskName);
	SetCtrlAttribute(panel_open,OPPANEL_TREE_ProjectList,ATTR_LABEL_TEXT,buffer);
	ClearListCtrl(panel_open, OPPANEL_TREE_ProjectList);
	SetTreeColumnAttribute(panel_open,OPPANEL_TREE_ProjectList,0,ATTR_LABEL_TEXT,"测量组编号");
	SetTreeColumnAttribute(panel_open,OPPANEL_TREE_ProjectList,1,ATTR_LABEL_TEXT,"环境条件");
	SetTreeColumnAttribute(panel_open,OPPANEL_TREE_ProjectList,2,ATTR_LABEL_TEXT,"已执行/预设测量次数");
	SetTreeColumnAttribute(panel_open,OPPANEL_TREE_ProjectList,3,ATTR_LABEL_TEXT,"测量完成情况");
	SetTreeColumnAttribute(panel_open,OPPANEL_TREE_ProjectList,0,ATTR_COLUMN_WIDTH,120);
	SetTreeColumnAttribute(panel_open,OPPANEL_TREE_ProjectList,1,ATTR_COLUMN_WIDTH,90);
	SetTreeColumnAttribute(panel_open,OPPANEL_TREE_ProjectList,2,ATTR_COLUMN_WIDTH,120);
	SetTreeColumnAttribute(panel_open,OPPANEL_TREE_ProjectList,3,ATTR_COLUMN_WIDTH,80);
	for (i = 0; i < operatingproject.TestedGroupNumber; i++)
	{
		sprintf(buffer,"测量组%03d",i+1);
		j = InsertTreeItem(panel_open,OPPANEL_TREE_ProjectList,VAL_SIBLING,i-1,VAL_LAST,buffer,buffer,Tag,i+1);
		resCode = SetTreeCellAttribute(panel_open,OPPANEL_TREE_ProjectList,j,1,ATTR_LABEL_TEXT,operatingproject.MeasureGroups[i].Environment);
		sprintf(buffer,"%d / %d",operatingproject.MeasureGroups[i].MeasuredNumber,operatingproject.ParameterSetting.TestMeasurementsNumberEachGroup);
		resCode = SetTreeCellAttribute(panel_open,OPPANEL_TREE_ProjectList,j,2,ATTR_LABEL_TEXT,buffer);
		if (operatingproject.MeasureGroups[i].isMeasurementFinished == 0)
		{
			sprintf(buffer,"%s","未完成");
			resCode = SetTreeCellAttribute(panel_open,OPPANEL_TREE_ProjectList,j,3,ATTR_LABEL_TEXT,buffer);
			resCode = SetTreeCellAttribute(panel_open,OPPANEL_TREE_ProjectList,j,3,ATTR_LABEL_COLOR,VAL_RED);
		}
		else
		{
			sprintf(buffer,"%s","已完成");
			resCode = SetTreeCellAttribute(panel_open,OPPANEL_TREE_ProjectList,j,3,ATTR_LABEL_TEXT,buffer);
			resCode = SetTreeCellAttribute(panel_open,OPPANEL_TREE_ProjectList,j,3,ATTR_LABEL_COLOR,VAL_BLACK);
		}
//		MessagePopup("",Tag);
	}
	state_open = 2;
	return 0;
}

