s��        ~   K J�  3   �   ����                               MSACAL                          Microsoft Calendar Control 11.0                                                                       � � ��MSACALObj_Font  � � ��MSACALObj_IFontDisp  � � ��MSACALType_OLE_COLOR     (� (��DCalendarEventsRegOnNewYear_CallbackType     )� )��DCalendarEventsRegOnNewMonth_CallbackType     ,� ,��DCalendarEventsRegOnAfterUpdate_CallbackType     -� -��DCalendarEventsRegOnBeforeUpdate_CallbackType     &� &��DCalendarEventsRegOnKeyUp_CallbackType     )� )��DCalendarEventsRegOnKeyPress_CallbackType     (� (��DCalendarEventsRegOnKeyDown_CallbackType     )� )��DCalendarEventsRegOnDblClick_CallbackType     &� &��DCalendarEventsRegOnClick_CallbackType     � ��const char *     � ��LCID     	� 	��ERRORINFO  �  � ��HRESULT  � � ��SAFEARRAY *  � 	� 	��LPUNKNOWN     � ��VARIANT  � � ��VBOOL  �  � ��SCODE  � � ��CAObjHandle  � � ��DATE     � ��CURRENCY       :$@SYSHELP<>13438:    ^    This class contains functions you use to register callbacks that the ActiveX server objects call when events occur.  The callback registration functions are grouped into event classes.  The ActiveX server specifies which event classes are supported by each server object.  These relationships are documented in the event class' function panel help.    2    This class contains functions you use to register callbacks that ActiveX server objects call when events occur.  This class contains all of the callback registration functions for the DCalendarEvents event class.  The DCalendarEvents event class is supported by the following server object(s): ICalendar.         Calendar Control    v    Call this function to register a callback for the Click event of the DCalendarEvents event class.  When you register the callback, you must specify the CAObjHandle of the server object from which you want to receive events.  The following server objects generate DCalendarEvents events: ICalendar.

The callback function that you specify must have the following prototype:

HRESULT CVICALLBACK Callback (CAObjHandle caServerObjHandle,
                              void *caCallbackData);

Upon entry to the callback, the caServerObjHandle parameter identifies the object that is firing the event.  You can obtain the panel and control ID for the ActiveX control or document object firing the event by calling GetActiveXCtrlFromObjHandle.  The caCallbackData parameter contains the value you passed in the Callback Data parameter of this function.  The other parameters are event-specific and are specified and (optionally) documented by the server.  The return value is currently unused.  You should always return S_OK.  

You can view the server's documentation by bringing up the help for the Callback Function parameter of this function.        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code.     �    Pass the CAObjHandle of the server object from which you want to receive events.  You must pass a CAObjHandle to a server object that supports DCalendarEvents events.  The following server objects support DCalendarEvents events: ICalendar.         :$@SYSHELP<>13489:     �    Pass a value that you want the CVI ActiveX library to pass to your callback as the caCallbackData parameter.  Do not pass the address of a local variable or any other variable that might not be valid when the callback is executed.    0    This parameter specifies whether this registration function enables the registered callbacks for the server.  Pass 1 to enable all of the registered callbacks in the DCalendarEvents class associated with the server object passed in the Server Object parameter of this function.  Pass 0 to specify that this call to the registration function will not enable the callbacks.  Once the callbacks in the DCalendarEvents class have been enabled for a particular server object, the value of this parameter is ignored for subsequent callback registration functions in the DCalendarEvents class.

Typically, you pass 1 to enable callbacks immediately.  Pass 0 when you have a set of callbacks that must be enabled simultaneously in order for you to properly respond to the server events.  In this case, you must explicitly advise the server when you are ready to begin receiving events.  You can advise the server either by passing 1 for this parameter when you register the final callback, or by calling CA_EnableEventsForServerObject when you are ready to enable the callbacks.     �    This parameter returns a unique identifier for the callback.  Pass this identifier to CA_UnregisterEventCallback to unregister the callback.  Pass NULL if you do not want the Callback Id.    A����  �    Status                            O -   �  �    Server Object                     H - � �  �    Callback Function                 d -�    �    Callback Data                     T �      �    Enable Callbacks                  � � �     �    Callback Id                        	                   NULL    1            NULL   y    Call this function to register a callback for the DblClick event of the DCalendarEvents event class.  When you register the callback, you must specify the CAObjHandle of the server object from which you want to receive events.  The following server objects generate DCalendarEvents events: ICalendar.

The callback function that you specify must have the following prototype:

HRESULT CVICALLBACK Callback (CAObjHandle caServerObjHandle,
                              void *caCallbackData);

Upon entry to the callback, the caServerObjHandle parameter identifies the object that is firing the event.  You can obtain the panel and control ID for the ActiveX control or document object firing the event by calling GetActiveXCtrlFromObjHandle.  The caCallbackData parameter contains the value you passed in the Callback Data parameter of this function.  The other parameters are event-specific and are specified and (optionally) documented by the server.  The return value is currently unused.  You should always return S_OK.  

You can view the server's documentation by bringing up the help for the Callback Function parameter of this function.        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code.     �    Pass the CAObjHandle of the server object from which you want to receive events.  You must pass a CAObjHandle to a server object that supports DCalendarEvents events.  The following server objects support DCalendarEvents events: ICalendar.         :$@SYSHELP<>13490:     �    Pass a value that you want the CVI ActiveX library to pass to your callback as the caCallbackData parameter.  Do not pass the address of a local variable or any other variable that might not be valid when the callback is executed.    0    This parameter specifies whether this registration function enables the registered callbacks for the server.  Pass 1 to enable all of the registered callbacks in the DCalendarEvents class associated with the server object passed in the Server Object parameter of this function.  Pass 0 to specify that this call to the registration function will not enable the callbacks.  Once the callbacks in the DCalendarEvents class have been enabled for a particular server object, the value of this parameter is ignored for subsequent callback registration functions in the DCalendarEvents class.

Typically, you pass 1 to enable callbacks immediately.  Pass 0 when you have a set of callbacks that must be enabled simultaneously in order for you to properly respond to the server events.  In this case, you must explicitly advise the server when you are ready to begin receiving events.  You can advise the server either by passing 1 for this parameter when you register the final callback, or by calling CA_EnableEventsForServerObject when you are ready to enable the callbacks.     �    This parameter returns a unique identifier for the callback.  Pass this identifier to CA_UnregisterEventCallback to unregister the callback.  Pass NULL if you do not want the Callback Id.    A����  �    Status                            O -   �  �    Server Object                     H - � �  �    Callback Function                 d -�    �    Callback Data                     T �      �    Enable Callbacks                   � � �     �    Callback Id                        	                   NULL    1            NULL   �    Call this function to register a callback for the KeyDown event of the DCalendarEvents event class.  When you register the callback, you must specify the CAObjHandle of the server object from which you want to receive events.  The following server objects generate DCalendarEvents events: ICalendar.

The callback function that you specify must have the following prototype:

HRESULT CVICALLBACK Callback (CAObjHandle caServerObjHandle,
                              void *caCallbackData,
                              short *keyCode,
                              short  shift);

Upon entry to the callback, the caServerObjHandle parameter identifies the object that is firing the event.  You can obtain the panel and control ID for the ActiveX control or document object firing the event by calling GetActiveXCtrlFromObjHandle.  The caCallbackData parameter contains the value you passed in the Callback Data parameter of this function.  The other parameters are event-specific and are specified and (optionally) documented by the server.  The return value is currently unused.  You should always return S_OK.  

You can view the server's documentation by bringing up the help for the Callback Function parameter of this function.        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code.     �    Pass the CAObjHandle of the server object from which you want to receive events.  You must pass a CAObjHandle to a server object that supports DCalendarEvents events.  The following server objects support DCalendarEvents events: ICalendar.         :$@SYSHELP<>13492:     �    Pass a value that you want the CVI ActiveX library to pass to your callback as the caCallbackData parameter.  Do not pass the address of a local variable or any other variable that might not be valid when the callback is executed.    0    This parameter specifies whether this registration function enables the registered callbacks for the server.  Pass 1 to enable all of the registered callbacks in the DCalendarEvents class associated with the server object passed in the Server Object parameter of this function.  Pass 0 to specify that this call to the registration function will not enable the callbacks.  Once the callbacks in the DCalendarEvents class have been enabled for a particular server object, the value of this parameter is ignored for subsequent callback registration functions in the DCalendarEvents class.

Typically, you pass 1 to enable callbacks immediately.  Pass 0 when you have a set of callbacks that must be enabled simultaneously in order for you to properly respond to the server events.  In this case, you must explicitly advise the server when you are ready to begin receiving events.  You can advise the server either by passing 1 for this parameter when you register the final callback, or by calling CA_EnableEventsForServerObject when you are ready to enable the callbacks.     �    This parameter returns a unique identifier for the callback.  Pass this identifier to CA_UnregisterEventCallback to unregister the callback.  Pass NULL if you do not want the Callback Id.    '�����  �    Status                            (� -   �  �    Server Object                     )� - � �  �    Callback Function                 )� -�    �    Callback Data                     *� �      �    Enable Callbacks                  .� � �     �    Callback Id                        	                   NULL    1            NULL   �    Call this function to register a callback for the KeyPress event of the DCalendarEvents event class.  When you register the callback, you must specify the CAObjHandle of the server object from which you want to receive events.  The following server objects generate DCalendarEvents events: ICalendar.

The callback function that you specify must have the following prototype:

HRESULT CVICALLBACK Callback (CAObjHandle caServerObjHandle,
                              void *caCallbackData,
                              short *keyAscii);

Upon entry to the callback, the caServerObjHandle parameter identifies the object that is firing the event.  You can obtain the panel and control ID for the ActiveX control or document object firing the event by calling GetActiveXCtrlFromObjHandle.  The caCallbackData parameter contains the value you passed in the Callback Data parameter of this function.  The other parameters are event-specific and are specified and (optionally) documented by the server.  The return value is currently unused.  You should always return S_OK.  

You can view the server's documentation by bringing up the help for the Callback Function parameter of this function.        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code.     �    Pass the CAObjHandle of the server object from which you want to receive events.  You must pass a CAObjHandle to a server object that supports DCalendarEvents events.  The following server objects support DCalendarEvents events: ICalendar.         :$@SYSHELP<>13493:     �    Pass a value that you want the CVI ActiveX library to pass to your callback as the caCallbackData parameter.  Do not pass the address of a local variable or any other variable that might not be valid when the callback is executed.    0    This parameter specifies whether this registration function enables the registered callbacks for the server.  Pass 1 to enable all of the registered callbacks in the DCalendarEvents class associated with the server object passed in the Server Object parameter of this function.  Pass 0 to specify that this call to the registration function will not enable the callbacks.  Once the callbacks in the DCalendarEvents class have been enabled for a particular server object, the value of this parameter is ignored for subsequent callback registration functions in the DCalendarEvents class.

Typically, you pass 1 to enable callbacks immediately.  Pass 0 when you have a set of callbacks that must be enabled simultaneously in order for you to properly respond to the server events.  In this case, you must explicitly advise the server when you are ready to begin receiving events.  You can advise the server either by passing 1 for this parameter when you register the final callback, or by calling CA_EnableEventsForServerObject when you are ready to enable the callbacks.     �    This parameter returns a unique identifier for the callback.  Pass this identifier to CA_UnregisterEventCallback to unregister the callback.  Pass NULL if you do not want the Callback Id.    5�����  �    Status                            6� -   �  �    Server Object                     7� - � �  �    Callback Function                 7� -�    �    Callback Data                     8� �      �    Enable Callbacks                  = � �     �    Callback Id                        	                   NULL    1            NULL   �    Call this function to register a callback for the KeyUp event of the DCalendarEvents event class.  When you register the callback, you must specify the CAObjHandle of the server object from which you want to receive events.  The following server objects generate DCalendarEvents events: ICalendar.

The callback function that you specify must have the following prototype:

HRESULT CVICALLBACK Callback (CAObjHandle caServerObjHandle,
                              void *caCallbackData,
                              short *keyCode,
                              short  shift);

Upon entry to the callback, the caServerObjHandle parameter identifies the object that is firing the event.  You can obtain the panel and control ID for the ActiveX control or document object firing the event by calling GetActiveXCtrlFromObjHandle.  The caCallbackData parameter contains the value you passed in the Callback Data parameter of this function.  The other parameters are event-specific and are specified and (optionally) documented by the server.  The return value is currently unused.  You should always return S_OK.  

You can view the server's documentation by bringing up the help for the Callback Function parameter of this function.        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code.     �    Pass the CAObjHandle of the server object from which you want to receive events.  You must pass a CAObjHandle to a server object that supports DCalendarEvents events.  The following server objects support DCalendarEvents events: ICalendar.         :$@SYSHELP<>13492:     �    Pass a value that you want the CVI ActiveX library to pass to your callback as the caCallbackData parameter.  Do not pass the address of a local variable or any other variable that might not be valid when the callback is executed.    0    This parameter specifies whether this registration function enables the registered callbacks for the server.  Pass 1 to enable all of the registered callbacks in the DCalendarEvents class associated with the server object passed in the Server Object parameter of this function.  Pass 0 to specify that this call to the registration function will not enable the callbacks.  Once the callbacks in the DCalendarEvents class have been enabled for a particular server object, the value of this parameter is ignored for subsequent callback registration functions in the DCalendarEvents class.

Typically, you pass 1 to enable callbacks immediately.  Pass 0 when you have a set of callbacks that must be enabled simultaneously in order for you to properly respond to the server events.  In this case, you must explicitly advise the server when you are ready to begin receiving events.  You can advise the server either by passing 1 for this parameter when you register the final callback, or by calling CA_EnableEventsForServerObject when you are ready to enable the callbacks.     �    This parameter returns a unique identifier for the callback.  Pass this identifier to CA_UnregisterEventCallback to unregister the callback.  Pass NULL if you do not want the Callback Id.    D ����  �    Status                            E. -   �  �    Server Object                     F' - � �  �    Callback Function                 FC -�    �    Callback Data                     G3 �      �    Enable Callbacks                  Kk � �     �    Callback Id                        	                   NULL    1            NULL   �    Call this function to register a callback for the BeforeUpdate event of the DCalendarEvents event class.  When you register the callback, you must specify the CAObjHandle of the server object from which you want to receive events.  The following server objects generate DCalendarEvents events: ICalendar.

The callback function that you specify must have the following prototype:

HRESULT CVICALLBACK Callback (CAObjHandle caServerObjHandle,
                              void *caCallbackData,
                              short *cancel);

Upon entry to the callback, the caServerObjHandle parameter identifies the object that is firing the event.  You can obtain the panel and control ID for the ActiveX control or document object firing the event by calling GetActiveXCtrlFromObjHandle.  The caCallbackData parameter contains the value you passed in the Callback Data parameter of this function.  The other parameters are event-specific and are specified and (optionally) documented by the server.  The return value is currently unused.  You should always return S_OK.  

You can view the server's documentation by bringing up the help for the Callback Function parameter of this function.        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code.     �    Pass the CAObjHandle of the server object from which you want to receive events.  You must pass a CAObjHandle to a server object that supports DCalendarEvents events.  The following server objects support DCalendarEvents events: ICalendar.         :$@SYSHELP<>13488:     �    Pass a value that you want the CVI ActiveX library to pass to your callback as the caCallbackData parameter.  Do not pass the address of a local variable or any other variable that might not be valid when the callback is executed.    0    This parameter specifies whether this registration function enables the registered callbacks for the server.  Pass 1 to enable all of the registered callbacks in the DCalendarEvents class associated with the server object passed in the Server Object parameter of this function.  Pass 0 to specify that this call to the registration function will not enable the callbacks.  Once the callbacks in the DCalendarEvents class have been enabled for a particular server object, the value of this parameter is ignored for subsequent callback registration functions in the DCalendarEvents class.

Typically, you pass 1 to enable callbacks immediately.  Pass 0 when you have a set of callbacks that must be enabled simultaneously in order for you to properly respond to the server events.  In this case, you must explicitly advise the server when you are ready to begin receiving events.  You can advise the server either by passing 1 for this parameter when you register the final callback, or by calling CA_EnableEventsForServerObject when you are ready to enable the callbacks.     �    This parameter returns a unique identifier for the callback.  Pass this identifier to CA_UnregisterEventCallback to unregister the callback.  Pass NULL if you do not want the Callback Id.    RQ����  �    Status                            S_ -   �  �    Server Object                     TX - � �  �    Callback Function                 Tt -�    �    Callback Data                     Ud �      �    Enable Callbacks                  Y� � �     �    Callback Id                        	                   NULL    1            NULL   |    Call this function to register a callback for the AfterUpdate event of the DCalendarEvents event class.  When you register the callback, you must specify the CAObjHandle of the server object from which you want to receive events.  The following server objects generate DCalendarEvents events: ICalendar.

The callback function that you specify must have the following prototype:

HRESULT CVICALLBACK Callback (CAObjHandle caServerObjHandle,
                              void *caCallbackData);

Upon entry to the callback, the caServerObjHandle parameter identifies the object that is firing the event.  You can obtain the panel and control ID for the ActiveX control or document object firing the event by calling GetActiveXCtrlFromObjHandle.  The caCallbackData parameter contains the value you passed in the Callback Data parameter of this function.  The other parameters are event-specific and are specified and (optionally) documented by the server.  The return value is currently unused.  You should always return S_OK.  

You can view the server's documentation by bringing up the help for the Callback Function parameter of this function.        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code.     �    Pass the CAObjHandle of the server object from which you want to receive events.  You must pass a CAObjHandle to a server object that supports DCalendarEvents events.  The following server objects support DCalendarEvents events: ICalendar.         :$@SYSHELP<>13487:     �    Pass a value that you want the CVI ActiveX library to pass to your callback as the caCallbackData parameter.  Do not pass the address of a local variable or any other variable that might not be valid when the callback is executed.    0    This parameter specifies whether this registration function enables the registered callbacks for the server.  Pass 1 to enable all of the registered callbacks in the DCalendarEvents class associated with the server object passed in the Server Object parameter of this function.  Pass 0 to specify that this call to the registration function will not enable the callbacks.  Once the callbacks in the DCalendarEvents class have been enabled for a particular server object, the value of this parameter is ignored for subsequent callback registration functions in the DCalendarEvents class.

Typically, you pass 1 to enable callbacks immediately.  Pass 0 when you have a set of callbacks that must be enabled simultaneously in order for you to properly respond to the server events.  In this case, you must explicitly advise the server when you are ready to begin receiving events.  You can advise the server either by passing 1 for this parameter when you register the final callback, or by calling CA_EnableEventsForServerObject when you are ready to enable the callbacks.     �    This parameter returns a unique identifier for the callback.  Pass this identifier to CA_UnregisterEventCallback to unregister the callback.  Pass NULL if you do not want the Callback Id.    `T����  �    Status                            ab -   �  �    Server Object                     b[ - � �  �    Callback Function                 bw -�    �    Callback Data                     cg �      �    Enable Callbacks                  g� � �     �    Callback Id                        	                   NULL    1            NULL   y    Call this function to register a callback for the NewMonth event of the DCalendarEvents event class.  When you register the callback, you must specify the CAObjHandle of the server object from which you want to receive events.  The following server objects generate DCalendarEvents events: ICalendar.

The callback function that you specify must have the following prototype:

HRESULT CVICALLBACK Callback (CAObjHandle caServerObjHandle,
                              void *caCallbackData);

Upon entry to the callback, the caServerObjHandle parameter identifies the object that is firing the event.  You can obtain the panel and control ID for the ActiveX control or document object firing the event by calling GetActiveXCtrlFromObjHandle.  The caCallbackData parameter contains the value you passed in the Callback Data parameter of this function.  The other parameters are event-specific and are specified and (optionally) documented by the server.  The return value is currently unused.  You should always return S_OK.  

You can view the server's documentation by bringing up the help for the Callback Function parameter of this function.        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code.     �    Pass the CAObjHandle of the server object from which you want to receive events.  You must pass a CAObjHandle to a server object that supports DCalendarEvents events.  The following server objects support DCalendarEvents events: ICalendar.         :$@SYSHELP<>13494:     �    Pass a value that you want the CVI ActiveX library to pass to your callback as the caCallbackData parameter.  Do not pass the address of a local variable or any other variable that might not be valid when the callback is executed.    0    This parameter specifies whether this registration function enables the registered callbacks for the server.  Pass 1 to enable all of the registered callbacks in the DCalendarEvents class associated with the server object passed in the Server Object parameter of this function.  Pass 0 to specify that this call to the registration function will not enable the callbacks.  Once the callbacks in the DCalendarEvents class have been enabled for a particular server object, the value of this parameter is ignored for subsequent callback registration functions in the DCalendarEvents class.

Typically, you pass 1 to enable callbacks immediately.  Pass 0 when you have a set of callbacks that must be enabled simultaneously in order for you to properly respond to the server events.  In this case, you must explicitly advise the server when you are ready to begin receiving events.  You can advise the server either by passing 1 for this parameter when you register the final callback, or by calling CA_EnableEventsForServerObject when you are ready to enable the callbacks.     �    This parameter returns a unique identifier for the callback.  Pass this identifier to CA_UnregisterEventCallback to unregister the callback.  Pass NULL if you do not want the Callback Id.    nT����  �    Status                            ob -   �  �    Server Object                     p[ - � �  �    Callback Function                 pw -�    �    Callback Data                     qg �      �    Enable Callbacks                  u� � �     �    Callback Id                        	                   NULL    1            NULL   x    Call this function to register a callback for the NewYear event of the DCalendarEvents event class.  When you register the callback, you must specify the CAObjHandle of the server object from which you want to receive events.  The following server objects generate DCalendarEvents events: ICalendar.

The callback function that you specify must have the following prototype:

HRESULT CVICALLBACK Callback (CAObjHandle caServerObjHandle,
                              void *caCallbackData);

Upon entry to the callback, the caServerObjHandle parameter identifies the object that is firing the event.  You can obtain the panel and control ID for the ActiveX control or document object firing the event by calling GetActiveXCtrlFromObjHandle.  The caCallbackData parameter contains the value you passed in the Callback Data parameter of this function.  The other parameters are event-specific and are specified and (optionally) documented by the server.  The return value is currently unused.  You should always return S_OK.  

You can view the server's documentation by bringing up the help for the Callback Function parameter of this function.        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code.     �    Pass the CAObjHandle of the server object from which you want to receive events.  You must pass a CAObjHandle to a server object that supports DCalendarEvents events.  The following server objects support DCalendarEvents events: ICalendar.         :$@SYSHELP<>13495:     �    Pass a value that you want the CVI ActiveX library to pass to your callback as the caCallbackData parameter.  Do not pass the address of a local variable or any other variable that might not be valid when the callback is executed.    0    This parameter specifies whether this registration function enables the registered callbacks for the server.  Pass 1 to enable all of the registered callbacks in the DCalendarEvents class associated with the server object passed in the Server Object parameter of this function.  Pass 0 to specify that this call to the registration function will not enable the callbacks.  Once the callbacks in the DCalendarEvents class have been enabled for a particular server object, the value of this parameter is ignored for subsequent callback registration functions in the DCalendarEvents class.

Typically, you pass 1 to enable callbacks immediately.  Pass 0 when you have a set of callbacks that must be enabled simultaneously in order for you to properly respond to the server events.  In this case, you must explicitly advise the server when you are ready to begin receiving events.  You can advise the server either by passing 1 for this parameter when you register the final callback, or by calling CA_EnableEventsForServerObject when you are ready to enable the callbacks.     �    This parameter returns a unique identifier for the callback.  Pass this identifier to CA_UnregisterEventCallback to unregister the callback.  Pass NULL if you do not want the Callback Id.    |S����  �    Status                            }a -   �  �    Server Object                     ~Z - � �  �    Callback Function                 ~v -�    �    Callback Data                     f �      �    Enable Callbacks                  �� � �     �    Callback Id                        	                   NULL    1            NULL   ]    Use this function to create a new Calendar ActiveX control or document object.

If the server application is already running, this function may or may not start another copy of the application.  This is determined by the server application.

You must call CA_InitActiveXThreadStyleForCurrentThread with COINIT_APARTMENTTHREADED if you register any ActiveX event callbacks and want the callbacks to be called from the same thread in which they were registered.  If you do not call CA_InitActiveXThreadStyleForCurrentThread with COINIT_APARTMENTTHREADED your callbacks will be called from a system thread.    �    A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

A value of E_CVIAUTO_CVI_UI_ERROR indicates a User Interface Library error, in which case the specific UIL error code is returned separately as an output parameter.

You can use CA_GetAutomationErrorString to get the description of an error code.     �    The specifier for a particular panel that is currently in memory.

This handle will have been returned by the LoadPanel(), NewPanel(), or DuplicatePanel() function.     V    The label of the new ActiveX control or document object.

Pass "" or 0 for no label.    ;    The vertical coordinate at which the upper left corner of the ActiveX control or document object (not including labels) is placed.

The coordinate must be an integer value from -32768 to 32767.

The origin (0,0) is at the upper-left corner of the panel (directly below the title bar) before the panel is scrolled.    =    The horizontal coordinate at which the upper left corner of the ActiveX control or document object (not including labels) is placed.

The coordinate must be an integer value from -32768 to 32767.

The origin (0,0) is at the upper-left corner of the panel (directly below the title bar) before the panel is scrolled.     �    The ID used to specify this ActiveX control or document object in subsequent function calls.  Negative values indicate that an error occurred.  See cvi\include\userint.h for a list of possible error codes.  Zero is not a valid ID.     �    The User Interface Library error code if this function causes a UIL error.  In the event of a UIL error this function will return a value of E_CVIAUTO_CVI_UI_ERROR.    �7����  �    Status                            �� -       �    Panel                             �� - � �  �    Label                             �� -�     �    Top                               �: �      �    Left                              � � �     �    Control ID                        �o ��     �    UIL Error                          	               ""            	            	           �    Use this function to create a Calendar document object from a file.

If the server application is already running, this function may or may not start another copy of the application.  The server application determines whether the function starts another copy of the application.

You must call CA_InitActiveXThreadStyleForCurrentThread with COINIT_APARTMENTTHREADED if you register any ActiveX event callbacks and want the callbacks to be called from the same thread in which they were registered.  If you do not call CA_InitActiveXThreadStyleForCurrentThread with COINIT_APARTMENTTHREADED your callbacks will be called from a system thread.    �    A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

A value of E_CVIAUTO_CVI_UI_ERROR indicates a User Interface Library error, in which case the specific UIL error code is returned separately as an output parameter.

You can use CA_GetAutomationErrorString to get the description of an error code.     <    A file containing the data for an ActiveX document object.     �    The specifier for a particular panel that is currently in memory.

This handle will have been returned by the LoadPanel(), NewPanel(), or DuplicatePanel() function.     V    The label of the new ActiveX control or document object.

Pass "" or 0 for no label.    ;    The vertical coordinate at which the upper left corner of the ActiveX control or document object (not including labels) is placed.

The coordinate must be an integer value from -32768 to 32767.

The origin (0,0) is at the upper-left corner of the panel (directly below the title bar) before the panel is scrolled.    =    The horizontal coordinate at which the upper left corner of the ActiveX control or document object (not including labels) is placed.

The coordinate must be an integer value from -32768 to 32767.

The origin (0,0) is at the upper-left corner of the panel (directly below the title bar) before the panel is scrolled.     �    The ID used to specify this ActiveX control or document object in subsequent function calls.  Negative values indicate that an error occurred.  See cvi\include\userint.h for a list of possible error codes.  Zero is not a valid ID.     �    The User Interface Library error code if this function causes a UIL error.  In the event of a UIL error this function will return a value of E_CVIAUTO_CVI_UI_ERROR.    �Q����  �    Status                            � -   �  �    File Name                         �I - �     �    Panel                             �� -� �  �    Label                             �U �      �    Top                               �� � �     �    Left                              �� ��     �    Control ID                        �� �      �    UIL Error                          	                   ""            	            	                :$@SYSHELP<>13443:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.    �y����  �    Status                            �� -   �  �    Object Handle                     �� - � �  �    Error Info                        � -� �  �    Pclr Back Color                    	                       NULL    	                :$@SYSHELP<>13443:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.    ������  �    Status                            �� -   �  �    Object Handle                     �4 - � �  �    Error Info                        �` -� �  �    Pclr Back Color                    	                       NULL            :$@SYSHELP<>13444:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.    ������  �    Status                            �� -   �  �    Object Handle                     �; - � �  �    Error Info                        �g -�    �    Pn Day                             	                       NULL    	                :$@SYSHELP<>13444:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.    �4����  �    Status                            �S -   �  �    Object Handle                     �� - � �  �    Error Info                        �� -�    �    Pn Day                             	                       NULL            :$@SYSHELP<>13445:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.    �    A handle to an ActiveX object. You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.

Use this handle to call methods and get/set properties of the appropriate ActiveX object.

When it is no longer needed, you must discard this handle using CA_DiscardObjHandle.

See function help for more information.

NOTE: CAObjHandles created by this function inherit multithreading support and locale values from the Object Handle parameter.

To use different values for multithreading support and locale you can call CA_SetSupportForMultithreading and CA_SetLocale to specify the desired values.    �;����  �    Status                            �Z -   �  �    Object Handle                     �� - � �  �    Error Info                        �� -� �  �    Ppfont Day Font                    	                       NULL    	               :$@SYSHELP<>13445:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.    ©����  �    Status                            �� -   �  �    Object Handle                     �
 - � �  �    Error Info                        �6 -� �  �    Ppfont Day Font                    	                       NULL            :$@SYSHELP<>13446:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.    ɰ����  �    Status                            �� -   �  �    Object Handle                     � - � �  �    Error Info                        �= -� �  �    Pclr Day Font Color                	                       NULL    	                :$@SYSHELP<>13446:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.    �
����  �    Status                            �) -   �  �    Object Handle                     �k - � �  �    Error Info                        ֗ -� �  �    Pclr Day Font Color                	                       NULL            :$@SYSHELP<>13447:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.    �����  �    Status                            �0 -   �  �    Object Handle                     �r - � �  �    Error Info                        ݞ -�    �    Pn Day Length                      	                       NULL    	                :$@SYSHELP<>13447:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.    �k����  �    Status                            � -   �  �    Object Handle                     �� - � �  �    Error Info                        �� -�    �    Pn Day Length                      	                       NULL            :$@SYSHELP<>13449:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.    �r����  �    Status                            � -   �  �    Object Handle                     �� - � �  �    Error Info                        �� -�    �    Pn First Day                       	                       NULL    	                :$@SYSHELP<>13449:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.    ������  �    Status                            �� -   �  �    Object Handle                     �- - � �  �    Error Info                        �Y -�    �    Pn First Day                       	                       NULL            :$@SYSHELP<>14048:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.    ������  �    Status                            �� -   �  �    Object Handle                     �4 - � �  �    Error Info                        �` -�    �    Pl Grid Cell Effect                	                       NULL    	                :$@SYSHELP<>14048:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.    �-����  �    Status                            �L -   �  �    Object Handle                     �� - � �  �    Error Info                       � -�    �    Pl Grid Cell Effect                	                       NULL            :$@SYSHELP<>13451:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.    �    A handle to an ActiveX object. You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.

Use this handle to call methods and get/set properties of the appropriate ActiveX object.

When it is no longer needed, you must discard this handle using CA_DiscardObjHandle.

See function help for more information.

NOTE: CAObjHandles created by this function inherit multithreading support and locale values from the Object Handle parameter.

To use different values for multithreading support and locale you can call CA_SetSupportForMultithreading and CA_SetLocale to specify the desired values.   4����  �    Status                           S -   �  �    Object Handle                    � - � �  �    Error Info                       � -� �  �    Ppfont Grid Font                   	                       NULL    	               :$@SYSHELP<>13451:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   �����  �    Status                           � -   �  �    Object Handle                     - � �  �    Error Info                       / -� �  �    Ppfont Grid Font                   	                       NULL            :$@SYSHELP<>13452:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.   �����  �    Status                           � -   �  �    Object Handle                    
 - � �  �    Error Info                       6 -� �  �    Pclr Grid Font Color               	                       NULL    	                :$@SYSHELP<>13452:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   ����  �    Status                           " -   �  �    Object Handle                    d - � �  �    Error Info                        � -� �  �    Pclr Grid Font Color               	                       NULL            :$@SYSHELP<>13453:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.   "
����  �    Status                           $) -   �  �    Object Handle                    %k - � �  �    Error Info                       '� -� �  �    Pclr Grid Lines Color              	                       NULL    	                :$@SYSHELP<>13453:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   )d����  �    Status                           +� -   �  �    Object Handle                    ,� - � �  �    Error Info                       .� -� �  �    Pclr Grid Lines Color              	                       NULL            :$@SYSHELP<>13455:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.   0k����  �    Status                           2� -   �  �    Object Handle                    3� - � �  �    Error Info                       5� -�    �    Pn Month                           	                       NULL    	                :$@SYSHELP<>13455:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   7�����  �    Status                           9� -   �  �    Object Handle                    ;& - � �  �    Error Info                       =R -�    �    Pn Month                           	                       NULL            :$@SYSHELP<>13456:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.   >�����  �    Status                           @� -   �  �    Object Handle                    B- - � �  �    Error Info                       DY -�    �    Pn Month Length                    	                       NULL    	                :$@SYSHELP<>13456:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   F&����  �    Status                           HE -   �  �    Object Handle                    I� - � �  �    Error Info                       K� -�    �    Pn Month Length                    	                       NULL            :$@SYSHELP<>13457:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.   M-����  �    Status                           OL -   �  �    Object Handle                    P� - � �  �    Error Info                       R� -� �  �    Pf Show Date Selectors             	                       NULL    	                :$@SYSHELP<>13457:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   T�����  �    Status                           V� -   �  �    Object Handle                    W� - � �  �    Error Info                       Z -� �       Pf Show Date Selectors             	                       NULL    VTRUE VTRUE VFALSE VFALSE        :$@SYSHELP<>13458:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.   [�����  �    Status                           ]� -   �  �    Object Handle                    _ - � �  �    Error Info                       a4 -� �  �    Pf Show Days                       	                       NULL    	                :$@SYSHELP<>13458:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   c����  �    Status                           e  -   �  �    Object Handle                    fb - � �  �    Error Info                       h� -� �       Pf Show Days                       	                       NULL    VTRUE VTRUE VFALSE VFALSE        :$@SYSHELP<>13459:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.   j!����  �    Status                           l@ -   �  �    Object Handle                    m� - � �  �    Error Info                       o� -� �  �    Pf Show Horizontal Grid            	                       NULL    	                :$@SYSHELP<>13459:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   q{����  �    Status                           s� -   �  �    Object Handle                    t� - � �  �    Error Info                       w -� �       Pf Show Horizontal Grid            	                       NULL    VTRUE VTRUE VFALSE VFALSE        :$@SYSHELP<>13460:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.   x�����  �    Status                           z� -   �  �    Object Handle                    {� - � �  �    Error Info                       ~( -� �  �    Pf Show Title                      	                       NULL    	                :$@SYSHELP<>13460:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   �����  �    Status                           � -   �  �    Object Handle                    �V - � �  �    Error Info                       �� -� �       Pf Show Title                      	                       NULL    VTRUE VTRUE VFALSE VFALSE        :$@SYSHELP<>13461:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.   �����  �    Status                           �4 -   �  �    Object Handle                    �v - � �  �    Error Info                       �� -� �  �    Pf Show Vertical Grid              	                       NULL    	                :$@SYSHELP<>13461:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   �o����  �    Status                           �� -   �  �    Object Handle                    �� - � �  �    Error Info                       �� -� �       Pf Show Vertical Grid              	                       NULL    VTRUE VTRUE VFALSE VFALSE        :$@SYSHELP<>13462:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.    �    A handle to an ActiveX object. You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.

Use this handle to call methods and get/set properties of the appropriate ActiveX object.

When it is no longer needed, you must discard this handle using CA_DiscardObjHandle.

See function help for more information.

NOTE: CAObjHandles created by this function inherit multithreading support and locale values from the Object Handle parameter.

To use different values for multithreading support and locale you can call CA_SetSupportForMultithreading and CA_SetLocale to specify the desired values.   ������  �    Status                           �� -   �  �    Object Handle                    �� - � �  �    Error Info                       � -� �  �    Ppfont Title Font                  	                       NULL    	               :$@SYSHELP<>13462:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   ������  �    Status                           � -   �  �    Object Handle                    �^ - � �  �    Error Info                       �� -� �  �    Ppfont Title Font                  	                       NULL            :$@SYSHELP<>13463:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.   �����  �    Status                           �# -   �  �    Object Handle                    �e - � �  �    Error Info                       �� -� �  �    Pclr Title Font Color              	                       NULL    	                :$@SYSHELP<>13463:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   �^����  �    Status                           �} -   �  �    Object Handle                    �� - � �  �    Error Info                       �� -� �  �    Pclr Title Font Color              	                       NULL            :$@SYSHELP<>13464:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.    �    A Variant that is filled in by the function. You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.

The Variant Related Functions class in the CVI ActiveX Library contains functions to help you query the type of value stored in a Variant and to retrieve values from a Variant.

   �e����  �    Status                           �� -   �  �    Object Handle                    �� - � �  �    Error Info                       �� -� �  �    Pvar Value                         	                       NULL    	                :$@SYSHELP<>13464:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   ������  �    Status                           �� -   �  �    Object Handle                    � - � �  �    Error Info                       �- -� �  �    Pvar Value                         	                       NULL           A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.    �    A Variant that is filled in by the function. You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.

The Variant Related Functions class in the CVI ActiveX Library contains functions to help you query the type of value stored in a Variant and to retrieve values from a Variant.

   Ë����  �    Status                           Ū -   �  �    Object Handle                    �� - � �  �    Error Info                       � -� �  �    Pvar Value                         	                       NULL    	               A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   ˪����  �    Status                           �� -   �  �    Object Handle                    � - � �  �    Error Info                       �7 -� �  �    Pvar Value                         	                       NULL            :$@SYSHELP<>13465:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.   ұ����  �    Status                           �� -   �  �    Object Handle                    � - � �  �    Error Info                       �> -� �  �    Pf Value Is Null                   	                       NULL    	                :$@SYSHELP<>13465:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   �����  �    Status                           �* -   �  �    Object Handle                    �l - � �  �    Error Info                       ߘ -� �       Pf Value Is Null                   	                       NULL    VTRUE VTRUE VFALSE VFALSE        :$@SYSHELP<>13466:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     �    You can pass NULL for this parameter if you do not need this information.

Documentation for this function, if provided by the server, is located in the function help.   �+����  �    Status                           �J -   �  �    Object Handle                    � - � �  �    Error Info                       � -�    �    Pn Year                            	                       NULL    	                :$@SYSHELP<>13466:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   �����  �    Status                           � -   �  �    Object Handle                    �� - � �  �    Error Info                       � -�    �    Pn Year                            	                       NULL            :$@SYSHELP<>13468:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.   �����  �    Status                           � -   �  �    Object Handle                    �� - � �  �    Error Info                         	                       NULL        :$@SYSHELP<>13470:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.   ������  �    Status                           � -   �  �    Object Handle                    �U - � �  �    Error Info                         	                       NULL        :$@SYSHELP<>13472:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.   �\����  �    Status                           �{ -   �  �    Object Handle                    �� - � �  �    Error Info                         	                       NULL        :$@SYSHELP<>13474:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.   �����  �    Status                           � -   �  �    Object Handle                    % - � �  �    Error Info                         	                       NULL        :$@SYSHELP<>13476:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.   	,����  �    Status                           K -   �  �    Object Handle                    � - � �  �    Error Info                         	                       NULL        :$@SYSHELP<>13478:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.   �����  �    Status                           � -   �  �    Object Handle                    � - � �  �    Error Info                         	                       NULL        :$@SYSHELP<>13480:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.   �����  �    Status                            -   �  �    Object Handle                    ] - � �  �    Error Info                         	                       NULL        :$@SYSHELP<>13482:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.   d����  �    Status                           � -   �  �    Object Handle                    � - � �  �    Error Info                         	                       NULL        :$@SYSHELP<>13484:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.   "�����  �    Status                           $� -   �  �    Object Handle                    &- - � �  �    Error Info                         	                       NULL        :$@SYSHELP<>13486:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.   )4����  �    Status                           +S -   �  �    Object Handle                    ,� - � �  �    Error Info                         	                       NULL        :$@SYSHELP<>13467:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.   /�����  �    Status                           1� -   �  �    Object Handle                    2� - � �  �    Error Info                         	                       NULL        :$@SYSHELP<>13445:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   6����  �    Status                           8# -   �  �    Object Handle                    9e - � �  �    Error Info                       ;� -� �  �    Ppfont Day Font                    	                       NULL            :$@SYSHELP<>13451:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   =����  �    Status                           ?* -   �  �    Object Handle                    @l - � �  �    Error Info                       B� -� �  �    Ppfont Grid Font                   	                       NULL            :$@SYSHELP<>13462:        A value indicating whether an error occurred.  A negative error code indicates function failure.

Error codes are defined in cvi\include\cviauto.h and cvi\sdk\include\winerror.h.

You can use CA_GetAutomationErrorString to get the description of an error code or CA_DisplayErrorInfo to display the description of the error code.

If the error code is DISP_E_EXCEPTION  (0x80020009 or -2147352567), then the Error Info parameter contains additional error information.  You can use CA_DisplayErrorInfo to display the error information.    :    An ActiveX object handle obtained from GetObjHandleFromActiveXCtrl or an ActiveX method or property.

All of the methods that can be applied to a particular object are grouped under a single class in the function tree.  The name of the class corresponds to the type of the object to which this handle must refer.    $    When an ActiveX server function fails with the error code DISP_E_EXCEPTION, descriptive information about the error code is stored in this parameter.  The descriptive information may include the error's code, source, and description.  It may also include a help file and help file context.

When an ActiveX server function fails with the error codes DISP_E_PARAMNOTFOUND, DISP_E_TYPEMISMATCH, or E_INVALIDARG, the parameter position of the invalid argument may be stored in the errorParamPos member of this parameter.

This parameter may be NULL.     ^    Documentation for this function, if provided by the server, is located in the function help.   D����  �    Status                           F1 -   �  �    Object Handle                    Gs - � �  �    Error Info                       I� -� �  �    Ppfont Title Font                  	                       NULL     ����         �  Q             K.        DCalendarEventsRegOnClick                                                                                                               ����         �  !Q             K.        DCalendarEventsRegOnDblClick                                                                                                            ����         "�  /�             K.        DCalendarEventsRegOnKeyDown                                                                                                             ����         1  =�             K.        DCalendarEventsRegOnKeyPress                                                                                                            ����         ?H  L0             K.        DCalendarEventsRegOnKeyUp                                                                                                               ����         M�  Za             K.        DCalendarEventsRegOnBeforeUpdate                                                                                                        ����         [�  hd             K.        DCalendarEventsRegOnAfterUpdate                                                                                                         ����         i�  vd             K.        DCalendarEventsRegOnNewMonth                                                                                                            ����         w�  �c             K.        DCalendarEventsRegOnNewYear                                                                                                             ����         ��  �             K.        NewICalendar                                                                                                                            ����         ��  �{             K.        OpenICalendar                                                                                                                           ����         �]  ��             K.        ICalendarGetBackColor                                                                                                                   ����         ��  ��             K.        ICalendarSetBackColor                                                                                                                   ����         ��  �             K.        ICalendarGetDay                                                                                                                         ����         �  �'             K.        ICalendarSetDay                                                                                                                         ����         �  ��             K.        ICalendarGetDayFont                                                                                                                     ����           Ȝ             K.        ICalendarSetDayFont                                                                                                                     ����         ɔ  ��             K.        ICalendarGetDayFontColor                                                                                                                ����         ��  ��             K.        ICalendarSetDayFontColor                                                                                                                ����         ��  �O             K.        ICalendarGetDayLength                                                                                                                   ����         �O  �^             K.        ICalendarSetDayLength                                                                                                                   ����         �V  �             K.        ICalendarGetFirstDay                                                                                                                    ����         ��  �             K.        ICalendarSetFirstDay                                                                                                                    ����         ��  �             K.        ICalendarGetGridCellEffect                                                                                                              ����         �               K.        ICalendarSetGridCellEffect                                                                                                              ����         �             K.        ICalendarGetGridFont                                                                                                                    ����        � �             K.        ICalendarSetGridFont                                                                                                                    ����        � �             K.        ICalendarGetGridFontColor                                                                                                               ����        �  �             K.        ICalendarSetGridFontColor                                                                                                               ����        !� (H             K.        ICalendarGetGridLinesColor                                                                                                              ����        )H /W             K.        ICalendarSetGridLinesColor                                                                                                              ����        0O 6�             K.        ICalendarGetMonth                                                                                                                       ����        7� =�             K.        ICalendarSetMonth                                                                                                                       ����        >� E
             K.        ICalendarGetMonthLength                                                                                                                 ����        F
 L             K.        ICalendarSetMonthLength                                                                                                                 ����        M Sk             K.        ICalendarGetShowDateSelectors                                                                                                           ����        Tk Zz             K.        ICalendarSetShowDateSelectors                                                                                                           ����        [� a�             K.        ICalendarGetShowDays                                                                                                                    ����        b� h�             K.        ICalendarSetShowDays                                                                                                                    ����        j p_             K.        ICalendarGetShowHorizontalGrid                                                                                                          ����        q_ wn             K.        ICalendarSetShowHorizontalGrid                                                                                                          ����        x ~�             K.        ICalendarGetShowTitle                                                                                                                   ����        � ��             K.        ICalendarSetShowTitle                                                                                                                   ����        �� �S             K.        ICalendarGetShowVerticalGrid                                                                                                            ����        �S �b             K.        ICalendarSetShowVerticalGrid                                                                                                            ����        �s ��             K.        ICalendarGetTitleFont                                                                                                                   ����        �� ��             K.        ICalendarSetTitleFont                                                                                                                   ����        �� �B             K.        ICalendarGetTitleFontColor                                                                                                              ����        �B �Q             K.        ICalendarSetTitleFontColor                                                                                                              ����        �I ��             K.        ICalendarGetValue                                                                                                                       ����        ��              K.        ICalendarSetValue                                                                                                                       ����       ���� ʪ             K.        ICalendarGet_Value                                                                                                                      ����       ���� ѝ             K.        ICalendarSet_Value                                                                                                                      ����        ҕ ��             K.        ICalendarGetValueIsNull                                                                                                                 ����        �� ��             K.        ICalendarSetValueIsNull                                                                                                                 ����        � �i             K.        ICalendarGetYear                                                                                                                        ����        �i �x             K.        ICalendarSetYear                                                                                                                        ����        �p �             K.        ICalendarNextDay                                                                                                                        ����        �� ��             K.        ICalendarNextMonth                                                                                                                      ����        �@ �             K.        ICalendarNextWeek                                                                                                                       ����        � Q             K.        ICalendarNextYear                                                                                                                       ����        	 �             K.        ICalendarPreviousDay                                                                                                                    ����        x !             K.        ICalendarPreviousMonth                                                                                                                  ����        � �             K.        ICalendarPreviousWeek                                                                                                                   ����        H !�             K.        ICalendarPreviousYear                                                                                                                   ����        "� (Y             K.        ICalendarRefresh                                                                                                                        ����        ) .�             K.        ICalendarToday                                                                                                                          ����        /� 5)             K.        ICalendarAboutBox                                                                                                                       ����        5� ;�             K.        ICalendarSetByRefDayFont                                                                                                                ����        <� B�             K.        ICalendarSetByRefGridFont                                                                                                               ����        C� J             K.        ICalendarSetByRefTitleFont                                                                                                                    �                                                                                    	Event Callback Registration Functions                                               oDCalendarEvents                                                                      �Register Click Callback                                                              �Register DblClick Callback                                                           �Register KeyDown Callback                                                            �Register KeyPress Callback                                                           �Register KeyUp Callback                                                              �Register BeforeUpdate Callback                                                       �Register AfterUpdate Callback                                                        �Register NewMonth Callback                                                           �Register NewYear Callback                                                           �ICalendar                                                                            �New ICalendar                                                                        �Open ICalendar                                                                       �Get Back Color                                                                       �Set Back Color                                                                       �Get Day                                                                              �Set Day                                                                              �Get Day Font                                                                         �Set Day Font                                                                         �Get Day Font Color                                                                   �Set Day Font Color                                                                   �Get Day Length                                                                       �Set Day Length                                                                       �Get First Day                                                                        �Set First Day                                                                        �Get Grid Cell Effect                                                                 �Set Grid Cell Effect                                                                 �Get Grid Font                                                                        �Set Grid Font                                                                        �Get Grid Font Color                                                                  �Set Grid Font Color                                                                  �Get Grid Lines Color                                                                 �Set Grid Lines Color                                                                 �Get Month                                                                            �Set Month                                                                            �Get Month Length                                                                     �Set Month Length                                                                     �Get Show Date Selectors                                                              �Set Show Date Selectors                                                              �Get Show Days                                                                        �Set Show Days                                                                        �Get Show Horizontal Grid                                                             �Set Show Horizontal Grid                                                             �Get Show Title                                                                       �Set Show Title                                                                       �Get Show Vertical Grid                                                               �Set Show Vertical Grid                                                               �Get Title Font                                                                       �Set Title Font                                                                       �Get Title Font Color                                                                 �Set Title Font Color                                                                 �Get Value                                                                            �Set Value                                                                            �Get_Value                                                                            �Set_Value                                                                            �Get Value Is Null                                                                    �Set Value Is Null                                                                    �Get Year                                                                             �Set Year                                                                             �Next Day                                                                             �Next Month                                                                           �Next Week                                                                            �Next Year                                                                            �Previous Day                                                                         �Previous Month                                                                       �Previous Week                                                                        �Previous Year                                                                        �Refresh                                                                              �Today                                                                                �About Box                                                                            �Set By Ref Day Font                                                                  �Set By Ref Grid Font                                                                 �Set By Ref Title Font                                                           