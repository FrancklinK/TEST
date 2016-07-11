#ifndef _GLOBAL_H
#define _GLOBAL_H

#include <time.h>
#include <NIDAQmx.h>

#ifdef __cplusplus
    extern "C" {
#endif

//常量定义
#define ROOTDIR		"C:\\Documents and Settings\\Administrator\\My Documents\\National Instruments\\CVI\\GUI1.0\\"
#define MAXSTRLEN	256		//通常字符串长度
#define BUFFERLEN	256		//通常缓冲区长度
#define LONGSTRLEN	1024	//长字符串长度（试验结论模板等）
		
#define _TEST_ON_CPCI
#ifdef _TEST_ON_CPCI
	//采样频率
	#define samplingrate 1000.0
	//采样（周期）长度
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
	//采样频率
	#define samplingrate 400000.0
	//采样（周期）长度
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

	
//结构体定义
//日期
typedef struct _Date
{
	//年
	int Year;
	
	//月
	int Month;
	
	//日
	int Day;
	
	//日期字符串
	char DateSTR[MAXSTRLEN];
	
} _Date, * PDate;

//时间
typedef struct _Time
{
	//时
	int Hour;
	
	//分
	int Minute;
	
	//秒
	int Second;
	
	//时间字符串
	char TimeSTR[MAXSTRLEN];
	
} _Time, * PTime;

//测量结果记录
typedef struct MeasureResult
{
	//弹序、编号
	int Number;
	
	//日期
	_Date Date;
	
	//时间
	_Time Time;
	
	//最大后坐力
	double MaxRecoil;
	
	//平均后坐力
	double MeanRecoil;
	
	//后坐时间
	double RecoilTime;
	
	//后坐冲量
	double RecoilImpulse;
	
	//数据文件名
	char DataFileName[MAXSTRLEN];
	
	//数据文件路径（含文件名）
	char DataFileLocation[MAXSTRLEN];
	
} MR, * PMR;

//测量组记录
typedef struct MeasureGroup
{
	//测量组编号
	int Number;
	
	//测量环境
	char Environment[MAXSTRLEN];
	
	//已测量次数
	int MeasuredNumber;
	
	//本组测量是否已完成
	BOOL isMeasurementFinished;
	
	//（本测量组）测量报告路径（含文件名）
	char ReportLocation[MAXSTRLEN];
	
	//测量结果记录动态数组指针（长度为已测量次数）
	PMR MeasureResults;
	
} MG, * PMG;

//项目参数配置
typedef struct ProjectSetting
{
	//每组测试测量次数
	int TestMeasurementsNumberEachGroup;
	
	//力传感器量程
	double ForceSensorMeasurementRange;
	
	//前置放大系数
	double PreMagnificationFactor;
	
	//数采终端量程
	double DigitalSamplingTerminalRange;
	
	//冲击阈值
	double ShockThreshold;
	
	//项目报告路径（含文件名）
	char TestProjectReportLocation[MAXSTRLEN];
	
} PS, * PPS;


//项目信息
typedef struct ProjectInfo
{
	//试验任务名称
	char TestTaskName[MAXSTRLEN];
	
	//试验任务代号
	char TestTaskCode[MAXSTRLEN];
	
	//试验单位名称
	char TestUnit[MAXSTRLEN];
	
	//试验创建人
	char TestCreator[MAXSTRLEN];
	
	//测试创建日期
	_Date TestCreateDate;
	
	//测试创建时间
	_Time TestCreateTime;
	
	//测试装备类型（类别）
	char TestEquipmentType[MAXSTRLEN];
	
	//测试武器（具体型号）
	char TestWeapon[MAXSTRLEN];
	
	//测试项目工作路径（项目文件夹路径）
	char TestProjectLocation[MAXSTRLEN];
	
	//已有测量组数目
	int TestedGroupNumber;
	
	//测量组动态数组指针（长度为已有测量组数目）
	PMG MeasureGroups;
	
	//参数设置
	PS ParameterSetting;
	
} PI, * PPI;

//项目列表（项目信息动态数组）
typedef struct ProjectList
{
	PPI projects;
	int number;
} PL, * PPL;

//辅助函数
//初始化结构体
void InitDate(PDate Date);
void InitTime(PTime Time);
void InitMeasureResult(PMR MeasureResult);
void InitMeasureGroup(PMG MeasureGroup);
void InitProjectInfo(PPI ProjectInfo);
void InitProjectList(PPL ProjectList);
//清空结构体数据
void freeMeasureGroup(PMG MeasureGroup);
void freeProjectInfo(PPI ProjectInfo);
void freeProjectList(PPL ProjectList);
//数据读写、判断
BOOL inrange(_Date StartDate, _Date EndDate, _Date CheckDate);
_Date readdate(PDate Date, char * DateStr);
_Time readtime(PTime Time, char * TimeStr);
void copyMR(PMR source, PMR target);
void copyMG(PMG source, PMG target);
void copyPI(PPI source, PPI target);
	
	
//全局变量
//当前操作中项目相关（已打开项目）
PI operatingproject;
int operatinggroupnum;
int operatingmeasurenum;
//当前新建项目（新建中项目）
PI newproject;
//（满足查询条件的）项目信息列表
PL projectlist;

//数据库句柄
int hdbc,hstmt;

//采样句柄
TaskHandle hsample;
//缓存区域长度
int wavelen;

//面板句柄
int panel_main;
int panel_open;
int panel_newproject;
int panel_query;
//面板状态（状态机）
int state_main;
int state_open;
int state_newproject;
int panel_query;



#ifdef __cplusplus
    }
#endif

#endif
