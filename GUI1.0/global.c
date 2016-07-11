#include <ansi_c.h>
#include "global.h"

//初始化结构体
void InitDate(PDate Date)
{
	Date->Year = 2000;
	Date->Month = 1;
	Date->Day = 1;
	Date->DateSTR[0] = 0;
	return ;
}

void InitTime(PTime Time)
{
	Time->Hour = 0;
	Time->Minute = 0;
	Time->Second = 0;
	Time->TimeSTR[0] = 0;
	return ;
}

void InitMeasureResult(PMR MeasureResult)
{
	InitDate(&MeasureResult->Date);
	InitTime(&MeasureResult->Time);
	
	MeasureResult->Number = 0;
	MeasureResult->MaxRecoil = 0;
	MeasureResult->MeanRecoil = 0;
	MeasureResult->RecoilTime = 0;
	MeasureResult->RecoilImpulse = 0;
	MeasureResult->DataFileName[0] = 0;
	MeasureResult->DataFileLocation[0] = 0;
	return ;
}

void InitMeasureGroup(PMG MeasureGroup)
{
	MeasureGroup->Number = 0;
	MeasureGroup->Environment[0] = 0;
	MeasureGroup->MeasuredNumber = 0;
	MeasureGroup->isMeasurementFinished = 0;
	MeasureGroup->ReportLocation[0] = 0;
	
	MeasureGroup->MeasureResults = NULL;
//	MeasureGroup->NumberOfMeasureResults = 0;
	return ;
}

void InitProjectInfo(PPI ProjectInfo)
{
	InitDate(&ProjectInfo->TestCreateDate);
	InitTime(&ProjectInfo->TestCreateTime);
	
	ProjectInfo->TestTaskName[0] = 0;
	ProjectInfo->TestTaskCode[0] = 0;
	ProjectInfo->TestUnit[0] = 0;
	ProjectInfo->TestCreator[0] = 0;
	ProjectInfo->TestEquipmentType[0] = 0;
	ProjectInfo->TestWeapon[0] = 0;
	ProjectInfo->TestProjectLocation[0] = 0;
	ProjectInfo->TestedGroupNumber = 0;
	
	ProjectInfo->MeasureGroups = NULL;
//	ProjectInfo->NumberOfMeasureGroups = 0;
	return ;
}

void InitProjectList(PPL ProjectList)
{
	ProjectList->projects = NULL;
	ProjectList->number = 0;
	return ;
}


//清空结构体数据
void freeMeasureGroup(PMG MeasureGroup)
{
	if(MeasureGroup == NULL)
		return ;
	MeasureGroup->Number = 0;
	MeasureGroup->Environment[0] = 0;
	MeasureGroup->MeasuredNumber = 0;
	MeasureGroup->isMeasurementFinished = 0;
	MeasureGroup->ReportLocation[0] = 0;
	
	if (MeasureGroup->MeasureResults)
	{
		free(MeasureGroup->MeasureResults);
		MeasureGroup->MeasureResults = NULL;
	}
	MeasureGroup = NULL;
//	MeasureGroup->NumberOfMeasureResults = 0;
	return ;
}

void freeProjectInfo(PPI ProjectInfo)
{
	if(ProjectInfo == NULL)
		return ;
	InitDate(&ProjectInfo->TestCreateDate);
	InitTime(&ProjectInfo->TestCreateTime);
	ProjectInfo->TestTaskName[0] = 0;
	ProjectInfo->TestTaskCode[0] = 0;
	ProjectInfo->TestUnit[0] = 0;
	ProjectInfo->TestCreator[0] = 0;
	ProjectInfo->TestEquipmentType[0] = 0;
	ProjectInfo->TestWeapon[0] = 0;
	ProjectInfo->TestProjectLocation[0] = 0;
	ProjectInfo->TestedGroupNumber = 0;
	
	if (ProjectInfo->MeasureGroups)
	{
		free(ProjectInfo->MeasureGroups);
		ProjectInfo->MeasureGroups = NULL;
	}
	ProjectInfo = NULL;
//	ProjectInfo->NumberOfMeasureGroups = 0;
	return ;
}

void freeProjectList(PPL ProjectList)
{
	if(ProjectList == NULL)
		return ;
	if (ProjectList->projects)
	{
		free(ProjectList->projects);
		ProjectList->projects = NULL;
	}
	ProjectList->number = 0;
	ProjectList = NULL;
	return ;
}


//数据读写、判断
BOOL inrange(_Date StartDate, _Date EndDate, _Date CheckDate)
{
	int startdate = StartDate.Year * 10000 + StartDate.Month * 100 + StartDate.Day;
	int enddate = EndDate.Year * 10000 + EndDate.Month * 100 + EndDate.Day;
	int checkdate = CheckDate.Year * 10000 + CheckDate.Month * 100 + CheckDate.Day;
	return startdate <= checkdate && checkdate <= enddate;
}

_Date readdate(PDate Date, char * DateStr)
{
	sscanf(DateStr, "%s", Date->DateSTR);
	sscanf(DateStr, "%d/%d/%d", &Date->Year, &Date->Month, &Date->Day);
	return *Date;
}

_Time readtime(PTime Time, char * TimeStr)
{
	sscanf(TimeStr, "%s", Time->TimeSTR);
	sscanf(TimeStr, "%d:%d:%d", &Time->Hour, &Time->Minute, &Time->Second);
	return *Time;
}

void copyMR(PMR source, PMR target)
{
	target->Number = source->Number;
	readdate(&target->Date, source->Date.DateSTR);
	readtime(&target->Time, source->Time.TimeSTR);
	target->MaxRecoil = source->MaxRecoil;
	target->MeanRecoil = source->MeanRecoil;
	target->RecoilTime = source->RecoilTime;
	target->RecoilImpulse= source->RecoilImpulse;
	strcpy(target->DataFileName, source->DataFileName);
	strcpy(target->DataFileLocation, source->DataFileLocation);
	return ;
}

