#ifndef _GLOBAL_H
#define _GLOBAL_H

#include <time.h>
#include <NIDAQmx.h>

#ifdef __cplusplus
    extern "C" {
#endif

//��������
#define ROOTDIR		"C:\\Documents and Settings\\Administrator\\My Documents\\National Instruments\\CVI\\GUI1.0\\"
#define MAXSTRLEN	256		//ͨ���ַ�������
#define BUFFERLEN	256		//ͨ������������
#define LONGSTRLEN	1024	//���ַ������ȣ��������ģ��ȣ�
		
#define _TEST_ON_CPCI
#ifdef _TEST_ON_CPCI
	//����Ƶ��
	#define samplingrate 1000.0
	//���������ڣ�����
	#define samplinglen 500
	#define arraylen	100
	#define pointsshown 100
	#define recordlen	500
		float64     data[samplinglen];
		float64		wave[(int)samplingrate];

	#ifndef TRUE
	#define TRUE	1
	#endif
	#ifndef FALSE
	#define FALSE	0
	#endif
#else
	//����Ƶ��
	#define samplingrate 400000.0
	//���������ڣ�����
	#define samplinglen 50000
	#define arraylen	10000
	#define pointsshown 10000
		float64     data[samplinglen];
		float64		wave[pointsshown];

	#ifndef TRUE
	#define TRUE	1
	#endif
	#ifndef FALSE
	#define FALSE	0
	#endif
#endif

	
//�ṹ�嶨��
//����
typedef struct _Date
{
	//��
	int Year;
	
	//��
	int Month;
	
	//��
	int Day;
	
	//�����ַ���
	char DateSTR[MAXSTRLEN];
	
} _Date, * PDate;

//ʱ��
typedef struct _Time
{
	//ʱ
	int Hour;
	
	//��
	int Minute;
	
	//��
	int Second;
	
	//ʱ���ַ���
	char TimeSTR[MAXSTRLEN];
	
} _Time, * PTime;

//���������¼
typedef struct MeasureResult
{
	//���򡢱��
	int Number;
	
	//����
	_Date Date;
	
	//ʱ��
	_Time Time;
	
	//��������
	double MaxRecoil;
	
	//ƽ��������
	double MeanRecoil;
	
	//����ʱ��
	double RecoilTime;
	
	//��������
	double RecoilImpulse;
	
	//�����ļ���
	char DataFileName[MAXSTRLEN];
	
	//�����ļ�·�������ļ�����
	char DataFileLocation[MAXSTRLEN];
	
} MR, * PMR;

//�������¼
typedef struct MeasureGroup
{
	//��������
	int Number;
	
	//��������
	char Environment[MAXSTRLEN];
	
	//�Ѳ�������
	int MeasuredNumber;
	
	//��������Ƿ������
	BOOL isMeasurementFinished;
	
	//���������飩��������·�������ļ�����
	char ReportLocation[MAXSTRLEN];
	
	//���������¼��̬����ָ�루����Ϊ�Ѳ���������
	PMR MeasureResults;
	
} MG, * PMG;

//��Ŀ��������
typedef struct ProjectSetting
{
	//ÿ����Բ�������
	int TestMeasurementsNumberEachGroup;
	
	//������������
	double ForceSensorMeasurementRange;
	
	//ǰ�÷Ŵ�ϵ��
	double PreMagnificationFactor;
	
	//�����ն�����
	double DigitalSamplingTerminalRange;
	
	//�����ֵ
	double ShockThreshold;
	
	//��Ŀ����·�������ļ�����
	char TestProjectReportLocation[MAXSTRLEN];
	
} PS, * PPS;


//��Ŀ��Ϣ
typedef struct ProjectInfo
{
	//������������
	char TestTaskName[MAXSTRLEN];
	
	//�����������
	char TestTaskCode[MAXSTRLEN];
	
	//���鵥λ����
	char TestUnit[MAXSTRLEN];
	
	//���鴴����
	char TestCreator[MAXSTRLEN];
	
	//���Դ�������
	_Date TestCreateDate;
	
	//���Դ���ʱ��
	_Time TestCreateTime;
	
	//����װ�����ͣ����
	char TestEquipmentType[MAXSTRLEN];
	
	//���������������ͺţ�
	char TestWeapon[MAXSTRLEN];
	
	//������Ŀ����·������Ŀ�ļ���·����
	char TestProjectLocation[MAXSTRLEN];
	
	//���в�������Ŀ
	int TestedGroupNumber;
	
	//�����鶯̬����ָ�루����Ϊ���в�������Ŀ��
	PMG MeasureGroups;
	
	//��������
	PS ParameterSetting;
	
} PI, * PPI;

//��Ŀ�б���Ŀ��Ϣ��̬���飩
typedef struct ProjectList
{
	PPI projects;
	int number;
} PL, * PPL;

//��������
//��ʼ���ṹ��
void InitDate(PDate Date);
void InitTime(PTime Time);
void InitMeasureResult(PMR MeasureResult);
void InitMeasureGroup(PMG MeasureGroup);
void InitProjectInfo(PPI ProjectInfo);
void InitProjectList(PPL ProjectList);
//��սṹ������
void freeMeasureGroup(PMG MeasureGroup);
void freeProjectInfo(PPI ProjectInfo);
void freeProjectList(PPL ProjectList);
//���ݶ�д���ж�
BOOL inrange(_Date StartDate, _Date EndDate, _Date CheckDate);
_Date readdate(PDate Date, char * DateStr);
_Time readtime(PTime Time, char * TimeStr);
void copyMR(PMR source, PMR target);
void copyMG(PMG source, PMG target);
void copyPI(PPI source, PPI target);
	
	
//ȫ�ֱ���
//��ǰ��������Ŀ��أ��Ѵ���Ŀ��
PI operatingproject;
int operatinggroupnum;
int operatingmeasurenum;
//��ǰ�½���Ŀ���½�����Ŀ��
PI newproject;
//�������ѯ�����ģ���Ŀ��Ϣ�б�
PL projectlist;

//���ݿ���
int hdbc,hstmt;

//�������
TaskHandle hsample;
//�������򳤶�
int wavelen;

//�����
int panel_main;
int panel_open;
int panel_newproject;
int panel_query;
//���״̬��״̬����
int state_main;
int state_open;
int state_newproject;
int panel_query;



#ifdef __cplusplus
    }
#endif

#endif
