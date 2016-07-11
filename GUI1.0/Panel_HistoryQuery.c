#include "Panel_Main.h"
#include <cvirte.h>		
#include <userint.h>
#include <string.h>
#include "Panel_HistoryQuery.h"

#include "global.h"
#include "MSCAL.h"
/*
int main (int argc, char *argv[])
{
	if (InitCVIRTE (0, argv, 0) == 0)
		return -1;	// out of memory
	if ((panel_query = LoadPanel (0, "Panel_HistoryQuery.uir", PANEL)) < 0)
		return -1;
	DisplayPanel (panel_query);
	RunUserInterface ();
	DiscardPanel (panel_query);
	return 0;
}
*/
int CVICALLBACK QueryProjectList (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	char buffer[BUFFERLEN] = "";
	int i = 0, j = 0, pi, gi, mi;
	switch (event)
	{
		case EVENT_VAL_CHANGED:
			GetTreeItem(panel,control,VAL_ALL,0,0,VAL_NEXT_PLUS_SELF,VAL_SELECTED,&i);
//			sscanf(buffer,"%d|%d|%d",&i,&j,&j);
			if (i > -1)
			{
				//��ȡѡ����Ŀ����Ŀ�б��е�λ��
				GetTreeItemAttribute(panel,PANEL_TREE_QueryProjectList,i,ATTR_CTRL_VAL,buffer);
				sscanf(buffer,"%d|%d|%d",&pi,&gi,&mi);
				//��ȡѡ����Ŀ��ϸ��Ϣ
//				newproject = projectlist.projects[pi-1];
//				getDetails(&newproject);
				if (gi == 0)//��Ŀ��Ŀ
				{
					sprintf(buffer,"%d",projectlist.projects[pi-1].TestedGroupNumber);
					MessagePopup("",buffer);
				}
				else
				{
					if (mi == 0)//��������Ŀ
					{
						sprintf(buffer,"%d",projectlist.projects[pi-1].MeasureGroups[gi-1].MeasuredNumber);
						MessagePopup("",buffer);
					}
					else
					{
						//������¼��Ŀ
						MessagePopup("",buffer);
					}
				}
			}
			break;
	}
	return 0;
}

int CVICALLBACK HistoryQuery (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int num = 0, i = 0, j = 0, k = 0, t = 0, resCode;
	char TestTask[MAXSTRLEN] = "";
	char TestWeapon[MAXSTRLEN] = "";
	char TestUnit[MAXSTRLEN] = "";
	char buffer[MAXSTRLEN] = "", buf[MAXSTRLEN] = "";
	char Tag[32] = "";
	_Date startDate, endDate;
	switch (event)
	{
		case EVENT_COMMIT:
			//�Ѷ�ȡȫ����Ŀ��Ϣ
			//��ѯ����
			GetCtrlVal(panel_query,PANEL_STRING_TestTask,TestTask);
			GetCtrlVal(panel_query,PANEL_STRING_TestWeapon,TestWeapon);
			GetCtrlVal(panel_query,PANEL_STRING_TestUnit,TestUnit);
			GetCtrlVal(panel_query,PANEL_TEXTMSG_StartDate,buffer);
			readdate(&startDate,buffer);
			GetCtrlVal(panel_query,PANEL_TEXTMSG_EndDate,buffer);
			readdate(&endDate,buffer);
			
			ClearListCtrl(panel, PANEL_TREE_QueryProjectList);
			
			//����ж��Ƿ���ϲ�ѯ����
			//���������ȡ��ϸ��Ϣ���������б���ʾ
			num = projectlist.number;
//			clock_t s,e;
//			s = clock();
			//������Ŀ��
			int treenum = 0;
			for (i = 0; i < num; i ++)
			{
				if (check(TestTask,TestWeapon,TestUnit,startDate,endDate,projectlist.projects[i]) == TRUE)
				{
					//��Ӹ���Ŀ��tree�ؼ���
					sprintf(buffer,"%d|%d|%d",i+1,0,0);
					t = InsertTreeItem(panel, PANEL_TREE_QueryProjectList, VAL_SIBLING, 0, VAL_LAST, projectlist.projects[i].TestTaskName, projectlist.projects[i].TestTaskName, Tag, buffer);
					treenum ++ ;
					resCode = SetTreeCellAttribute(panel,PANEL_TREE_QueryProjectList,t,1,ATTR_LABEL_TEXT,projectlist.projects[i].TestUnit);
					resCode = SetTreeCellAttribute(panel,PANEL_TREE_QueryProjectList,t,2,ATTR_LABEL_TEXT,projectlist.projects[i].TestCreateDate.DateSTR);
					resCode = SetTreeCellAttribute(panel,PANEL_TREE_QueryProjectList,t,3,ATTR_LABEL_TEXT,projectlist.projects[i].TestCreateTime.TimeSTR);
					resCode = SetTreeCellAttribute(panel,PANEL_TREE_QueryProjectList,t,4,ATTR_LABEL_TEXT,projectlist.projects[i].TestWeapon);
					//�����������
					int pt = t;
					for (j = 0; j < projectlist.projects[i].TestedGroupNumber; j ++)
					{
						sprintf(buf,"������No.%03d",j+1);
						sprintf(buffer,"%d|%d|%d",i+1,j+1,0);
						t = InsertTreeItem(panel, PANEL_TREE_QueryProjectList, VAL_CHILD, pt, VAL_LAST , buf, buf, Tag, buffer);
						/*
					resCode = SetTreeCellAttribute(panel,PANEL_TREE_QueryProjectList,t,1,ATTR_LABEL_TEXT,projectlist.projects[i].TestUnit);
					resCode = SetTreeCellAttribute(panel,PANEL_TREE_QueryProjectList,t,2,ATTR_LABEL_TEXT,projectlist.projects[i].TestCreateDate.DateSTR);
					resCode = SetTreeCellAttribute(panel,PANEL_TREE_QueryProjectList,t,3,ATTR_LABEL_TEXT,projectlist.projects[i].TestCreateTime.TimeSTR);
					resCode = SetTreeCellAttribute(panel,PANEL_TREE_QueryProjectList,t,4,ATTR_LABEL_TEXT,projectlist.projects[i].TestWeapon);
					*/
						int gt = t;
						//���������¼��
						for (k = 0; k < projectlist.projects[i].MeasureGroups[j].MeasuredNumber; k ++)
						{
							sprintf(buffer,"��%02d��������",k+1);
							sprintf(buffer,"%d|%d|%d",i+1,j+1,k+1);
							t = InsertTreeItem(panel, PANEL_TREE_QueryProjectList, VAL_CHILD, gt, VAL_LAST , buf, buf, Tag, buffer);
						}
					}
				}
			}
//			e = clock();
//			sprintf(buffer,"%d",e-s);
			SetCtrlVal(panel,PANEL_STRING_QAverageRecoil,buffer);
			break;
	}
	return 0;
}

int CVICALLBACK QueryReturn (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_COMMIT:
			HidePanel (panel_query);
			DisplayPanel (panel_main);
			break;
	}
	return 0;
}

int CVICALLBACK ChooseStartDate (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_COMMIT:
			CAObjHandle handle;
			short year, month, day;
			char buffer[BUFFERLEN] = "";
			GetObjHandleFromActiveXCtrl(panel,PANEL_CALENDAR_TestDate,&handle);
			MSACAL_ICalendarGetYear(handle,NULL,&year);
			MSACAL_ICalendarGetMonth(handle,NULL,&month);
			MSACAL_ICalendarGetDay(handle,NULL,&day);
			sprintf(buffer,"%4d/%02d/%02d",(int)year,(int)month,(int)day);
			SetCtrlVal(panel,PANEL_TEXTMSG_StartDate,buffer);
			break;
	}
	return 0;
}

int CVICALLBACK ChooseEndDate (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_COMMIT:
			CAObjHandle handle;
			short year, month, day;
			char buffer[BUFFERLEN] = "";
			GetObjHandleFromActiveXCtrl(panel,PANEL_CALENDAR_TestDate,&handle);
			MSACAL_ICalendarGetYear(handle,NULL,&year);
			MSACAL_ICalendarGetMonth(handle,NULL,&month);
			MSACAL_ICalendarGetDay(handle,NULL,&day);
			sprintf(buffer,"%4d/%02d/%02d",(int)year,(int)month,(int)day);
			SetCtrlVal(panel,PANEL_TEXTMSG_EndDate,buffer);
			break;
	}
	return 0;
}
