#ifndef _MSACAL_H
#define _MSACAL_H

#include <cviauto.h>

#ifdef __cplusplus
    extern "C" {
#endif
/* NICDBLD_BEGIN> Type Library Specific Types */

typedef unsigned long MSACALType_OLE_COLOR;
typedef CAObjHandle MSACALObj_Font;
typedef CAObjHandle MSACALObj_IFontDisp;
typedef HRESULT (CVICALLBACK *DCalendarEventsRegOnClick_CallbackType) (CAObjHandle caServerObjHandle,
                                                                       void *caCallbackData);
typedef HRESULT (CVICALLBACK *DCalendarEventsRegOnDblClick_CallbackType) (CAObjHandle caServerObjHandle,
                                                                          void *caCallbackData);
typedef HRESULT (CVICALLBACK *DCalendarEventsRegOnKeyDown_CallbackType) (CAObjHandle caServerObjHandle,
                                                                         void *caCallbackData,
                                                                         short *keyCode,
                                                                         short  shift);
typedef HRESULT (CVICALLBACK *DCalendarEventsRegOnKeyPress_CallbackType) (CAObjHandle caServerObjHandle,
                                                                          void *caCallbackData,
                                                                          short *keyAscii);
typedef HRESULT (CVICALLBACK *DCalendarEventsRegOnKeyUp_CallbackType) (CAObjHandle caServerObjHandle,
                                                                       void *caCallbackData,
                                                                       short *keyCode,
                                                                       short  shift);
typedef HRESULT (CVICALLBACK *DCalendarEventsRegOnBeforeUpdate_CallbackType) (CAObjHandle caServerObjHandle,
                                                                              void *caCallbackData,
                                                                              short *cancel);
typedef HRESULT (CVICALLBACK *DCalendarEventsRegOnAfterUpdate_CallbackType) (CAObjHandle caServerObjHandle,
                                                                             void *caCallbackData);
typedef HRESULT (CVICALLBACK *DCalendarEventsRegOnNewMonth_CallbackType) (CAObjHandle caServerObjHandle,
                                                                          void *caCallbackData);
typedef HRESULT (CVICALLBACK *DCalendarEventsRegOnNewYear_CallbackType) (CAObjHandle caServerObjHandle,
                                                                         void *caCallbackData);
/* NICDBLD_END> Type Library Specific Types */

extern const IID MSACAL_IID_ICalendar;
extern const IID MSACAL_IID_DCalendarEvents;

HRESULT CVIFUNC MSACAL_NewICalendar (int panel, const char *label, int top,
                                     int left, int *controlID, int *UILError);

HRESULT CVIFUNC MSACAL_OpenICalendar (const char *fileName, int panel,
                                      const char *label, int top, int left,
                                      int *controlID, int *UILError);

HRESULT CVIFUNC MSACAL_ICalendarGetBackColor (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo,
                                              MSACALType_OLE_COLOR *pclrBackColor);

HRESULT CVIFUNC MSACAL_ICalendarSetBackColor (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo,
                                              MSACALType_OLE_COLOR pclrBackColor);

HRESULT CVIFUNC MSACAL_ICalendarGetDay (CAObjHandle objectHandle,
                                        ERRORINFO *errorInfo, short *pnDay);

HRESULT CVIFUNC MSACAL_ICalendarSetDay (CAObjHandle objectHandle,
                                        ERRORINFO *errorInfo, short pnDay);

HRESULT CVIFUNC MSACAL_ICalendarGetDayFont (CAObjHandle objectHandle,
                                            ERRORINFO *errorInfo,
                                            MSACALObj_IFontDisp *ppfontDayFont);

HRESULT CVIFUNC MSACAL_ICalendarSetDayFont (CAObjHandle objectHandle,
                                            ERRORINFO *errorInfo,
                                            MSACALObj_IFontDisp ppfontDayFont);

HRESULT CVIFUNC MSACAL_ICalendarGetDayFontColor (CAObjHandle objectHandle,
                                                 ERRORINFO *errorInfo,
                                                 MSACALType_OLE_COLOR *pclrDayFontColor);

HRESULT CVIFUNC MSACAL_ICalendarSetDayFontColor (CAObjHandle objectHandle,
                                                 ERRORINFO *errorInfo,
                                                 MSACALType_OLE_COLOR pclrDayFontColor);

HRESULT CVIFUNC MSACAL_ICalendarGetDayLength (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo,
                                              short *pnDayLength);

HRESULT CVIFUNC MSACAL_ICalendarSetDayLength (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo,
                                              short pnDayLength);

HRESULT CVIFUNC MSACAL_ICalendarGetFirstDay (CAObjHandle objectHandle,
                                             ERRORINFO *errorInfo,
                                             short *pnFirstDay);

HRESULT CVIFUNC MSACAL_ICalendarSetFirstDay (CAObjHandle objectHandle,
                                             ERRORINFO *errorInfo,
                                             short pnFirstDay);

HRESULT CVIFUNC MSACAL_ICalendarGetGridCellEffect (CAObjHandle objectHandle,
                                                   ERRORINFO *errorInfo,
                                                   long *plGridCellEffect);

HRESULT CVIFUNC MSACAL_ICalendarSetGridCellEffect (CAObjHandle objectHandle,
                                                   ERRORINFO *errorInfo,
                                                   long plGridCellEffect);

HRESULT CVIFUNC MSACAL_ICalendarGetGridFont (CAObjHandle objectHandle,
                                             ERRORINFO *errorInfo,
                                             MSACALObj_IFontDisp *ppfontGridFont);

HRESULT CVIFUNC MSACAL_ICalendarSetGridFont (CAObjHandle objectHandle,
                                             ERRORINFO *errorInfo,
                                             MSACALObj_IFontDisp ppfontGridFont);

HRESULT CVIFUNC MSACAL_ICalendarGetGridFontColor (CAObjHandle objectHandle,
                                                  ERRORINFO *errorInfo,
                                                  MSACALType_OLE_COLOR *pclrGridFontColor);

HRESULT CVIFUNC MSACAL_ICalendarSetGridFontColor (CAObjHandle objectHandle,
                                                  ERRORINFO *errorInfo,
                                                  MSACALType_OLE_COLOR pclrGridFontColor);

HRESULT CVIFUNC MSACAL_ICalendarGetGridLinesColor (CAObjHandle objectHandle,
                                                   ERRORINFO *errorInfo,
                                                   MSACALType_OLE_COLOR *pclrGridLinesColor);

HRESULT CVIFUNC MSACAL_ICalendarSetGridLinesColor (CAObjHandle objectHandle,
                                                   ERRORINFO *errorInfo,
                                                   MSACALType_OLE_COLOR pclrGridLinesColor);

HRESULT CVIFUNC MSACAL_ICalendarGetMonth (CAObjHandle objectHandle,
                                          ERRORINFO *errorInfo, short *pnMonth);

HRESULT CVIFUNC MSACAL_ICalendarSetMonth (CAObjHandle objectHandle,
                                          ERRORINFO *errorInfo, short pnMonth);

HRESULT CVIFUNC MSACAL_ICalendarGetMonthLength (CAObjHandle objectHandle,
                                                ERRORINFO *errorInfo,
                                                short *pnMonthLength);

HRESULT CVIFUNC MSACAL_ICalendarSetMonthLength (CAObjHandle objectHandle,
                                                ERRORINFO *errorInfo,
                                                short pnMonthLength);

HRESULT CVIFUNC MSACAL_ICalendarGetShowDateSelectors (CAObjHandle objectHandle,
                                                      ERRORINFO *errorInfo,
                                                      VBOOL *pfShowDateSelectors);

HRESULT CVIFUNC MSACAL_ICalendarSetShowDateSelectors (CAObjHandle objectHandle,
                                                      ERRORINFO *errorInfo,
                                                      VBOOL pfShowDateSelectors);

HRESULT CVIFUNC MSACAL_ICalendarGetShowDays (CAObjHandle objectHandle,
                                             ERRORINFO *errorInfo,
                                             VBOOL *pfShowDays);

HRESULT CVIFUNC MSACAL_ICalendarSetShowDays (CAObjHandle objectHandle,
                                             ERRORINFO *errorInfo,
                                             VBOOL pfShowDays);

HRESULT CVIFUNC MSACAL_ICalendarGetShowHorizontalGrid (CAObjHandle objectHandle,
                                                       ERRORINFO *errorInfo,
                                                       VBOOL *pfShowHorizontalGrid);

HRESULT CVIFUNC MSACAL_ICalendarSetShowHorizontalGrid (CAObjHandle objectHandle,
                                                       ERRORINFO *errorInfo,
                                                       VBOOL pfShowHorizontalGrid);

HRESULT CVIFUNC MSACAL_ICalendarGetShowTitle (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo,
                                              VBOOL *pfShowTitle);

HRESULT CVIFUNC MSACAL_ICalendarSetShowTitle (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo,
                                              VBOOL pfShowTitle);

HRESULT CVIFUNC MSACAL_ICalendarGetShowVerticalGrid (CAObjHandle objectHandle,
                                                     ERRORINFO *errorInfo,
                                                     VBOOL *pfShowVerticalGrid);

HRESULT CVIFUNC MSACAL_ICalendarSetShowVerticalGrid (CAObjHandle objectHandle,
                                                     ERRORINFO *errorInfo,
                                                     VBOOL pfShowVerticalGrid);

HRESULT CVIFUNC MSACAL_ICalendarGetTitleFont (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo,
                                              MSACALObj_IFontDisp *ppfontTitleFont);

HRESULT CVIFUNC MSACAL_ICalendarSetTitleFont (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo,
                                              MSACALObj_IFontDisp ppfontTitleFont);

HRESULT CVIFUNC MSACAL_ICalendarGetTitleFontColor (CAObjHandle objectHandle,
                                                   ERRORINFO *errorInfo,
                                                   MSACALType_OLE_COLOR *pclrTitleFontColor);

HRESULT CVIFUNC MSACAL_ICalendarSetTitleFontColor (CAObjHandle objectHandle,
                                                   ERRORINFO *errorInfo,
                                                   MSACALType_OLE_COLOR pclrTitleFontColor);

HRESULT CVIFUNC MSACAL_ICalendarGetValue (CAObjHandle objectHandle,
                                          ERRORINFO *errorInfo,
                                          VARIANT *pvarValue);

HRESULT CVIFUNC MSACAL_ICalendarSetValue (CAObjHandle objectHandle,
                                          ERRORINFO *errorInfo,
                                          VARIANT pvarValue);

HRESULT CVIFUNC MSACAL_ICalendarGet_Value (CAObjHandle objectHandle,
                                           ERRORINFO *errorInfo,
                                           VARIANT *pvarValue);

HRESULT CVIFUNC MSACAL_ICalendarSet_Value (CAObjHandle objectHandle,
                                           ERRORINFO *errorInfo,
                                           VARIANT pvarValue);

HRESULT CVIFUNC MSACAL_ICalendarGetValueIsNull (CAObjHandle objectHandle,
                                                ERRORINFO *errorInfo,
                                                VBOOL *pfValueIsNull);

HRESULT CVIFUNC MSACAL_ICalendarSetValueIsNull (CAObjHandle objectHandle,
                                                ERRORINFO *errorInfo,
                                                VBOOL pfValueIsNull);

HRESULT CVIFUNC MSACAL_ICalendarGetYear (CAObjHandle objectHandle,
                                         ERRORINFO *errorInfo, short *pnYear);

HRESULT CVIFUNC MSACAL_ICalendarSetYear (CAObjHandle objectHandle,
                                         ERRORINFO *errorInfo, short pnYear);

HRESULT CVIFUNC MSACAL_ICalendarNextDay (CAObjHandle objectHandle,
                                         ERRORINFO *errorInfo);

HRESULT CVIFUNC MSACAL_ICalendarNextMonth (CAObjHandle objectHandle,
                                           ERRORINFO *errorInfo);

HRESULT CVIFUNC MSACAL_ICalendarNextWeek (CAObjHandle objectHandle,
                                          ERRORINFO *errorInfo);

HRESULT CVIFUNC MSACAL_ICalendarNextYear (CAObjHandle objectHandle,
                                          ERRORINFO *errorInfo);

HRESULT CVIFUNC MSACAL_ICalendarPreviousDay (CAObjHandle objectHandle,
                                             ERRORINFO *errorInfo);

HRESULT CVIFUNC MSACAL_ICalendarPreviousMonth (CAObjHandle objectHandle,
                                               ERRORINFO *errorInfo);

HRESULT CVIFUNC MSACAL_ICalendarPreviousWeek (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo);

HRESULT CVIFUNC MSACAL_ICalendarPreviousYear (CAObjHandle objectHandle,
                                              ERRORINFO *errorInfo);

HRESULT CVIFUNC MSACAL_ICalendarRefresh (CAObjHandle objectHandle,
                                         ERRORINFO *errorInfo);

HRESULT CVIFUNC MSACAL_ICalendarToday (CAObjHandle objectHandle,
                                       ERRORINFO *errorInfo);

HRESULT CVIFUNC MSACAL_ICalendarAboutBox (CAObjHandle objectHandle,
                                          ERRORINFO *errorInfo);

HRESULT CVIFUNC MSACAL_ICalendarSetByRefDayFont (CAObjHandle objectHandle,
                                                 ERRORINFO *errorInfo,
                                                 MSACALObj_IFontDisp ppfontDayFont);

HRESULT CVIFUNC MSACAL_ICalendarSetByRefGridFont (CAObjHandle objectHandle,
                                                  ERRORINFO *errorInfo,
                                                  MSACALObj_IFontDisp ppfontGridFont);

HRESULT CVIFUNC MSACAL_ICalendarSetByRefTitleFont (CAObjHandle objectHandle,
                                                   ERRORINFO *errorInfo,
                                                   MSACALObj_IFontDisp ppfontTitleFont);

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnClick (CAObjHandle serverObject,
                                                  DCalendarEventsRegOnClick_CallbackType callbackFunction,
                                                  void *callbackData,
                                                  int enableCallbacks,
                                                  int *callbackId);

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnDblClick (CAObjHandle serverObject,
                                                     DCalendarEventsRegOnDblClick_CallbackType callbackFunction,
                                                     void *callbackData,
                                                     int enableCallbacks,
                                                     int *callbackId);

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnKeyDown (CAObjHandle serverObject,
                                                    DCalendarEventsRegOnKeyDown_CallbackType callbackFunction,
                                                    void *callbackData,
                                                    int enableCallbacks,
                                                    int *callbackId);

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnKeyPress (CAObjHandle serverObject,
                                                     DCalendarEventsRegOnKeyPress_CallbackType callbackFunction,
                                                     void *callbackData,
                                                     int enableCallbacks,
                                                     int *callbackId);

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnKeyUp (CAObjHandle serverObject,
                                                  DCalendarEventsRegOnKeyUp_CallbackType callbackFunction,
                                                  void *callbackData,
                                                  int enableCallbacks,
                                                  int *callbackId);

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnBeforeUpdate (CAObjHandle serverObject,
                                                         DCalendarEventsRegOnBeforeUpdate_CallbackType callbackFunction,
                                                         void *callbackData,
                                                         int enableCallbacks,
                                                         int *callbackId);

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnAfterUpdate (CAObjHandle serverObject,
                                                        DCalendarEventsRegOnAfterUpdate_CallbackType callbackFunction,
                                                        void *callbackData,
                                                        int enableCallbacks,
                                                        int *callbackId);

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnNewMonth (CAObjHandle serverObject,
                                                     DCalendarEventsRegOnNewMonth_CallbackType callbackFunction,
                                                     void *callbackData,
                                                     int enableCallbacks,
                                                     int *callbackId);

HRESULT CVIFUNC MSACAL_DCalendarEventsRegOnNewYear (CAObjHandle serverObject,
                                                    DCalendarEventsRegOnNewYear_CallbackType callbackFunction,
                                                    void *callbackData,
                                                    int enableCallbacks,
                                                    int *callbackId);
#ifdef __cplusplus
    }
#endif
#endif /* _MSACAL_H */
