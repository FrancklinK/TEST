#include <ansi_c.h>
#include <userint.h>
#include <string.h>

#include "Database.h"
#include "global.h"

const char * DatabaseName = "TestSample";
char * ProjectInfoTableName = "ProjectOverview";
//char * ConclusionTableName = "ConclusionTemplate";

int connectDatabase()
{
	char buffer[64] = "DSN=";
	hdbc = DBConnect (strcat(buffer,DatabaseName));
	return hdbc;
}

int disconnectDatabase()
{
	return DBDisconnect(hdbc);
}

int getProjectInfo(char * ProjectName,  PPI projectinfo)
{
	hstmt = DBActivateSQL (hdbc, "SELECT * FROM ProjectOverview"); 
	int resCode = DBDeactivateSQL (hstmt);
	return resCode;
}

int getAllProjectsInfo(PPL projectsinfo)
{
	int num,i,hmap,resCode;
	char buffer[BUFFERLEN] = "";
	PI projectinfo;
	long status;
	InitProjectInfo(&projectinfo);
	
	freeProjectList(projectsinfo);
	
	//查询当前已有项目总数
	resCode = DBAllowFetchAnyDirection(hdbc,TRUE);
	sprintf(buffer,"SELECT * FROM %s",ProjectInfoTableName);
	hstmt = DBActivateSQL(hdbc,buffer);
	num = DBNumberOfRecords(hstmt);
	projectsinfo->number = num;
	
	projectsinfo->projects = (PPI) malloc(sizeof(PI) * num);
	for (i = 0; i < num; i++)
	{
		InitProjectInfo(projectsinfo->projects+i);
	}

	resCode = DBBindColInt(hstmt, 1, &num, &status);
	resCode = DBBindColChar(hstmt, 2, MAXSTRLEN, projectinfo.TestTaskName, &status, "");
	resCode = DBBindColChar(hstmt, 3, MAXSTRLEN, projectinfo.TestTaskCode, &status, "");
	resCode = DBBindColChar(hstmt, 4, MAXSTRLEN, projectinfo.TestUnit, &status, "");
	resCode = DBBindColChar(hstmt, 5, MAXSTRLEN, projectinfo.TestCreator, &status, "");
	resCode = DBBindColChar(hstmt, 6, MAXSTRLEN, projectinfo.TestCreateDate.DateSTR, &status, "");
	resCode = DBBindColChar(hstmt, 7, MAXSTRLEN, projectinfo.TestCreateTime.TimeSTR, &status, "");
	resCode = DBBindColChar(hstmt, 8, MAXSTRLEN, projectinfo.TestEquipmentType, &status, "");
	resCode = DBBindColChar(hstmt, 9, MAXSTRLEN, projectinfo.TestWeapon, &status, "");
	resCode = DBBindColChar(hstmt, 10, MAXSTRLEN, projectinfo.TestProjectLocation, &status, "");
	resCode = DBBindColInt(hstmt, 11, &projectinfo.TestedGroupNumber, &status);
	
	i = 0;
	while(DBFetchNext(hstmt) != DB_EOF)
	{
		*(projectsinfo->projects+i) = projectinfo;
		readdate(&projectsinfo->projects[i].TestCreateDate,projectsinfo->projects[i].TestCreateDate.DateSTR);
		readtime(&projectsinfo->projects[i].TestCreateTime,projectsinfo->projects[i].TestCreateTime.TimeSTR);
		i++;
	}

	resCode = DBDeactivateSQL(hstmt);

//	sprintf(buffer,"%d",num);
//	MessagePopup("Number of Projects",buffer);
	

	/*通过map方式读数据库
	hmap = DBBeginMap(hdbc);
	//ID由系统自动生成，无须添加
//	resCode = DBMapColumnToInt(hmap, "ID", &num, &status);
	resCode = DBMapColumnToChar(hmap, "TestTaskName", MAXSTRLEN, projectinfo.TestTaskName, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestTaskCode", MAXSTRLEN, projectinfo.TestTaskCode, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestUnit", MAXSTRLEN, projectinfo.TestUnit, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestCreator", MAXSTRLEN, projectinfo.TestCreator, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestCreateDate", MAXSTRLEN, projectinfo.TestCreateDate.DateSTR, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestCreateTime", MAXSTRLEN, projectinfo.TestCreateTime.TimeSTR, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestWeaponType", MAXSTRLEN, projectinfo.TestEquipmentType, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestWeapon", MAXSTRLEN, projectinfo.TestWeapon, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestProjectLocation", MAXSTRLEN, projectinfo.TestProjectLocation, &status, "");
	resCode = DBMapColumnToInt (hmap, "TestedGroupnumber", &projectinfo.TestedGroupNumber, &status);

	hstmt = DBActivateMap (hmap, ProjectInfoTableName);
	i = 0;
	while(DBFetchNext(hstmt) == 0)
	{
		*(projectsinfo->projects+i) = projectinfo;
		i++;
//		MessagePopup(projectinfo.TestCreateDate.DateSTR,projectinfo.TestCreateTime.TimeSTR);
//		MessagePopup(projectinfo.TestWeapon,projectinfo.TestEquipmentType);
	}
	resCode = DBDeactivateMap(hmap);
	*/
	
	return num;
}

int addProjectRecord(PI projectinfo)
{
	int num = 0,hmap,resCode;
	long status;
	hmap = DBBeginMap(hdbc);

	//ID由系统自动生成，无须添加
//	resCode = DBMapColumnToInt(hmap, "ID", &num, &status);
	
	resCode = DBMapColumnToChar(hmap, "TestTaskName", MAXSTRLEN, projectinfo.TestTaskName, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestTaskCode", MAXSTRLEN, projectinfo.TestTaskCode, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestUnit", MAXSTRLEN, projectinfo.TestUnit, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestCreator", MAXSTRLEN, projectinfo.TestCreator, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestCreateDate", MAXSTRLEN, projectinfo.TestCreateDate.DateSTR, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestCreateTime", MAXSTRLEN, projectinfo.TestCreateTime.TimeSTR, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestWeaponType", MAXSTRLEN, projectinfo.TestEquipmentType, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestWeapon", MAXSTRLEN, projectinfo.TestWeapon, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestProjectLocation", MAXSTRLEN, projectinfo.TestProjectLocation, &status, "");
	resCode = DBMapColumnToInt(hmap, "TestedGroupNumber", &projectinfo.TestedGroupNumber, &status);
	
	hstmt = DBActivateMap (hmap, ProjectInfoTableName);
	resCode = DBCreateRecord(hstmt);
	resCode = DBPutRecord(hstmt);
	resCode = DBDeactivateMap(hmap);
	
	creatNewProjectSettingTable(projectinfo.TestTaskName);
	creatNewMeasureGroupResultTable(projectinfo.TestTaskName);
	addProjectSetting(projectinfo.TestTaskName,projectinfo.ParameterSetting);
	return num;
}

int addProjectSetting(char * ProjectName, PS projectsetting)
{
	char buffer[BUFFERLEN] = "";
	int map = DBBeginMap(hdbc);
	int resCode;
	long status;
	sprintf(buffer,"%sProjectSettings",ProjectName);
	
	resCode = DBMapColumnToInt(map, "TestMeasurementsNumberEachGroup", &newproject.ParameterSetting.TestMeasurementsNumberEachGroup, &status);
	resCode = DBMapColumnToDouble(map, "ForceSensorMeasurementRange", &newproject.ParameterSetting.ForceSensorMeasurementRange, &status);
	resCode = DBMapColumnToDouble(map, "PreMagnificationFactor", &newproject.ParameterSetting.PreMagnificationFactor, &status);
	resCode = DBMapColumnToDouble(map, "DigitalSamplingTerminalRange", &newproject.ParameterSetting.DigitalSamplingTerminalRange, &status);
	resCode = DBMapColumnToDouble(map, "ShockThreshold", &newproject.ParameterSetting.ShockThreshold, &status);
	resCode = DBMapColumnToChar(map, "TestProjectReportLocation", MAXSTRLEN, newproject.ParameterSetting.TestProjectReportLocation, &status, "");
	
	hstmt = DBActivateMap (map, buffer);
	resCode = DBCreateRecord(hstmt);
	resCode = DBPutRecord(hstmt);
	resCode = DBDeactivateMap(map);
	return 0;
}

int setProjectInfo(PI modifiedprojectinfo)
{
	char buffer[BUFFERLEN] = "";
	int hmap, resCode;
	long status;
	int i,j;
	PI projectinfo;
	
	hmap = DBBeginMap(hdbc);
	
	resCode = DBMapColumnToChar(hmap, "TestTaskName", MAXSTRLEN, projectinfo.TestTaskName, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestTaskCode", MAXSTRLEN, projectinfo.TestTaskCode, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestUnit", MAXSTRLEN, projectinfo.TestUnit, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestCreator", MAXSTRLEN, projectinfo.TestCreator, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestCreateDate", MAXSTRLEN, projectinfo.TestCreateDate.DateSTR, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestCreateTime", MAXSTRLEN, projectinfo.TestCreateTime.TimeSTR, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestWeaponType", MAXSTRLEN, projectinfo.TestEquipmentType, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestWeapon", MAXSTRLEN, projectinfo.TestWeapon, &status, "");
	resCode = DBMapColumnToChar(hmap, "TestProjectLocation", MAXSTRLEN, projectinfo.TestProjectLocation, &status, "");
	resCode = DBMapColumnToInt(hmap, "TestedGroupNumber", &projectinfo.TestedGroupNumber, &status);
	
	hstmt = DBActivateMap (hmap, ProjectInfoTableName);
	
	while(DBFetchNext(hstmt) != DB_EOF)
	{
		if (strcmp(modifiedprojectinfo.TestTaskName, projectinfo.TestTaskName) == 0)
		{
			projectinfo = modifiedprojectinfo;
			DBPutRecord(hstmt);
//			MessagePopup("",projectinfo.TestTaskName);
		}
	}
	
	return 0;
}

int getDetails(PPI projectinfo)
{
	char buffer[BUFFERLEN] = "";
	int map,hmap;
	int resCode, testedgroupnumber = projectinfo->TestedGroupNumber,measurednumber;
	long status;
	
	int i,j;

	//get parameter setting
	map = DBBeginMap(hdbc);
	
	resCode = DBMapColumnToInt(map, "TestMeasurementsNumberEachGroup", &projectinfo->ParameterSetting.TestMeasurementsNumberEachGroup, &status);
	resCode = DBMapColumnToDouble(map, "ForceSensorMeasurementRange", &projectinfo->ParameterSetting.ForceSensorMeasurementRange, &status);
	resCode = DBMapColumnToDouble(map, "PreMagnificationFactor", &projectinfo->ParameterSetting.PreMagnificationFactor, &status);
	resCode = DBMapColumnToDouble(map, "DigitalSamplingTerminalRange", &projectinfo->ParameterSetting.DigitalSamplingTerminalRange, &status);
	resCode = DBMapColumnToDouble(map, "ShockThreshold", &projectinfo->ParameterSetting.ShockThreshold, &status);
	resCode = DBMapColumnToChar(map, "TestProjectReportLocation", MAXSTRLEN, projectinfo->ParameterSetting.TestProjectReportLocation, &status, "");
	
	sprintf(buffer,"%sProjectSettings",projectinfo->TestTaskName);
	hstmt = DBActivateMap (map, buffer);

	DBFetchNext(hstmt);
	
	resCode = DBDeactivateMap(map);
	
	//get measure groups
	MG measuregroup;
	InitMeasureGroup(&measuregroup);
	projectinfo->MeasureGroups = (PMG) malloc(sizeof(MG) * testedgroupnumber);
	for(i = 0; i < testedgroupnumber; i++)
	{
		InitMeasureGroup(projectinfo->MeasureGroups+i);
	}
	
	map = DBBeginMap(hdbc);
	resCode = DBMapColumnToInt (map, "MeasurementGroupNumber", &measuregroup.Number, &status);
	resCode = DBMapColumnToChar (map, "MeasurementEnvironment", MAXSTRLEN, measuregroup.Environment, &status, "");
	resCode = DBMapColumnToInt (map, "MeasuredNumberInGroup", &measuregroup.MeasuredNumber, &status);
	resCode = DBMapColumnToInt (map, "MeasurementGroupFinished", &measuregroup.isMeasurementFinished, &status);
 	resCode = DBMapColumnToChar (map, "MeasurementReportLocation", MAXSTRLEN, measuregroup.ReportLocation, &status, "");

	sprintf(buffer, "%sProjectMeasureGroupResult", projectinfo->TestTaskName);
	hstmt = DBActivateMap (map, buffer);
	i = 0;
	while(DBFetchNext(hstmt) == 0)
	{
		*(projectinfo->MeasureGroups+i) = measuregroup;
		i++;
	}
	resCode = DBDeactivateMap(map);

	//get measure results
	MR measureresult;
	InitMeasureResult(&measureresult);
	for (i = 1; i <= testedgroupnumber; i++)
	{
		projectinfo->MeasureGroups[i-1].MeasureResults = (PMR) malloc(sizeof(MR) * projectinfo->ParameterSetting.TestMeasurementsNumberEachGroup);
		for(j = 0; j < projectinfo->ParameterSetting.TestMeasurementsNumberEachGroup; j ++)
		{
			InitMeasureResult(projectinfo->MeasureGroups[i-1].MeasureResults+j);
		}
		if (projectinfo->MeasureGroups[i-1].MeasuredNumber > 0)
		{
			hmap = DBBeginMap(hdbc);

			resCode = DBMapColumnToInt (hmap, "MeasurementNumber", &measureresult.Number, &status);
			resCode = DBMapColumnToChar (hmap, "MeasurementDate", MAXSTRLEN, measureresult.Date.DateSTR, &status, "");
			resCode = DBMapColumnToChar (hmap, "MeasurementTime", MAXSTRLEN, measureresult.Time.TimeSTR, &status, "");
			resCode = DBMapColumnToDouble (hmap, "MeasurementMaxRecoil", &measureresult.MaxRecoil, &status);
			resCode = DBMapColumnToDouble (hmap, "MeasurementMeanRecoil", &measureresult.MeanRecoil, &status);
			resCode = DBMapColumnToDouble (hmap, "MeasurementRecoilTime", &measureresult.RecoilTime, &status);
			resCode = DBMapColumnToDouble (hmap, "MeasurementRecoilImpulse", &measureresult.RecoilImpulse, &status);
			resCode = DBMapColumnToChar (hmap, "MeasurementDataFileName", MAXSTRLEN, measureresult.DataFileName, &status, "");
			resCode = DBMapColumnToChar (hmap, "MeasurementDataFileLocation", MAXSTRLEN, measureresult.DataFileLocation, &status, "");

			sprintf(buffer, "%sProjectNo%dGroupMeasureResult", projectinfo->TestTaskName, i);
			
			hstmt = DBActivateMap(hmap, buffer);
			
			j = 0;
			while(DBFetchNext(hstmt) == 0)
			{
				*(projectinfo->MeasureGroups[i-1].MeasureResults+j) = measureresult;
				j++;
			}
			resCode = DBDeactivateMap(hmap);
		}
	}

	return projectinfo->TestedGroupNumber;
}

int addMeasureGroupRecord(PI projectinfo,int MeasureGroupNumber)
{
	char buffer[BUFFERLEN] = "";
	int map = DBBeginMap(hdbc);
	int resCode;
	long status;
	
	resCode = DBMapColumnToInt (map, "MeasurementGroupNumber", &MeasureGroupNumber, &status);
	resCode = DBMapColumnToChar (map, "MeasurementEnvironment", MAXSTRLEN, (projectinfo.MeasureGroups+MeasureGroupNumber-1)->Environment, &status, "");
	resCode = DBMapColumnToInt (map, "MeasuredNumberInGroup", &(projectinfo.MeasureGroups+MeasureGroupNumber-1)->MeasuredNumber, &status);
	resCode = DBMapColumnToInt (map, "MeasurementGroupFinished", &(projectinfo.MeasureGroups+MeasureGroupNumber-1)->isMeasurementFinished, &status);
 	resCode = DBMapColumnToChar (map, "MeasurementReportLocation", MAXSTRLEN, (projectinfo.MeasureGroups+MeasureGroupNumber-1)->ReportLocation, &status, "");
	
	sprintf(buffer,"%sProjectMeasureGroupResult",projectinfo.TestTaskName);
	hstmt = DBActivateMap (map, buffer);
	resCode = DBCreateRecord(hstmt);
	resCode = DBPutRecord(hstmt);
	resCode = DBDeactivateMap(map);
	return 0;
}

int saveMeasureGroupResult(PPI projectinfo, int MeasureGroupNumber)
{
	setProjectInfo(*projectinfo);
	
	char buffer[BUFFERLEN] = "";
	int map, num = 0, i;
	int resCode;
	long status;
	
	MG measuregroup;
	InitMeasureGroup(&measuregroup);
	
	//读取已有测量组数并更新
	map = DBBeginMap(hdbc);
	
	resCode = DBMapColumnToInt (map, "MeasurementGroupNumber", &measuregroup.Number, &status);
	resCode = DBMapColumnToChar (map, "MeasurementEnvironment", MAXSTRLEN, measuregroup.Environment, &status, "");
	resCode = DBMapColumnToInt (map, "MeasuredNumberInGroup", &measuregroup.MeasuredNumber, &status);
	resCode = DBMapColumnToInt (map, "MeasurementGroupFinished", &measuregroup.isMeasurementFinished, &status);
 	resCode = DBMapColumnToChar (map, "MeasurementReportLocation", MAXSTRLEN, measuregroup.ReportLocation, &status, "");

	sprintf(buffer,"%sProjectMeasureGroupResult",projectinfo->TestTaskName);
	hstmt = DBActivateMap (map, buffer);
	DBFetchRandom(hstmt,MeasureGroupNumber);
	num = measuregroup.MeasuredNumber;
	measuregroup = projectinfo->MeasureGroups[MeasureGroupNumber-1];
	DBPutRecord(hstmt);
	resCode = DBDeactivateMap(map);

	//更新测量记录表
	
	MR measureresult;
	InitMeasureResult(&measureresult);
	
	map = DBBeginMap(hdbc);
	
	resCode = DBMapColumnToInt (map, "MeasurementNumber", &measureresult.Number, &status);
	resCode = DBMapColumnToChar (map, "MeasurementDate", MAXSTRLEN, measureresult.Date.DateSTR, &status, "");
	resCode = DBMapColumnToChar (map, "MeasurementTime", MAXSTRLEN, measureresult.Time.TimeSTR, &status, "");
	resCode = DBMapColumnToDouble (map, "MeasurementMaxRecoil", &measureresult.MaxRecoil, &status);
	resCode = DBMapColumnToDouble (map, "MeasurementMeanRecoil", &measureresult.MeanRecoil, &status);
	resCode = DBMapColumnToDouble (map, "MeasurementRecoilTime", &measureresult.RecoilTime, &status);
	resCode = DBMapColumnToDouble (map, "MeasurementRecoilImpulse", &measureresult.RecoilImpulse, &status);
	resCode = DBMapColumnToChar (map, "MeasurementDataFileName", MAXSTRLEN, measureresult.DataFileName, &status, "");
	resCode = DBMapColumnToChar (map, "MeasurementDataFileLocation", MAXSTRLEN, measureresult.DataFileLocation, &status, "");
	
	sprintf(buffer, "%sProjectNo%dGroupMeasureResult", projectinfo->TestTaskName, MeasureGroupNumber);
	
//	resCode = DBCreateTableFromMap (map, buffer);
	hstmt = DBActivateMap (map, buffer);
	for (i = num; i < projectinfo->MeasureGroups[MeasureGroupNumber-1].MeasuredNumber; i++)
	{
		//copyMR(projectinfo->MeasureGroups[MeasureGroupNumber-1].MeasureResults+i, &measureresult);
		measureresult = *(projectinfo->MeasureGroups[MeasureGroupNumber-1].MeasureResults+i);
		resCode = DBCreateRecord(hstmt);
		resCode = DBPutRecord(hstmt);
	}
	resCode = DBDeactivateMap(map);
	
//	EnableBreakOnLibraryErrors();
	
	return projectinfo->MeasureGroups[MeasureGroupNumber-1].MeasuredNumber;
}

int queryDatabase(char * TestTask, char * TestWeapon, char * TestUnit, _Time StartTime, _Time EndTime, PPL projectsinfo)
{
	return projectsinfo->number;
}

int creatNewProjectSettingTable(char * ProjectName)
{
	char buffer[BUFFERLEN] = "";
	int map = DBBeginMap(hdbc);
	int resCode;
	long status;
	sprintf(buffer,"%sProjectSettings",ProjectName);
	
	resCode = DBMapColumnToInt(map, "TestMeasurementsNumberEachGroup", &newproject.ParameterSetting.TestMeasurementsNumberEachGroup, &status);
	resCode = DBMapColumnToDouble(map, "ForceSensorMeasurementRange", &newproject.ParameterSetting.ForceSensorMeasurementRange, &status);
	resCode = DBMapColumnToDouble(map, "PreMagnificationFactor", &newproject.ParameterSetting.PreMagnificationFactor, &status);
	resCode = DBMapColumnToDouble(map, "DigitalSamplingTerminalRange", &newproject.ParameterSetting.DigitalSamplingTerminalRange, &status);
	resCode = DBMapColumnToDouble(map, "ShockThreshold", &newproject.ParameterSetting.ShockThreshold, &status);
	resCode = DBMapColumnToChar(map, "TestProjectReportLocation", MAXSTRLEN, newproject.ParameterSetting.TestProjectReportLocation, &status, "");
	
	resCode = DBCreateTableFromMap (map, buffer);

	return 0;
}

int creatNewMeasureGroupResultTable(char * ProjectName)
{
	char buffer[BUFFERLEN] = "";
	int map = DBBeginMap(hdbc);
	int resCode;
	long status;
	sprintf(buffer,"%sProjectMeasureGroupResult",ProjectName);
	MG measuregroup;
	
	resCode = DBMapColumnToInt (map, "MeasurementGroupNumber", &measuregroup.Number, &status);
	resCode = DBMapColumnToChar (map, "MeasurementEnvironment", MAXSTRLEN, measuregroup.Environment, &status, "");
	resCode = DBMapColumnToInt (map, "MeasuredNumberInGroup", &measuregroup.MeasuredNumber, &status);
	resCode = DBMapColumnToInt (map, "MeasurementGroupFinished", &measuregroup.isMeasurementFinished, &status);
 	resCode = DBMapColumnToChar (map, "MeasurementReportLocation", MAXSTRLEN, measuregroup.ReportLocation, &status, "");
	
	resCode = DBCreateTableFromMap (map, buffer);

	return 0;
}

int creatNewMeasureDataResultTable(char * ProjectName, int MeasureGroupNumber)
{
	char buffer[BUFFERLEN] = "";
	int map = DBBeginMap(hdbc);
	int resCode;
	long status;
	sprintf(buffer,"%sProjectNo%dGroupMeasureResult",ProjectName,MeasureGroupNumber);
	MR measureresult;
	
	resCode = DBMapColumnToInt (map, "MeasurementNumber", &measureresult.Number, &status);
	resCode = DBMapColumnToChar (map, "MeasurementDate", MAXSTRLEN, measureresult.Date.DateSTR, &status, "");
	resCode = DBMapColumnToChar (map, "MeasurementTime", MAXSTRLEN, measureresult.Time.TimeSTR, &status, "");
	resCode = DBMapColumnToDouble (map, "MeasurementMaxRecoil", &measureresult.MaxRecoil, &status);
	resCode = DBMapColumnToDouble (map, "MeasurementMeanRecoil", &measureresult.MeanRecoil, &status);
	resCode = DBMapColumnToDouble (map, "MeasurementRecoilTime", &measureresult.RecoilTime, &status);
	resCode = DBMapColumnToDouble (map, "MeasurementRecoilImpulse", &measureresult.RecoilImpulse, &status);
	resCode = DBMapColumnToChar (map, "MeasurementDataFileName", MAXSTRLEN, measureresult.DataFileName, &status, "");
	resCode = DBMapColumnToChar (map, "MeasurementDataFileLocation", MAXSTRLEN, measureresult.DataFileLocation, &status, "");
	
	resCode = DBCreateTableFromMap (map, buffer);

	return 0;
}

BOOL check(char * TestTask, char * TestWeapon, char * TestUnit, _Date StartDate, _Date EndDate, PI projectinfo)
{
	return (strcmp(TestTask, "") == 0 || strstr(projectinfo.TestTaskName, TestTask) != NULL)
		&& (strcmp(TestWeapon, "") == 0 || strstr(projectinfo.TestWeapon, TestWeapon) != NULL)
		&& (strcmp(TestUnit, "") == 0 || strstr(projectinfo.TestUnit, TestUnit) != NULL)
		&& inrange(StartDate, EndDate, projectinfo.TestCreateDate);
}

BOOL existProject(PI projectinfo)
{
	BOOL find = FALSE;
	return find;
}

BOOL existMeasureGroup(PI projectinfo,int MeasureGroupNumber)
{
	BOOL find = FALSE;
	return find;
}

BOOL existMeasureResult(PI projectinfo,int MeasureGroupNumber,int MeasureResultNumber)
{
	BOOL find = FALSE;
	return find;
}
