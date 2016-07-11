#include "MSCAL.h"
#include <userint.h>

static void CVIFUNC DCalendarEventsRegOnClick_EventVTableFunc (void *thisPtr);

static void CVIFUNC DCalendarEventsRegOnDblClick_EventVTableFunc (void *thisPtr);

static void CVIFUNC DCalendarEventsRegOnKeyDown_EventVTableFunc (void *thisPtr,
                                                                 short *keyCode,
                                                                 short shift);

static void CVIFUNC DCalendarEventsRegOnKeyPress_EventVTableFunc (void *thisPtr,
                                                                  short *keyAscii);

static void CVIFUNC DCalendarEventsRegOnKeyUp_EventVTableFunc (void *thisPtr,
                                                               short *keyCode,
                                                               short shift);

static void CVIFUNC DCalendarEventsRegOnBeforeUpdate_EventVTableFunc (void *thisPtr,
                                                                      short *cancel);

static void CVIFUNC DCalendarEventsRegOnAfterUpdate_EventVTableFunc (void *thisPtr);

static void CVIFUNC DCalendarEventsRegOnNewMonth_EventVTableFunc (void *thisPtr);

static void CVIFUNC DCalendarEventsRegOnNewYear_EventVTableFunc (void *thisPtr);

#define __ActiveXCtrlErrorHandler() \
if ((ctrlId) > 0) \
	{ \
	if (controlID) \
		*controlID = (ctrlId); \
	if (UILError) \
		*UILError = 0; \
	__result = S_OK; \
	} \
else if ((ctrlId) == UIEActiveXError) \
	{ \
	if (controlID) \
		*controlID = 0; \
	if (UILError) \
		*UILError = 0; \
	} \
else \
	{ \
	if (controlID) \
		*controlID = 0; \
	if (UILError) \
		*UILError = (ctrlId); \
	__result = E_CVIAUTO_CVI_UI_ERROR; \
	}

typedef interface tagMSACAL_ICalendar_Interface MSACAL_ICalendar_Interface;

typedef struct tagMSACAL_ICalendar_VTable
{
	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *QueryInterface )( MSACAL_ICalendar_Interface __RPC_FAR * This, 
	                                                         REFIID riid, 
	                                                         void __RPC_FAR *__RPC_FAR *ppvObject);

	ULONG ( STDMETHODCALLTYPE __RPC_FAR *AddRef )( MSACAL_ICalendar_Interface __RPC_FAR * This);

	ULONG ( STDMETHODCALLTYPE __RPC_FAR *Release )( MSACAL_ICalendar_Interface __RPC_FAR * This);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfoCount )( MSACAL_ICalendar_Interface __RPC_FAR * This, 
	                                                           UINT __RPC_FAR *pctinfo);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTypeInfo )( MSACAL_ICalendar_Interface __RPC_FAR * This, 
	                                                      UINT iTInfo, 
	                                                      LCID lcid, 
	                                                      ITypeInfo __RPC_FAR *__RPC_FAR *ppTInfo);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetIDsOfNames )( MSACAL_ICalendar_Interface __RPC_FAR * This, 
	                                                        REFIID riid, 
	                                                        LPOLESTR __RPC_FAR *rgszNames, 
	                                                        UINT cNames, 
	                                                        LCID lcid, 
	                                                        DISPID __RPC_FAR *rgDispId);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Invoke )( MSACAL_ICalendar_Interface __RPC_FAR * This, 
	                                                 DISPID dispIdMember, 
	                                                 REFIID riid, 
	                                                 LCID lcid, 
	                                                 WORD wFlags, 
	                                                 DISPPARAMS __RPC_FAR *pDispParams, 
	                                                 VARIANT __RPC_FAR *pVarResult, 
	                                                 EXCEPINFO __RPC_FAR *pExcepInfo, 
	                                                 UINT __RPC_FAR *puArgErr);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetBackColor_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                       unsigned long *pclrBackColor);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetBackColor_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                       unsigned long pclrBackColor);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetDay_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                 short *pnDay);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetDay_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                 short pnDay);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetDayFont_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                     LPDISPATCH *ppfontDayFont);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetDayFont_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                     LPDISPATCH ppfontDayFont);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetDayFontColor_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                          unsigned long *pclrDayFontColor);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetDayFontColor_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                          unsigned long pclrDayFontColor);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetDayLength_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                       short *pnDayLength);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetDayLength_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                       short pnDayLength);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetFirstDay_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                      short *pnFirstDay);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetFirstDay_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                      short pnFirstDay);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetGridCellEffect_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                            long *plGridCellEffect);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetGridCellEffect_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                            long plGridCellEffect);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetGridFont_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                      LPDISPATCH *ppfontGridFont);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetGridFont_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                      LPDISPATCH ppfontGridFont);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetGridFontColor_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                           unsigned long *pclrGridFontColor);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetGridFontColor_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                           unsigned long pclrGridFontColor);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetGridLinesColor_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                            unsigned long *pclrGridLinesColor);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetGridLinesColor_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                            unsigned long pclrGridLinesColor);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetMonth_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                   short *pnMonth);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetMonth_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                   short pnMonth);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetMonthLength_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                         short *pnMonthLength);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetMonthLength_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                         short pnMonthLength);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetShowDateSelectors_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                               VBOOL *pfShowDateSelectors);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetShowDateSelectors_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                               VBOOL pfShowDateSelectors);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetShowDays_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                      VBOOL *pfShowDays);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetShowDays_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                      VBOOL pfShowDays);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetShowHorizontalGrid_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                                VBOOL *pfShowHorizontalGrid);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetShowHorizontalGrid_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                                VBOOL pfShowHorizontalGrid);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetShowTitle_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                       VBOOL *pfShowTitle);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetShowTitle_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                       VBOOL pfShowTitle);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetShowVerticalGrid_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                              VBOOL *pfShowVerticalGrid);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetShowVerticalGrid_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                              VBOOL pfShowVerticalGrid);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTitleFont_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                       LPDISPATCH *ppfontTitleFont);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetTitleFont_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                       LPDISPATCH ppfontTitleFont);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetTitleFontColor_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                            unsigned long *pclrTitleFontColor);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetTitleFontColor_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                            unsigned long pclrTitleFontColor);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetValue_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                   VARIANT *pvarValue);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetValue_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                   VARIANT pvarValue);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Get_Value_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                    VARIANT *pvarValue);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Set_Value_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                    VARIANT pvarValue);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetValueIsNull_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                         VBOOL *pfValueIsNull);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetValueIsNull_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                         VBOOL pfValueIsNull);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *GetYear_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                  short *pnYear);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetYear_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                  short pnYear);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *NextDay_) (MSACAL_ICalendar_Interface __RPC_FAR *This);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *NextMonth_) (MSACAL_ICalendar_Interface __RPC_FAR *This);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *NextWeek_) (MSACAL_ICalendar_Interface __RPC_FAR *This);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *NextYear_) (MSACAL_ICalendar_Interface __RPC_FAR *This);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *PreviousDay_) (MSACAL_ICalendar_Interface __RPC_FAR *This);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *PreviousMonth_) (MSACAL_ICalendar_Interface __RPC_FAR *This);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *PreviousWeek_) (MSACAL_ICalendar_Interface __RPC_FAR *This);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *PreviousYear_) (MSACAL_ICalendar_Interface __RPC_FAR *This);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Refresh_) (MSACAL_ICalendar_Interface __RPC_FAR *This);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *Today_) (MSACAL_ICalendar_Interface __RPC_FAR *This);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *AboutBox_) (MSACAL_ICalendar_Interface __RPC_FAR *This);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetByRefDayFont_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                          LPDISPATCH ppfontDayFont);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetByRefGridFont_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                           LPDISPATCH ppfontGridFont);

	HRESULT ( STDMETHODCALLTYPE __RPC_FAR *SetByRefTitleFont_) (MSACAL_ICalendar_Interface __RPC_FAR *This, 
	                                                            LPDISPATCH ppfontTitleFont);

} MSACAL_ICalendar_VTable;

typedef interface tagMSACAL_ICalendar_Interface
{
	CONST_VTBL MSACAL_ICalendar_VTable __RPC_FAR *lpVtbl;
} MSACAL_ICalendar_Interface;

static CA_PARAMDATA _DCalendarEvents_RegOnKeyDown_CA_PARAMDATA[] =
	{
		{"keyCode", VT_I2 | VT_BYREF},
        {"shift", VT_I2}
	};

static CA_PARAMDATA _DCalendarEvents_RegOnKeyPress_CA_PARAMDATA[] =
	{
		{"keyAscii", VT_I2 | VT_BYREF}
	};

static CA_PARAMDATA _DCalendarEvents_RegOnKeyUp_CA_PARAMDATA[] =
	{
		{"keyCode", VT_I2 | VT_BYREF},
        {"shift", VT_I2}
	};

static CA_PARAMDATA _DCalendarEvents_RegOnBeforeUpdate_CA_PARAMDATA[] =
	{
		{"cancel", VT_I2 | VT_BYREF}
	};

static CA_METHODDATA _DCalendarEvents_CA_METHODDATA[] =
	{
		{"Click", NULL, -600, 0, CC_STDCALL, 0, DISPATCH_METHOD, VT_EMPTY},
        {"DblClick", NULL, -601, 1, CC_STDCALL, 0, DISPATCH_METHOD, VT_EMPTY},
        {"KeyDown", _DCalendarEvents_RegOnKeyDown_CA_PARAMDATA, -602, 2, CC_STDCALL, 2, DISPATCH_METHOD, VT_EMPTY},
        {"KeyPress", _DCalendarEvents_RegOnKeyPress_CA_PARAMDATA, -603, 3, CC_STDCALL, 1, DISPATCH_METHOD, VT_EMPTY},
        {"KeyUp", _DCalendarEvents_RegOnKeyUp_CA_PARAMDATA, -604, 4, CC_STDCALL, 2, DISPATCH_METHOD, VT_EMPTY},
        {"BeforeUpdate", _DCalendarEvents_RegOnBeforeUpdate_CA_PARAMDATA, 2, 5, CC_STDCALL, 1, DISPATCH_METHOD, VT_EMPTY},
        {"AfterUpdate", NULL, 1, 6, CC_STDCALL, 0, DISPATCH_METHOD, VT_EMPTY},
        {"NewMonth", NULL, 3, 7, CC_STDCALL, 0, DISPATCH_METHOD, VT_EMPTY},
        {"NewYear", NULL, 4, 8, CC_STDCALL, 0, DISPATCH_METHOD, VT_EMPTY}
	};

static CA_INTERFACEDATA _DCalendarEvents_CA_INTERFACEDATA =
	{
		_DCalendarEvents_CA_METHODDATA,
        (unsigned int)(sizeof (_DCalendarEvents_CA_METHODDATA) / sizeof (*_DCalendarEvents_CA_METHODDATA))
	};

static void * _DCalendarEvents_EventVTable[] =
	{
		DCalendarEventsRegOnClick_EventVTableFunc,
        DCalendarEventsRegOnDblClick_EventVTableFunc,
        DCalendarEventsRegOnKeyDown_EventVTableFunc,
        DCalendarEventsRegOnKeyPress_EventVTableFunc,
        DCalendarEventsRegOnKeyUp_EventVTableFunc,
        DCalendarEventsRegOnBeforeUpdate_EventVTableFunc,
        DCalendarEventsRegOnAfterUpdate_EventVTableFunc,
        DCalendarEventsRegOnNewMonth_EventVTableFunc,
        DCalendarEventsRegOnNewYear_EventVTableFunc
	};

static CAEventClassDefn _DCalendarEvents_CAEventClassDefn =
	{
		(int)sizeof(CAEventClassDefn),
        &MSACAL_IID_DCalendarEvents,
        _DCalendarEvents_EventVTable,
        &_DCalendarEvents_CA_INTERFACEDATA,
        0
	};

const IID MSACAL_IID_ICalendar =
	{
		0x8E27C92C, 0x1264, 0x101C, 0x8A, 0x2F, 0x4, 0x2, 0x24, 0x0, 0x9C, 0x2
	};

const IID MSACAL_IID_DCalendarEvents =
	{
		0x8E27C92D, 0x1264, 0x101C, 0x8A, 0x2F, 0x4, 0x2, 0x24, 0x0, 0x9C, 0x2
	};

const IID MSACAL_IID_Font =
	{
		0xBEF6E003, 0xA874, 0x101A, 0x8B, 0xBA, 0x0, 0xAA, 0x0, 0x30, 0xC, 0xAB
	};

HRESULT CVIFUNC MSACAL_NewICalendar (int panel, const char *label, int top,
                                     int left, int *controlID, int *UILError)
{
	HRESULT __result = S_OK;
	int ctrlId;
	GUID clsid = {0x8E27C92B, 0x1264, 0x101C, 0x8A, 0x2F, 0x4, 0x2, 0x24, 0x0,
	              0x9C, 0x2};
	const char * licStr = NULL;

	ctrlId = NewActiveXCtrl (panel, label, top, left, &clsid,
	                         &MSACAL_IID_ICalendar, licStr, &__result);

	__ActiveXCtrlErrorHandler();

	return __result;
}

HRESULT CVIFUNC MSACAL_OpenICalendar (const char *fileName, int panel,
                                      const char *label, int top, int left,
                                      int *controlID, int *UILError)
{
	HRESULT __result = S_OK;
	int ctrlId;

	ctrlId = NewActiveXCtrlFromFile (panel, label, top, left, fileName,
	                                 &MSACAL_IID_ICalendar, &__result);

	__ActiveXCtrlErrorHandler();

	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetBackColor (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo,
                                              MSACALType_OLE_COLOR *pclrBackColor)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	unsigned long pclrBackColor__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetBackColor_ (__vtblIFacePtr,
	                                                   &pclrBackColor__Temp));

	if (pclrBackColor)
		{
		*pclrBackColor = pclrBackColor__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetBackColor (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo,
                                              MSACALType_OLE_COLOR pclrBackColor)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetBackColor_ (__vtblIFacePtr,
	                                                   pclrBackColor));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetDay (CAObjHandle objectHandle,
                                        ERRORINFO *errorInfo, short *pnDay)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	short pnDay__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetDay_ (__vtblIFacePtr, &pnDay__Temp));

	if (pnDay)
		{
		*pnDay = pnDay__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetDay (CAObjHandle objectHandle,
                                        ERRORINFO *errorInfo, short pnDay)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetDay_ (__vtblIFacePtr, pnDay));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetDayFont (CAObjHandle objectHandle,
                                            ERRORINFO *errorInfo,
                                            MSACALObj_IFontDisp *ppfontDayFont)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	LPDISPATCH ppfontDayFont__AutoType = 0;
	LCID __locale;
	int __supportMultithreading;

	if (ppfontDayFont)
		*ppfontDayFont = 0;

	__caErrChk (CA_GetLocale (objectHandle, &__locale));
	__caErrChk (CA_GetSupportForMultithreading (objectHandle,
	                                            &__supportMultithreading));

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetDayFont_ (__vtblIFacePtr,
	                                                 &ppfontDayFont__AutoType));
	

	if (ppfontDayFont)
		{
		__caErrChk (CA_CreateObjHandleFromInterface (ppfontDayFont__AutoType,
		                                             &MSACAL_IID_Font,
		                                             __supportMultithreading,
		                                             __locale, 0, 0, ppfontDayFont));
		ppfontDayFont__AutoType = 0;
		}

Error:
	if (ppfontDayFont__AutoType)
		ppfontDayFont__AutoType->lpVtbl->Release (ppfontDayFont__AutoType);
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	if (FAILED(__result))
		{
		if (ppfontDayFont)
			{
			CA_DiscardObjHandle (*ppfontDayFont);
			*ppfontDayFont = 0;
			}
		}
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetDayFont (CAObjHandle objectHandle,
                                            ERRORINFO *errorInfo,
                                            MSACALObj_IFontDisp ppfontDayFont)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	LPDISPATCH ppfontDayFont__AutoType = 0;

	if (ppfontDayFont)
		{
		__caErrChk (CA_GetInterfaceFromObjHandle (ppfontDayFont, &MSACAL_IID_Font,
	                                          1, &ppfontDayFont__AutoType,
	                                          NULL));
		}

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetDayFont_ (__vtblIFacePtr,
	                                                 ppfontDayFont__AutoType));

Error:
	if (ppfontDayFont__AutoType)
		ppfontDayFont__AutoType->lpVtbl->Release (ppfontDayFont__AutoType);
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetDayFontColor (CAObjHandle objectHandle,
                                                 ERRORINFO *errorInfo,
                                                 MSACALType_OLE_COLOR *pclrDayFontColor)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	unsigned long pclrDayFontColor__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetDayFontColor_ (__vtblIFacePtr,
	                                                      &pclrDayFontColor__Temp));

	if (pclrDayFontColor)
		{
		*pclrDayFontColor = pclrDayFontColor__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetDayFontColor (CAObjHandle objectHandle,
                                                 ERRORINFO *errorInfo,
                                                 MSACALType_OLE_COLOR pclrDayFontColor)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetDayFontColor_ (__vtblIFacePtr,
	                                                      pclrDayFontColor));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetDayLength (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo,
                                              short *pnDayLength)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	short pnDayLength__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetDayLength_ (__vtblIFacePtr,
	                                                   &pnDayLength__Temp));

	if (pnDayLength)
		{
		*pnDayLength = pnDayLength__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetDayLength (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo,
                                              short pnDayLength)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetDayLength_ (__vtblIFacePtr,
	                                                   pnDayLength));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetFirstDay (CAObjHandle objectHandle,
                                             ERRORINFO *errorInfo,
                                             short *pnFirstDay)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	short pnFirstDay__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetFirstDay_ (__vtblIFacePtr,
	                                                  &pnFirstDay__Temp));

	if (pnFirstDay)
		{
		*pnFirstDay = pnFirstDay__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetFirstDay (CAObjHandle objectHandle,
                                             ERRORINFO *errorInfo,
                                             short pnFirstDay)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetFirstDay_ (__vtblIFacePtr,
	                                                  pnFirstDay));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetGridCellEffect (CAObjHandle objectHandle,
                                                   ERRORINFO *errorInfo,
                                                   long *plGridCellEffect)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	long plGridCellEffect__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetGridCellEffect_ (__vtblIFacePtr,
	                                                        &plGridCellEffect__Temp));

	if (plGridCellEffect)
		{
		*plGridCellEffect = plGridCellEffect__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetGridCellEffect (CAObjHandle objectHandle,
                                                   ERRORINFO *errorInfo,
                                                   long plGridCellEffect)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetGridCellEffect_ (__vtblIFacePtr,
	                                                        plGridCellEffect));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetGridFont (CAObjHandle objectHandle,
                                             ERRORINFO *errorInfo,
                                             MSACALObj_IFontDisp *ppfontGridFont)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	LPDISPATCH ppfontGridFont__AutoType = 0;
	LCID __locale;
	int __supportMultithreading;

	if (ppfontGridFont)
		*ppfontGridFont = 0;

	__caErrChk (CA_GetLocale (objectHandle, &__locale));
	__caErrChk (CA_GetSupportForMultithreading (objectHandle,
	                                            &__supportMultithreading));

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetGridFont_ (__vtblIFacePtr,
	                                                  &ppfontGridFont__AutoType));
	

	if (ppfontGridFont)
		{
		__caErrChk (CA_CreateObjHandleFromInterface (ppfontGridFont__AutoType,
		                                             &MSACAL_IID_Font,
		                                             __supportMultithreading,
		                                             __locale, 0, 0,
		                                             ppfontGridFont));
		ppfontGridFont__AutoType = 0;
		}

Error:
	if (ppfontGridFont__AutoType)
		ppfontGridFont__AutoType->lpVtbl->Release (ppfontGridFont__AutoType);
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	if (FAILED(__result))
		{
		if (ppfontGridFont)
			{
			CA_DiscardObjHandle (*ppfontGridFont);
			*ppfontGridFont = 0;
			}
		}
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetGridFont (CAObjHandle objectHandle,
                                             ERRORINFO *errorInfo,
                                             MSACALObj_IFontDisp ppfontGridFont)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	LPDISPATCH ppfontGridFont__AutoType = 0;

	if (ppfontGridFont)
		{
		__caErrChk (CA_GetInterfaceFromObjHandle (ppfontGridFont, &MSACAL_IID_Font,
	                                          1, &ppfontGridFont__AutoType,
	                                          NULL));
		}

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetGridFont_ (__vtblIFacePtr,
	                                                  ppfontGridFont__AutoType));

Error:
	if (ppfontGridFont__AutoType)
		ppfontGridFont__AutoType->lpVtbl->Release (ppfontGridFont__AutoType);
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetGridFontColor (CAObjHandle objectHandle,
                                                  ERRORINFO *errorInfo,
                                                  MSACALType_OLE_COLOR *pclrGridFontColor)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	unsigned long pclrGridFontColor__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetGridFontColor_ (__vtblIFacePtr,
	                                                       &pclrGridFontColor__Temp));

	if (pclrGridFontColor)
		{
		*pclrGridFontColor = pclrGridFontColor__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetGridFontColor (CAObjHandle objectHandle,
                                                  ERRORINFO *errorInfo,
                                                  MSACALType_OLE_COLOR pclrGridFontColor)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetGridFontColor_ (__vtblIFacePtr,
	                                                       pclrGridFontColor));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetGridLinesColor (CAObjHandle objectHandle,
                                                   ERRORINFO *errorInfo,
                                                   MSACALType_OLE_COLOR *pclrGridLinesColor)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	unsigned long pclrGridLinesColor__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetGridLinesColor_ (__vtblIFacePtr,
	                                                        &pclrGridLinesColor__Temp));

	if (pclrGridLinesColor)
		{
		*pclrGridLinesColor = pclrGridLinesColor__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetGridLinesColor (CAObjHandle objectHandle,
                                                   ERRORINFO *errorInfo,
                                                   MSACALType_OLE_COLOR pclrGridLinesColor)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetGridLinesColor_ (__vtblIFacePtr,
	                                                        pclrGridLinesColor));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetMonth (CAObjHandle objectHandle,
                                          ERRORINFO *errorInfo, short *pnMonth)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	short pnMonth__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetMonth_ (__vtblIFacePtr,
	                                               &pnMonth__Temp));

	if (pnMonth)
		{
		*pnMonth = pnMonth__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetMonth (CAObjHandle objectHandle,
                                          ERRORINFO *errorInfo, short pnMonth)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetMonth_ (__vtblIFacePtr, pnMonth));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetMonthLength (CAObjHandle objectHandle,
                                                ERRORINFO *errorInfo,
                                                short *pnMonthLength)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	short pnMonthLength__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetMonthLength_ (__vtblIFacePtr,
	                                                     &pnMonthLength__Temp));

	if (pnMonthLength)
		{
		*pnMonthLength = pnMonthLength__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetMonthLength (CAObjHandle objectHandle,
                                                ERRORINFO *errorInfo,
                                                short pnMonthLength)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetMonthLength_ (__vtblIFacePtr,
	                                                     pnMonthLength));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetShowDateSelectors (CAObjHandle objectHandle,
                                                      ERRORINFO *errorInfo,
                                                      VBOOL *pfShowDateSelectors)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	VBOOL pfShowDateSelectors__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetShowDateSelectors_ (__vtblIFacePtr,
	                                                           &pfShowDateSelectors__Temp));

	if (pfShowDateSelectors)
		{
		*pfShowDateSelectors = pfShowDateSelectors__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetShowDateSelectors (CAObjHandle objectHandle,
                                                      ERRORINFO *errorInfo,
                                                      VBOOL pfShowDateSelectors)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetShowDateSelectors_ (__vtblIFacePtr,
	                                                           pfShowDateSelectors));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetShowDays (CAObjHandle objectHandle,
                                             ERRORINFO *errorInfo,
                                             VBOOL *pfShowDays)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	VBOOL pfShowDays__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetShowDays_ (__vtblIFacePtr,
	                                                  &pfShowDays__Temp));

	if (pfShowDays)
		{
		*pfShowDays = pfShowDays__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetShowDays (CAObjHandle objectHandle,
                                             ERRORINFO *errorInfo,
                                             VBOOL pfShowDays)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetShowDays_ (__vtblIFacePtr,
	                                                  pfShowDays));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetShowHorizontalGrid (CAObjHandle objectHandle,
                                                       ERRORINFO *errorInfo,
                                                       VBOOL *pfShowHorizontalGrid)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	VBOOL pfShowHorizontalGrid__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetShowHorizontalGrid_ (__vtblIFacePtr,
	                                                            &pfShowHorizontalGrid__Temp));

	if (pfShowHorizontalGrid)
		{
		*pfShowHorizontalGrid = pfShowHorizontalGrid__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetShowHorizontalGrid (CAObjHandle objectHandle,
                                                       ERRORINFO *errorInfo,
                                                       VBOOL pfShowHorizontalGrid)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetShowHorizontalGrid_ (__vtblIFacePtr,
	                                                            pfShowHorizontalGrid));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetShowTitle (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo,
                                              VBOOL *pfShowTitle)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	VBOOL pfShowTitle__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetShowTitle_ (__vtblIFacePtr,
	                                                   &pfShowTitle__Temp));

	if (pfShowTitle)
		{
		*pfShowTitle = pfShowTitle__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetShowTitle (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo,
                                              VBOOL pfShowTitle)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetShowTitle_ (__vtblIFacePtr,
	                                                   pfShowTitle));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetShowVerticalGrid (CAObjHandle objectHandle,
                                                     ERRORINFO *errorInfo,
                                                     VBOOL *pfShowVerticalGrid)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	VBOOL pfShowVerticalGrid__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetShowVerticalGrid_ (__vtblIFacePtr,
	                                                          &pfShowVerticalGrid__Temp));

	if (pfShowVerticalGrid)
		{
		*pfShowVerticalGrid = pfShowVerticalGrid__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetShowVerticalGrid (CAObjHandle objectHandle,
                                                     ERRORINFO *errorInfo,
                                                     VBOOL pfShowVerticalGrid)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetShowVerticalGrid_ (__vtblIFacePtr,
	                                                          pfShowVerticalGrid));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetTitleFont (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo,
                                              MSACALObj_IFontDisp *ppfontTitleFont)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	LPDISPATCH ppfontTitleFont__AutoType = 0;
	LCID __locale;
	int __supportMultithreading;

	if (ppfontTitleFont)
		*ppfontTitleFont = 0;

	__caErrChk (CA_GetLocale (objectHandle, &__locale));
	__caErrChk (CA_GetSupportForMultithreading (objectHandle,
	                                            &__supportMultithreading));

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetTitleFont_ (__vtblIFacePtr,
	                                                   &ppfontTitleFont__AutoType));
	

	if (ppfontTitleFont)
		{
		__caErrChk (CA_CreateObjHandleFromInterface (ppfontTitleFont__AutoType,
		                                             &MSACAL_IID_Font,
		                                             __supportMultithreading,
		                                             __locale, 0, 0,
		                                             ppfontTitleFont));
		ppfontTitleFont__AutoType = 0;
		}

Error:
	if (ppfontTitleFont__AutoType)
		ppfontTitleFont__AutoType->lpVtbl->Release (ppfontTitleFont__AutoType);
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	if (FAILED(__result))
		{
		if (ppfontTitleFont)
			{
			CA_DiscardObjHandle (*ppfontTitleFont);
			*ppfontTitleFont = 0;
			}
		}
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetTitleFont (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo,
                                              MSACALObj_IFontDisp ppfontTitleFont)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	LPDISPATCH ppfontTitleFont__AutoType = 0;

	if (ppfontTitleFont)
		{
		__caErrChk (CA_GetInterfaceFromObjHandle (ppfontTitleFont,
	                                          &MSACAL_IID_Font, 1,
	                                          &ppfontTitleFont__AutoType, NULL));
		}

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetTitleFont_ (__vtblIFacePtr,
	                                                   ppfontTitleFont__AutoType));

Error:
	if (ppfontTitleFont__AutoType)
		ppfontTitleFont__AutoType->lpVtbl->Release (ppfontTitleFont__AutoType);
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetTitleFontColor (CAObjHandle objectHandle,
                                                   ERRORINFO *errorInfo,
                                                   MSACALType_OLE_COLOR *pclrTitleFontColor)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	unsigned long pclrTitleFontColor__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetTitleFontColor_ (__vtblIFacePtr,
	                                                        &pclrTitleFontColor__Temp));

	if (pclrTitleFontColor)
		{
		*pclrTitleFontColor = pclrTitleFontColor__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetTitleFontColor (CAObjHandle objectHandle,
                                                   ERRORINFO *errorInfo,
                                                   MSACALType_OLE_COLOR pclrTitleFontColor)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetTitleFontColor_ (__vtblIFacePtr,
	                                                        pclrTitleFontColor));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetValue (CAObjHandle objectHandle,
                                          ERRORINFO *errorInfo,
                                          VARIANT *pvarValue)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	VARIANT pvarValue__Temp;

	if (pvarValue)
		CA_VariantSetEmpty (pvarValue);
	CA_VariantSetEmpty (&pvarValue__Temp);

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetValue_ (__vtblIFacePtr,
	                                               &pvarValue__Temp));

	if (pvarValue)
		{
		*pvarValue = pvarValue__Temp;
		CA_VariantSetEmpty (&pvarValue__Temp);
		}

Error:
	CA_VariantClear (&pvarValue__Temp);
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	if (FAILED(__result))
		{
		if (pvarValue)
			CA_VariantClear (pvarValue);
		}
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetValue (CAObjHandle objectHandle,
                                          ERRORINFO *errorInfo,
                                          VARIANT pvarValue)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetValue_ (__vtblIFacePtr, pvarValue));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGet_Value (CAObjHandle objectHandle,
                                           ERRORINFO *errorInfo,
                                           VARIANT *pvarValue)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	VARIANT pvarValue__Temp;

	if (pvarValue)
		CA_VariantSetEmpty (pvarValue);
	CA_VariantSetEmpty (&pvarValue__Temp);

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->Get_Value_ (__vtblIFacePtr,
	                                                &pvarValue__Temp));

	if (pvarValue)
		{
		*pvarValue = pvarValue__Temp;
		CA_VariantSetEmpty (&pvarValue__Temp);
		}

Error:
	CA_VariantClear (&pvarValue__Temp);
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	if (FAILED(__result))
		{
		if (pvarValue)
			CA_VariantClear (pvarValue);
		}
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSet_Value (CAObjHandle objectHandle,
                                           ERRORINFO *errorInfo,
                                           VARIANT pvarValue)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->Set_Value_ (__vtblIFacePtr, pvarValue));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetValueIsNull (CAObjHandle objectHandle,
                                                ERRORINFO *errorInfo,
                                                VBOOL *pfValueIsNull)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	VBOOL pfValueIsNull__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetValueIsNull_ (__vtblIFacePtr,
	                                                     &pfValueIsNull__Temp));

	if (pfValueIsNull)
		{
		*pfValueIsNull = pfValueIsNull__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetValueIsNull (CAObjHandle objectHandle,
                                                ERRORINFO *errorInfo,
                                                VBOOL pfValueIsNull)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetValueIsNull_ (__vtblIFacePtr,
	                                                     pfValueIsNull));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarGetYear (CAObjHandle objectHandle,
                                         ERRORINFO *errorInfo, short *pnYear)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	short pnYear__Temp;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->GetYear_ (__vtblIFacePtr,
	                                              &pnYear__Temp));

	if (pnYear)
		{
		*pnYear = pnYear__Temp;
		}

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetYear (CAObjHandle objectHandle,
                                         ERRORINFO *errorInfo, short pnYear)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetYear_ (__vtblIFacePtr, pnYear));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarNextDay (CAObjHandle objectHandle,
                                         ERRORINFO *errorInfo)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->NextDay_ (__vtblIFacePtr));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarNextMonth (CAObjHandle objectHandle,
                                           ERRORINFO *errorInfo)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->NextMonth_ (__vtblIFacePtr));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarNextWeek (CAObjHandle objectHandle,
                                          ERRORINFO *errorInfo)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->NextWeek_ (__vtblIFacePtr));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarNextYear (CAObjHandle objectHandle,
                                          ERRORINFO *errorInfo)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->NextYear_ (__vtblIFacePtr));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarPreviousDay (CAObjHandle objectHandle,
                                             ERRORINFO *errorInfo)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->PreviousDay_ (__vtblIFacePtr));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarPreviousMonth (CAObjHandle objectHandle,
                                               ERRORINFO *errorInfo)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->PreviousMonth_ (__vtblIFacePtr));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarPreviousWeek (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->PreviousWeek_ (__vtblIFacePtr));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarPreviousYear (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->PreviousYear_ (__vtblIFacePtr));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarRefresh (CAObjHandle objectHandle,
                                         ERRORINFO *errorInfo)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->Refresh_ (__vtblIFacePtr));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarToday (CAObjHandle objectHandle,
                                       ERRORINFO *errorInfo)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->Today_ (__vtblIFacePtr));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarAboutBox (CAObjHandle objectHandle,
                                          ERRORINFO *errorInfo)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->AboutBox_ (__vtblIFacePtr));

Error:
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetByRefDayFont (CAObjHandle objectHandle,
                                                 ERRORINFO *errorInfo,
                                                 MSACALObj_IFontDisp ppfontDayFont)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	LPDISPATCH ppfontDayFont__AutoType = 0;

	if (ppfontDayFont)
		{
		__caErrChk (CA_GetInterfaceFromObjHandle (ppfontDayFont, &MSACAL_IID_Font,
	                                          1, &ppfontDayFont__AutoType,
	                                          NULL));
		}

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetByRefDayFont_ (__vtblIFacePtr,
	                                                      ppfontDayFont__AutoType));

Error:
	if (ppfontDayFont__AutoType)
		ppfontDayFont__AutoType->lpVtbl->Release (ppfontDayFont__AutoType);
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetByRefGridFont (CAObjHandle objectHandle,
                                                  ERRORINFO *errorInfo,
                                                  MSACALObj_IFontDisp ppfontGridFont)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	LPDISPATCH ppfontGridFont__AutoType = 0;

	if (ppfontGridFont)
		{
		__caErrChk (CA_GetInterfaceFromObjHandle (ppfontGridFont, &MSACAL_IID_Font,
	                                          1, &ppfontGridFont__AutoType,
	                                          NULL));
		}

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetByRefGridFont_ (__vtblIFacePtr,
	                                                       ppfontGridFont__AutoType));

Error:
	if (ppfontGridFont__AutoType)
		ppfontGridFont__AutoType->lpVtbl->Release (ppfontGridFont__AutoType);
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

HRESULT CVIFUNC MSACAL_ICalendarSetByRefTitleFont (CAObjHandle objectHandle,
                                                   ERRORINFO *errorInfo,
                                                   MSACALObj_IFontDisp ppfontTitleFont)
{
	HRESULT __result = S_OK;
	MSACAL_ICalendar_Interface * __vtblIFacePtr = 0;
	int __didAddRef;
	int __errorInfoPresent = 0;
	LPDISPATCH ppfontTitleFont__AutoType = 0;

	if (ppfontTitleFont)
		{
		__caErrChk (CA_GetInterfaceFromObjHandle (ppfontTitleFont,
	                                          &MSACAL_IID_Font, 1,
	                                          &ppfontTitleFont__AutoType, NULL));
		}

	__caErrChk (CA_GetInterfaceFromObjHandle (objectHandle,
	                                          &MSACAL_IID_ICalendar, 0,
	                                          &__vtblIFacePtr, &__didAddRef));
	__caErrChk (__vtblIFacePtr->lpVtbl->SetByRefTitleFont_ (__vtblIFacePtr,
	                                                        ppfontTitleFont__AutoType));

Error:
	if (ppfontTitleFont__AutoType)
		ppfontTitleFont__AutoType->lpVtbl->Release (ppfontTitleFont__AutoType);
	if (__vtblIFacePtr && __didAddRef)
		__vtblIFacePtr->lpVtbl->Release (__vtblIFacePtr);
	CA_FillErrorInfoEx (objectHandle, &MSACAL_IID_ICalendar, __result,
	                    errorInfo, &__errorInfoPresent);
	if (__errorInfoPresent)
		__result = DISP_E_EXCEPTION;
	return __result;
}

static void CVIFUNC DCalendarEventsRegOnClick_EventVTableFunc (void *thisPtr)
{
	HRESULT __result = S_OK;
	void * __callbackData;
	CAObjHandle __serverObjHandle;
	DCalendarEventsRegOnClick_CallbackType __callbackFunction;
	
	

	__caErrChk (CA_GetEventCallback (thisPtr, 0, &__callbackFunction,
	                                 &__callbackData, &__serverObjHandle));

	if (__callbackFunction != NULL)
		{
	
		__result = __callbackFunction (__serverObjHandle, __callbackData);
	
		__caErrChk (__result);
		
		}
Error:

	return;
}

static void CVIFUNC DCalendarEventsRegOnDblClick_EventVTableFunc (void *thisPtr)
{
	HRESULT __result = S_OK;
	void * __callbackData;
	CAObjHandle __serverObjHandle;
	DCalendarEventsRegOnDblClick_CallbackType __callbackFunction;
	
	

	__caErrChk (CA_GetEventCallback (thisPtr, 1, &__callbackFunction,
	                                 &__callbackData, &__serverObjHandle));

	if (__callbackFunction != NULL)
		{
	
		__result = __callbackFunction (__serverObjHandle, __callbackData);
	
		__caErrChk (__result);
		
		}
Error:

	return;
}

static void CVIFUNC DCalendarEventsRegOnKeyDown_EventVTableFunc (void *thisPtr,
                                                                 short *keyCode,
                                                                 short shift)
{
	HRESULT __result = S_OK;
	void * __callbackData;
	CAObjHandle __serverObjHandle;
	DCalendarEventsRegOnKeyDown_CallbackType __callbackFunction;
	
	

	__caErrChk (CA_GetEventCallback (thisPtr, 2, &__callbackFunction,
	                                 &__callbackData, &__serverObjHandle));

	if (__callbackFunction != NULL)
		{
	
		__result = __callbackFunction (__serverObjHandle, __callbackData, keyCode, shift);
	
		__caErrChk (__result);
		
		}
Error:

	return;
}

static void CVIFUNC DCalendarEventsRegOnKeyPress_EventVTableFunc (void *thisPtr,
                                                                  short *keyAscii)
{
	HRESULT __result = S_OK;
	void * __callbackData;
	CAObjHandle __serverObjHandle;
	DCalendarEventsRegOnKeyPress_CallbackType __callbackFunction;
	
	

	__caErrChk (CA_GetEventCallback (thisPtr, 3, &__callbackFunction,
	                                 &__callbackData, &__serverObjHandle));

	if (__callbackFunction != NULL)
		{
	
		__result = __callbackFunction (__serverObjHandle, __callbackData, keyAscii);
	
		__caErrChk (__result);
		
		}
Error:

	return;
}

static void CVIFUNC DCalendarEventsRegOnKeyUp_EventVTableFunc (void *thisPtr,
                                                               short *keyCode,
                                                               short shift)
{
	HRESULT __result = S_OK;
	void * __callbackData;
	CAObjHandle __serverObjHandle;
	DCalendarEventsRegOnKeyUp_CallbackType __callbackFunction;
	
	

	__caErrChk (CA_GetEventCallback (thisPtr, 4, &__callbackFunction,
	                                 &__callbackData, &__serverObjHandle));

	if (__callbackFunction != NULL)
		{
	
		__result = __callbackFunction (__serverObjHandle, __callbackData, keyCode, shift);
	
		__caErrChk (__result);
		
		}
Error:

	return;
}

static void CVIFUNC DCalendarEventsRegOnBeforeUpdate_EventVTableFunc (void *thisPtr,
                                                                      short *cancel)
{
	HRESULT __result = S_OK;
	void * __callbackData;
	CAObjHandle __serverObjHandle;
	DCalendarEventsRegOnBeforeUpdate_CallbackType __callbackFunction;
	
	

	__caErrChk (CA_GetEventCallback (thisPtr, 5, &__callbackFunction,
	                                 &__callbackData, &__serverObjHandle));

	if (__callbackFunction != NULL)
		{
	
		__result = __callbackFunction (__serverObjHandle, __callbackData, cancel);
	
		__caErrChk (__result);
		
		}
Error:

	return;
}

static void CVIFUNC DCalendarEventsRegOnAfterUpdate_EventVTableFunc (void *thisPtr)
{
	HRESULT __result = S_OK;
	void * __callbackData;
	CAObjHandle __serverObjHandle;
	DCalendarEventsRegOnAfterUpdate_CallbackType __callbackFunction;
	
	

	__caErrChk (CA_GetEventCallback (thisPtr, 6, &__callbackFunction,
	                                 &__callbackData, &__serverObjHandle));

	if (__callbackFunction != NULL)
		{
	
		__result = __callbackFunction (__serverObjHandle, __callbackData);
	
		__caErrChk (__result);
		
		}
Error:

	return;
}

static void CVIFUNC DCalendarEventsRegOnNewMonth_EventVTableFunc (void *thisPtr)
{
	HRESULT __result = S_OK;
	void * __callbackData;
	CAObjHandle __serverObjHandle;
	DCalendarEventsRegOnNewMonth_CallbackType __callbackFunction;
	
	

	__caErrChk (CA_GetEventCallback (thisPtr, 7, &__callbackFunction,
	                                 &__callbackData, &__serverObjHandle));

	if (__callbackFunction != NULL)
		{
	
		__result = __callbackFunction (__serverObjHandle, __callbackData);
	
		__caErrChk (__result);
		
		}
Error:

	return;
}

static void CVIFUNC DCalendarEventsRegOnNewYear_EventVTableFunc (void *thisPtr)
{
	HRESULT __result = S_OK;
	void * __callbackData;
	CAObjHandle __serverObjHandle;
	DCalendarEventsRegOnNewYear_CallbackType __callbackFunction;
	
	

	__caErrChk (CA_GetEventCallback (thisPtr, 8, &__callbackFunction,
	                                 &__callbackData, &__serverObjHandle));

	if (__callbackFunction != NULL)
		{
	
		__result = __callbackFunction (__serverObjHandle, __callbackData);
	
		__caErrChk (__result);
		
		}
Error:

	return;
}

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnClick (CAObjHandle serverObject,
                                                  DCalendarEventsRegOnClick_CallbackType callbackFunction,
                                                  void *callbackData,
                                                  int enableCallbacks,
                                                  int *callbackId)
{
	HRESULT __result = S_OK;

	__result = CA_RegisterEventCallback (serverObject,
	                                     &_DCalendarEvents_CAEventClassDefn, 0,
	                                     callbackFunction, callbackData,
	                                     enableCallbacks, callbackId);

	return __result;
}

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnDblClick (CAObjHandle serverObject,
                                                     DCalendarEventsRegOnDblClick_CallbackType callbackFunction,
                                                     void *callbackData,
                                                     int enableCallbacks,
                                                     int *callbackId)
{
	HRESULT __result = S_OK;

	__result = CA_RegisterEventCallback (serverObject,
	                                     &_DCalendarEvents_CAEventClassDefn, 1,
	                                     callbackFunction, callbackData,
	                                     enableCallbacks, callbackId);

	return __result;
}

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnKeyDown (CAObjHandle serverObject,
                                                    DCalendarEventsRegOnKeyDown_CallbackType callbackFunction,
                                                    void *callbackData,
                                                    int enableCallbacks,
                                                    int *callbackId)
{
	HRESULT __result = S_OK;

	__result = CA_RegisterEventCallback (serverObject,
	                                     &_DCalendarEvents_CAEventClassDefn, 2,
	                                     callbackFunction, callbackData,
	                                     enableCallbacks, callbackId);

	return __result;
}

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnKeyPress (CAObjHandle serverObject,
                                                     DCalendarEventsRegOnKeyPress_CallbackType callbackFunction,
                                                     void *callbackData,
                                                     int enableCallbacks,
                                                     int *callbackId)
{
	HRESULT __result = S_OK;

	__result = CA_RegisterEventCallback (serverObject,
	                                     &_DCalendarEvents_CAEventClassDefn, 3,
	                                     callbackFunction, callbackData,
	                                     enableCallbacks, callbackId);

	return __result;
}

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnKeyUp (CAObjHandle serverObject,
                                                  DCalendarEventsRegOnKeyUp_CallbackType callbackFunction,
                                                  void *callbackData,
                                                  int enableCallbacks,
                                                  int *callbackId)
{
	HRESULT __result = S_OK;

	__result = CA_RegisterEventCallback (serverObject,
	                                     &_DCalendarEvents_CAEventClassDefn, 4,
	                                     callbackFunction, callbackData,
	                                     enableCallbacks, callbackId);

	return __result;
}

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnBeforeUpdate (CAObjHandle serverObject,
                                                         DCalendarEventsRegOnBeforeUpdate_CallbackType callbackFunction,
                                                         void *callbackData,
                                                         int enableCallbacks,
                                                         int *callbackId)
{
	HRESULT __result = S_OK;

	__result = CA_RegisterEventCallback (serverObject,
	                                     &_DCalendarEvents_CAEventClassDefn, 5,
	                                     callbackFunction, callbackData,
	                                     enableCallbacks, callbackId);

	return __result;
}

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnAfterUpdate (CAObjHandle serverObject,
                                                        DCalendarEventsRegOnAfterUpdate_CallbackType callbackFunction,
                                                        void *callbackData,
                                                        int enableCallbacks,
                                                        int *callbackId)
{
	HRESULT __result = S_OK;

	__result = CA_RegisterEventCallback (serverObject,
	                                     &_DCalendarEvents_CAEventClassDefn, 6,
	                                     callbackFunction, callbackData,
	                                     enableCallbacks, callbackId);

	return __result;
}

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnNewMonth (CAObjHandle serverObject,
                                                     DCalendarEventsRegOnNewMonth_CallbackType callbackFunction,
                                                     void *callbackData,
                                                     int enableCallbacks,
                                                     int *callbackId)
{
	HRESULT __result = S_OK;

	__result = CA_RegisterEventCallback (serverObject,
	                                     &_DCalendarEvents_CAEventClassDefn, 7,
	                                     callbackFunction, callbackData,
	                                     enableCallbacks, callbackId);

	return __result;
}

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnNewYear (CAObjHandle serverObject,
                                                    DCalendarEventsRegOnNewYear_CallbackType callbackFunction,
                                                    void *callbackData,
                                                    int enableCallbacks,
                                                    int *callbackId)
{
	HRESULT __result = S_OK;

	__result = CA_RegisterEventCallback (serverObject,
	                                     &_DCalendarEvents_CAEventClassDefn, 8,
	                                     callbackFunction, callbackData,
	                                     enableCallbacks, callbackId);

	return __result;
}
