#include <cvirte.h>		
#include <userint.h>
#include "Panel_Main.h"
#include "Panel_OpenProject.h"
#include "Panel_NewProject.h"
#include "Panel_HistoryQuery.h"
#include <stdio.h>
#include <NIDAQmx.h>

#include "global.h"
#include "Database.h"

#include <utility.h>
#include <formatio.h>
#define DAQmxErrChk(functionCall) if( DAQmxFailed(error=(functionCall)) ) goto Error; else


int32 CVICALLBACK EveryNCallback(TaskHandle taskHandle, int32 everyNsamplesEventType, uInt32 nSamples, void *callbackData);
//int operatinggroupnum;
//int operatingmeasurenum;
SYSTEMTIME starttime, endtime;
clock_t startclock, endclock;

int __stdcall WinMain (HINSTANCE hInstance, HINSTANCE hPrevInstance,
                       LPSTR lpszCmdLine, int nCmdShow)
{
	if (InitCVIRTE (hInstance, 0, 0) == 0)
		return -1;	/* out of memory */
	if ((panel_main = LoadPanel (0, "Panel_Main.uir", MAINPANEL)) < 0)
		return -2;
	if ((panel_open = LoadPanel (0, "Panel_OpenProject.uir", OPPANEL)) < 0)
		return -3;
	if ((panel_newproject = LoadPanel (0, "Panel_NewProject.uir", NPPANEL)) < 0)
		return -4;
	if ((panel_query = LoadPanel (0, "Panel_HistoryQuery.uir", PANEL)) < 0)
		return -5;

	connectDatabase();
	
	//initialize panels
	initpanelmain();
	initpanelnewproject();
	
	DisplayPanel (panel_main);
	
	RunUserInterface ();
	
	DiscardPanel (panel_query);
	DiscardPanel (panel_open);
	DiscardPanel (panel_newproject);
	DiscardPanel (panel_main);
	
	freeProjectInfo(&operatingproject);
	freeProjectInfo(&newproject);
	freeProjectList(&projectlist);
	
	disconnectDatabase();
	
	return 0;
}

//��ʼ��ֹͣ����
int CVICALLBACK AutoMeasureButton (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	char buffer[BUFFERLEN] = "";
	int i;
	switch (event)
	{
		case EVENT_COMMIT:
			GetCtrlAttribute(panel_main,MAINPANEL_TB_StartPause,ATTR_LABEL_TEXT,buffer);
//			MessagePopup("label",buffer);
			GetCtrlAttribute(panel_main,MAINPANEL_TB_StartPause,ATTR_CTRL_VAL,&i);
			sprintf(buffer,"%d",i);
//			MessagePopup("value",buffer);
			if (i == 1)
			{
				if (state_main != 2)
				{
					SetCtrlAttribute(panel_main,MAINPANEL_TB_StartPause,ATTR_CTRL_VAL,0);
					MessagePopup("��ʼ��������","���ȴ򿪲�����򴴽��µĲ�������ִ�в�������");
				}
				else
				{
					//��ʼ����
					//disconnectDatabase();
					SetCtrlVal(panel_main,MAINPANEL_LED_MeasureState,1);
					wavelen = 0;
					DAQmxStartTask(hsample);
//					SetCtrlAttribute(panel_main,MAINPANEL_TIMER_DAQ,ATTR_ENABLED,1);
					state_main = 3;//���ڲ�����
				}
			}
			else
			{
				if (state_main == 3)
				{
					//ֹͣ����
					SetCtrlVal(panel_main,MAINPANEL_LED_MeasureState,0);
					DAQmxStopTask(hsample);
//					SetCtrlAttribute(panel_main,MAINPANEL_TIMER_DAQ,ATTR_ENABLED,0);
					state_main = 2;//ֹͣ����
				}
				else
				{
					SetCtrlAttribute(panel_main,MAINPANEL_TB_StartPause,ATTR_CTRL_VAL,1);
					MessagePopup("","��ȵ�ǰ�������ݴ������֮����ִ��ֹͣ��������");
				}
			}
			break;
	}
	return 0;
}

//ɾ��ѡ�в�����¼
int CVICALLBACK DeleteResult (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_COMMIT:

			break;
	}
	return 0;
}

//�������в�����¼
int CVICALLBACK SaveAllResults (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	char buffer[BUFFERLEN] = "";
	switch (event)
	{
		case EVENT_COMMIT:
	int i;
	startclock = clock();
	for (i = 0 ; i < 10000;){
//		wave[i] = data[i];
		i ++;
	}
	endclock = clock();
	sprintf(buffer,"%d",endclock - startclock);
	SetCtrlVal(panel_main,MAINPANEL_STRING_MRecoilTime,buffer);
			break;
	}
	return 0;
}

//�½�������Ŀ
void CVICALLBACK Menu_NewProject (int menuBar, int menuItem, void *callbackData,
		int panel)
{
	DisplayPanel (panel_newproject);
	HidePanel (panel_main);
	return ;
}

//�򿪲�����Ŀ
void CVICALLBACK Menu_OpenProject (int menuBar, int menuItem, void *callbackData,
		int panel)
{
	getAllProjectsInfo(&projectlist);
	loadprojects();
	DisplayPanel (panel_open);
	HidePanel (panel_main);
	return ;
}

//�رյ�ǰ��Ŀ
void CVICALLBACK Menu_CloseProject (int menuBar, int menuItem, void *callbackData,
		int panel)
{
	closeproject();
	return ;
}

//�½�������
void CVICALLBACK Menu_NewMeasureGroup (int menuBar, int menuItem, void *callbackData,
		int panel)
{
	//����Ƿ��Ѿ�����Ŀ
	if (strcmp(operatingproject.TestTaskName,"") == 0)
		MessagePopup("�½����������","���ڴ���Ŀ֮��ִ�д˲���");
	else
	{
		char buffer[BUFFERLEN] = "";
		GetCtrlVal(panel_main,MAINPANEL_STRING_Environment,buffer);
		if (strcmp(buffer,"") == 0)
			MessagePopup("�½����������","�����뵱ǰ������������");
		else
		{
			int num,i;
			PMG pmg;
//			GetCtrlVal(panel_main,MAINPANEL_STRING_GroupNum,buffer);
//			sscanf(buffer,"%d//%d",&operatinggroupnumber,&i);
			
			//�����ǰ�������ѽ��в������Զ�����������
			if (operatinggroupnum != 0 && state_main > 2)
			{
				saveMeasureGroupResult(&operatingproject,operatinggroupnum);
			}
			
			num = operatingproject.TestedGroupNumber+1;
			pmg = (PMG) malloc(sizeof(MG) * num);
			if (operatingproject.MeasureGroups)
			{
				for (i = 0; i < num-1; i++)
				{
					*(pmg+i) = *(operatingproject.MeasureGroups+i);
				}
				free(operatingproject.MeasureGroups);
			}
			else
			{}
			InitMeasureGroup(pmg+num-1);
			(pmg+num-1)->Number = num;
			(pmg+num-1)->MeasureResults = (PMR) malloc(sizeof(MR) * operatingproject.ParameterSetting.TestMeasurementsNumberEachGroup);
			for (i = 0; i < operatingproject.ParameterSetting.TestMeasurementsNumberEachGroup; i ++ )
			{
				InitMeasureResult((pmg+num-1)->MeasureResults+i);
			}
			GetCtrlVal(panel_main,MAINPANEL_STRING_Environment,(pmg+num-1)->Environment);
			operatingproject.MeasureGroups = pmg;
			operatingproject.TestedGroupNumber ++;
			operatinggroupnum = num;
			operatingmeasurenum = 0;
//			operatingproject.TestedGroupNumber = num;
			
			char buffer[MAXSTRLEN] = "";
			sprintf(buffer,"%s\\%d",operatingproject.TestProjectLocation,operatinggroupnum);
			MakeDir(buffer);
			addMeasureGroupRecord(operatingproject, num);
			creatNewMeasureDataResultTable(operatingproject.TestTaskName,operatinggroupnum);
			
			update();
			state_main = 2;//�Ѵ򿪲�����
		}
	}
	return ;
}

//�򿪲�����
void CVICALLBACK Menu_OpenMeasureGroup (int menuBar, int menuItem, void *callbackData,
		int panel)
{
	//����Ƿ��Ѿ�����Ŀ
	if (strcmp(operatingproject.TestTaskName,"") == 0)
		MessagePopup("�򿪲��������","���ڴ���Ŀ֮��ִ�д˲���");
	else
	{
		getDetails(&operatingproject);
		loadmeasuregroups();
		DisplayPanel (panel_open);
		HidePanel (panel_main);
	}
	return ;
}

//�˳�����
void CVICALLBACK Menu_Exit (int menuBar, int menuItem, void *callbackData,
		int panel)
{
	QuitUserInterface (0);
	return ;
}

//��ʷ���ݲ�ѯ
void CVICALLBACK Menu_HistoryQuery (int menuBar, int menuItem, void *callbackData,
		int panel)
{
	if (state_main > 2)//������
	{
		DAQmxStopTask(hsample);
		state_main = 2;//ֹͣ����
		SetCtrlAttribute(panel_main,MAINPANEL_TB_StartPause,ATTR_CTRL_VAL,0);
		MessagePopup("�Զ���ͣ����","������ʷ���ݲ�ѯ����");
	}
	int i = 0;
	getAllProjectsInfo(&projectlist);
	for (i = 0; i < projectlist.number; i ++)
	{
		getDetails(projectlist.projects + i);
	}
	DisplayPanel (panel_query);
	HidePanel (panel_main);
	return ;
}

//���ɲ����鱨��
void CVICALLBACK Menu_GenerateMeasureGroupReport (int menuBar, int menuItem, void *callbackData,
		int panel)
{
	return ;
}

//������Ŀ����
void CVICALLBACK Menu_GenerateProjectReport (int menuBar, int menuItem, void *callbackData,
		int panel)
{
	return ;
}

//�鿴�����ĵ�
void CVICALLBACK Menu_Help (int menuBar, int menuItem, void *callbackData,
		int panel)
{
	return ;
}

//���� ����������ϵͳ��
void CVICALLBACK Menu_About (int menuBar, int menuItem, void *callbackData,
		int panel)
{
	MessagePopup("���� ��������ϵͳ","������������");
	return ;
}

//��������Ӧ����
int CVICALLBACK MainPanelCallBack (int panel, int event, void *callbackData,
		int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_GOT_FOCUS:

			break;
		case EVENT_LOST_FOCUS:

			break;
		case EVENT_CLOSE:
			QuitUserInterface(0);
			break;
	}
	return 0;
}

int  CVICALLBACK autoSampling(int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	
	return 0;
}


//��������
int32 CVICALLBACK EveryNCallback(TaskHandle taskHandle, int32 everyNsamplesEventType, uInt32 nSamples, void *callbackData)
{
	int32       error=0;
	char        errBuff[2048]={'\0'};
	static int  totalRead=0;
	int32       read=0;

	/*********************************************/
	// DAQmx Read Code
	/*********************************************/
//
	DAQmxErrChk (DAQmxReadAnalogF64(taskHandle,arraylen/*DAQmx_Val_Auto*/,10.0,DAQmx_Val_GroupByScanNumber,data,samplinglen,&read,NULL));
//	DAQmxErrChk (DAQmxReadDigitalU16 (taskHandle, DAQmx_Val_Auto, 10.0, DAQmx_Val_GroupByChannel, idata, samplinglen, &read, 0));
	/*
	if( read>0 ) {
		printf("Acquired %d samples. Total %d\r",(int)read,(int)(totalRead+=read));
		fflush(stdout);
	}
	*/
	//�Ѷ��������ݷ��뱾�ػ���
//	addSignals(data,read);
	//ArrayToFile ("D:\\temp.dat", data, VAL_FLOAT, read, 1, VAL_GROUPS_TOGETHER, VAL_GROUPS_AS_COLUMNS, VAL_CONST_WIDTH, 10, VAL_BINARY, VAL_APPEND);
	int i = 0;
	
	startclock = clock();
	
	if (wavelen == 0)
	{
		double threshold = operatingproject.ParameterSetting.ShockThreshold;
		for (i = 0; i < pointsshown; i ++)
		{
			if (data[i] > threshold)
			{
				state_main = 5;//������¼��
				update();
				break;
			}
		}
	}
	for (; i < pointsshown; i ++)
	{
		wave[wavelen ++] = data[i];
		if (wavelen >= recordlen)
		{
			DAQmxStopTask(hsample);
			state_main = 6;//�ļ�������
			update();

			char fname[MAXSTRLEN] = "";
			
			operatingproject.MeasureGroups[operatinggroupnum-1].MeasuredNumber ++;
			operatingmeasurenum = operatingproject.MeasureGroups[operatinggroupnum-1].MeasuredNumber;
		//*--- get local time	
			time_t rawtime;
			struct tm * timeinfo;
			time( &rawtime );
			timeinfo = localtime ( &rawtime );
		//*---	end get local time
			sprintf(fname,"%4d/%02d/%02d",1900+timeinfo->tm_year, 1+timeinfo->tm_mon,timeinfo->tm_mday);
			readdate(&operatingproject.MeasureGroups[operatinggroupnum-1].MeasureResults[operatingmeasurenum-1].Date,fname);
			sprintf(fname,"%02d:%02d:%02d",timeinfo->tm_hour,timeinfo->tm_min,timeinfo->tm_sec);
			readtime(&operatingproject.MeasureGroups[operatinggroupnum-1].MeasureResults[operatingmeasurenum-1].Time,fname);

			sprintf(fname,"%s_%d_%d_%4d%02d%02d_%02d%02d%02d.dat", operatingproject.TestTaskName, operatinggroupnum,operatingmeasurenum,
				1900+timeinfo->tm_year, 1+timeinfo->tm_mon, timeinfo->tm_mday, timeinfo->tm_hour, timeinfo->tm_min, timeinfo->tm_sec);
//			MessagePopup("0",fname);
			strcpy(operatingproject.MeasureGroups[operatinggroupnum-1].MeasureResults[operatingmeasurenum-1].DataFileName, fname);
//			MessagePopup("1",fname);
			sprintf(fname,"%s\\%d\\%s",operatingproject.TestProjectLocation, operatinggroupnum, operatingproject.MeasureGroups[operatinggroupnum-1].MeasureResults[operatingmeasurenum-1].DataFileName);
//			MessagePopup("2",fname);
			strcpy(operatingproject.MeasureGroups[operatinggroupnum-1].MeasureResults[operatingmeasurenum-1].DataFileLocation, fname);
//			MessagePopup("3",fname);
			
			FILE * fp = fopen(fname,"w+");
			fclose(fp);
			ArrayToFile (fname, wave, VAL_DOUBLE, wavelen, 1, VAL_GROUPS_TOGETHER, VAL_GROUPS_AS_COLUMNS, VAL_CONST_WIDTH, 10, VAL_ASCII, VAL_TRUNCATE);
			
			double sum = 0, maxrecoil = 0, meanrecoil = 0, recoiltime = 0, impulse = 0;
			int end = 0, j = 0;
			
			for (j = 0; j < wavelen; j ++)
			{
				sum += wave[j];
				if (wave[j] > maxrecoil)
				{
					maxrecoil = wave[j];
				}
				if (wave[j] < operatingproject.ParameterSetting.ShockThreshold)
				{
					end = j;
				}
			}
			meanrecoil = sum / (end+1);
			recoiltime = (double)(end+1) / samplingrate;//s
			
			operatingproject.MeasureGroups[operatinggroupnum-1].MeasureResults[operatingmeasurenum-1].MaxRecoil = maxrecoil;
			operatingproject.MeasureGroups[operatinggroupnum-1].MeasureResults[operatingmeasurenum-1].MeanRecoil = meanrecoil;
			operatingproject.MeasureGroups[operatinggroupnum-1].MeasureResults[operatingmeasurenum-1].RecoilTime = recoiltime * 1000;//ms
			operatingproject.MeasureGroups[operatinggroupnum-1].MeasureResults[operatingmeasurenum-1].RecoilImpulse = meanrecoil * recoiltime;
			
			operatingproject.MeasureGroups[operatinggroupnum-1].MeasureResults[operatingmeasurenum-1].Number = operatingmeasurenum;

			DeleteGraphPlot(panel_main,MAINPANEL_GRAPH_MesuredData,-1,VAL_IMMEDIATE_DRAW);
			int plot = PlotWaveform (panel_main, MAINPANEL_GRAPH_MesuredData, wave, wavelen, VAL_DOUBLE, 1.0, 0.0, 0.0, 1.0/samplingrate, VAL_CONNECTED_POINTS,VAL_BOLD_X,VAL_SOLID,wavelen,VAL_RED);
			SetAxisScalingMode (panel_main, MAINPANEL_GRAPH_MesuredData, VAL_LEFT_YAXIS, VAL_MANUAL, 0.0, maxrecoil * 1.2);
//			RefreshGraph (panel_main, MAINPANEL_GRAPH_MesuredData);
//			SetPlotAttribute(,,,
			wavelen = 0;
			if (operatingmeasurenum < operatingproject.ParameterSetting.TestMeasurementsNumberEachGroup)
			{
				//��������
				DAQmxStartTask(hsample);
				state_main = 4;//������
			}
			else
			{
				//��������������Զ�����
				operatingproject.MeasureGroups[operatinggroupnum-1].isMeasurementFinished = 1;
				SetCtrlVal(panel_main,MAINPANEL_TB_StartPause,0);
				saveMeasureGroupResult(&operatingproject,operatinggroupnum);
				state_main = 3;//���й�����
			}
			update();
			break;
		}
	}
	
	endclock = clock();
//	printf("Wave Length: %d . pointsshown: %d\r",wavelen,recordlen);
//	fflush(stdout);
	
//	sprintf(errBuff,"%d",endclock - startclock);
//	SetCtrlVal(panel_main,MAINPANEL_STRING_MRecoilTime,errBuff);
	ClearStripChart (panel_main, MAINPANEL_STRIPCHART_SensorData);
	PlotStripChart (panel_main, MAINPANEL_STRIPCHART_SensorData, data, pointsshown, 0, 0, VAL_DOUBLE);

Error:
	if( DAQmxFailed(error) ) {
		DAQmxGetExtendedErrorInfo(errBuff,2048);
		/*********************************************/
		// DAQmx Stop Code
		/*********************************************/
		DAQmxStopTask(taskHandle);
		DAQmxClearTask(taskHandle);
		printf("DAQmx Error: %s\n",errBuff);
	}
	return 0;
}


//��ʼ����������ʾ�ؼ�
int initpanelmain()
{
	//initialize variable & status
	InitProjectInfo(&operatingproject);
	InitProjectList(&projectlist);
	
	state_main = 0;
	SetCtrlAttribute(panel_main,MAINPANEL_STRIPCHART_SensorData,ATTR_POINTS_PER_SCREEN,pointsshown);

	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MRecoilImpulse,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_GRAPH_MesuredData,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MRecoilTime,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MAverageRecoil,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MMaxRecoil,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_TREE_MeasuredDataList,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_TB_StartPause,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MeasureNum,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_GroupNum,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_Environment,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_CB_DeleteResult,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_CB_SaveAllResults,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_STRIPCHART_SensorData,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_LED_MeasureState,ATTR_VISIBLE,0);	
	SetCtrlAttribute(panel_main,MAINPANEL_TEXTMSG_OpenedProject,ATTR_VISIBLE,0);	
	
	SetCtrlAttribute(panel_main,MAINPANEL_TEXTMSG_Welcome,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_main,MAINPANEL_PICTURE_Welcome,ATTR_VISIBLE,1);

//	SetAxisRange (panel_main,MAINPANEL_STRIPCHART_SensorData,VAL_MANUAL,0.0,1.0/samplingrate,VAL_AUTOSCALE,0.0,0.0);
	SetCtrlAttribute(panel_main,MAINPANEL_STRIPCHART_SensorData,ATTR_XAXIS_OFFSET,0.0);
	SetCtrlAttribute(panel_main,MAINPANEL_STRIPCHART_SensorData,ATTR_XAXIS_GAIN,1.0/samplingrate);
	SetAxisScalingMode (panel_main, MAINPANEL_STRIPCHART_SensorData, VAL_LEFT_YAXIS, VAL_AUTOSCALE, 0.0, 0.0);
	SetAxisScalingMode (panel_main, MAINPANEL_GRAPH_MesuredData, VAL_LEFT_YAXIS, VAL_AUTOSCALE, 0.0, 0.0);
/*	int i = GetPanelMenuBar(panel_main);
	char buffer[64] = "";
	sprintf(buffer,"%d",i);
	MessagePopup("���� ��������ϵͳ",buffer);
	//MenuBar Item
	SetCtrlAttribute(panel_main,MENUBAR_MENU_Project_ITEM_NewGroup,ATTR_DIMMED,1);
	SetCtrlAttribute(panel_main,MENUBAR_MENU_Project_ITEM_OpenGroup,ATTR_DIMMED,1);
	*/
	return 0;
}

//����Ŀ����ʾ������ؿؼ�
int openproject()
{
	//��ʾ��Ŀ����
	char buffer[BUFFERLEN] = "";
	sprintf(buffer,"��ǰ�Ѵ���Ŀ��%s",operatingproject.TestTaskName);
	SetCtrlVal(panel_main,MAINPANEL_TEXTMSG_OpenedProject,buffer);
	
	SetCtrlAttribute(panel_main,MAINPANEL_TEXTMSG_Welcome,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_PICTURE_Welcome,ATTR_VISIBLE,0);
	
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MRecoilImpulse,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_main,MAINPANEL_GRAPH_MesuredData,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MRecoilTime,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MAverageRecoil,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MMaxRecoil,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_main,MAINPANEL_TREE_MeasuredDataList,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_main,MAINPANEL_TB_StartPause,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MeasureNum,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_GroupNum,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_Environment,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_main,MAINPANEL_CB_DeleteResult,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_main,MAINPANEL_CB_SaveAllResults,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_main,MAINPANEL_STRIPCHART_SensorData,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_main,MAINPANEL_LED_MeasureState,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_main,MAINPANEL_TEXTMSG_OpenedProject,ATTR_VISIBLE,1);
	
	//ģ������������
	//������������
	DAQmxCreateTask ("", &hsample);
	DAQmxCreateAIVoltageChan (hsample, "CPCI3000/ai0", "", DAQmx_Val_Cfg_Default, 0.0, operatingproject.ParameterSetting.DigitalSamplingTerminalRange, DAQmx_Val_Volts, NULL);
	//����ɨ������
	DAQmxCfgSampClkTiming (hsample, "", samplingrate, DAQmx_Val_Rising, DAQmx_Val_ContSamps, samplinglen);
	//�����Զ���Ӧ����
	DAQmxRegisterEveryNSamplesEvent (hsample,DAQmx_Val_Acquired_Into_Buffer,arraylen,0,EveryNCallback,NULL);

	operatinggroupnum = 0;
	operatingmeasurenum = 0;
	update();
/*	//MenuBar Item
	SetCtrlAttribute(panel_main,MENUBAR_MENU_Project_ITEM_NewGroup,ATTR_DIMMED,0);
	SetCtrlAttribute(panel_main,MENUBAR_MENU_Project_ITEM_OpenGroup,ATTR_DIMMED,0);
	*/
	state_main = 1;//�Ѵ���Ŀ
	return 0;
}

//�ر���Ŀ����ʾ��ӭ����
int closeproject()
{
	//��ղ�������Ŀ����
	freeProjectInfo(&operatingproject);
	
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MRecoilImpulse,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_GRAPH_MesuredData,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MRecoilTime,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MAverageRecoil,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MMaxRecoil,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_TREE_MeasuredDataList,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_TB_StartPause,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MeasureNum,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_GroupNum,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_STRING_Environment,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_CB_DeleteResult,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_CB_SaveAllResults,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_STRIPCHART_SensorData,ATTR_VISIBLE,0);
	SetCtrlAttribute(panel_main,MAINPANEL_LED_MeasureState,ATTR_VISIBLE,0);	
	SetCtrlAttribute(panel_main,MAINPANEL_TEXTMSG_OpenedProject,ATTR_VISIBLE,0);	
	
	SetCtrlAttribute(panel_main,MAINPANEL_TEXTMSG_Welcome,ATTR_VISIBLE,1);
	SetCtrlAttribute(panel_main,MAINPANEL_PICTURE_Welcome,ATTR_VISIBLE,1);
	
	//ȡ����������
	DAQmxClearTask(hsample);

/*	//MenuBar Item
	SetCtrlAttribute(panel_main,MENUBAR_MENU_Project_ITEM_NewGroup,ATTR_DIMMED,1);
	SetCtrlAttribute(panel_main,MENUBAR_MENU_Project_ITEM_OpenGroup,ATTR_DIMMED,1);
	*/
	state_main = 0;//��ʼ״̬
	return 0;
}

//�򿪲����飬���������ؿؼ�
int openmeasuregroup()
{
	update();
	getDetails(&operatingproject);
	state_main = 2;//�Ѵ򿪲�����
	return 0;
}

//���½���ؼ���ʾ����
int update()
{
	char buffer[BUFFERLEN] = "";
	sprintf(buffer,"%d/%d", operatinggroupnum, operatingproject.TestedGroupNumber);
//	SetCtrlAttribute(panel_main,MAINPANEL_STRING_GroupNum,ATTR_CTRL_MODE,VAL_HOT);
	SetCtrlVal(panel_main,MAINPANEL_STRING_GroupNum,buffer);
//	SetCtrlAttribute(panel_main,MAINPANEL_STRING_GroupNum,ATTR_CTRL_MODE,VAL_INDICATOR);
	sprintf(buffer,"%d/%d", operatingmeasurenum, operatingproject.ParameterSetting.TestMeasurementsNumberEachGroup);
//	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MeasureNum,ATTR_CTRL_MODE,VAL_HOT);
	SetCtrlVal(panel_main,MAINPANEL_STRING_MeasureNum,buffer);
//	SetCtrlAttribute(panel_main,MAINPANEL_STRING_MeasureNum,ATTR_CTRL_MODE,VAL_INDICATOR);
	
	switch(state_main)
	{
		case 1:
		case 2:
		case 3:
			SetCtrlAttribute(panel_main,MAINPANEL_LED_MeasureState,ATTR_ON_COLOR,VAL_GREEN);
			SetCtrlVal(panel_main,MAINPANEL_LED_MeasureState,0);
			break;
		case 4:
			SetCtrlAttribute(panel_main,MAINPANEL_LED_MeasureState,ATTR_ON_COLOR,VAL_GREEN);
			SetCtrlVal(panel_main,MAINPANEL_LED_MeasureState,1);
			break;
		case 5:
			SetCtrlAttribute(panel_main,MAINPANEL_LED_MeasureState,ATTR_ON_COLOR,VAL_OFFWHITE);
			SetCtrlVal(panel_main,MAINPANEL_LED_MeasureState,1);
			break;
		case 6:
			SetCtrlAttribute(panel_main,MAINPANEL_LED_MeasureState,ATTR_ON_COLOR,VAL_YELLOW);
			SetCtrlVal(panel_main,MAINPANEL_LED_MeasureState,1);
			break;
	}
	
	ClearListCtrl(panel_main, MAINPANEL_TREE_MeasuredDataList);
	if (operatinggroupnum > 0)
	{
		int num = operatingproject.MeasureGroups[operatinggroupnum-1].MeasuredNumber, i = 0, j = 0;
		char Tag[32] = "";
		for (i = 0; i < num; i ++)
		{
			j = InsertTreeItem(panel_main, MAINPANEL_TREE_MeasuredDataList, VAL_SIBLING, 0, VAL_LAST, operatingproject.MeasureGroups[operatinggroupnum-1].MeasureResults[i].DataFileName, operatingproject.MeasureGroups[operatinggroupnum-1].MeasureResults[i].DataFileName, Tag, i+1);
		}
		if (operatingmeasurenum > 0)
		{
			sprintf(buffer,"%f N",operatingproject.MeasureGroups[operatinggroupnum-1].MeasureResults[operatingmeasurenum-1].MaxRecoil);
			SetCtrlVal(panel_main,MAINPANEL_STRING_MMaxRecoil,buffer);
			sprintf(buffer,"%f N",operatingproject.MeasureGroups[operatinggroupnum-1].MeasureResults[operatingmeasurenum-1].MeanRecoil);
			SetCtrlVal(panel_main,MAINPANEL_STRING_MAverageRecoil,buffer);
			sprintf(buffer,"%f ms",operatingproject.MeasureGroups[operatinggroupnum-1].MeasureResults[operatingmeasurenum-1].RecoilTime);
			SetCtrlVal(panel_main,MAINPANEL_STRING_MRecoilTime,buffer);
			sprintf(buffer,"%f N��s",operatingproject.MeasureGroups[operatinggroupnum-1].MeasureResults[operatingmeasurenum-1].RecoilImpulse);
			SetCtrlVal(panel_main,MAINPANEL_STRING_MRecoilImpulse,buffer);
		}
	}
	
	return 0;
}


















