#ifndef _DATABASE_H
#define _DATABASE_H

#include <string.h>
#include "global.h"
#include "cvi_db.h"

//连接数据库，数据库名称为const char DatabaseName[]变量中预先存储的常量字符串
int connectDatabase();
//断开数据库连接
int disconnectDatabase();
//获取指定项目信息(这个函数好像也用不到)
int getProjectInfo(char * ProjectName,  PPI projectinfo);
//获取已创建的所有项目信息
int getAllProjectsInfo(PPL projectsinfo);
//创建一条新的项目记录，同时创建相应的项目配置信息记录表单(与测量组记录表单)
int addProjectRecord(PI projectinfo);
//创建一条新的项目配置信息
int addProjectSetting(char * ProjectName, PS projectsetting);
//暂时规定不允许在创建项目之后再对项目信息与配置信息进行更改
//主要用于更新测量组数与项目报告位置等信息
int setProjectInfo(PI projectinfo);
//获取当前项目所有测量组与相应测量数据记录信息
int getDetails(PPI projectinfo);
//为当前项目新建一个测量组记录
int addMeasureGroupRecord(PI projectinfo,int MeasureGroupNumber);
//保存当前测量组测量结果,更新已测量次数信息
//在对应的测量数据记录表中添加新增记录
int saveMeasureGroupResult(PPI projectinfo, int MeasureGroupNumber);
//查询数据库，给出所有符合条件的项目列表与相关信息
int queryDatabase(char * TestTask, char * TestWeapon, char * TestUnit, _Time StartTime, _Time EndTime, PPL projectsinfo);
//为指定项目创建项目配置信息表单（固定格式）
int creatNewProjectSettingTable(char * ProjectName);
//为指定项目创建测量组结果记录表单（固定格式）
int creatNewMeasureGroupResultTable(char * ProjectName);
//为指定项目指定测量组创建测量结果记录表单（固定格式）
int creatNewMeasureDataResultTable(char * ProjectName, int MeasureGroupNumber);
//检查项目是否符合查询要求
BOOL check(char * TestTask, char * TestWeapon, char * TestUnit, _Date StartDate, _Date EndDate, PI projectinfo);

//读取试验结论模板
int getTestConclusions(char * );
//添加试验结论模板
int addTestConclusion(char * title, char * article);

//检查项目记录是否存在
BOOL existProject(PI projectinfo);
//检查测量组记录是否已存在
BOOL existMeasureGroup(PI projectinfo,int MeasureGroupNumber);
//检查测量记录是否已存在
BOOL existMeasureResult(PI projectinfo,int MeasureGroupNumber,int MeasureResultNumber);

#endif
