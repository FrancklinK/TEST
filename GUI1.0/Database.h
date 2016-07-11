#ifndef _DATABASE_H
#define _DATABASE_H

#include <string.h>
#include "global.h"
#include "cvi_db.h"

//�������ݿ⣬���ݿ�����Ϊconst char DatabaseName[]������Ԥ�ȴ洢�ĳ����ַ���
int connectDatabase();
//�Ͽ����ݿ�����
int disconnectDatabase();
//��ȡָ����Ŀ��Ϣ(�����������Ҳ�ò���)
int getProjectInfo(char * ProjectName,  PPI projectinfo);
//��ȡ�Ѵ�����������Ŀ��Ϣ
int getAllProjectsInfo(PPL projectsinfo);
//����һ���µ���Ŀ��¼��ͬʱ������Ӧ����Ŀ������Ϣ��¼��(��������¼��)
int addProjectRecord(PI projectinfo);
//����һ���µ���Ŀ������Ϣ
int addProjectSetting(char * ProjectName, PS projectsetting);
//��ʱ�涨�������ڴ�����Ŀ֮���ٶ���Ŀ��Ϣ��������Ϣ���и���
//��Ҫ���ڸ��²�����������Ŀ����λ�õ���Ϣ
int setProjectInfo(PI projectinfo);
//��ȡ��ǰ��Ŀ���в���������Ӧ�������ݼ�¼��Ϣ
int getDetails(PPI projectinfo);
//Ϊ��ǰ��Ŀ�½�һ���������¼
int addMeasureGroupRecord(PI projectinfo,int MeasureGroupNumber);
//���浱ǰ������������,�����Ѳ���������Ϣ
//�ڶ�Ӧ�Ĳ������ݼ�¼�������������¼
int saveMeasureGroupResult(PPI projectinfo, int MeasureGroupNumber);
//��ѯ���ݿ⣬�������з�����������Ŀ�б��������Ϣ
int queryDatabase(char * TestTask, char * TestWeapon, char * TestUnit, _Time StartTime, _Time EndTime, PPL projectsinfo);
//Ϊָ����Ŀ������Ŀ������Ϣ�����̶���ʽ��
int creatNewProjectSettingTable(char * ProjectName);
//Ϊָ����Ŀ��������������¼�����̶���ʽ��
int creatNewMeasureGroupResultTable(char * ProjectName);
//Ϊָ����Ŀָ�������鴴�����������¼�����̶���ʽ��
int creatNewMeasureDataResultTable(char * ProjectName, int MeasureGroupNumber);
//�����Ŀ�Ƿ���ϲ�ѯҪ��
BOOL check(char * TestTask, char * TestWeapon, char * TestUnit, _Date StartDate, _Date EndDate, PI projectinfo);

//��ȡ�������ģ��
int getTestConclusions(char * );
//����������ģ��
int addTestConclusion(char * title, char * article);

//�����Ŀ��¼�Ƿ����
BOOL existProject(PI projectinfo);
//���������¼�Ƿ��Ѵ���
BOOL existMeasureGroup(PI projectinfo,int MeasureGroupNumber);
//��������¼�Ƿ��Ѵ���
BOOL existMeasureResult(PI projectinfo,int MeasureGroupNumber,int MeasureResultNumber);

#endif
