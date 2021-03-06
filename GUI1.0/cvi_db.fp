s��        �   � �f   $   �   
����                                           SQL Toolkit                                      � ��tDBParameterDirection     � ��tDBConnectionAttr     � ��tDBStatementAttributes     � ��tDBColumnAttr     � ��tDBParamAttr     � ��tDBSchemaType     	� 	��tDBAffect     	� 	��VARIANT *     � ��VARIANT     � ��size_t   �    This toolkit allows communication with ADO/OLEDB and ODBC compliant databases from a variety of vendors.  The toolkit supplies a set of high level functions for various database interactions.
     �    You must connect to a database before using any other SQL Toolkit functions.  You should also disconnect from all databases before your program exits.     �    These functions work with constructed SQL statements.  They are used primarily to construct and execute simple SELECT statements, but can also be used to create tables.     G    These functions work with SQL statements provided by the programmer.
     ]    These functions fetch records.  You can use them with either automatic SQL or explicit SQL.     ~    These functions allow inserting, deleting and updating records.  They may be used with either automatic SQL or explicit SQL.     �    These functions return information about databases, tables and active statements.  They may be used with either automatic SQL or explicit SQL.     N    These functions return information about available data sources, and tables.     F    These functions return information about an active SELECT statement.     �    These functions allow database operations to be grouped into transactions which may be rolled back (undone) or committed
as a unit.     ;    These functions get error and warning codes and messages.     =    These functions free memory allocated by toolkit functions.     G    Get SQL Toolkit version and set compatibility with previous versions.     �    These functions allow for more advanced operations.  They are more closely tied to the underlying implementation model than the higher level functions.     �    The functions provide the ability to set and get connection attributes and separate create and open functions for  connections so attributes can be set before the connection is opened.     �    The functions provide the ability to set and get statement attributes and separate create and open functions for SQL statements so attributes can be set before the statement is opened.     E    Functions for placing all returned records in an array of Variants.     X    Functions which create parameters for stored procedures or parameterized SQL queries.
     d    Functions to set the value of input parameters for stored procedures or parameterized SQL queries.     J    Functions to get the values of output parameters for stored procedures.
     B    Functions to put values into records without binding variables.
     B    Functions to get values from records without binding variables.
        Initialize the SQL toolkit.  If you use the toolkit functions from multiple threads, you must initialize the toolkit before calling any toolkit functions.  You do not need to intialize the toolkit if you only use the toolkit from a single thread.

Note:  You cannot initialize the toolkit for use from multiple threads if you use the Microsoft ODBC drivers version 3.50 or earlier for Access, DBase, FoxPro, Paradox, Excel or text files.

Example:
    resCode = DBInit(DB_INIT_MULTITHREADED);
    hdbc = DBConnect("DSN=CVI Samples");
     �    Initialization options.

Value                         Meaning
-----                         -------
DB_INIT_SINGLE_THREADED       Initialize for single threaded.
DB_INIT_MULTI_THREADED        Initialize for multi threaded.     �    Result code returned by DBInit.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
    � $       �    Options                           ����         Result Code                      J Multithreaded DB_INIT_MULTITHREADED Singlethreaded DB_INIT_SINGLETHREADED    	           �    Opens a connection to a database system to allow SQL statements to be executed.  DBConnect is similar to DBNewConnection followed by DBOpenConnection.

If your program is multithreaded, you must call DBInit before calling any DBConnect or DBNewConnection.

Examples:
  To connect to CVI Sample tables:
    hdbc = DBConnect("DSN=CVI32_Samples");
    ...
    res_code = DBDisconnect();

See Also:
    DBDisconnect, DBNewConnection, DBOpenConnection
    �    Database connection handle that identifies the connection and is a parameter to other functions.  If the handle is less than or equal to 0, the connection could not be opened.

Prior to version 2.0, the SQL Toolkit always returned 0 on error.  To minimize changes to programs which depend on this behavior, set the compatility mode to version 1.1 with:
    DBSetBackwardCompatibility(110);

    C    Specifies a data source as a detailed connection string containing a series of argument = value statements separated by semicolons.

The following attributes are supported at the ADO level.  Any other arguments are passed directly to the provider without any processing by ADO 

Attribute          Description
---------          -----------
Provider           Name of ADO provider to use for the 
                   connection.  If not specified the connection 
                   uses default ODBC provider.
Data Source        Name of the data source to use for the
                   connection, for example an MS Access database 
                   registered as an ODBC data source.
User ID            User name to use when opening the connection.
Password           Password to use when opening the connection.
File Name          A provider specific file which contains
                   preset connection information.

Most ODBC data sources support the following attributes.  See the driver documentation for each database for additional attributes.

Attribute          Description
---------          -----------

DSN                Name of the ODBC data source to use for the
                   connection.
DLG                When enabled (DLG=1) displays a dialog box
                   that allows user input of connection string
                   information.
UID                The user ID or name.
PWD                The password.
MODIFYSQL          Set to 1, support ODBC compliant SQL.
                   Set to 0, support native SQL of the 
                     underlying database.
    ����         Connection Handle                 | @ F          Connection String                  	               	    Sets the attribute value for all subsequent statements created on a connection.

Example:

    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");
     S    The handle to the database connection that DBConnect or DBNewConnection returned.    |    The attribute to set.  The valid attributes are:

Attribute                Values
---------                ------
ATTR_DB_USE_COMMAND      DB_USE_RECORDSET_ONLY
                         DB_USE_COMMAND 
ATTR_LOCK_TYPE           DB_LOCK_READ_ONLY
                             You cannot alter the data.
                         DB_LOCK_PESSIMISTIC
                             The provider does what is necessary
                             to ensure successful editing of the
                             records, usually by locking records
                             at the data source immediately upon
                             editing.
                         DB_LOCK_OPTIMISTIC
                             The provider locks records only
                             when you call DBUpdateRecord.
                         DB_LOCK_BATCH_OPTIMISTIC
                             Note: DB_LOCK_BATCH_OPTIMISTIC is
                             required to use DBUpdateBatch.
ATTR_DB_CURSOR_TYPE      DB_CURSOR_TYPE_STATIC
                             A static copy of a set of records 
                             Additions, changes, or deletions by 
                             other users are not visible.
                         DB_CURSOR_TYPE_FORWARD_ONLY
                             Identical to a static cursor except 
                             that you can only scroll forward 
                             through records. This improves
                             performance in situations when you 
                             only need to make a single pass 
                             through a recordset.
                         DB_CURSOR_TYPE_DYNAMIC
                             Additions, changes, and deletions 
                             by other users are visible, and all 
                             types of movement through the
                             recordset are allowed.
                         DB_CURSOR_TYPE_KEYSET
                             Like a dynamic cursor, except that 
                             you can't see records that other 
                             users add.  Records that other
                             users delete are inaccessible from 
                             your recordset). Data changes by 
                             other users within records are
                             still visible.
ATTR_DB_COMMAND_TYPE     DB_COMMAND_UNKNOWN
                             ADO attempts to determine the
                             command type.
                         DB_COMMAND_TEXT
                             SQL statement or for some ADO
                             providers a command in the
                             provider's command language.
                         DB_COMMAND_TABLE
                             Table name.
                         DB_COMMAND_STORED_PROC
                             Call to a stored procedure
    q    The value for the attribute.  Valid values are:

Attribute                Values
---------                ------
ATTR_DB_USE_COMMAND      DB_USE_RECORDSET_ONLY
                         DB_USE_COMMAND 
ATTR_LOCK_TYPE           DB_LOCK_READ_ONLY
                         DB_LOCK_PESSIMISTIC
                         DB_LOCK_OPTIMISTIC
                         DB_LOCK_BATCH_OPTIMISTIC
                             Note: DB_LOCK_BATCH_OPTIMISTIC is
                             required to use DBUpdateBatch.
ATTR_DB_CURSOR_TYPE      DB_CURSOR_TYPE_FORWARD_ONLY
                         DB_CURSOR_TYPE_KEYSET
                         DB_CURSOR_TYPE_DYNAMIC
                         DB_CURSOR_TYPE_STATIC

ATTR_DB_COMMAND_TYPE     DB_COMMAND_UNKNOWN
                         DB_COMMAND_TEXT
                         DB_COMMAND_TABLE
                         DB_COMMAND_STORED_PROC


     �    Result code returned by DBSetAttributeDefault.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.    R $            Connection Handle                 � $ �         Attribute                         '1 $T         Value                             *����         Result Code                                       �Use Command Object ATTR_DB_USE_COMMAND Lock Type ATTR_DB_LOCK_TYPE Cursor Type ATTR_DB_CURSOR_TYPE Command Type ATTR_DB_COMMAND_TYPE        	           �    Closes a connection to a database system.  You should close all connections before your program terminates to free system resources.  Calling DBDisconnect is equivalent to calling DBCloseConnection and then DBDiscardConnection.

DBDisconnect deactivates any active maps or SQL statements on the connection.

Example:
    hdbc = DBConnect("DSN=CVI32_Samples");
    ...
    res_code = DBDisconnect(hdbc);

See also:
    DBConnect     �    Result code returned by DBDisconnect.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.     :    Handle to the database connection returned by DBConnect.    .����         Result Code                       /t 7 K           Connection Handle                  	               *    Sets the default database in systems that allow you to store tables in separate databases.

A limited number of database systems support this function.

Example:
    hdbc = DBConnect("DSN=QESS;UID=STEPHEN");
    res_code = DBSetDatabase(hdbc, "TESTS")
    ...
    res_code = DBDisconnect(hdbc);

     �    Result code returned by DBSetDatabase.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.     L    Handle to the database connection returned by DBConnect or DBNewConnection     $    Name of the new default database.
    1b���         Result Code                       2+ 7 K           Connection Handle                 2 7         Database Name                      	                ""   \    Begin a set of column to variable mappings.  The map describes which columns will be selected and the variables that will receive column values when you fetch a record.  You can also use the map with DBCreateTableFromMap to create a new database table.

Example:

    hmap = DBBeginMap(hdbc);
    resCode = DBMapColumnToChar(hstmt, "SER_NUM", 11, serialNum, 
                                &sNumStatus, "");
    resCode = DBMapColumnToDouble(map, "MEAS1", 
                                  &measurement,              
                                  &measStatus);
    ...
    hstmt = DBActivateMap(hmap, "TESTLOG");
    while (DBFetchNext(hstmt) == 0) {
        ...
    }
    resCode = DBDeactivateMap(hmap);

See Also:
    DBMapColumnTo functions, DBCreateTableFromMap, 
    DBActivateMap, DBFetchNext, DBFetchPrev, DBFetchRandom, 
    DBDeactivateMap.
     K    The handle to the database connection that DBConnect previously returned.    �    Handle to the new map.  A value less than or equal to 0 indicates an error.  This value is a parameter to DBCreateTableFromMap, DBActivateMap and the DBMapColumnTo... functions.

Note: prior to version 2.0, the SQL Toolkit always returned 0 on error.  To minimize changes to programs that depend on this behavior, set the compatility mode to version 1.1 with:
    DBSetBackwardCompatibility(110);

    6� 3 1           Connection Handle                 7���         Map Handle                             	           4    Specifies a column selected and the value and status variables in your program that are to receive the column's value and status when you fetch a record.

Example:

    char serialNum[11];
    int sNumStatus;
    ...
    hmap = DBBeginMap(hdbc);
    resCode = DBMapColumnToChar(hmap, "SER_NUM", 11, serialNum, 
                                &sNumStatus, "");
    /* More variable mappings */
    ...
    hstmt = DBActivateMap(map, "testlog");
    while (DBFetchNext(hstmt) == 0) {
        if (sNumStatus == DB_NULL_DATA)
           ...
        if (sNumStatus == DB_TRUNCATION)
           ...
        printf("Serial Number: %s\n",serialNumber);
        ...
    }
    resCode = DBDeactivateMap(hmap);

See Also:
    DBBeginMap, DBActivateMap, DBFetchNext, DBFetchPrev,
    DBFetchRandom, DBPutRecord, DBDeactivateMap.
     -    Handle to the map that DBBeginMap returned.    �    The column name whose variables are specified.

Note: If you connect to an existing table, but use a column name that is not in the table, some database systems will interpret the invalid name as a parameter.  The resulting error message is misleading.

Note: Some database systems have restrictions on column names. For maximum portability, limit column names to 10 upper case characters with no space characters (or enclose the column name in the ASCII grave character (`)).
     �    Pointer to the variable the receives the null-terminated character string value for the specified column when you fetch a record.    0    Pointer to the variable the receives the status value for the specified column when you fetch a record.  The status value is DB_TRUNCATION (-1), DB_NULL_DATA (-2) or the number of bytes fetched.

Note: your program can also set the status variable to change the behavior of DBPutRecord.  To place a NULL value into a column, set the status value for that column to DB_NULL_DATA before calling DBPutRecord.  To prevent DBPutRecord from updating a column, set the status value to DB_NO_DATA_CHANGE.  This is useful when the record contains read only columns. 
    E    Result code returned by DBMapColumnToChar.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.

Note: if you provide an illegal column name, MS Access returns the misleading error message "Too few parameters. Expected 1."
     �    Size of the target string in bytes.  The toolkit uses one byte of the target string for the string termination character, NUL.        Format string.  Use the empty string "" if you want ADO to supply the formatting based on the Windows control panel settings.

Date formats support the following symbols

Symbol    Description
------    -----------
m         Month�s number suppress leading zero
mm        Month�s number with leading zero if applicable
mmm       Month�s three letter abbreviation, lowercase
Mmm       Month�s three letter abbreviation, initial cap
MMM       Month�s three letter abbreviation, upper case
mmmm      Month�s full name, lowercase
Mmmm      Month�s full name, initial cap
MMMM      Month�s full name, upper case
d         Day of the month�s number, suppress leading zero
dd        Day of the month�s number, include leading zero
ddd       Day of the month�s three letter abbreviation, 
          lowercase
Ddd       Day of the month�s three letter abbreviation, initial     
          cap
DDD       Day of the month�s three letter abbreviation, upper 
          case
dddd      Day of the month�s full name, lower case
Dddd      Day of the month�s full name, initial cap
DDDD      Day of the month�s full name, upper case
yy        Last two digits of year
yyyy      Four digit year
h         Hour of the day, suppress leading zero 
          (use am/pm symbol for 12 hour style)
hh        Hour of the day, include leading zero 
          (use am/pm symbol for 12 hour style)
i (or m)  Minute of the hour, suppress leading zero
ii (or mm)Minute of the hour, include leading zero
s         Second of the minute, suppress leading zero
ss        Second of the minute, include leading zero
ss.ssssss Second of the minute with fractional seconds, (use up
          to six �s� symbols after the decimal point)        am/pm     "am" or "pm" string, lower case (forces 12 hour clock)
a/p       "a" or "p" string.  (forces 12 hour clock)
AM/PM     "AM" or "PM" string, upper case (forces 12 hour clock)
A/P       "A" or "P" string, upper case (forces 12 hour clock)
l/l       localized am/pm string (forces 12 hour clock)
J         Julian value for date/time.
/ - . : , Output the character
<space>   Output a space character
\<char>   Output the character following the �\� character
"<text>"  Output the text
�<text>�  Output the string
GD        Windows Short Date Format (Do not combine other format
          symbols with GD except "[US]"
GDT       Windows Short Date Format + Time Format Do not combine
          with other format symbols except "[US]")
GL        Windows Long Date Format. (Do not combine other format 
          symbols with GL except "[US]")
GLT       Windows Long Date Format + Time Format (Do not combine
          other format symbols with GLT except "[US]")
GT        Windows Time Format (Do not combine any other format
          symbols with GT)
[US]      The information in the International section of the 
          Windows control panel is ignored, instead the United
          States defaults are substituted.

Numeric Format Strings allow you to format numbers in a variety of ways. Numeric formats can have one section or two sections separated by a semicolon. Formats with one section use the same format for positive and negative numbers. Formats with two sections use the second section as the format for negative numbers. 

Number formats support the following symbols

Symbol    Description
------    -----------
$         Output the Windows currency string
.         Output the Windows decimal point character 
,         Output the Windows thousands separator character 
#         Output a digit. If there is no digit to output in the 
          position output nothing.
0         Output a digit, If there is no digit to output in the 
          position output a zero
?         Output a digit, If there is no digit to output in the 
          position output a space
%         Output the value as a percent. The value is multiplied            
          by 100 and the �%� character is output.
e+        Output in scientific notation, show exponent sign only 
          if negative
e-        Output in scientific notation, always show sign of 
          exponent
E+ E-     Upper case analogs of e+ and e-
- + ( ) , Output the character
<space>   Output a space character
\<char>   Output the character following the �\� character
"<text>"  Output the text
�<text>�  Output the text
GN        Windows General Number Format (Note you can only 
          combine GN with symbols which are enclosed in 
          brackets such as "[US]"
GF        Windows General Fixed Format for numbers (Note
          you can only combine GF with symbols which are 
          enclosed in brackets such as "[US]")
GC        Windows General Currency Format for numbers (Note you 
          can only combine GC with symbols which are enclosed 
          in brackets such as "[US]"
[S/n]     Scale (divide) the number by a power of 10 before 
          output.
[S*n]     Scale (multiply) the number by a power of 10 before 
          output. 
[US]      The information in the International section of the 
          Windows control panel is ignored, instead the United
          States defaults are substituted.
    <e . 7           Map Handle                        <� . �         Column Name                       >� w 3         Location for Value                ? z �         Location for Status               AD���         Result Code                       B� 0~         Maximum Length                    C {�         Format String                          ""    	            	            	                ""   6    Specifies a column selected and the value and status variables in your program that are to receive the column's value and status when you fetch a record.

Example:

    short numTries;
    long  numTriesStatus;
    ...
    hmap = DBBeginMap(hdbc);
    resCode = DBMapColumnToShort(hmap, "NUM_TRIES", &numTries, 
                                 &numTriesStatus);
    /* More variable mappings */
    ...
    hstmt = DBActivateMap(hmap, "TESTLOG");
    while (DBFetchNext(hstmt) == 0) {
        if (sNumStatus == DB_NULL_DATA)
           ...
        if (sNumStatus == DB_TRUNCATION)
           ...
        printf("Number of tries: %d\n",numTries);
        ...
    }
    resCode = DBDeactivateMap(hmap);

See Also:
    DBBeginMap, DBActivateMap, DBFetchNext, DBFetchPrev, 
    DBFetchRandom, DBDeactivateMap, DBPutRecord.
     -    Handle to the map that DBBeginMap returned.    �    The column name whose variables are specified.

Note: If you connect to an existing table, but use a column name that is not in the table, some database systems will interpret the invalid name as a parameter.  The resulting error message is misleading.

Note: Some database systems have restrictions on column names. For maximum portability, limit column names to 10 upper case characters with no space characters (or enclose the column name in the ASCII grave character (`)).
     p    Pointer to the variable the receives the short integer value for the specified column when you fetch a record.    0    Pointer to the variable the receives the status value for the specified column when you fetch a record.  The status value is DB_TRUNCATION (-1), DB_NULL_DATA (-2) or the number of bytes fetched.

Note: your program can also set the status variable to change the behavior of DBPutRecord.  To place a NULL value into a column, set the status value for that column to DB_NULL_DATA before calling DBPutRecord.  To prevent DBPutRecord from updating a column, set the status value to DB_NO_DATA_CHANGE.  This is useful when the record contains read only columns. 
    E    Result code returned by DBMapColumnToShort.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.

Note: if you provide an illegal column name, MS Access returns the misleading error message "Too few parameters. Expected 1."    \ . 7           Map Handle                        \@ . �         Column Name                       ^' w 3         Location for Value                ^� z �         Location for Status               `����         Result Code                            ""    	            	            	           H    Specifies a column selected and the value and status variables in your program that are to receive the column's value and status when you fetch a record.

Example:

    short numTries;
    long  numTriesStatus;
    ...
    hmap = DBBeginMap(hdbc);
    resCode = DBMapColumnToInt(hmap, "num_tries", &numTries,                       
                               &numTriesStatus);
    /* More variable mappings */
    ...
    hstmt = DBActivateMap(hmap, "testlog");
    while (DBFetchNext(hstmt) == 0) {
        if (sNumStatus == DB_NULL_DATA)
           ...
        if (sNumStatus == DB_TRUNCATION)
           ...
        printf("Number of tries: %d\n",numTries);
        ...
    }
    resCode = DBDeactivateMap(hmap);

See Also:
    DBBeginMap, DBActivateMap, DBFetchNext, DBFetchPrev, 
    DBFetchRandom, DBDeactivateMap, DBPutRecord.
     .    Handle to the map that DBBeginMap returned.
    �    The column name whose variables are specified.

Note: If you connect to an existing table, but use a column name that is not in the table, some database systems will interpret the invalid name as a parameter.  The resulting error message is misleading.

Note: Some database systems have restrictions on column names. For maximum portability, limit column names to 10 upper case characters with no space characters (or enclose the column name in the ASCII grave character (`)).
     j    Pointer to the variable the receives the integer value for the specified column when you fetch a record.    0    Pointer to the variable the receives the status value for the specified column when you fetch a record.  The status value is DB_TRUNCATION (-1), DB_NULL_DATA (-2) or the number of bytes fetched.

Note: your program can also set the status variable to change the behavior of DBPutRecord.  To place a NULL value into a column, set the status value for that column to DB_NULL_DATA before calling DBPutRecord.  To prevent DBPutRecord from updating a column, set the status value to DB_NO_DATA_CHANGE.  This is useful when the record contains read only columns. 
    D    Result code returned by DBMapColumnToInt.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.

Note: if you provide an illegal column name, MS Access returns the misleading error message "Too few parameters. Expected 1."
    f� . 7           Map Handle                        f� . �         Column Name                       h� x :          Location for Value                i: z �         Location for Status               kr���         Result Code                            ""    	            	            	           c    Specifies a column selected and the value and status variables in your program that are to receive the column's value and status when you fetch a record.

Example:

    float measurement;
    long  measStatus;
    ...
    hmap = DBBeginMap(hdbc);
    resCode = DBMapColumnToFloat(hmap, "measurement", 
                                 &measurement,              
                                 &measStatus);
    /* More variable mappings */
    ...
    hstmt = DBActivateMap(hmap, "testlog");
    while (DBFetchNext(hstmt) == 0) {
        if (measStatus == DB_NULL_DATA)
           ...
        if (measStatus == DB_TRUNCATION)
           ...
        printf("Measurement %f\n",measurement);
        ...
    }
    resCode = DBDeactivateMap(hmap);

See Also:
    DBBeginMap, DBActivateMap, DBFetchNext, DBFetchPrev, 
    DBFetchRandom, DBDeactivateMap, DBPutRecord.
     .    Handle to the map that DBBeginMap returned.
    �    The column name whose variables are specified.

Note: If you connect to an existing table, but use a column name that is not in the table, some database systems will interpret the invalid name as a parameter.  The resulting error message is misleading.

Note: Some database systems have restrictions on column names. For maximum portability, limit column names to 10 upper case characters with no space characters (or enclose the column name in the ASCII grave character (`)).
     h    Pointer to the variable the receives the float value for the specified column when you fetch a record.    0    Pointer to the variable the receives the status value for the specified column when you fetch a record.  The status value is DB_TRUNCATION (-1), DB_NULL_DATA (-2) or the number of bytes fetched.

Note: your program can also set the status variable to change the behavior of DBPutRecord.  To place a NULL value into a column, set the status value for that column to DB_NULL_DATA before calling DBPutRecord.  To prevent DBPutRecord from updating a column, set the status value to DB_NO_DATA_CHANGE.  This is useful when the record contains read only columns. 
    F    Result code returned by DBMapColumnToFloat.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.

Note: if you provide an illegal column name, MS Access returns the misleading error message "Too few parameters. Expected 1."
    q` . 7           Map Handle                        q� . �         Column Name                       s} x :         Location for Value                s� z �         Location for Status               v%���         Result Code                            ""    	           	            	           a    Specifies a column selected and the value and status variables in your program that are to receive the column's value and status when you fetch a record.

Example:

    float measurement;
    long  measStatus;
    ...
    hmap = DBBeginMap(hdbc);
    resCode = DBMapColumnToDouble(hmap, "MEAS1", 
                                  &measurement,              
                                  &measStatus);
    /* More variable mappings */
    ...
    hstmt = DBActivateMap(hmap, "TESTLOG");
    while (DBFetchNext(hstmt) == 0) {
        if (measStatus == DB_NULL_DATA)
           ...
        if (measStatus == DB_TRUNCATION)
           ...
        printf("Measurement: %f\n",measurement);
        ...
    }
    resCode = DBDeactivateMap(hmap);

See Also:
    DBBeginMap, DBActivateMap, DBFetchNext, DBFetchPrev, 
    DBFetchRandom, DBDeactivateMap, DBPutRecord.
     .    Handle to the map that DBBeginMap returned.
    �    The column name whose variables are specified.

Note: If you connect to an existing table, but use a column name that is not in the table, some database systems will interpret the invalid name as a parameter.  The resulting error message is misleading.

Note: Some database systems have restrictions on column names. For maximum portability, limit column names to 10 upper case characters with no space characters (or enclose the column name in the ASCII grave character (`)).
     i    Pointer to the variable the receives the double value for the specified column when you fetch a record.    0    Pointer to the variable the receives the status value for the specified column when you fetch a record.  The status value is DB_TRUNCATION (-1), DB_NULL_DATA (-2) or the number of bytes fetched.

Note: your program can also set the status variable to change the behavior of DBPutRecord.  To place a NULL value into a column, set the status value for that column to DB_NULL_DATA before calling DBPutRecord.  To prevent DBPutRecord from updating a column, set the status value to DB_NO_DATA_CHANGE.  This is useful when the record contains read only columns. 
    G    Result code returned by DBMapColumnToDouble.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.

Note: if you provide an illegal column name, MS Access returns the misleading error message "Too few parameters. Expected 1."
    | . 7           Map Handle                        |I . �         Column Name                       ~0 x :         Location for Value                ~� z �         Location for Status               �����         Result Code                            ""    	           	            	           �    Specifies a column to select and the value and status variables in your program that are to receive the column's value and status when you fetch a record.

Example:

    unsigned char *toDBBits = NULL;
    int bitsStatus = 0;
    int bitsSize = 6;
    ...
    toDBBits = malloc(bitsSize);
    toDBBits[0] = 'N'; toDBBits[1] = 0; toDBBits[2] = 'C';
    toDBBits[3] = 'B'; toDBBits[4] = 0; toDBBits[5] = 250;
    
    /* save the data */
    map = DBBeginMap (hdbc);
    
    resCode = DBMapColumnToBinary(map, "THEBITS", bitsSize,
                                  toDBBits, &bitsStatus);   
    
    resCode = DBCreateTableFromMap (map, "BINTEST");

    hstmt = DBActivateMap (map, "BINTEST");
    resCode = DBCreateRecord(hstmt);
    resCode = DBPutRecord(hstmt);
    resCode = DBDeactivateMap(map);
    hstmt = 0;
    map = 0;


See Also:
    DBBeginMap, DBActivateMap, DBFetchNext, DBFetchPrev,
    DBFetchRandom, DBPutRecord, DBDeactivateMap.
     -    Handle to the map that DBBeginMap returned.    �    The column name whose variables are specified.

Note: If you connect to an existing table, but use a column name that is not in the table, some database systems will interpret the invalid name as a parameter.  The resulting error message is misleading.

Note: Some database systems have restrictions on column names. For maximum portability, limit column names to 10 upper case characters with no space characters (or enclose the column name in the ASCII grave character (`)).
     i    Pointer to the variable the receives the binary value for the specified column when you fetch a record.    0    Pointer to the variable the receives the status value for the specified column when you fetch a record.  The status value is DB_TRUNCATION (-1), DB_NULL_DATA (-2) or the number of bytes fetched.

Note: your program can also set the status variable to change the behavior of DBPutRecord.  To place a NULL value into a column, set the status value for that column to DB_NULL_DATA before calling DBPutRecord.  To prevent DBPutRecord from updating a column, set the status value to DB_NO_DATA_CHANGE.  This is useful when the record contains read only columns. 
    E    Result code returned by DBMapColumnToChar.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.

Note: if you provide an illegal column name, MS Access returns the misleading error message "Too few parameters. Expected 1."
     #    Size of the binary data in bytes.    � . 7           Map Handle                        �Q . �         Column Name                       �8 w 3         Location for Value                �� z �         Location for Status               �����         Result Code                       �. 0~         Maximum Length                         ""    	            	            	               �    Creates a database table based on a map.  This function constructs a SQL CREATE TABLE statement from the map and table name and executes the statement.

After calling DBCreateTableFromMap, you can optionally activate the map with DBActivateMap and use DBCreateRecord and DBPutRecord to fill in the table values

Note: Some databases have limited data types available. In these cases DBCreateTableFromMap attempts to find a compromise data type, but may not succeeed. 

Example:
    hmap = DBBeginMap(hdbc);
    resCode = DBMapColumnToChar(hstmt, "SER_NUM", 11, serialNum, 
                                &sNumStatus, "");
    resCode = DBMapColumnToDouble(hmap, "MEAS1", 
                                  &measurement,              
                                  &measStatus);
    ...
    resCode = DBCreateTableFromMap(hmap, "TESTLOG");

See Also:
    DBBeginMap, DBActivateMap DBDeactivateMap, DBMapColumnTo
     /    The handle to the map returned by DBBeginMap.     (    Name of the database table to create.
     �    Result code returned by DBCreateTableFromMap.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.    �g 1 $           Map Handle                        �� 0 �         Table Name                        �����         Result Code                            ""    	           �    Activates a map by constructing an SQL SELECT statement based on the map and table name, executing the statement and binding mapped program variables to the resulting columns.

Example:
    hmap = DBBeginMap(hdbc);
    resCode = DBMapColumnToChar(hstmt, "ser_num", 11, serialNum, 
                                &sNumStatus, "");
    resCode = DBMapColumnToDouble(hmap, "measurement", 
                                  &measurement,              
                                  &measStatus);
    ...
    hstmt = DBActivateMap(map, "testlog");
    while (DBFetchNext(hstmt) == 0) {
        ...
    }
    resCode = DBDeactivateMap(hmap);

See Also:
    DBBeginMap, DBDeactivateMap, DBMapColumnTo
     8    Handle to the map that DBBeginMap previously returned.    �    Returned handle to the statement execution.  This identifies the statement and is a parameter to other functions.  If less than or equal to 0, the statement could not be executed.

Note: prior to version 2.0, the SQL Toolkit always returned 0 on
error.  To minimize changes to programs which depend on this behavior, set the compatility mode to version 1.1 with:
    DBSetBackwardCompatibility(110);
     2    Name of the database table to use with the map.
    � 1 $           Map Handle                        �X���         Statement Handle                  �� 0 �         Table Name                             	            ""   )    Ends activation of a map.  It is important to call DBDeactivateMap to free system resources.

Example:
    hmap = DBBeginMap(hdbc);
    resCode = DBMapColumnToChar(hstmt, "ser_num", 11, serialNum, 
                                &sNumStatus, "");
    resCode = DBMapColumnToDouble(hmap, "measurement", 
                                  &measurement, &measStatus);
    ...
    hstmt = DBActivateMap(map, "testlog");
    while (DBFetchNext(hstmt) == 0) {
        ...
    }
    resCode = DBDeactivateMap(hmap);

See Also:
    DBBeginMap, DBActivateMap.     �    Result code returned by DBDeactivateMap.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
     -    Handle to the map that DBBeginMap returned.    ����         Result Code                       �� , B           Map Handle                         	               �    Executes a SQL statement immediately.  Calling DBImmediateSQL is equivalent to calling DBActivateSQL and then DBDeactivateSQL.  This function is useful for any SQL statement which does not require further processing such as CREATE TABLE, INSERT INTO and UPDATE.  Because this function also ends statement execution, it is not useful for SELECT statements.

Example:
    hdbc = DBConnect("DSN=CVI32_Samples");
    ...
    resCode = DBImmediateSQL (hdbc,
            "CREATE TABLE TESTRES \
                (UUT_NUM CHAR (10), \ 
                 MEAS1 NUMERIC (10,2), \
                 MEAS2 NUMERIC (10,2))");
    resCode = DBImmediateSQL (hdbc,
            "INSERT INTO TESTRES VALUES ('28A123', 0.5 ,0.5)");
    resCode = DBImmediateSQL (hdbc,
            "INSERT INTO TESTRES VALUES ('28A124', 0.0 ,0.5)");
    ...
    resCode = DBDisconnect(hdbc);

See Also:
    DBNumberOfModifiedRecords, DBActivateSQL, DBDeactivateSQL
         S    The handle to the database connection that DBConnect or DBNewConnection returned.     �    Result code returned by DBImmediateSQL.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.     #    The SQL statement to be executed.    �9 4 T           Connection Handle                 �����         Result Code                       �^ 5 �         SQL Statement                          	            ""   k    Activates a SQL statement.  Calling DBActivateSQL is equivalent to calling DBNewSQLStatement and then DBOpenSQLStatement.

Example:
    hdbc = DBConnect("DSN=CVI32_Samples");
    ...
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    ...
    resCode = DBDeactivateSQL(hstmt);
    resCode = DBDisconnect(hdbc);

See Also:
    DBDeactivateSQL, DBFetchNext, DBFetchPrev, DBFetchRandom, 
    the DBBindCol functions, DBColumnName, DBColumnType,  
    DBAllowFetchAnyDirection, DBNewSQLStatement and   
    DBOpenSQLStatement

Note: 
    To use SQL parameters you must use DBPrepareSQL instead of DBActivateSQL.     G    Handle to the database connection that DBConnect previously returned.          The SQL statement to activate.    �    Statement execution handle that identifies the statement and is a parameter to other functions.  If less than or equal to 0, the statement could not be executed.

Note: prior to version 2.0, the SQL Toolkit always returned 0 on
error.  To minimize changes to programs which depend on this behavior, set the compatility mode to version 1.1 with:
    DBSetBackwardCompatibility(110);
    �� 4 T           Connection Handle                 �  5 �         SQL Statement                     �(���         Statement Handle                       ""    	           `    Specifies the value and status variables in your program that are to receive a column's value and status when you fetch a record.

You do not have to bind all columns in the statement.  You can bind columns in any order.

Example:

    char serialNum[11];
    long serialNumLen;
    ...
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    serialNumLen = 11;
    DBBindColChar(hstmt, 1, serialNumLen, serialNum, 
                  &serialNumStat, "");
    /* More variable bindings */
    ...
    while (DBFetchNext(hstmt) == 0) {
        if (serialNumStat == DB_NULLDATA)
           ...
        if (serialNumStat == DB_TRUNCATION)
           ...
        printf("Serial Number: %s\n",serialNum);
        ...
    }
    resCode = DBDeactivateSQL();

See Also:
    DBFetchNext, DBFetchPrev, DBFetchRandom, DBActivateSQL, 
    DBPutRecord, DBDeactivateSQL.
     ]    Handle to the SQL statement that DBActivateSQL, DBPrepareSQL or DBNewSQLStatement returned.     W    The column number to bind to the specified variables.  The first column number is 1.
     �    Pointer to the variable the receives the null-terminated character string value for the specified column when you fetch a record.    ]    Pointer to the variable the receives the column's status when you fetch a record.

After a record is fetched, you can use this variable to determine whether the fetch retrieved truncated or null data (DB_NULL_DATA (-2) and DB_TRUNCATION (-1))

Note: your program can also set the status value to change the behavior of DBPutRecord.  To place a NULL value into a column, set the status value for that column to DB_NULL_DATA before calling DBPutRecord.  To prevent DBPutRecord from updating a column, set the status value to DB_NO_DATA_CHANGE.  This is useful when the record contains read only columns. 
     �    Result code returned by DBBindColChar.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.     �    Size of the value variable in bytes.  The toolkit uses one byte of the value variable for the string termination character, NUL.    �    Format string.  Use the empty string "" if you want ADO to supply the formatting based on the Windows control panel settings.

Date formats support the following symbols

Symbol    Description
------    -----------
m         Month�s number suppress leading zero
mm        Month�s number with leading zero if applicable
mmm       Month�s three letter abbreviation, lowercase
Mmm       Month�s three letter abbreviation, initial cap
MMM       Month�s three letter abbreviation, upper case
mmmm      Month�s full name, lowercase
Mmmm      Month�s full name, initial cap
MMMM      Month�s full name, upper case
d         Day of the month�s number, suppress leading zero
dd        Day of the month�s number, include leading zero
ddd       Day of the month�s three letter abbreviation, 
          lowercase
Ddd       Day of the month�s three letter abbreviation, initial     
          cap
DDD       Day of the month�s three letter abbreviation, upper 
          case
dddd      Day of the month�s full name, lower case
Dddd      Day of the month�s full name, initial cap
DDDD      Day of the month�s full name, upper case
yy        Last two digits of year
yyyy      Four digit year
h         Hour of the day, suppress leading zero 
          (use am/pm symbol for 12 hour style)
hh        Hour of the day, include leading zero 
          (use am/pm symbol for 12 hour style)
i (or m)  Minute of the hour, suppress leading zero
ii (or mm)Minute of the hour, include leading zero
s         Second of the minute, suppress leading zero
ss        Second of the minute, include leading zero
ss.ssssss Second of the minute with fractional seconds, (use up
          to six �s� symbols after the decimal point)
am/pm     "am" or "pm" string, lower case (forces 12 hour clock)
a/p       "a" or "p" string.  (forces 12 hour clock)
AM/PM     "AM" or "PM" string, upper case (forces 12 hour clock)
A/P       "A" or "P" string, upper case (forces 12 hour clock)
J         Julian value for date/time.
/ - . : , Output the character
<space>   Output a space character
\<char>   Output the character following the �\� character
"<text>"  Output the text
�<text>�  Output the string
GD        Windows Short Date Format (Do not combine other format
          symbols with GD except "[US]"
GDT       Windows Short Date Format + Time Format Do not combine
          with other format symbols except "[US]")
GL        Windows Long Date Format. (Do not combine other format 
          symbols with GL except "[US]")
GLT       Windows Long Date Format + Time Format (Do not combine
          other format symbols with GLT except "[US]")
GT        Windows Time Format (Do not combine any other format
          symbols with GT)
[US]      The information in the International section of the 
          Windows control panel is ignored, instead the United
          States defaults are substituted.

Numeric Format Strings allow you to format numbers in a variety of ways. Numeric formats can have one section or two sections separated by a semicolon. Formats with one section use the same format for positive and negative numbers. Formats with two sections use the second section as the format for negative numbers. 

Number formats support the following symbols

Symbol    Description
------    -----------
$         Output the Windows currency string
.         Output the Windows decimal point character 
,         Output the Windows thousands separator character 
#         Output a digit. If there is no digit to output in the 
          position output nothing.
0         Output a digit, If there is no digit to output in the 
          position output a zero
?         Output a digit, If there is no digit to output in the 
          position output a space
%         Output the value as a percent. The value is multiplied            
          by 100 and the �%� character is output.
e+        Output in scientific notation, show exponent sign only 
          if negative
e-        Output in scientific notation, always show sign of 
          exponent
E+ E-     Upper case analogs of e+ and e-
- + ( ) , Output the character
<space>   Output a space character
\<char>   Output the character following the �\� character
"<text>"  Output the text
�<text>�  Output the text
GN        Windows General Number Format (Note you can only 
          combine GN with symbols which are enclosed in 
          brackets such as "[US]"
GF        Windows General Fixed Format for numbers (Note
          you can only combine GF with symbols which are 
          enclosed in brackets such as "[US]")
GC        Windows General Currency Format for numbers (Note you 
          can only combine GC with symbols which are enclosed 
          in brackets such as "[US]"
[S/n]     Scale (divide) the number by a power of 10 before 
          output.
[S*n]     Scale (multiply) the number by a power of 10 before 
          output. 
[US]      The information in the International section of the 
          Windows control panel is ignored, instead the United
          States defaults are substituted.
    �� - 1           Statement Handle                  �2 . �          Column Number                     �� � 0         Location for Value                � � �         Location for Status               �����         Result Code                       �J 0�         Maximum Length                    �� ��         Format String                          1    	            	            	                ""   E    Specifies the value and status variables in your program that are to receive a column's value and length when you fetch a record.  Data is converted to a 2 byte integer.

You do not have to bind all columns in the statement.  You bind columns in any order.

Example:

    short numTries;
    int   numTriesStat;
    ...
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    /* Other variable bindings */
    ...
    DBBindColShort(hstmt, 5, &numTries, &numTriesStat, "");
    /* More variable bindings */
    ...
    while (DBFetchNext(hstmt) == 0) {
        ...
        if (numTriesStat == DB_NULL_DATA)
           ...
        printf("Number of tries: %d\n",numTries);
        ...
    }
    resCode = DBDeactivateSQL();

See Also:
    DBFetchNext, DBFetchPrev, DBFetchRandom, DBActivateSQL, 
    DBDeactivateSQL, DBPutRecord.
     ]    Handle to the SQL statement that DBActivateSQL, DBPrepareSQL or DBNewSQLStatement returned.     W    The column number to bind to the specified variables.  The first column number is 1.
     X    Pointer to the short integer that receives the column's value when you fetch a record.    b    Pointer to the variable the receives the column's status when you fetch a record.  

After a record is fetched, you can use this variable to determine whether the fetch retrieved truncated or null data (DB_NULL_DATA (-2) and DB_TRUNCATION (-1))

Note: your program can also set the status variable to change the behavior of DBPutRecord.  To place a NULL value into a column, set the status value for that column to DB_NULL_DATA before calling DBPutRecord.  To prevent DBPutRecord from updating a column, set the status value to DB_NO_DATA_CHANGE.  This is useful when the record contains read only columns. 
     �    Result code returned by DBBindColShort.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.    ɕ 3 H           Statement Handle                  �� 3 �          Column Number                     �Y | D         Location for Value                ʹ  �         Location for Status               �#���         Result Code                            1    	            	            	           j    Specifies the value and length variables in your program that are to receive a column's value and length when you fetch a record.  Data is converted to a 4 byte integer (a long int or int in LabWindows/CVI).

You do not have to bind all columns in the statement.  You can bind columns in any order.

Example:

    long  numTries;
    long  numTriesStat;
    ...
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    /* Other variable bindings */
    ...
    DBBindColInt(hstmt, 5, &numTries, &numTriesStat);
    /* More variable bindings */
    ...
    while (DBFetchNext(hstmt) == 0) {
        ...
        if (numTriesStat == DB_NULL_DATA)
           ...
        printf("Number of tries: %ld\n",numTries);
        ...
    }
    resCode = DBDeactivateSQL();

See Also:
    DBFetchNext, DBFetchPrev, DBFetchRandom, DBActivateSQL, 
    DBDeactivateSQL, DBPutRecord.
     ]    Handle to the SQL statement that DBActivateSQL, DBPrepareSQL or DBNewSQLStatement returned.     W    The column number to bind to the specified variables.  The first column number is 1.
     R    Pointer to the integer that receives the column's value when you fetch a record.    b    Pointer to the variable the receives the column's status when you fetch a record.  

After a record is fetched, you can use this variable to determine whether the fetch retrieved truncated or null data (DB_NULL_DATA (-2) and DB_TRUNCATION (-1))

Note: your program can also set the status variable to change the behavior of DBPutRecord.  To place a NULL value into a column, set the status value for that column to DB_NULL_DATA before calling DBPutRecord.  To prevent DBPutRecord from updating a column, set the status value to DB_NO_DATA_CHANGE.  This is useful when the record contains read only columns. 
     �    Result code returned by DBBindColInt.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.    ҕ 3 H           Statement Handle                  �� 3 �          Column Number                     �Y | D          Location for Value                ӳ  �         Location for Status               ����         Result Code                            1    	            	            	           X    Specifies the value and status variables in your program that are to receive a column's value and length when you fetch a record.  Data is converted to a single precision floating point value.

You do not have to bind all columns in the statement.  You can bind columns in any order.

Example:

    float measurement;
    long  measStat;
    ...
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    /* Other variable bindings */
    ...
    DBBindColFloat(hstmt, 6, &measurement, &measStat);
    /* More variable bindings */
    ...
    while (DBFetchNext(hstmt) == 0) {
        ...
        if (numTriesLen == DB_NULL_DATA)
           ...
        printf("Measurement: %f\n",measurement);
        ...
    }
    resCode = DBDeactivateSQL();

See Also:
    DBFetchNext, DBFetchPrev, DBFetchRandom, DBActivateSQL, 
    DBPutRecord, DBDeactivateSQL.
     ]    Handle to the SQL statement that DBActivateSQL, DBPrepareSQL or DBNewSQLStatement returned.     W    The column number to bind to the specified variables.  The first column number is 1.
     Y    Pointer to the float variable that receives the column's value when you fetch a record.    c    Pointer to the variable the receives the column's status when you fetch a record.  

After a record is fetched, you can use this variable to determine whether the fetch retrieved truncated or null data (DB_NULL_DATA (-2) and DB_TRUNCATION (-1)).

Note: your program can also set the status variable to change the behavior of DBPutRecord.  To place a NULL value into a column, set the status value for that column to DB_NULL_DATA before calling DBPutRecord.  To prevent DBPutRecord from updating a column, set the status value to DB_NO_DATA_CHANGE.  This is useful when the record contains read only columns. 
     �    Result code returned by DBBindColFloat.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.    �{ 3 H           Statement Handle                  �� 3 �          Column Number                     �? | D         Location for Value                ܠ  �         Location for Status               ����         Result Code                            1    	           	            	           X    Specifies the value and status variables in your program that are to receive a column's value and status when you fetch a record.  Data is converted to a double precision floating-point value.

You do not have to bind all columns in the statement.  You can bind columns in any order.

Example:

    double measurement;
    long   measStat;
    ...
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    /* Other variable bindings */
    ...
    DBBindColDouble(hstmt, 6, &measurement, &measStat);
    /* More variable bindings */
    ...
    while (DBFetchNext(hstmt) == 0) {
        ...
        if (numTriesLen == DB_NULL_DATA)
           ...
        printf("Measurement: %f\n",measurement);
        ...
    }
    resCode = DBDeactivateSQL();

See Also:
    DBFetchNext, DBFetchPrev, DBFetchRandom, DBActivateSQL, 
    DBDeactivate, DBPutRecord.
     ]    Handle to the SQL statement that DBActivateSQL, DBPrepareSQL or DBNewSQLStatement returned.     W    The column number to bind to the specified variables.  The first column number is 1.
     Z    Pointer to the double variable that receives the column's value when you fetch a record.    c    Pointer to the variable the receives the column's status when you fetch a record.  

After a record is fetched, you can use this variable to determine whether the fetch retrieved truncated or null data (DB_NULL_DATA (-2) and DB_TRUNCATION (-1)).

Note: your program can also set the status variable to change the behavior of DBPutRecord.  To place a NULL value into a column, set the status value for that column to DB_NULL_DATA before calling DBPutRecord.  To prevent DBPutRecord from updating a column, set the status value to DB_NO_DATA_CHANGE.  This is useful when the record contains read only columns. 
     �    Result code returned by DBBindColDouble.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.    �k 3 H           Statement Handle                  �� 3 �          Column Number                     �/ | D         Location for Value                �  �         Location for Status               ��	���         Result Code                            1    	           	            	           �    Specifies the value and status variables in your program that  receive a column's value and length when you fetch a record.  

You do not have to bind all columns in the statement.  You can bind columns in any order.

Example:

    unsigned char *toDBBits = NULL;
    int bitsStatus = 0;
    int bitsSize = 6;
    ...
    hstmt = DBActivateSQL(hdbc, "SELECT THEBITS FROM BINTEST");

    fromDBBits = malloc(bitsSize);
    dbStatus = DBBindColBinary(hstmt, 1, bitsSize, fromDBBits,
                               &bitsStatus);
    
    while ((dbStatus = DBFetchNext(hstmt) == DB_SUCCESS) {
        /* Use the value */
    }

    dbStatus = DBDeactivateSQL(hstmt);
    free(fromDBBits); /* not DBFree bacause we allocated the */
                      /* memory here, the toolkit did not    */
                      /* allocate the memory.                */
    hstmt = 0;

See Also:
    DBFetchNext, DBFetchPrev, DBFetchRandom, DBActivateSQL, 
    DBPutRecord, DBDeactivateSQL.
     ]    Handle to the SQL statement that DBActivateSQL, DBPrepareSQL or DBNewSQLStatement returned.     W    The column number to bind to the specified variables.  The first column number is 1.
     i    Pointer to the variable the receives the binary value for the specified column when you fetch a record.    `    Pointer to the variable the receives the column's status when you fetch a record.

After a record is fetched, you can use this variable to determine whether the fetch retrieved truncated or null data (DB_NULL_DATA (-2) and DB_TRUNCATION (-1))

Note: your program can also set the status variable to change the behavior of DBPutRecord.  To place a NULL value into a column, set the status value for that column to DB_NULL_DATA before calling DBPutRecord.  To prevent DBPutRecord from updating a column, set the status value to DB_NO_DATA_CHANGE.  This is useful when the record contains read only columns. 
     �    Result code returned by DBBindColBinary.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.     &    Size of the value variable in bytes.    �� - 1           Statement Handle                  �= . �          Column Number                     � � 0         Location for Value                � � �         Location for Status               �u���         Result Code                       �@ 0�         Maximum Length                         1    	            	            	               �    Deactivates a SQL statement.  It is important to call DBDeactivateSQL to free system resources.  DBDeactivateSQL is similar to DBCloseSQLStatement followed by DBDiscardSQLStatement.

Example:
    hdbc = DBConnect("DSN=CVI32_Samples");
    ...
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    ...
    res_code = DBDeactivateSQL(hstmt);
    res_code = DBDisconnect(hdbc);

See Also:
    DBActivateSQL, DBCloseSQLStatement and DBDiscardSQLStatement
     �    Result code returned by DBDeactivateSQL.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.     A    Handle to the SQL statement that DBActivateSQL or DBPrepareSQL.    �����         Result Code                       �} , B           Statement Handle                   	               ?    Retrieves the next record from the database.  This function places the column values in any variables you previously specified using the functions for binding or mapping variables.

When DBFetchNext reaches the last record returned by the SELECT statement, it returns a result of DB_EOF.

Example:

    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    ...
    while (DBFetchNext(hstmt) == 0) {
        ...
    }
    resCode = DBDeactivateSQL();

See Also:
    DBFetchPrev, DBFetchRandom, DBActivateMap, DBActivateSQL,
    DBBindCol functions, DBAllowFetchAnyDir.

     �    Result code returned by DBFetchNext.  This function returns the set of result codes listed in the function description for DBError.  Returns a value of DB_EOF when DBFetchNext reaches the last record returned by the SELECT statement.
     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
    �����         Result Code                       �{ + ,           Statement Handle                   	               #    Retrieves the previous record from the database. The column values are placed in the variables previously specified by the variable binding functions if any.

You cannot use this function if you are using a forward-only cursor.  For more infomation on cursors, see ATTR_DB_STMT_CURSOR_TYPE in the function help for DBSetAttributeDefault.

When DBFetchPrev attempts to fetch a record before the first record returned by the SELECT statement, it returns a result of DB_EOF.

You can use DBFetchPrev with either automatic SQL or explicit SQL.

Example:

    /* Cannot use DBFetchPrev with a forward-only cursor */
    /* keyset is one of the bi-directional cursor types  */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_CURSOR_TYPE, 
                                    DB_CURSOR_TYPE_KEYSET);
    resCode = DBSetDefaultAttribute(hdbc, ATTR_DB_CURSOR_TYPE,
                                    ATTR_DB_CURSOR_TYPE);
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    ...
    resCode = DBFetchNext(hstmt)
    /* This is repeated to read other records */
    ...
    resCode = DBFetchPrev(hstmt);
    ...
    resCode = DBDeactivateSQL();

See Also:
    DBActivateSQL, DBActivateMap, DBFetchNext, DBFetchRandom, 
    DBAllowFetchAnyDir, DBBindCol functions, DBMapColumnTo
    functions and DBPutRecord.


     �    Result code returned by DBFetchPrev.  This function returns the set of result codes listed in the function description for DBError.  Returns a value of DB_EOF when attempting to fetch a record before the first record returned by the SELECT statement.

     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
    ����         Result Code                      � J .           Statement Handle                ���� 	 /��                                            	                EYou cannot use this function if you are using a forward-only cursor.   �    Retrieves the designated record from the database. The column values are placed in the variables previously specified by the variable binding functions if any.

You cannot use this function if you are using a forward only cursor.  For more information on cursors, refer to ATTR_DB_STMT_CURSOR_TYPE in the function description of DBSetAttributeDefault.

When DBFetchRandom attempts to fetch a record not contained in the result set returned by the SELECT statement, it returns a result of DB_EOF.

You can use DBFetchRandom with either automatic SQL or explict SQL.

Prior to version 2.0.1, the first DBFetchNext after DBFetchRandom fetched the same record again.  To minimize
changes to programs which depend on this behavior, set the compatibility mode to version 2.0.0 with:
    DBSetBackwardCompatibility(200);

Example:

    resCode = DBAllowFetchAnyDir(hdbc, TRUE);
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    ...
    numRecs = DBNumberOfRecords(hstmt)
    /* Fetch the last record. */
    resCode = DBFetchRandom(hstmt,numRecs);
    ...
    resCode = DBDeactivateSQL();

See Also:
    DBActivateSQL, DBActivateMap, DBFetchNext, DBFetchPrev, 
    DBAllowFetchAnyDir, DBBindCol functions, DBMapColumn
    functions and DBPutRecord.


     �    Result code returned by DBFetchRandom.  This function returns the set of result codes listed in the function description for DBError.  Returns DB_EOF if the designated record is not in the result set.
     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     6    The record number to fetch.  The first record is 1.
   ���         Result Code                      � [ -           Statement Handle                 	e \ �         Record Number                   ����  $��                                            	                1    FYou must Call DBAllowFetchAnyDirection  before calling this function.   I    Creates buffer for use with a new record.  Initially sets all column values to null.  You can place values into the buffer with the DBPutCol functions or by copying the values into bound variables.  You can then insert the record in the database by calling DBPutRecord.

After you create a record, some ODBC drivers will not allow you to close the SQL statement until you call either DBPutRecord or DBCancelRecordChanges.

Example:

    char serNum[11];
    long serNumLen;
    ...
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    serialNumLen = 11;
    res_code = DBBindColChar(hstmt, 1, serNum, &serNumLen, "");
    ...
    res_code = DBCreateRecord(hstmt, 1);
    strcpy(serNum,"PDX 600R");
    ...
    resCode = DBPutRecord(hstmt);
    ...
    resCode = DBDeactivateSQL();

See Also:
    DBPutRecord, DBBindCol, DBPutCol
      n    Handle to the SQL statement that DBActivateSQL,  DBActivateMap, DBNewSQLStatement or DBPrepareSQL returned.
     �    Result code returned by DBCreateRecord.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   & / &           Statement Handle                 ����         Result Code                            	               Deletes the current record.

Note: after you delete a record, the current record is positioned between the previous record and the next record in the buffer.  You must call one of the DBFetch functions position on the next record.

Example:

    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    ...
    /* Fetch the first record and delete it. */
    resCode = DBFetchNext(hstmt);
    resCode = DBDeleteRecord(hstmt);
    ...
    resCode = DBDeactivateSQL();

See Also:
    DBActivateSQL, DBDeactivateSQL, DBFetch functions.
      m    Handle to the SQL statement that DBActivateSQL, DBActivateMap, DBPrepareSQL or DBNewSQLStatement returned.
     �    Result code returned by DBDeleteRecord.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.    / &           Statement Handle                 v���         Result Code                            	               Places the current record in the database.  You can use DBPutRecord  new records you creat with DBCreateRecord, or existing records you fetched from a SELECT statement.

You can override the default behavior of DBPutRecord for individual columns by setting the status variable for a column before calling DBPutRecord.  If you set the status variable to DB_NULL_DATA , DBPutRecord will place a NULL value in the column.  If the status variable is DB_NO_DATA_CHANGE, DBPutRecord does not attempt to update the column.  This is useful when the record contains read only columns.

Example:

    char serNum[11];
    long serNumLen;
    ...
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    serialNumLen = 11;
    resCode = DBBindColChar(hstmt, 1, serNum, &serNumLen);
    ...
    resCode = DBCreateRecord(hstmt, 1);
    strcpy(serNum,"PDX 600R");
    ...
    resCode = DBPutRecord(hstmt);
   ...
    resCode = DBDeactivateSQL();

See Also:
    DBActivateSQL, DBActivateMap, DBCreateRecord, 
    DBBindCol, DBMapColumnTo
      l    Handle to the SQL statement that DBActivateSQL DBActivateMap, DBPrepareSQL or DBNewSQLStatement returned.
     �    Result code returned by DBPutRecord.  This function returns the set of result codes listed in the function description for DBError.   � / &           Statement Handle                 =���         Result Code                            	           _    Cancel pending changes to the current record or discard a newly added record.  

If you are adding a new record when you call DBCancelRecordChanges, the record that was current before the DBCreateRecord call becomes the current record again.

If you have not changed the current record or added a new record, calling DBCancelRecordChanges generates an error.

Some ODBC drivers and ADO providers do not allow you to deactivate a SQL statement if there is a record with pending changes (for example if an error occurs while preparing a new record).  You can use DBCancelRecordChanges to cancel the pending changes so your progam can deactivate the statement.

Example:

    ...
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    ...
    resCode = DBCreateRecord(hstmt, 1);
    ...
    resCode = DBPutColInt(hstmt, 2, i);
    if (resCode < 0) {
        DBCancelRecordChanges(hstmt);
        goto DB_Error;
    }
    ...
    resCode = DBPutRecord(hstmt);
    ...
    resCode = DBDeactivateSQL();

See Also:
    DBActivateSQL, DBActivateMap, DBCreateRecord, 
    DBBindCol functions, DBMapColumnTo functions.
      l    Handle to the SQL statement that DBActivateSQL DBActivateMap, DBPrepareSQL or DBNewSQLStatement returned.
     �    Result code returned by DBCancelRecordChanges.  This function returns the set of result codes listed in the function description for DBError.
   � / &           Statement Handle                 ���         Result Code                            	           �    Writes pending changes to the database.  You can only use DBUpdateBatch with statements that you have opened with lock type of DB_LOCK_BATCH_OPTIMISTIC.

Example:

    
    /* Set lock type attribute to batch optimistic */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_LOCK_TYPE,
                                    DB_LOCK_BATCH_OPTIMISTIC);
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM rec1000");
    /* Bind variables */
    ...
    for (i = 0; i < 1000; i++) {
        /* Create the new record */
        resCode = DBCreateRecord (hstmt);
        /* Set bound variables */
        ...
        /* Insert the record into the database */
        resCode = DBPutRecord (hstmt);
    }
    resCode = DBUpdateBatch(hstmt, DB_AFFECT_ALL);
    resCode = DBDeactivateSQL(hstmt);
    /* Set lock type attribute back to default. */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_LOCK_TYPE,
                                    DB_LOCK_OPTIMISTIC);

     l    Handle to the SQL statement that DBActivateSQL DBActivateMap, DBPrepareSQL or DBNewSQLStatement returned.
     ^    Which records to update.  Either the current record only or all records with pending changes     �    Result code returned by DBUpdateBatch.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   "� '            Statement Handle                 #d ' � �      Affect which Records             #����         Result Code                                      ,Current DB_AFFECT_CURRENT All DB_AFFECT_ALL    	           �    Creates and activates a SELECT statement that returns information about the available database sources.  You can then use the DBBindCol and DBFetch functions to retrieve the information. DBSources does not support the SELECT information functions such as DBColumnName or DBNumberOfRecords.  You do not have to connect to a a database before using DBSources. 

Each record contains the following columns:

Column      Type       Description
Name        string     Data source name
Description string     Data source description

Example
    hstmt = DBSources(DB_SRC_AVAILABLE);
    resCode = DBBindColChar(hstmt, 1, 32, srcName,      
                            &srcNameStat, "");
    resCode = DBBindColChar(hstmt, 2, 256, remarks,
                            &remarksStat,"");
    ...
    /* Fetch records */
    ...
    resCode = DBDeactivateSQL(hstmt);

See Also:
    DBActivateSQL, DBActivateMap.


    �    Statement execution handle that identifies the statement and is a parameter to other functions.  If less than or equal to 0, the statement could not be executed.

Note: prior to version 2.0, the SQL Toolkit always returned 0 on
error.  To minimize changes to programs that depend on this behavior,
set the compatility mode to version 1.1 with:
    DBSetBackwardCompatibility(110);

     ;    Options, only DB_AVAILABLE is the only supported option.
   )���         Statement Handle                 *� 0 +          Source Type                        	                       All Sources DB_SRC_AVAILABLE   �    Creates and activates a SELECT statement that returns information about the available databases on a connection.  You can then use the DBBindCol and DBFetch functions to retrieve the information. Each record contains two columns:

Column     Type       Description
Database   Char (128) Database name
Remarks    Char (256) Remarks (can be null)

Example
    hstmt = DBDatabases(hdbc);
    resCode = DBBindColChar(hstmt, 1, 32, dbName,      
                            &dbNameStat, "");
    resCode = DBBindColChar(hstmt, 2, remarks, &remarksStat,"");
    ...
    /* Fetch records */
    ...
    resCode = DBDeactivateSQL(hstmt);

See Also:
    DBActivateSQL, DBActivateMap


    �    Returned handle to the statement execution.  This identifies the statement and is a parameter to other functions.  If less than or equal to zero, the statement could not be executed.

Note: prior to version 2.0, the SQL Toolkit always returned 0 on
error.  To minimize changes to programs that depend on this behavior,
set the compatility mode to version 1.1 with:
    DBSetBackwardCompatibility(110);

     S    The handle to the database connection that DBConnect or DBNewConnection returned.   .*���         Statement Handle                 /� 3 >           Connection Handle                  	                   Creates and activates a SELECT statement which returns information about the available tables on a connection.  You can then use the DBBindCol and DBFetch functions to retrieve the information. Each record contains the following columns:

Column            Type       Description
------            ----       -----------
Table Catalog     string     Table catalog.
Table Schema      string     Table schema.
Table Name        string     Table name.
Table Type        string     Table type. 
Table GUID        integer    Table GUID.
Description       string     Table description.

Example
    hstmt = DBTables(hdbc,"","","", DB_TBL_TABLE | DB_TBL_VIEW);
    resCode = DBBindColChar(hstmt, 1, 128, tabCat, 
                            &tabCatStat);
    resCode = DBBindColChar(hstmt, 2, 128, tabSchema, 
                            &schemaStat, "");
    resCode = DBBindColChar(hstmt, 3, 128, table,  
                            &tableStat, "");
    resCode = DBBindColChar(hstmt, 4, 128, tabType,  
                            &tabTypeStat, "");
    resCode = DBBindColInt(hstmt, 5, &tabGUID, &tabGUIDStat);
    resCode = DBBindColChar(hstmt, 6, remarks, &remStat, "");
    ...
    /* Fetch records */
    ...
    resCode = DBDeactivateSQL(hstmt);

See Also:
    DBActivateSQL, DBActivateMap.


    {    Statement execution that identifies the statement and is a parameter to other functions.  If less than or equal to zero, the statement could not be executed.

Note: prior to version 2.0, the SQL Toolkit always returned 0 on
error.  To minimize changes to programs that depend on this behavior,
set the compatility mode to version 1.1 with:
    DBSetBackwardCompatibility(110);
     S    The handle to the database connection that DBConnect or DBNewConnection returned.     �    Table catalog.  Use this parameter to restrict the table information that this function returns to a single catalog. Some ADO providers and ODBC drivers do not support this parameter.
     �    Table Schema.  Use this parameter to restrict the table information that this function returns to a single schema.  Some ADO providers and ODBC drivers do not support this parameter.
     �    Table Name.  Use this parameter to restrict the table
information that this function returns to a single table.  Some
ADO providers and ODBC drivers do not support this parameter.                
    �    Specifies the type(s) of table(s) for which information will be returned.  You can use any of the following values:

Constant           Value   Description
--------           -----   -----------
DB_TBL_TABLE       0x0001  Table names
DB_TBL_VIEW        0x0002  View names
DB_TBL_PROCEDURE   0x0004  Stored procedure names
DB_TBL_DATABASE    0x0080  Database names

Except for DB_TBL_DATABASE, you can combine these constants by adding them together or joining them with an or clause.   5����         Statement Handle                 79 3 >           Connection Handle                7� z <         Table Catalog                    8V y �         Table Schema                     9 yE         Table Name                       9� � =          Flags                              	                ""    ""    ""    DB_TBL_TABLE   �    Creates and activates a SELECT statement that returns information about the set of indexes on a table.  You can then use the DBFetch and DBBindCol or DBGetCol functions to retrieve the information. Each record contains the following columns:

Column            Type       Description
------            ----       -----------
Table Catalog     string     Table catalog.
Table Schema      string     Table schema.
Table Name        string     Table name.
Index Catalog     string     Index catalog. 
Index Schema      string     Index schema.
Index Name        string     Index column name.
Primary key       integer    Column is a primary key.
Unique            integer    Column must be unique.
Clustered         integer    Column is clustered.
Index Type        integer    Type of index column.
Fill Factor       integer    Column fill factor.
Initial Size      integer    Initial size of column
NULLs             integer    Column can be NULL.
Sort Bookmark     integer    Sort bookmark.
Auto Update       integer    Column is auto update.
Null Collation    integer    Collation rule for NULLs.
Ordinal           integer    The number of this column within
                             the index.
Column Name       string     Column name.
Column GUID       integer    Column GUID.
Column Prop ID    integer    Column property id.
Collation         string     Collating sequence.  Values:
                                  DB_INDEX_ASC 'A'
                                  DB_INDEX_DESC 'D'
                                  DB_INDEX_ORDER_UNKNOWN NULL
Cardinality       Integer    Number of unique values in index;
                             may be NULL.
Pages             Integer    Number of pages used to store 
                             index; may be NULL.
Filter            string     The filter condition when one 
                             exists, otherwise NULL.
Example:

    hstmt = DBIndexes(hdbc, "blap", 0x0);
    resCode = DBBindColChar (hstmt, 1, 29, tabCat, 
                             &tabCatStat,"");
    resCode = DBBindColChar (hstmt, 2, 29, tabSchema, 
                             &tabSchemaStat,"");
    resCode = DBBindColChar (hstmt, 3, 29, tabName, 
                             &tabNameStat,"");
    resCode = DBBindColChar (hstmt, 4, 29, idxCat, 
                             &idxCatStat,"");
    resCode = DBBindColChar (hstmt, 5, 29, idxSchema, 
                             &idxSchemaStat,"");
    resCode = DBBindColChar (hstmt, 6, 29, idxName, 
                             &idxNameStat,"");
    resCode = DBBindColInt (hstmt, 7, &pk, &pkStat);
    resCode = DBBindColInt (hstmt, 8, &unique, &uniqueStat);
    resCode = DBBindColInt (hstmt, 9, &clustered, 
                            &clusteredStat);
    resCode = DBBindColInt (hstmt, 10, &type, &typeStat);
    resCode = DBBindColInt (hstmt, 11, &fillFactor, 
                            &fillFactorStat);
    resCode = DBBindColInt (hstmt, 12, &initSize, 
                            &initSizeStat);
    resCode = DBBindColInt (hstmt, 13, &nulls, &nullsStat);
    resCode = DBBindColInt (hstmt, 14, &sortBkm, &sortBkmStat);
    resCode = DBBindColInt (hstmt, 15, &autoUpdate, 
                            &autoUpdateStat);
    resCode = DBBindColInt (hstmt, 16, &nullColl, 
                            &nullCollStat);
    resCode = DBBindColInt (hstmt, 17, &ordinal, &ordinalStat);
    resCode = DBBindColChar (hstmt, 18, 29, colName, 
                             &colNameStat,"");
    resCode = DBBindColInt (hstmt, 19, &colGuid, &colGuidStat);
    resCode = DBBindColInt (hstmt, 20, &colProp, &colPropStat);
    resCode = DBBindColInt (hstmt, 21, &coll, &collStat);
    resCode = DBBindColInt (hstmt, 22, &card, &cardStat);
    resCode = DBBindColInt (hstmt, 23, &pages, &pagesStat);
    resCode = DBBindColChar (hstmt, 24, 29, filtCond, 
                             &filtCondStat,"");

    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        ...
    }
    resCode = DBDeactivateSQL(hstmt);




    �    Returned handle to the statement execution.  This identifies the statement and is a parameter to other functions.  If less than or equal to zero, the statement could not be executed.

Note: prior to version 2.0, the SQL Toolkit always returned 0 on
error.  To minimize changes to programs that depend on this behavior,
set the compatility mode to version 1.1 with:
    DBSetBackwardCompatibility(110);
     S    The handle to the database connection that DBConnect or DBNewConnection returned.     d    Pointer to a string containing the name of the table for which index information will be selected.    1    Specifies a set of option flags that control the values returned from DBIndexes.  The only flag value supported is:
  
Constant           Value   Description
--------           -----   -----------
DB_NO_FLAGS        0x0000  Return all indexes perform quick         
                           retrieval
   L����         Statement Handle                 N� 3 >           Connection Handle                N� 4 �         Table Name                       OZ 4s         Flags                              	                ""    0   *    Creates and activates a SELECT statement which returns information about the set of columns that make up a table's primary keys.  You can then use the DBBindCol and DBFetch functions to retrieve the information. Each record contains the following columns:

Note: Not all database systems support primary keys.  

Column            Type       Description
------            ----       -----------
Table Catalog     string     Table catalog.
Table Schema      string     Table schema.
Table Name        string     Table name.
Column Name       string     Column name.
Column GUID       integer    Column GUID.
Column Prop ID    integer    Column property id.
Sequence Number   integer    The number of this columns within
                             the primary key.

Example

    hstmt = DBPrimaryKeys(hdbc, "blap");
    resCode = DBBindColChar (hstmt, 1, 29, pkTabCat, 
                             &pkTabCatStat,"");
    resCode = DBBindColChar (hstmt, 2, 29, pkTabSchema, 
                             &pkTabSchemaStat,"");
    resCode = DBBindColChar (hstmt, 3, 29, pkTabName, 
                             &pkTabNameStat,"");
    resCode = DBBindColChar (hstmt, 4, 29, pkColName, 
                             &pkColNameStat,"");
    resCode = DBBindColInt (hstmt, 5, &pkColGuid, 
                            &pkColGuidStat);
    resCode = DBBindColInt (hstmt, 6, &pkColPropId, 
                            &pkColPropIdStat);
    resCode = DBBindColInt (hstmt, 7, &ordinal, &ordinalStat);

    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        ...
    }




    �    Returned handle to the statement execution.  This identifies the statement and is a parameter to other functions.  If less than or equal to zero, the statement could not be executed.

Note: prior to version 2.0, the SQL Toolkit always returned 0 on
error.  To minimize changes to programs that depend on this behavior,
set the compatility mode to version 1.1 with:
    DBSetBackwardCompatibility(110);
     S    The handle to the database connection that DBConnect or DBNewConnection returned.     j    Pointer to a string containing the name of the table for which primary key information will be selected.   W����         Statement Handle                 YP 3 >           Connection Handle                Y� 4 �         Table Name                         	                ""   /    Creates and activates a SELECT statement which returns information about the set of columns that make up a table's primary keys.  You can then use the DBBindCol and DBFetch functions to retrieve the information.  Each record contains the following columns:

Note: Not all database systems support foreign keys.  

Column             Type       Description
------             ----       -----------
PK Table Catalog   string     Primary key table catalog.
PK Table Schema    string     Primary key table schema.
PK Table Name      string     Primary key table name.
PK Column Name     string     Primary key column name.
PK Column GUID     integer    Primary key column GUID.
PK Column Prop ID  integer    Primary key column property id.
FK Table Catalog   string     Foreign key table catalog.
FK Table Schema    string     Foreign key table schema
FK Table Name      string     Foreign key table name.
FK Column Name     string     Foreign key column name.
FK Column GUID     integer    Foreign key column GUID.
FK Column Prop ID  integer    Foreign key property id.
Sequence Number    Short Int  The number of this column within
                              the foreign key.
Update Action      Short Int  Action applied to the foreign key
                              when an UPDATE is performed.
                                  DB_CASCADE - 0
                                  DB_RESTRICT - 1
                                  DB_SET_NULL - 2
Delete Action      Short Int  Action applied to the foreign key
                              when a DELETE is performed.
                                  DB_CASCADE - 0
                                  DB_RESTRICT - 1
                                  DB_SET_NULL - 2
Example
    hstmt = DBForeignKeys(hdbc, "testpk", "testfk);
    resCode = DBBindColChar (hstmt, 1, 29, pkTabCat,  
                             &pkTabCatStat,"");
    resCode = DBBindColChar (hstmt, 2, 29, pkTabSchema, 
                             &pkTabSchemaStat,"");
    resCode = DBBindColChar (hstmt, 3, 29, pkTabName, 
                             &pkTabNameStat,"");
    resCode = DBBindColChar (hstmt, 4, 29, pkColName, 
                             &pkColNameStat,"");
    resCode = DBBindColInt (hstmt, 5, &pkColGuid, 
                            &pkColGuidStat);
    resCode = DBBindColInt (hstmt, 6, &pkColPropId, 
                            &pkColPropIdStat);
    resCode = DBBindColChar (hstmt, 7, 29, fkTabCat, 
                             &fkTabCatStat,"");
    resCode = DBBindColChar (hstmt, 8, 29, fkTabSchema, 
                             &fkTabSchemaStat,"");
    resCode = DBBindColChar (hstmt, 9, 29, fkTabName, 
                             &fkTabNameStat,"");
    resCode = DBBindColChar (hstmt, 10, 29, fkColName, 
                             &fkColNameStat,"");
    resCode = DBBindColInt (hstmt,11, &fkColGuid, 
                            &fkColGuidStat);
    resCode = DBBindColInt (hstmt, 12, &fkColPropId, 
                            &fkColPropIdStat);
    resCode = DBBindColInt (hstmt, 13, &ordinal, &ordinalStat);
    resCode = DBBindColChar (hstmt, 14, 29, updateRule, 
                             &updateRuleStat,"");
    resCode = DBBindColChar (hstmt, 15, 29, deleteRule, 
                             &deleteRuleStat,"");

    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        ...
    }




    �    Returned handle to the statement execution.  This identifies the statement and is a parameter to other functions.  If less than or equal to zero, the statement could not be executed.

Note: prior to version 2.0, the SQL Toolkit always returned 0 on
error.  To minimize changes to programs that depend on this behavior,
set the compatility mode to version 1.1 with:
    DBSetBackwardCompatibility(110);

     O    Handle to the database connection that DBConnect or DBNewConnection returned.     j    Pointer to a string containing the name of the table for which primary key information will be selected.     j    Pointer to a string containing the name of the table for which foreign key information will be selected.   h	���         Statement Handle                 i� 3 >           Connection Handle                i� 4 �         Primary Key Table Name           jo 4g         Foreign Key Table Name             	                ""    ""   �    Creates and activates a SELECT statement that returns schema information.

Example:
    VARIANT restrictArray[4];
    VARIANT vRestrictArray;

    /* Set up the restrictions to match only table testres */
    restrictArray[0] = CA_VariantNULL();
    restrictArray[1] = CA_VariantNULL();
    CA_VariantSetCString (&(restrictArray[2]), "testres");
    restrictArray[3] = CA_VariantNULL();
    CA_VariantSet1DArray (&vRestrictArray, CAVT_VARIANT, 4, 
                          restrictArray);
    
    
    /* Open the tables Schema */
    hstmt = DBOpenSchema (hdbc, DB_SCHEMA_TABLES, 
                          vRestrictArray);
    resCode = DBBindColChar (hstmt, 1, 29, catalog, 
                             &catalogStat,"");
    resCode = DBBindColChar (hstmt, 2, 29, schema, 
                             &schemaStat,"");
    resCode = DBBindColChar (hstmt, 3, 29, name, &nameStat,"");
    resCode = DBBindColInt (hstmt, 5, &guid, &guidStat);
    resCode = DBBindColChar (hstmt, 6, 29, descr,
                             &descrStat,"");

    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        ...
    }

    hstmt = DBDeactivateSQL (hstmt);
     S    The handle to the database connection that DBConnect or DBNewConnection returned.    w    The type of schema query to run.

The following table shows the possible query types and the restrictions that may be available.  (The OLE DB specification requires that providers support the DB_PROVIDER_TYPES, DB_SCHEMA_TABLES and DB_SCHEMA_COLUMNS query types.  The specification does not require that providers support any other query types or any restriction critera.)

Query Type                         Criteria values
----------                         ---------------
DB_SCHEMA_ASSERTS                  Constraint catalog
                                   Constraint schema
                                   Constraint name
DB_SCHEMA_CATALOGS                 Catalog name
DB_SCHEMA_CHARACTER_SETS           Character set catalog
                                   Character set schema
                                   Character set name
DB_SCHEMA_COLLATIONS               Collation catalog
                                   Collation schema
                                   Collation name
DB_SCHEMA_COLUMNS                  Table catalog
                                   Table schema
                                   Table name
                                   Column name
DB_SCHEMA_CHECK_CONSTRAINTS        Constraint catalog
                                   Constraint schema
                                   Constraint name
DB_SCHEMA_CONSTRAINT_COLUMN_USAGE  Table catalog
                                   Table schema
                                   Table name
                                   Column name
DB_SCHEMA_CONSTRAINT_TABLE_USAGE   Table catalog
                                   Table schema
                                   Table name
DB_SCHEMA_KEY_COLUMN_USAGE         Constraint catalog
                                   Constraint schema
                                   Constraint name
                                   Table catalog
                                   Table schema
                                   Table name
                                   Column name
DB_SCHEMA_REFERENTIAL_CONSTRAINTS  Constaint catalog
                                   Constraint schema
                                   Constraint name
DB_SCHEMA_TABLE_CONSTRAINSTS       Constraint catalog
                                   Constraint schema
                                   Constraint name
                                   Table catalog
                                   Table schema
                                   Table name
                                   Constraint type
DB_SCHEMA_COLUMN_DOMAIN_USAGE      Domain catalog
                                   Domain schema
                                   Domain name
                                   Column name
DB_SCHEMA_INDEXES                  Table catalog
                                   Table schema
                                   Index name
                                   Type
                                   Table name
DB_SCHEMA_COLUMN_PRIVILEGES        Table catalog
                                   Table Schema
                                   Table name
                                   Column name
                                   Grantor
                                   Grantee
DB_SCHEMA_TABLE_PRIVILEGES         Table catalog
                                   Table schema
                                   Table name
                                   Grantor
                                   Grantee
DB_SCHEMA_USAGE_PRIVILEGES         Object catalog
                                   Object schema
                                   Object name
                                   Object type
                                   Grantor
                                   Grantee
DB_SCHEMA_PROCEDURE                Procedure catalog
                                   Procedure schema
                                   Procedure name
                                   Column name
DB_SCHEMA_SCHEMATA                 Catalog name
                                   Schema name
                                   Schema owner
DB_SCHEMA_SQL_LANGUAGES            <none>
DB_SCHEMA_STATISTICS               Table catalog
                                   Table schema
                                   Table name
DB_SCHEMA_TABLES                   Table catalog
                                   Table schema
                                   Table name
                                   Table type
DB_SCHEMA_TRANSLATIONS             Translation catalog
                                   Translation schema
                                   Translation name
DB_SCHEMA_PROVIDER_TYPES           Data type
                                   Best match
DB_SCHEMA_VIEWS                    Table catalog
                                   Table schema
                                   Table name
DB_SCHEMA_VIEW_COLUMN_USAGE        View catalog
                                   View schema
                                   View name
DB_SCHEMA_VIEW_TABLE_USAGE         View catalog
                                   View schema
                                   View name
DB_SCHEMA_PROCEDURE_PARAMETERS     Procedure catalog
                                   Procedure schema
                                   Procedure name
                                   Parameter name
DB_SCHEMA_FOREIGN_KEYS             PK table catalog
                                   PK table schema
                                   PK table name
                                   FK table catalog
                                   FK table schema
                                   FK table name
DB_SCHEMA_PRIMARY_KEYS             PK table catalog
                                   PK table schema
                                   PK table name
DB_SCHEMA_PROCEDURE_COLUMNS        Procedure catalog
                                   Procedure schema
                                   Procedure name
                                   Column name
    �    Handle to the schema query execution that identifies the statement and is a parameter to other functions.  If less than or equal to 0, the schema query could not be executed.

Note: prior to version 2.0, the SQL Toolkit always returned 0 on
error.  To minimize changes to programs that depend on this behavior,
set the compatility mode to version 1.1 with:
    DBSetBackwardCompatibility(110);
        A variant containing an array of variants containing restrictions on the schema query.  Use CA_DEFAULT_VAL if you do not want restrictions.  Use a NULL variant for unrestricted elements of the array.

Example:
    VARIANT restrictArray[4];
    VARIANT vRestrictArray;

    restrictArray[0] = CA_VariantNULL();
    restrictArray[1] = CA_VariantNULL();
    CA_VariantSetCString (&(restrictArray[2]), "testres");
    restrictArray[3] = CA_VariantNULL();
    CA_VariantSet1DArray (&vRestrictArray, CAVT_VARIANT, 4,
                          restrictArray);

The following table shows the possible query types and the restrictions that may be available.  (The OLE DB specification requires that providers support the DB_PROVIDER_TYPES, DB_SCHEMA_TABLES and DB_SCHEMA_COLUMNS query types.  The specification does not require that providers support any other query types or any restriction critera.)

Query Type                         Criteria values
----------                         ---------------
DB_SCHEMA_ASSERTS                  Constraint catalog
                                   Constraint schema
                                   Constraint name
DB_SCHEMA_CATALOGS                 Catalog name
DB_SCHEMA_CHARACTER_SETS           Character set catalog
                                   Character set schema
                                   Character set name
DB_SCHEMA_COLLATIONS               Collation catalog
                                   Collation schema
                                   Collation name
DB_SCHEMA_COLUMNS                  Table catalog
                                   Table schema
                                   Table name
                                   Column name
DB_SCHEMA_CHECK_CONSTRAINTS        Constraint catalog
                                   Constraint schema
                                   Constraint name
DB_SCHEMA_CONSTRAINT_COLUMN_USAGE  Table catalog
                                   Table schema
                                   Table name
                                   Column name
DB_SCHEMA_CONSTRAINT_TABLE_USAGE   Table catalog
                                   Table schema
                                   Table name
DB_SCHEMA_KEY_COLUMN_USAGE         Constraint catalog
                                   Constraint schema
                                   Constraint name
                                   Table catalog
                                   Table schema
                                   Table name
                                   Column name
DB_SCHEMA_REFERENTIAL_CONSTRAINTS  Constaint catalog
                                   Constraint schema
                                   Constraint name
DB_SCHEMA_TABLE_CONSTRAINSTS       Constraint catalog
                                   Constraint schema
                                   Constraint name
                                   Table catalog
                                   Table schema
                                   Table name
                                   Constraint type
DB_SCHEMA_COLUMN_DOMAIN_USAGE      Domain catalog
                                   Domain schema
                                   Domain name
                                   Column name
DB_SCHEMA_INDEXES                  Table catalog
                                   Table schema
                                   Index name
                                   Type
                                   Table name
DB_SCHEMA_COLUMN_PRIVILEGES        Table catalog
                                   Table Schema
                                   Table name
                                   Column name
                                   Grantor
                                   Grantee
DB_SCHEMA_TABLE_PRIVILEGES         Table catalog
                                   Table schema
                                   Table name
                                   Grantor
                                   Grantee
DB_SCHEMA_USAGE_PRIVILEGES         Object catalog
                                   Object schema
                                   Object name
                                   Object type
                                   Grantor
                                   Grantee
DB_SCHEMA_PROCEDURE                Procedure catalog
                                   Procedure schema
                                   Procedure name
                                   Column name
DB_SCHEMA_SCHEMATA                 Catalog name
                                   Schema name
                                   Schema owner
DB_SCHEMA_SQL_LANGUAGES            <none>
DB_SCHEMA_STATISTICS               Table catalog
                                   Table schema
                                   Table name
DB_SCHEMA_TABLES                   Table catalog
                                   Table schema
                                   Table name
                                   Table type
DB_SCHEMA_TRANSLATIONS             Translation catalog
                                   Translation schema
                                   Translation name
DB_SCHEMA_PROVIDER_TYPES           Data type
                                   Best match
DB_SCHEMA_VIEWS                    Table catalog
                                   Table schema
                                   Table name
DB_SCHEMA_VIEW_COLUMN_USAGE        View catalog
                                   View schema
                                   View name
DB_SCHEMA_VIEW_TABLE_USAGE         View catalog
                                   View schema
                                   View name
DB_SCHEMA_PROCEDURE_PARAMETERS     Procedure catalog
                                   Procedure schema
                                   Procedure name
                                   Parameter name
DB_SCHEMA_FOREIGN_KEYS             PK table catalog
                                   PK table schema
                                   PK table name
                                   FK table catalog
                                   FK table schema
                                   FK table name
DB_SCHEMA_PRIMARY_KEYS             PK table catalog
                                   PK table schema
                                   PK table name
DB_SCHEMA_PROCEDURE_COLUMNS        Procedure catalog
                                   Procedure schema
                                   Procedure name
                                   Column name
   pa %            Connection Handle                p� $ � �      Query Type                       �;���         Statement Handle                 �� $1 �  �    Restrictions                                    �Provider Specific DB_SCHEMA_PROVIDER_SPECIFIC Asserts DB_SCHEMA_ASSERTS Catalogs DB_SCHEMA_CATALOGS Character Sets DB_SCHEMA_CHARACTER_SETS Collations DB_SCHEMA_COLLATIONS Columns DB_SCHEMA_COLUMNS Check Constraints DB_SCHEMA_CHECK_CONSTRAINTS Constraint Column Usage DB_SCHEMA_CONSTRAIN_COLUMN_USAGE Constraint Table Usage DB_SCHEMA_CONSTRAINT_TABLE_USAGE Key Column Usage DB_SCHEMA_KEY_COLUMN_USAGE Referential Constraints DB_SCHEMA_REFERENTIAL_CONSTRAINTS Table Constraints DB_SCHEMA_TABLE_CONSTRAINTS Column Domain Usage DB_SCHEMA_COLUMN_DOMAIN_USAGE Indexes DB_SCHEMA_INDEXES Column Privileges DB_SCHEMA_COLUMN_PRIVILEGES Table Privileges DB_SCHEMA_TABLE_PRIVILEGES Usage Privileges DB_SCHEMA_USAGE_PRIVILEGES Procedure DB_SCHEMA_PROCEDURE Schemata DB_SCHEMA_SCHEMATA SQL Languages DB_SCHEMA_SQL_LANGUAGES Statistics DB_SCHEMA_STATISTICS Tables DB_SCHEMA_TABLES Translations DB_SCHEMA_TRANSLATIONS Provider Types DB_SCHEMA_PROVIDER_TYPES Views DB_SCHEMA_VIEWS View Column Usage DB_SCHEMA_VIEW_COLUMN_USAGE View Table Usage DB_SCHEMA_VIEW_TABLE_USAGE Procedure Parameters DB_SCHEMA_PROCEDURE_PARAMETERS Foreign Keys DB_SCHEMA_FOREIGN_KEYS Primary Keys DB_SCHEMA_PRIMARY_KEYS Procedure Columns DB_SCHEMA_PROCEDURE_COLUMNS    	            CA_DEFAULT_VAL   *    Returns the number of records chosen by the SELECT statement.  Some database systems cannot determine the number or records until you read the last record.  If the number of records cannot be determined, this function returns DB_CANNOT_DETERMINE_NUM_RECS.

Prior to version 2.0, the toolkit always returned -1 on error.  To minimize changes to programs that depend on this behaviour, set the compatibility mode to verison 1.1 with the following function call:
    DBSetBackwardCompatibility(110);

Example:
    hdbc = DBConnect("DSN=CVI32_Samples");
    resCode = DBAllowFetchAnyDirection(hdbc,TRUE);
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    numRecs = DBNumberOfRecords(hstmt);
    resCode = DBDeactivate(hstmt);
    resCode = DBDisconnect(hdbc);

See Also:
    DBAllowFetchAnyDirection
     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     �    Number of records chosen by the SELECT statement.  A value less than 0 is an error code from the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
   �V X -           Statement Handle                 �����         Number of Records               ����  ,��                                                	            RThis function cannot determine the number of records for forward only recordsets.       Returns the number of columns selected by a SQL SELECT statement.

Example:
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    numCols = DBNumberOfColumns(hstmt);
    ...
    resCode = DBDeactivateSQL(hstmt);

See Also:
    DBActivateSQL, DBDeactivateMap.
     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     �    The number of columns selected.  If zero, the statement is not a SELECT statement.  If less than zero, an error occurred, the return value is the error code.   �� 6 /           Statement Handle                 �Z���         Number of Columns                      	           _    Returns the name of a column.

Example:
    hdbc = DBConnect("DSN=CVI32_Samples");
    ...
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    colName = DBColumnName(hstmt, 1);
    ...
    resCode = DBDeactivate(hstmt);
    resCode = DBDisconnect(hdbc);

See Also:
    DBActivateSQL, DBActivateMap, DBExecutePreparedSQL, DBOpenSQLStatement     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
    s    Pointer to the returned column name.  The string is stored in a buffer maintained by the Toolkit.  You must copy the string out of this buffer before you call another Toolkit function, because the next function may use the same buffer.

  The column name is "" if the column is an expression in the SQL SELECT statement.  The column name is NULL if an error occurred.

     Y    The column number for which the name is to be returned.  The first column number is 1.
   �� % #           Statement Handle                 �c���        Column Name                      �� $ �          Column Number                          	            1   �    Returns the width of a column.  The width is the size, in bytes, of the longest value that can be stored in the column.

Example:
    hdbc = DBConnect("DSN=CVI32_Samples");
    ...
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    colWidth = DBColumnWidth(hstmt, 1);
    ...
    resCode = DBDeactivate(hstmt);
    resCode = DBDisconnect(hdbc);

See Also:
    DBActivateSQL, DBActivateMap, DBExecutePreparedSQL, DBNewSQLStatement     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
          Width of the column in bytes.
     Z    The column number for which the width is to be returned.  The first column number is 1.
   �� % #           Statement Handle                 �6���         Column Width                     �^ $ �          Column Number                          	            1   a    Returns the data type for a column in a SQL SELECT statement.

Prior to version 2.0, the SQL Toolkit could only return the DB_CHAR, DB_VARCHAR, DB_DECIMAL, DB_INTEGER, DB_SMALLINT, DB_FLOAT, DB_DOUBLEPRECISION and DB_DATETIME type.  To minimize changes to programs which depend on this behavior, set the compatility mode to version 1.1 with:
    DBSetBackwardCompatibility(110);


Example
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    dataType = DBColumnType(hstmt, 1);
    ...
    resCode = DBDeactivateSQL(hstmt);

See Also:
    DBActivateSQL, DBActivateMap, DBSetBackwardCompatibility.


     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
    �    The returned data type.  The type is the ADO type which may not be the same as the type in the underlying database.

Prior to version 2.0, the SQL Toolkit could only return the DB_CHAR, DB_VARCHAR, DB_DECIMAL, DB_INTEGER, DB_SMALLINT, DB_FLOAT, DB_DOUBLEPRECISION and DB_DATETIME type.  To minimize changes to programs which depend on this behavior, set the compatility mode to version 1.1 with:
    DBSetBackwardCompatibility(110);

Constant            Description
--------            -----------
DB_TINYINT          1 byte integer
DB_SMALLINT         2 byte integer
DB_INTEGER          4 byte integer
DB_BIGINT           8 byte integer
DB_UNSIGNEDTINYINT  1 byte unsigned integer
DB_UNSIGNEDSMALLINT 2 byte unsigned integer
DB_UNSIGNEDINT      4 byte unsigned integer
DB_UNSIGNEDBIGINT   8 byte unsigned integer
DB_FLOAT            4 byte floating point
DB_DOUBLEPRECISION  8 byte double precision
DB_CURRENCY         fixed-point number with 4 digits to the 
                      right of the decimal point. It is stored 
                      in an 8-byte integer scaled by 10000
DB_DECIMAL          Exact numeric value with a fixed 
                      precision and scale. 
DB_NUMERIC          Exact numeric value with a fixed 
                      precision and scale. 
DB_BOOLEAN          Boolean value.
DB_ERROR            4 byte error code
DB_USERDEFINED      User defined.
DB_GUID             Globally unique identifier
DB_DATE             days_since_1899_12_30.fraction_of_day, 
                      stored as a double precision value.
DB_DBDATE           yyyymmdd
DB_TIME             hhmmss 
DB_DATETIME         yyyymmddhhmmss plus a fraction in billionths
DB_BSTR             Nul terminated character string
DB_CHAR             Fixed length string
DB_VARCHAR          String value (parameter only)
DB_LONGVARCHAR      Long string value (parameter only)
DB_WCHAR            Wide character Nul terminated string. 
DB_VARWCHAR         Wide character Nul terminated string 
                      (parameter only)
DB_LONGVARWCHAR     Long Nul terminated string (parameter only)
DB_BINARY           Binary value
DB_VARBINARY        Variable length binary value
DB_LONGVARBINARY    Long binary value.
     Y    The column number for which the type is to be returned.  The first column number is 1.
   �� * $           Statement Handle                 �^���         Column Type                      � , �          Column Number                          	            1    �    Set the value of a field/column attribute.  Only the value and in certain cases the actual size attributes may be set.  All other attributes are read only.     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL, DBActivateMap, or DBNewSQLStatement.     ?    The index of the column.  The index of the first column is 1.    �    The attribute to get.

Attribute                     Type     Description
ATTR_DB_COLUMN_VALUE          VARIANT  Value of field/column.
ATTR_DB_COLUMN_ACTUAL_SIZE    long     Actual size reserved.
                                       Usually read only.  Some
                                       Providers may allow this
                                       attribute to be set to 
                                       reserve space for BLOB
                                       data.
    ;    Value for the field/column attribute.  The type of the value varies depending on the attribute.

Attribute                     Type     Description
DB_COLUMN_ATTR_VALUE          VARIANT  Value of field/column.
DB_COLUMN_ATTR_ACTUAL_SIZE    long     Actual size reserved.
                                       Usually read only.  Some
                                       Providers may allow this
                                       attribute to be set to 
                                       reserve space for BLOB
                                       data.
     �    Result code returned by DBGetParamAttribute.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   �� *            Statement Handle                 �c * �          Index                            Ǫ ) �      Attribute                        ɣ )�         Value                            �����         Result Code                            1              BValue ATTR_DB_COLUMN_VALUE Actual Size ATTR_DB_COLUMN_ACTUAL_SIZE        	           �    Obtains a field/column attribute.

Example:

    resCode = DBGetColumnAttribute(hstmt, i, ATTR_DB_COLUMN_NAME
                                   &tempStr);
    ...
    DBFree(tempStr);
    resCode = DBGetColumnAttribute(hstmt, i, 
                                   ATTR_DB_COLUMN_VALUE,
                                   valueVariant);
    resCode = CA_VariantConvertToType(&valueVariant, 
                                      CAVT_STRING, &tempStr);
    ...
    CA_FreeMemory(tempStr);     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     ?    The index of the column.  The index of the first column is 1.        The attribute to set.

Attribute                     Type     Description
ATTR_DB_COLUMN_VALUE          VARIANT  Value of parameter.
ATTR_DB_COLUMN_ORIGINAL_VALUE VARIANT  Original value.
ATTR_DB_COLUMN_UNDERLYING_VALUE VARIANT Value currently inthe
                                       database which may have
                                       changed since the record
                                       read.
ATTR_DB_COLUMN_NAME           char*    Name of parameter
ATTR_DB_COLUMN_PRECISION      byte     Total number of digits.
ATTR_DB_COLUMN_NUMERIC_SCALE  byte     Number of digits to 
                                       the right of decimal.
ATTR_DB_COLUMN_DEFINED_SIZE   long     Defined size in bytes.
ATTR_DB_COLUMN_ACTUAL_SIZE    long     Actual size reserved.
ATTR_DB_COLUMN_ATTRIBUTES     long     The sum of zero or more
                                       of the following values:
                                       DB_COLUMN_MAY_DEFER
                                       DB_COLUMN_UPDATABLE
                                    DB_COLUMN_UNKNOWN_UPDATEABLE
                                       DB_COLUMN_FIXED
                                       DB_COLUMN_IS_NULLABLE
                                       DB_COLUMN_MAY_BE_NULL
                                       DB_COLUMN_LONG
                                       DB_COLUMN_ROW_ID
                                       DB_COLUMN_ROW_VERSION
                                       DB_COLUMN_CACHE_DEFFERED
DB_COLUMN_ATTR_TYPE           long     Type of parameter
                                       DB_EMPTY
                                       DB_TINYINT
                                       DB_SMALLINT
                                       DB_INTEGER
                                       DB_BIGINT
                                       DB_UNSIGNEDTINYINT
                                       DB_UNSIGNEDSMALLINT
                                       DB_UNSIGNEDINT
                                       DB_UNSIGNEDBIGINT
                                       DB_FLOAT
                                       DB_DOUBLEPRECISION 
                                       DB_CURRENCY
                                       DB_DECIMAL
                                       DB_NUMERIC
                                       DB_BOOLEAN
                                       DB_ERROR
                                       DB_USERDEFINED
                                       DB_VARIANT
                                       DB_IDDISPATCH
                                       DB_IUNKNOWN
                                       DB_GUID
                                       DB_DATE
                                       DB_DBDATE
                                       DB_DBTIME
                                       DB_DATETIME
                                       DB_BSTR
                                       DB_CHAR
                                       DB_VARCHAR
                                       DB_LONGVARCHAR
                                       DB_WCHAR
                                       DB_VARWCHAR
                                       DB_LONGVARWCHAR
                                       DB_BINARY
                                       DB_VARBINARY
                                       DB_LONGVARBINARY
    �    Value for the parameter attribute.  The type of the value varies depending on the attribute.

To free the strings that this function returns use DBFree.  To
free any allocated memory within the variants this function returns use CA_VariantClear.  See the documentation for the CVI ActiveX Automation Library for more information about working with Variants.

Attribute                     Type     Description
---------                     ----     -----------
DB_COLUMN_ATTR_VALUE          VARIANT  Value of parameter.
DB_COLUMN_ATTR_ORIGINAL_VALUE VARIANT  Original value.
DB_COLUMN_ATTR_UNDERLYING_VALUE VARIANT Value currently in the
                                       database which may have
                                       changed since you first  
                                       read the record
DB_COLUMN_ATTR_NAME           char*    Name of parameter
DB_COLUMN_ATTR_PRECISION      byte     Total number of digits.
DB_COLUMN_ATTR_NUMERIC_SCALE  byte     Number of digits to 
                                       the right of decimal.
DB_COLUMN_ATTR_DEFINED_SIZE   long     Defined size in bytes.
DB_COLUMN_ATTR_ACTUAL_SIZE    long     Actual size reserved.
DB_COLUMN_ATTR_ATTRIBUTES     long     The sum of zero or more
                                       of the following values:
                                       DB_COLUMN_MAY_DEFER
                                       DB_COLUMN_UPDATABLE
                                    DB_COLUMN_UNKNOWN_UPDATEABLE
                                       DB_COLUMN_FIXED
                                       DB_COLUMN_IS_NULLABLE
                                       DB_COLUMN_MAY_BE_NULL
                                       DB_COLUMN_LONG
                                       DB_COLUMN_ROW_ID
                                       DB_COLUMN_ROW_VERSION
                                       DB_COLUMN_CACHE_DEFFERED
DB_COLUMN_ATTR_TYPE           long     Type of parameter
                                       DB_EMPTY
                                       DB_TINYINT
                                       DB_SMALLINT
                                       DB_INTEGER
                                       DB_BIGINT
                                       DB_UNSIGNEDTINYINT
                                       DB_UNSIGNEDSMALLINT
                                       DB_UNSIGNEDINT
                                       DB_UNSIGNEDBIGINT
                                       DB_FLOAT
                                       DB_DOUBLEPRECISION 
                                       DB_CURRENCY
                                       DB_DECIMAL
                                       DB_NUMERIC
                                       DB_BOOLEAN
                                       DB_ERROR
                                       DB_USERDEFINED
                                       DB_VARIANT
                                       DB_IDDISPATCH
                                       DB_IUNKNOWN
                                       DB_GUID
                                       DB_DATE
                                       DB_DBDATE
                                       DB_DBTIME
                                       DB_DATETIME
                                       DB_BSTR
                                       DB_CHAR
                                       DB_VARCHAR
                                       DB_LONGVARCHAR
                                       DB_WCHAR
                                       DB_VARWCHAR
                                       DB_LONGVARWCHAR
                                       DB_BINARY
                                       DB_VARBINARY
                                       DB_LONGVARBINARY
     �    Result code returned by DBGetColumnAttribute.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   � *            Statement Handle                 М * �          Index                            �� ) �      Attribute                        �
 )�         Value                            �����         Result Code                            1           
  nValue ATTR_DB_COLUMN_VALUE Attributes ATTR_DB_COLUMN_ATTRIBUTES Name ATTR_DB_COLUMN_NAME Type ATTR_DB_COLUMN_TYPE Actual Size ATTR_DB_COLUMN_ACTUAL_SIZE Defined Size ATTR_DB_COLUMN_DEFINED_SIZE Original Value ATTR_DB_COLUMN_ORIGINAL_VALUE Underlying Value ATTR_DB_COLUMN_UNDERLYING_VALUE Precision ATTR_DB_COLUMN_PRECISION Numeric Scale ATTR_DB_COLUMN_NUMERIC_SCALE    	            	           �    Returns the number of records modified by the last function that modified the database.

Example:
    hdbc = DBConnect("DSM=CVI32_Samples");
    ...
    hstmt = DBActivateSQL(hdbc,"UPDATE EMP
        SET SALARY = SALARY * 1.1 WHERE DEPT='101'");
    numRecs = DBNumberOfModifiedRecords(hstmt);
    resCode = DBDeactivateSQL(hstmt);
    resCode = DBDisconnect(hdbc);

See Also:
    DBActivateSQL, DBActivateMap.
     �    0 or handle to the SQL statement that DBActivateSQL, DBActivateMap, DBPrepareSQL or DBNewSQLStatement returned.  If 0, returns the most recent number of records modified on any hstmt.     U    Number of modified records.  Returns 0 if the statement is not a SELECT statement.
   �� $ &           Statement Handle                 ����         Number of Modified Records             	               Starts a transaction on a database connection.  After a transaction begins, the SQL INSERT, UPDATE and DELETE statements that you execute as well as the changes you make with DBCreateRecord, DBDeleteRecord and DBPutRecord are not committed to the database until you call DBCommit.

DBCommit saves the changes that have been mades since DBBeginTran was called and frees all database locks.

DBRollback discards the changes that have been made since DBBeginTran was called and frees all database locks.

Notes:

If you execute an INSERT, UPDATE of DELETE statement without first calling DBBeginTran, the database changes are automaticallly committed and no database locks are held.

You cannot have more than one simultaneous transaction active on a database connection.  Once you call DBBeginTran, you must call either DBCommit or DBRollback before you call DBBeginTran again on the same database connection.

Once you call DBBeginTran, you must call either DBCommit or DBRollback before you call DBDisconnect.  Calling DBDisconnect with an active transaction results in an error.

Example:
    hdbc = DBConnect("DSN=MSSS;UID=shawkins;SRVR=PENNY");
    ...
    resCode = DBBeginTran(hdbc);
    hstmt = DBActivateSQL(hdbc,
        "UPDATE EMP SET SALARY = SALARY * 1.1");
    resCode = DBDeactivate(hstmt);
    resCode = DBCommit(hdbc);
    resCode = DBDisconnect(hdbc);

See Also:
    DBCommit, DBRollback
     �    Result code returned by DBBeginTran.  This function returns the set of result codes listed in the function description for DBError.     ?    The handle to the database connection that DBConnect returns.   �����         Result Code                      �� # )           Connection Handle                  	               )    Commits all changes that have been made using the SQL statements INSERT, UPDATE or DELETE since DBBeginTran was called.  You must call DBBeginTran to begin a transaction before you can call DBCommit to save all changes.

Example:
    hdbc = DBConnect("DSN=QESS;UID=shawkins;SRVR=PENNY");
    ...
    resCode = DBBeginTran(hdbc);
    hstmt = DBActivateSQL(hdbc,
        "UPDATE EMP SET SALARY = SALARY * 1.1");
    resCode = DBDeactivateSQL(hstmt);
    resCode = DBCommit(hdbc);
    resCode = DBDisconnect(hdbc);

See Also:
    DBBeginTran, DBRollback
     R    The handle to the database connection that DBConnect or DBNewConnection returns.     �    Result code returned by DBCommit.  This function returns the set of result codes listed in the function description for DBError.     �z ' )           Connection Handle                �����         Result Code                            	           �    Discards all changes that have been made using the SQL statements INSERT, UPDATE or DELETE since you called DBBeginTran.  You must call DBBeginTran to begin a transaction before you can call DBRollback to undo all changes.

DBRollback discards the following changes:

    Saved changes on records other than the current record.

    Records that you created with a call to DBCreateRecord.

    New values that you placed in the current record with calls 
    to DBPutRecord.

After rollback, you much call one of the DBFetch functions to position on a valid record.

Example:
    hdbc = DBConnect("DSN=QESS;UID=shawkins;SRVR=PENNY");
    ...
    resCode = DBBeginTran(hdbc);
    hstmt = DBActivateSQL(hdbc,
        "UPDATE EMP SET SALARY = SALARY * 1.1");
    resCode = DBDeactivateSQL(hstmt);
    resCode = DBRollback(hdbc);
    resCode = DBDisconnect(hdbc);

See Also:
    DBBeginTran, DBCommit.

     S    The handle to the database connection that DBConnect or DBNewConnection returned.     �    Result code returned by DBRollback.  This function returns the set of result codes listed in the function description for DBError.   g ' )           Connection Handle                ����         Result Code                            	               Returns the result code of the last SQL Toolkit function you called.

You should call DBError immediately after calling any other SQL Toolkit function that does not return a result code (for example DBColumnName and DBColumnWidth).

See Also:
    DBWarning, DBErrorMessage.
    �    Result code of the last SQL Toolkit function call.

Constant          Value Description
--------          ----- -----------
DB_ODBC_ERROR       -12 ODBC error in DBSources.
DB_AUTOMATION_ERROR -11 Error detected in OLE Automation.
DB_DBSYS_ERROR      -10 Error detected by ADO, ODBC driver or
                        underlying database system.
DB_EOF              -5  EOF.  Returned by DBFetchNext 
                        DBFetchPrev or DBFetchRandom when there 
                        is no record to return.
DB_USER_CANCELED    -4  User canceled out of the logon dialog 
                        box.
DB_OUT_OF_MEMORY    -3  Windows is out of memory.  This is 
                        usually fatal.
DB_SUCCESS           0  Success.
DB_SUCCESS_WITH_INFO 1  Success with information (warning).
DB_NO_DATA_WITH_INFO 2  EOF with additional information (usually
                        ESC during a fetch).
   ����         Result Code                        	            �    Returns the warning generated by the last SQL Toolkit function you called.  DBWarning is usually called after DBError to determine if the database system or the last function returned any warnings.

See Also:
    DBError.    _    Result code, either a warning code returned by the database system or one of the following

Constant             Value  Description
DB_SUCCESS_WITH_INFO 1      Success with information (warning).
DB_NO_DATA_WITH_INFO 2      EOF with additional information            
                            (usually ESC during a fetch).

See Also:
    DBError
   ����         Result Code                        	               Returns the result code from the underlying database system for the last SQL Toolkit function you called.

You can call DBNativeError when DBError returns a value of DB_DBSYS_ERROR (4) to determine the native error code.

See Also:
    DBError, DBWarning, DBErrorMessage.
     �    Native error code in the underlying database system.  If zero, no database system error was reported. If DBError returned DB_DBSYS_ERROR (4) DBNativeError may return 0.  In this case the underlying database system does not have a separate error code.
   c���         Result Code                        	            �    Returns the text associated with the error or warning generated by the last SQL Toolkit function you called.  Any message from the underlying database system is included in the returned string.

See Also:
    DBError, DBNativeError
     �    Pointer to a buffer containing the error or warning message text.

Remember, the buffer is reused by the Toolkit.  Copy the string out of this buffer before calling another SQL Toolkit function.
   ����        Error Text                         	           �    This function causes the memory pointed to by Mem Block Pointer to be deallocated, that is, made unavailable for further use.

In an external compiler environment, there can be one set of malloc() and free() functions used by the SQL toolkit and an entirely different set used by the external compiler.  Use DBFree to ensure that the proper function frees the memory that the toolkit allocates and returns.

Note: Do not use DBFree to free items extracted from variants.  See the the CVI ActiveX Automation Library documentation for for the proper free functions.  Do not use DBFree to free memory you allocate in your program, use the standard free() function.

    K    A pointer to the memory block that will that will have its space deallocated.  If a null pointer is entered into this control, no action occurs.  If the argument does not match a pointer previously obtained by the calloc(), malloc(), or realloc() function, or if the space has already been deallocated, the behavior is undefined.   J 2 �          Mem Block Pointer                      1    Obtains the version number of the SQL Toolkit.
     z    Version number of the SQL Toolkit.  The version number is 3 decimal digits, so, for example 200 stands for version 2.0.
   ���         Version                            	           �    Sets compatibility with previous versions ot the LabWindows/CVI SQL Toolkit. 

Version 1.x compatibility changes the following behaviours.
    Functions that return handles, such as DBConnect and    
    DBActivateSQL, always return zero when they fail rather 
    than an error code

    DBColumnType only coerces the column type to one of the 8 
    datatypes supported by version 1.x, not the full range
    of types supported in version 2.0

Example:

    resCode = DBSetBackwardCompatibility(110);
     �    SQL Toolkit version number.  The version number is three decimal digits.  The default is 200, any value below 200 sets compatibility with versions 1.0 and 1.1.     �    Result code returned by DBSetBackwardCompatibility.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
   � $            Version                          |���         Result Code                        200    	           /    Creates an unopened connection.  Unlike DBConnect, DBNewConnection (in conjunction with DBOpenConnection) allows you to set connection attributes before opening the connection.

If your program is multithreaded, you must call DBInit before calling any DBConnect or DBNewConnection.

Example:
    hdbc = DBNewConnection();
    resCode = DBSetConnectionAttribute(hdbc, 
            ATTR_DB_CONN_CONNECTION_TIMEOUT, 100);
    resCode = DBSetConnectionAttribute(hdbc, 
            ATTR_DB_CONN_ISOLATION_LEVEL,
            DB_ISOLATION_LEVEL_SERIALIZABLE);
    resCode = DBOpenConnection(hdbc);
    ...
    resCode = DBCloseConnection(hdbc);
    resCode = DBDiscardConnection(hdbc);

See also:
    DBConnect, DBOpenConnection, DBSetConnectionAttribute, DBGetConnectionAttribute, DBCloseConnection, DBDiscardConnection     �    Handle to the database connection that identifies the connection and is a parameter to other functions.  If the handle is less than or equal to 0, the connection could not be opened.
   ���         Connection Handle                  	           y    Set a conection attribute.  Because you must set most attributes before you open the connection (except ATTR_DB_CONN_DEFAULT_DATABASE), DBSetConnectionAttribute is used most often in conjuntion with DBNewConnection and DBOpenConnection.


Example:
    hdbc = DBNewConnection();
    resCode = DBSetConnectionAttribute(hdbc,
            ATTR_DB_CONN_CONNECTION_STRING, 
            "DSN=cvi ss;User ID=sa;Password=");
    resCode = DBSetConnectionAttribute(hdbc, 
            ATTR_DB_CONN_CONNECTION_TIMEOUT, 100);
    resCode = DBSetConnectionAttribute(hdbc, 
            ATTR_DB_CONN_ISOLATION_LEVEL,
            DB_ISOLATION_LEVEL_SERIALIZABLE);
    resCode = DBOpenConnection(hdbc);
    ...
    resCode = DBCloseConnection(hdbc);
    resCode = DBDiscardConnection(hdbc);

See also:
    DBNewConnection, DBOpenConnection, DBGetConnectionAttribute, DBCloseConnection, DBDiscardConnection     �    Handle to the connection returned by DBNewConnection or, if the attribute can be set after the connection is open, by DBConnect.     �    The attribute to set.  Some providers do not support all attributes.  

Attribute                         Type
ATTR_DB_CONN_CONNECTION_STRING    string
    a series of argument = value clauses separated by semicolons
    which describe the desired connection.  ADO recognizes the 
    following arguments, all other arguments are passed directly
    to the provider unchanged.
        Provider= name of the provider to use for the 
           connection. 
        Data Source= Specifies the name of the data source for             
           the connection.
        User ID= user name to use when opening the connection. 
        Password= Specifies the password to use when opening the 
            connection. 
        File Name= Specifies the name of a provider-specific 
            file (for example, a persisted data source object) 
            containing preset connection information. 
        Remote Provider= Specifies the name of a provider to use 
            when opening a client-side connection. 
        Remote Server= Specifies the path name of the sever to 
            use when opening a client-side connection.
ATTR_DB_CONN_COMMAND_TIMEOUT      long
    The number of seconds to wait for a command to execute
ATTR_DB_CONN_CONNECTION_TIMEOUT   long
    The number of seconds to wait for a connection to be 
    established.
ATTR_DB_CONN_DEFAULT_DATABASE     string
    The name of the default database for database systems which
    support storing tables in multiple databases.  This is the 
    only attribute which can only be set after a connection is
    established.
ATTR_DB_CONN_ISOLATION_LEVEL      long
    Isolation level of the connection:
        DB_ISOLATION_LEVEL_CHAOS
            You cannot overwrite pending changes from more 
            highly isolated transactions. 
        DB_ISOLATION_LEVEL_READ_UNCOMMITTED
            From one transaction you can view uncommitted
            changes in other transactions.
        DB_ISOLATION_LEVEL_READ_COMMITTED
            Default. From one transaction you can view changes  
            in other transactions only after they've been 
            committed. 
        DB_ISOLATION_LEVEL_REPEATABLE_READ
            From one transaction you cannot see changes made in
            other transactions, but requerying can bring new 
            recordsets.
        DB_ISOLATION_LEVEL_SERIALIZABLE
            transactions are conducted in isolation of other 
            transactions.
ATTR_DB_CONN_ATTRIBUTES           long
    Attributes of the connection, the sum of one or more of the 
    following values
        DB_XACT_COMMIT_RETAINING
            Performs retaining commits.  In other words, calling
            DBCommit automatically starts a new transaction.
            Not all providers support this.
        DB_XACT_ABORT_RETAINING
            Performs retaining aborts.  In other words, calling
            DBRollback automatically starts a new transaction.
            Not all providers support this.
ATTR_DB_CONN_CURSOR_LOCATION      long
    The location of the cursor
        DB_CURSOR_LOC_SERVER
            Default. Uses data provider or driver-supplied 
            cursors. 
        DB_CURSOR_LOC_CLIENT
            Uses client-side cursors supplied by a local cursor 
            library. 
ATTR_DB_CONN_MODE                 long
    The connection mode
        DB_CONN_MODE_READ
            Read-only permissions.
        DB_CONN_MODE_WRITE
            Write-only permissions. 
        DB_CONN_MODE_READ_WRITE
            read/write permissions.
        DB_CONN_MODE_SHARE_DENY_READ
            Prevents others from opening connection with read
            permissions.
        DB_CONN_MODE_SHARE_DENY_WRITE
            Prevents others from opening connection with write
            permissions.
        DB_CONN_MODE_SHARE_EXCLUSIVE
            Prevents others from opening connection.
        DB_CONN_MODE_SHARE_DENY_NONE
            Prevents others from opening connection with any
            permissions.
ATTR_DB_CONN_PROVIDER             string
    The name of the provider of the connection.  The default 
    is "MSDASQL"
ATTR_DB_CONN_STATE                long
    The open/closed state of the connection
        DB_OBJECT_STATE_CLOSED = 0,
        DB_OBJECT_STATE_OPEN = 1,

    �    Value for the attribute.  The type of the value varies depending on the attribute.  Some providers do not support all attributes.  

Attribute                         Type
ATTR_DB_CONN_CONNECTION_STRING    string
    a series of argument = value clauses separated by semicolons
    which describe the desired connection.  ADO recognizes the 
    following arguments, all other arguments are passed directly
    to the provider unchanged.
        Provider= name of the provider to use for the 
           connection. 
        Data Source= Specifies the name of the data source for             
           the connection.
        User ID= user name to use when opening the connection. 
        Password= Specifies the password to use when opening the 
            connection. 
        File Name= Specifies the name of a provider-specific 
            file (for example, a persisted data source object) 
            containing preset connection information. 
        Remote Provider= Specifies the name of a provider to use 
            when opening a client-side connection. 
        Remote Server= Specifies the path name of the sever to 
            use when opening a client-side connection.
ATTR_DB_CONN_COMMAND_TIMEOUT      long
    The number of seconds to wait for a command to execute
ATTR_DB_CONN_CONNECTION_TIMEOUT   long
    The number of seconds to wait for a connection to be 
    established.
ATTR_DB_CONN_DEFAULT_DATABASE     string
    The name of the default database for database systems which
    support storing tables in multiple databases.  This is the 
    only attribute which can only be set after a connection is
    established.
ATTR_DB_CONN_ISOLATION_LEVEL      long
    Isolation level of the connection:
        DB_ISOLATION_LEVEL_CHAOS
            You cannot overwrite pending changes from more 
            highly isolated transactions. 
        DB_ISOLATION_LEVEL_READ_UNCOMMITTED
            From one transaction you can view uncommitted
            changes in other transactions.
        DB_ISOLATION_LEVEL_READ_COMMITTED
            Default. From one transaction you can view changes  
            in other transactions only after they've been 
            committed. 
        DB_ISOLATION_LEVEL_REPEATABLE_READ
            From one transaction you cannot see changes made in
            other transactions, but requerying can bring new 
            recordsets.
        DB_ISOLATION_LEVEL_SERIALIZABLE
            transactions are conducted in isolation of other 
            transactions.
ATTR_DB_CONN_ATTRIBUTES           long
    Attributes of the connection, the sum of one or more of the 
    following values
        DB_XACT_COMMIT_RETAINING
            Performs retaining commits.  In other words, calling
            DBCommit automatically starts a new transaction.
            Not all providers support this.
        DB_XACT_ABORT_RETAINING
            Performs retaining aborts.  In other words, calling
            DBRollback automatically starts a new transaction.
            Not all providers support this.
ATTR_DB_CONN_CURSOR_LOCATION      long
    The location of the cursor
        DB_CURSOR_LOC_SERVER
            Default. Uses data provider or driver-supplied 
            cursors. 
        DB_CURSOR_LOC_CLIENT
            Uses client-side cursors supplied by a local cursor 
            library. 
ATTR_DB_CONN_MODE                 long
    The connection mode
        DB_CONN_MODE_READ
            Read-only permissions.
        DB_CONN_MODE_WRITE
            Write-only permissions. 
        DB_CONN_MODE_READ_WRITE
            read/write permissions.
        DB_CONN_MODE_SHARE_DENY_READ
            Prevents others from opening connection with read
            permissions.
        DB_CONN_MODE_SHARE_DENY_WRITE
            Prevents others from opening connection with write
            permissions.
        DB_CONN_MODE_SHARE_EXCLUSIVE
            Prevents others from opening connection.
        DB_CONN_MODE_SHARE_DENY_NONE
            Prevents others from opening connection with any
            permissions.
ATTR_DB_CONN_PROVIDER             string
    The name of the provider of the connection.  The default 
    is "MSDASQL"
ATTR_DB_CONN_STATE                long
    The open/closed state of the connection
        DB_OBJECT_STATE_CLOSED = 0,
        DB_OBJECT_STATE_OPEN = 1,

     �    Result code returned by DBSetConnectionAttribute.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   � *            Connection Handle                  ) � �      Attribute                        0� )>         Value                            A����         Result Code                                   
  �Connection String ATTR_DB_CONN_CONNECTION_STRING Command Timeout ATTR_DB_CONN_COMMAND_TIMEOUT Connection Timeout ATTR_DB_CONN_CONNECTION_TIMEOUT Default Database ATTR_DB_CONN_DEFAULT_DATABASE Isolation Level ATTR_DB_CONN_ISOLATION_LEVEL Attributes ATTR_DB_CONN_ATTRIBUTES Cursor Location ATTR_DB_CONN_CURSOR_LOCATION Mode ATTR_DB_CONN_MODE Provider ATTR_DB_CONN_PROVIDER State ATTR_DB_CONN_STATE        	           �    Obtains the value of a connection attribute.

Example:
    int timeout, isoLevel;
    hdbc = DBConnect("DSN=cvi ss;User ID=sa;Password=");
    resCode = DBGetConnectionAttribute(hdbc, 
            ATTR_DB_CONN_CONNECTION_TIMEOUT, &timeout);
    resCode = DBGetConnectionAttribute(hdbc, 
            ATTR_DB_CONN_ISOLATION_LEVEL, &isoLevel

See also:
    DBConnect, DBNewConnection, DBOpenConnection, DBSetConnectionAttribute.     F    Handle to the connection that DBNewConnection or DBConnect returned.    d    The attribute to set.  Some providers do not support all attributes.  

Attribute                         Type
ATTR_DB_CONN_CONNECTION_STRING    string
    a series of argument = value clauses separated by semicolons
    which describe the desired connection.  ADO recognizes the 
    following arguments, all other arguments are passed directly
    to the provider unchanged.
        Provider= name of the provider to use for the 
           connection. 
        Data Source= Specifies the name of the data source for             
           the connection.
        User ID= user name to use when opening the connection. 
        Password= Specifies the password to use when opening the 
            connection. 
        File Name= Specifies the name of a provider-specific 
            file (for example, a persisted data source object) 
            containing preset connection information. 
        Remote Provider= Specifies the name of a provider to use 
            when opening a client-side connection. 
        Remote Server= Specifies the path name of the sever to 
            use when opening a client-side connection.
ATTR_DB_CONN_COMMAND_TIMEOUT      long
    The number of seconds to wait for a command to execute
ATTR_DB_CONN_CONNECTION_TIMEOUT   long
    The number of seconds to wait for a connection to be 
    established.
ATTR_DB_CONN_DEFAULT_DATABASE     string
    The name of the default database for database systems which
    support storing tables in multiple databases.
ATTR_DB_CONN_ISOLATION_LEVEL      long
    Isolation level of the connection:
        DB_ISOLATION_LEVEL_UNSPECIFIED
            The provider is using a different isolation level
            than the level specified by the use and that level
            cannot be determined.
        DB_ISOLATION_LEVEL_CHAOS
            You cannot overwrite pending changes from more 
            highly isolated transactions. 
        DB_ISOLATION_LEVEL_READ_UNCOMMITTED
            From one transaction you can view uncommitted
            changes in other transactions.
        DB_ISOLATION_LEVEL_READ_COMMITTED
            Default. From one transaction you can view changes  
            in other transactions only after they've been 
            committed. 
        DB_ISOLATION_LEVEL_REPEATABLE_READ
            From one transaction you cannot see changes made in
            other transactions, but requerying can bring new 
            recordsets.
        DB_ISOLATION_LEVEL_SERIALIZABLE
            transactions are conducted in isolation of other 
            transactions.
ATTR_DB_CONN_ATTRIBUTES           long
    Attributes of the connection, the sum of one or more of the 
    following values
        DB_XACT_COMMIT_RETAINING
            Performs retaining commits.  In other words, calling
            DBCommit automatically starts a new transaction.
            Not all providers support this.
        DB_XACT_ABORT_RETAINING
            Performs retaining aborts.  In other words, calling
            DBRollback automatically starts a new transaction.
            Not all providers support this.
ATTR_DB_CONN_CURSOR_LOCATION      long
    The location of the cursor
        DB_CURSOR_LOC_NONE
            The cursor location has not been set or cannot be
            determined.
        DB_CURSOR_LOC_SERVER
            Default. Uses data provider or driver-supplied 
            cursors. 
        DB_CURSOR_LOC_CLIENT
            Uses client-side cursors supplied by a local cursor 
            library. 
ATTR_DB_CONN_MODE                 long
    The connection mode
        DB_CONN_MODE_UNKNOWN
           Permissions have not yet been set or cannot be
           determined.
        DB_CONN_MODE_READ
            Read-only permissions.
        DB_CONN_MODE_WRITE
            Write-only permissions. 
        DB_CONN_MODE_READ_WRITE
            read/write permissions.
        DB_CONN_MODE_SHARE_DENY_READ
            Prevents others from opening connection with read
            permissions.
        DB_CONN_MODE_SHARE_DENY_WRITE
            Prevents others from opening connection with write
            permissions.
        DB_CONN_MODE_SHARE_EXCLUSIVE
            Prevents others from opening connection.
        DB_CONN_MODE_SHARE_DENY_NONE
            Prevents others from opening connection with any
            permissions.
ATTR_DB_CONN_PROVIDER             string
    The name of the provider of the connection.  The default 
    is "MSDASQL"
ATTR_DB_CONN_STATE                long
    The open/closed state of the connection
        DB_OBJECT_STATE_CLOSED = 0,
        DB_OBJECT_STATE_OPEN = 1,
ATTR_DB_CONN_CONNECTION_OBJECT    CAObjHandle
     The ActiveX object handle of the connection.
    �    Value for the attribute.  The type of the value varies depending on the attribute.  Some providers do not support all attributes.  

To free the strings that this function returns use DBFree.  To
free any allocated memory within the variants this function returns use CA_VariantClear.  See the documentation for the CVI ActiveX Automation Library for more information about working with Variants.

Attribute                         Type
---------                         ---- 
ATTR_DB_CONN_CONNECTION_STRING    string
    a series of argument = value clauses separated by semicolons
    which describe the desired connection.  ADO recognizes the 
    following arguments, all other arguments are passed directly
    to the provider unchanged.
        Provider= name of the provider to use for the 
           connection. 
        Data Source= Specifies the name of the data source for             
           the connection.
        User ID= user name to use when opening the connection. 
        Password= Specifies the password to use when opening the 
            connection. 
        File Name= Specifies the name of a provider-specific 
            file (for example, a persisted data source object) 
            containing preset connection information. 
        Remote Provider= Specifies the name of a provider to use 
            when opening a client-side connection. 
        Remote Server= Specifies the path name of the sever to 
            use when opening a client-side connection.
ATTR_DB_CONN_COMMAND_TIMEOUT      long
    The number of seconds to wait for a command to execute
ATTR_DB_CONN_CONNECTION_TIMEOUT   long
    The number of seconds to wait for a connection to be 
    established.
ATTR_DB_CONN_DEFAULT_DATABASE     string
    The name of the default database for database systems which
    support storing tables in multiple databases.
ATTR_DB_CONN_ISOLATION_LEVEL      long
    Isolation level of the connection:
        DB_ISOLATION_LEVEL_UNSPECIFIED
            The provider is using a different isolation level
            than the level specified by the use and that level
            cannot be determined.
        DB_ISOLATION_LEVEL_CHAOS
            You cannot overwrite pending changes from more 
            highly isolated transactions. 
        DB_ISOLATION_LEVEL_READ_UNCOMMITTED
            From one transaction you can view uncommitted
            changes in other transactions.
        DB_ISOLATION_LEVEL_READ_COMMITTED
            Default. From one transaction you can view changes  
            in other transactions only after they've been 
            committed. 
        DB_ISOLATION_LEVEL_REPEATABLE_READ
            From one transaction you cannot see changes made in
            other transactions, but requerying can bring new 
            recordsets.
        DB_ISOLATION_LEVEL_SERIALIZABLE
            transactions are conducted in isolation of other 
            transactions.
ATTR_DB_CONN_ATTRIBUTES           long
    Attributes of the connection, the sum of one or more of the 
    following values
        DB_XACT_COMMIT_RETAINING
            Performs retaining commits.  In other words, calling
            DBCommit automatically starts a new transaction.
            Not all providers support this.
        DB_XACT_ABORT_RETAINING
            Performs retaining aborts.  In other words, calling
            DBRollback automatically starts a new transaction.
            Not all providers support this.
ATTR_DB_CONN_CURSOR_LOCATION      long
    The location of the cursor
        DB_CURSOR_LOC_NONE
            The cursor location has not been set or cannot be
            determined.
        DB_CURSOR_LOC_SERVER
            Default. Uses data provider or driver-supplied 
            cursors. 
        DB_CURSOR_LOC_CLIENT
            Uses client-side cursors supplied by a local cursor 
            library. 
ATTR_DB_CONN_MODE                 long
    The connection mode
        DB_CONN_MODE_UNKNOWN
           Permissions have not yet been set or cannot be
           determined.
        DB_CONN_MODE_READ
            Read-only permissions.
        DB_CONN_MODE_WRITE
            Write-only permissions. 
        DB_CONN_MODE_READ_WRITE
            read/write permissions.
        DB_CONN_MODE_SHARE_DENY_READ
            Prevents others from opening connection with read
            permissions.
        DB_CONN_MODE_SHARE_DENY_WRITE
            Prevents others from opening connection with write
            permissions.
        DB_CONN_MODE_SHARE_EXCLUSIVE
            Prevents others from opening connection.
        DB_CONN_MODE_SHARE_DENY_NONE
            Prevents others from opening connection with any
            permissions.
ATTR_DB_CONN_PROVIDER             string
    The name of the provider of the connection.  The default 
    is "MSDASQL", the ADO ODBC provider.
ATTR_DB_CONN_STATE                long
    The open/closed state of the connection
        DB_OBJECT_STATE_CLOSED = 0,
        DB_OBJECT_STATE_OPEN = 1,
ATTR_DB_CONN_CONNECTION_OBJECT    CAObjHandle
     The ActiveX object handle of the connection.

     �    Result code returned by DBGetConnectionAttribute.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   F� *            Connection Handle                G6 ) � �      Attribute                        Y� )>         Value                            m����         Result Code                                     �Connection String ATTR_DB_CONN_CONNECTION_STRING Command Timeout ATTR_DB_CONN_COMMAND_TIMEOUT Connection Timeout ATTR_DB_CONN_CONNECTION_TIMEOUT Default Database ATTR_DB_CONN_DEFAULT_DATABASE Isolation Level ATTR_DB_CONN_ISOLATION_LEVEL Attributes ATTR_DB_CONN_ATTRIBUTES Cursor Location ATTR_DB_CONN_CURSOR_LOCATION Mode ATTR_DB_CONN_MODE Provider ATTR_DB_CONN_PROVIDER State ATTR_DB_CONN_STATE Version ATTR_DB_CONN_VERSION Connection Object ATTR_DB_CONN_CONNECTION_OBJECT    	            	           �    Opens an existing but closed connection.  Unlike DBConnect, DBOpenConnection (in conjunction with DBNewConnection) allows you to set connection attributes before opening the connection.

Example:
    hdbc = DBNewConnection();
    resCode = DBSetConnectionAttribute(hdbc, 
            ATTR_DB_CONN_CONNECTION_TIMEOUT, 100);
    resCode = DBSetConnectionAttribute(hdbc, 
            ATTR_DB_CONN_ISOLATION_LEVEL,
            DB_ISOLATION_LEVEL_ISOLATED);
    resCode = DBOpenConnection(hdbc);
    ...
    resCode = DBCloseConnection(hdbc);
    resCode = DBDiscardConnection(hdbc);

See also:
    DBConnect, DBNewConnection, DBSetConnectionAttribute, DBGetConnectionAttribute, DBCloseConnection, DBDiscardConnection     R    Connection handle from DBNewConnection.  The connection is assumed to be closed.     �    Result code returned by DBOpenSQLStatement.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   t $            Connection Handle                tn���         Result Code                            	           �    Close the specified connection.  The connection still exists and can be reopened until discarded with DBDiscardConnection.

Example:
    hdbc = DBNewConnection();
    resCode = DBSetConnectionAttribute(hdbc, 
            ATTR_DB_CONN_CONNECTION_TIMEOUT, 100);
    resCode = DBSetConnectionAttribute(hdbc, 
            ATTR_DB_CONN_ISOLATION_LEVEL,
            DB_ISOLATION_LEVEL_ISOLATED);
    resCode = DBOpenConnection(hdbc);
    ...
    resCode = DBCloseConnection(hdbc);
    resCode = DBDiscardConnection(hdbc);

See also:
    DBDisconnect, DBNewConnection, DBOpenConnection, 
    DBSetConnectionAttribute, DBGetConnectionAttribute, 
    DBDiscardConnection     6    Connection handle from DBConnect or DBNewConnection.     �    Result code returned by DBCloseConnection.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   xU $            Statement Handle                 x����         Result Code                            	           �    Discard the specified connection.  Calling DBCloseConnection and then DBDiscardConnection is equivalent to calling DBDisconnect

Example:
    hdbc = DBNewConnection();
    resCode = DBSetConnectionAttribute(hdbc, 
            ATTR_DB_CONN_CONNECTION_TIMEOUT, 100);
    resCode = DBSetConnectionAttribute(hdbc, 
            ATTR_DB_CONN_ISOLATION_LEVEL,
            DB_ISOLATION_LEVEL_ISOLATED);
    resCode = DBOpenConnection(hdbc);
    ...
    resCode = DBCloseConnection(hdbc);
    resCode = DBDiscardConnection(hdbc);

See also:
    DBDisconnect, DBNewConnection, DBOpenConnection, 
    DBSetConnectionAttribute, DBGetConnectionAttribute, 
    DBCloseConnection     F    Handle to the connection that DBConnect or DBNewConnection returned.     �    Result code returned by DBDiscardConnection.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   || $            Connection Handle                |����         Result Code                            	           J    Creates, but does not open/execute an SQL statement.  DBNewSQLStatement (in conjunction with DBOpenSQLStatement) allows you to set attributes of the statement before executing the statement.

Example:
    hstmt = DBNewSQLStatement (hdbc, "SELECT UUT_NUM, MEAS1,\
                                      MEAS2 FROM TESTRES");
    resCode = DBSetStatementAttribute(hstmt,
                                      ATTR_DB_STMT_MAX_RECORDS,
                                      1);
    resCode = DBSetStatementAttribute(hstmt,
                                      ATTR_DB_STMT_CACHE_SIZE,
                                      10);
    resCode = DBOpenSQLStatement(hstmt);
    ...
    resCode = DBGetStatementAttribute(hstmt, 
                                      ATTR_DB_STMT_RECORD_COUNT,
                                      &recordCount
    ...
    resCode = DBCloseSQLStatement(hstmt);
    resCode = DBDiscardSQLStatement(hstmt);

See also:
    DBOpenSQLStatement, DBCloseSQLStatement, 
    DBDiscardSQLStatement, DBSetStatementAttribute, 
    DBGetStatementAttribute, DBActivateSQL, DBPrepareSQL     S    The handle to the database connection that DBConnect or DBNewConnection returned.     4    The stored procedure or SQL statement to activate.    u    Statement handle that identifies the statement and is a parameter to other functions.  If less than or equal to 0, the statement could not be executed.

Note: prior to version 2.0, the SQL Toolkit always returned 0 on
error.  To minimize changes to programs that depend on this behavior,
set the compatility mode to version 1.1 with:
    DBSetBackwardCompatibility(110);
   �e )            Connection Handle                �� * �         SQL Statement                    ��
���         Statement Handle                       ""    	           
�    Set a SQL statement attribute.  You can set attributes for statements created with DBActivateSQL, DBActivateMap, DBNewSQLStatement and DBPrepareSQL.  

For statement attributes that you must set before you open the SQL statement, you must set the statement attribute as follows:

    Call DBNewSQLStatement or DBPrepareSQL.

    Set the attribute.

    Call DBOpenSQLStatement or DBOpenPreparedSQL.

Example:
    hstmt = DBNewSQLStatement (hdbc, "SELECT UUT_NUM, MEAS1, \
                               MEAS2 FROM TESTRES");
    /* set the cursor type */
    resCode = DBSetStatementAttribute(hstmt, 
        ATTR_DB_STMT_CURSOR_TYPE, DB_CURSOR_TYPE_FORWARD_ONLY);
    ...
    resCode = DBOpenSQLStatement(hstmt);
    /* set the absolute position */
    resCode = DBSetStatementAttribute(hstmt, 
        ATTR_DB_STMT_ABSOLUTE_POSITION, 2);    
    ...
    resCode = DBCloseSQLStatement(hstmt);

Bookmark and Filter example:
    VARIANT vFilterArray;
    int filterIndex = 0;
    VARIANT bookmarks[2];
    
    /* It took your humble developer days to write tests  */
    /* for this attribute, so you're bloody well going to */
    /* get an example of how to use the stinking things   */
    hstmt = DBNewSQLStatement (hdbc, "SELECT UUT_NUM, MEAS1, \           
                                      MEAS2 FROM TESTRES");
    resCode = DBOpenSQLStatement(hstmt);

    /* criteria string example */
    /* note: it almost always much more efficient to use a */
    /* where clause in the SQL statement.                  */
    CA_VariantSetCString (&filter, "(MEAS1 > 1.0)");
    resCode = DBSetStatementAttribute(hstmt,
            ATTR_DB_STMT_FILTER, filter);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* only records where MEAS1 greater than 1.0 */
        ...
    }
    /* Filter constant example */
    CA_VariantSetLong (&filter, DB_FILTER_NONE);
    resCode = DBSetStatementAttribute(hstmt,
            ATTR_DB_STMT_FILTER, filter);
    i = 0;
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* will get all records */
        ...
        /* Get some bookmarks to use in next example */
        if ((i == 0) || (i == 2)) {
            resCode = DBGetStatementAttribute(hstmt,
                    ATTR_DB_STMT_BOOKMARK, 
                    &(bookmarks[filterIndex++]));
        i++;
        ...
    }

    /* Bookmark array example */
    CA_VariantSet1DArray (&vFilterArray, CAVT_VARIANT, 2,
                          bookmarks);
    resCode = DBSetStatementAttribute(hstmt,
        ATTR_DB_STMT_FILTER, vFilterArray);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* will only get records at the bookmarks we */
        /* grabbed in the previous example           */
        ...
    }
    resCode = DBCloseSQLStatement(hstmt);

     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
        The attribute to set.  Some providers do not support all attributes.  

Attribute                         Type
ATTR_DB_STMT_PAGE_SIZE            long
    Sets the number of records in a page.
ATTR_DB_STMT_ABSOLUTE_PAGE        long
    Move to the specified page.  Page numbers start at 1. 
ATTR_DB_STMT_ABSOLUTE_POSITION    long       
    Moves the to the specified record number.  Record numbers   
    start at 1.  If you set the record to record 1 then calling
    DBFetchNext fetches record 1.  (in version 2.0.0, 
    DBFetchNext fetched the record 2.  If your program requires
    the old behavior use DSSetBackwardCompatibility(200).
ATTR_DB_STMT_CACHE_SIZE           long
    Set the number of records the provider keeps in its in
    memory buffer and how many records the provider retrieves
    at one time.
ATTR_DB_STMT_CURSOR_TYPE          tDBCursorType       
    Sets the cursor type.  The cursor types are:
        DB_CURSOR_TYPE_DYNAMIC
            Additions, changes, and deletions by other users are
            visible, and all types of movement through the
            recordset are allowed.
        DB_CURSOR_TYPE_STATIC
            A static copy of a set of records Additions,     
            changes, or deletions by other users are not
            visible.
        DB_CURSOR_TYPE_FORWARD_ONLY
            Identical to a static cursor except that you can
            only scroll forward through records. This improves
            performance in situations when you only need to make
            a single pass through a recordset.
        DB_CURSOR_TYPE_KEYSET
            Like a dynamic cursor, except that you can't see
            records that other users add.  Records that
            other users delete are inaccessible from your
            recordset). Data changes by other users within
            records are still visible.
ATTR_DB_STMT_CURSOR_LOCATION      tDBCursorLoc
    Sets the cursor location.
       DB_CURSOR_LOC_SERVER
           Uses data provider or driver-supplied cursors. These
           cursors are sometimes very flexible and allow for
           some additional sensitivity to reflecting changes
           that others make to the actual data source. 
       DB_CURSOR_LOC_CLIENT
           Uses client-side cursors supplied by a local cursor
           library. Local cursor engines will often allow many
           features that driver-supplied cursors may not.
ATTR_DB_STMT_LOCK_TYPE            tDBLockType
    Sets the lock type.
       DB_LOCK_READ_ONLY
           You cannot alter the data.
       DB_LOCK_PESSIMISTIC
           The provider does what is necessary to ensure
           successful editing of the records, usually by locking
           records at the data source immediately upon editing.
       DB_LOCK_OPTIMISTIC
           The provider locks records only when you call
           DBUpateRecord.
       DB_LOCK_BATCH_OPTIMISTIC
           Required for batch updates.
ATTR_DB_STMT_MAX_RECORDS          long
    Sets the maximum number of records the provider returns from
    the data source.  If 0, the provider returns all records.
    Read only once a statement has been opened or executed.
ATTR_DB_STMT_MARSHAL_OPTIONS      tDBMarshalOpt
    Determines how modified data is written back to the server.
       DB_MARSHAL_OPT_ALL
           All records are written back to the server.
       DB_MARSHAL_OPT_MODIF_ONLY
           Only modified data is written back to the server.
ATTR_DB_STMT_BOOKMARK             Variant
    Moves to the record indicated by the bookmark.
ATTR_DB_STMT_COMMAND_TYPE         tDBCommandType
    Determines how the input text is interpreted.
        DB_COMMAND_UNKNOWN
            ADO attempts to determine the command type.
        DB_COMMAND_TEXT
            SQL statement or for some providers a command string
            in the provider's command language.
        DB_COMMAND_TABLE
            Table name.
        DB_COMMAND_STORED_PROC
            Call to a stored procedure.
ATTR_DB_STMT_COMMAND_TIMEOUT      long
    Time in seconds to wait for a command to execute.  If 0,
    wait forever.
ATTR_DB_STMT_PREPARED             long
    Whether the command to save a prepared (compiled) version
    of the statement to speed future executions of the 
    statement.  Applies to statements created with DBPrepareSQL.
ATTR_DB_STMT_ACTIVE_CONNECTION    String
    A string defining a connection.  The same as the connection
    string used for DBConnect.  Applies only to statements
    created with DBPrepareSQL.
ATTR_DB_STMT_NAME                 String
    The name of the command.  Applies only to statements created 
    with DBPrepareSQL.
ATTR_DB_STMT_FILTER               Variant
    Used to filter screen out records in a recordset.  The 
    variant can contain:
        a criteria string made up of individual clauses 
            connected by AND or OR.
        an array of bookmarks.
        a filter group value.
            DB_FILTER_NONE
                removes the current filter.
            DB_FILTER_PENDING
                only records that have changed but have not yet
                been sent to the server. Only applicable for
                batch update mode
            DB_FILTER_AFFECTED
                only records affected by the last DBDeleteRecord 
                or DBUpdateBatch.
            DB_FILTER_FETCHED
                records in the current cache.    *    Value for the parameter attribute.  The type of the value varies depending on the attribute.  Some providers do not support all attributes.  

Attribute                         Type
ATTR_DB_STMT_PAGE_SIZE            long
    Sets the number of records in a page.
ATTR_DB_STMT_ABSOLUTE_PAGE        long
    Move to the specified page.  Page numbers start at 1. 
ATTR_DB_STMT_ABSOLUTE_POSITION    long       
    Moves the to the specified record number.  Record numbers   
    start at 1.
ATTR_DB_STMT_CACHE_SIZE           long
    Set the number of records the provider keeps in its in
    memory buffer and how many records the provider retrieves
    at one time.
ATTR_DB_STMT_CURSOR_TYPE          tDBCursorType       
    Sets the cursor type.  The cursor types are:
        DB_CURSOR_TYPE_DYNAMIC
            Additions, changes, and deletions by other users are
            visible, and all types of movement through the
            recordset are allowed.
        DB_CURSOR_TYPE_STATIC
            A static copy of a set of records Additions,     
            changes, or deletions by other users are not
            visible.
        DB_CURSOR_TYPE_FORWARD_ONLY
            Identical to a static cursor except that you can
            only scroll forward through records. This improves
            performance in situations when you only need to make
            a single pass through a recordset.
        DB_CURSOR_TYPE_KEYSET
            Like a dynamic cursor, except that you can't see
            records that other users add.  Records that
            other users delete are inaccessible from your
            recordset). Data changes by other users within
            records are still visible.
ATTR_DB_STMT_CURSOR_LOCATION      tDBCursorLoc
    Sets the cursor location.
       DB_CURSOR_LOC_SERVER
           Uses data provider or driver-supplied cursors. These
           cursors are sometimes very flexible and allow for
           some additional sensitivity to reflecting changes
           that others make to the actual data source. 
       DB_CURSOR_LOC_CLIENT
           Uses client-side cursors supplied by a local cursor
           library. Local cursor engines will often allow many
           features that driver-supplied cursors may not.
ATTR_DB_STMT_LOCK_TYPE            tDBLockType
    Sets the lock type.
       DB_LOCK_READ_ONLY
           You cannot alter the data.
       DB_LOCK_PESSIMISTIC
           The provider does what is necessary to ensure
           successful editing of the records, usually by locking
           records at the data source immediately upon editing.
       DB_LOCK_OPTIMISTIC
           The provider locks records only when you call
           DBUpateRecord.
       DB_LOCK_BATCH_OPTIMISTIC
           Required for batch updates.
ATTR_DB_STMT_MAX_RECORDS          long
    Sets the maximum number of records the provider returns from
    the data source.  If 0, the provider returns all records.
    Read only once a statement has been opened or executed.
ATTR_DB_STMT_MARSHAL_OPTIONS      tDBMarshalOpt
    Determines how modified data is written back to the server.
       DB_MARSHAL_OPT_ALL
           All records are written back to the server.
       DB_MARSHAL_OPT_MODIF_ONLY
           Only modified data is written back to the server.
ATTR_DB_STMT_BOOKMARK             Variant
    Moves to the record indicated by the bookmark.
ATTR_DB_STMT_COMMAND_TYPE         tDBCommandType
    Determines how the input text is interpreted.
        DB_COMMAND_UNKNOWN
            ADO attempts to determine the command type.
        DB_COMMAND_TEXT
            SQL statement
        DB_COMMAND_TABLE
            Table name.
        DB_COMMAND_STORED_PROC
            Call to a stored procedure.
ATTR_DB_STMT_COMMAND_TIMEOUT      long
    Time in seconds to wait for a command to execute.  If 0,
    wait forever.
ATTR_DB_STMT_PREPARED             long
    Whether the command to save a prepared (compiled) version
    of the statement to speed future executions of the 
    statement.  Applies to statements created with DBPrepareSQL.
ATTR_DB_STMT_ACTIVE_CONNECTION    String
    A string defining a connection.  The same as the connection
    string used for DBConnect.  Applies only to statements
    created with DBPrepareSQL.
ATTR_DB_STMT_NAME                 String
    The name of the command.  Applies only to statements created 
    with DBPrepareSQL.
ATTR_DB_STMT_FILTER               Variant
    Used to filter screen out records in a recordset.  The 
    variant can contain:
        a criteria string made up of individual clauses 
            connected by AND or OR.
        an array of bookmarks.
        a filter group value.
            DB_FILTER_NONE
                removes the current filter.
            DB_FILTER_PENDING
                only records that have changed but have not yet
                been sent to the server. Only applicable for
                batch update mode
            DB_FILTER_AFFECTED
                only records affected by the last DBDeleteRecord 
                or DBUpdateBatch.
            DB_FILTER_FETCHED
                records in the current cache.
     �    Result code returned by DBSetStatmentAttribute.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   �/ *            Statement Handle                 �� ) � �      Attribute                        �� )>         Value                            ����         Result Code                                      WAbsolute Positon ATTR_DB_STMT_ABSOLUTE_POSITION Cache Size ATTR_DB_STMT_CACHE_SIZE Cursor Type ATTR_DB_STMT_CURSOR_TYPE Lock Type ATTR_DB_STMT_LOCK_TYPE Max Records ATTR_DB_STMT_MAX_RECORDS Absolute Page ATTR_DB_STMT_ABSOLUTE_PAGE Page Size ATTR_DB_STMT_PAGE_SIZE Cursor Location ATTR_DB_STMT_CURSOR_LOCATION Marshal Options ATTR_DB_STMT_MARSHAL_OPTIONS Bookmark ATTR_DB_STMT_BOOKMARK Command Type ATTR_DB_STMT_COMMAND_TYPE Command Timeout ATTR_DB_STMT_COMMAND_TIMEOUT Prepared ATTR_DB_STMT_PREPARED Active Connection ATTR_DB_STMT_ACTIVE_CONNECTION Name ATTR_DB_STMT_NAME Filter ATTR_DB_STMT_FILTER        	           	�    Obtains a SQL statement attribute.  You can get attributes for statements created with DBActivateSQL, DBActivateMap, DBNewSQLStatement or DBPrepareSQL.

Example:
    hstmt = DBNewSQLStatement (hdbc, "SELECT UUT_NUM, MEAS1, \
                               MEAS2 FROM TESTRES");
    /* set the cursor type */
    resCode = DBGetStatementAttribute(hstmt, 
        ATTR_DB_STMT_CURSOR_TYPE, &cursorType);
    ...
    resCode = DBOpenSQLStatement(hstmt);
    /* set the absolute position */
    resCode = DBGetStatementAttribute(hstmt, 
        ATTR_DB_STMT_ABSOLUTE_POSITION, &absPos);    
    ...
    resCode = DBCloseSQLStatement(hstmt);

Bookmark and Filter example:
    VARIANT vFilterArray;
    int filterIndex = 0;
    VARIANT bookmarks[2];
    
    /* It took your humble developer days to write tests  */
    /* for this attribute, so you're bloody well going to */
    /* get an example of how to use the stinking things   */
    hstmt = DBNewSQLStatement (hdbc, "SELECT UUT_NUM, MEAS1, \           
                                      MEAS2 FROM TESTRES");
    resCode = DBOpenSQLStatement(hstmt);

    /* criteria string example */
    /* note: it almost always much more efficient to use a */
    /* where clause in the SQL statement.                  */
    CA_VariantSetCString (&filter, "(MEAS1 > 1.0)");
    resCode = DBSetStatementAttribute(hstmt,
            ATTR_DB_STMT_FILTER, filter);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* only records where MEAS1 greater than 1.0 */
        ...
    }
    /* Filter constant example */
    CA_VariantSetLong (&filter, DB_FILTER_NONE);
    resCode = DBSetStatementAttribute(hstmt,
            ATTR_DB_STMT_FILTER, filter);
    i = 0;
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* will get all records */
        ...
        /* Get some bookmarks to use in next example */
        if ((i == 0) || (i == 2)) {
            resCode = DBGetStatementAttribute(hstmt,
                    ATTR_DB_STMT_BOOKMARK, 
                    &(bookmarks[filterIndex++]));
        i++;
        ...
    }

    /* Bookmark array example */
    CA_VariantSet1DArray (&vFilterArray, CAVT_VARIANT, 2,
                          bookmarks);
    resCode = DBSetStatementAttribute(hstmt,
        ATTR_DB_STMT_FILTER, vFilterArray);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* will only get records at the bookmarks we */
        /* grabbed in the previous example           */
        ...
    }
    resCode = DBCloseSQLStatement(hstmt);

     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
    !{    The attribute to get.  Some providers do not support all attributes.  

Attribute                         Type
ATTR_DB_STMT_PAGE_SIZE            long
    Returns the number of records in a page.
ATTR_DB_STMT_ABSOLUTE_PAGE        long
    Returns the current page.  Page numbers start at 1. 
ATTR_DB_STMT_ABSOLUTE_POSITION    long       
    Returns the absolut position of the current record.  Record
    numbers start at 1.
ATTR_DB_STMT_CACHE_SIZE           long
    Returns the number of records the provider keeps in its in
    memory buffer and how many records the provider retrieves
    at one time.
ATTR_DB_STMT_CURSOR_TYPE          tDBCursorType       
    Returns the cursor type.  The cursor types are:
        DB_CURSOR_TYPE_DYNAMIC
            Additions, changes, and deletions by other users are
            visible, and all types of movement through the
            recordset are allowed.
        DB_CURSOR_TYPE_STATIC
            A static copy of a set of records Additions,     
            changes, or deletions by other users are not
            visible.
        DB_CURSOR_TYPE_FORWARD_ONLY
            Identical to a static cursor except that you can
            only scroll forward through records. This improves
            performance in situations when you only need to make
            a single pass through a recordset.
        DB_CURSOR_TYPE_KEYSET
            Like a dynamic cursor, except that you can't see
            records that other users add.  Records that
            other users delete are inaccessible from your
            recordset). Data changes by other users within
            records are still visible.
ATTR_DB_STMT_CURSOR_LOCATION      tDBCursorLoc
    Returns the cursor location.
       DB_CURSOR_LOC_SERVER
           Uses data provider or driver-supplied cursors. These
           cursors are sometimes very flexible and allow for
           some additional sensitivity to reflecting changes
           that others make to the actual data source. 
       DB_CURSOR_LOC_CLIENT
           Uses client-side cursors supplied by a local cursor
           library. Local cursor engines will often allow many
           features that driver-supplied cursors may not.
ATTR_DB_STMT_LOCK_TYPE            tDBLockType
    Returns the lock type.
       DB_LOCK_READ_ONLY
           You cannot alter the data.
       DB_LOCK_PESSIMISTIC
           The provider does what is necessary to ensure
           successful editing of the records, usually by locking
           records at the data source immediately upon editing.
       DB_LOCK_OPTIMISTIC
           The provider locks records only when you call
           DBUpateRecord.
       DB_LOCK_BATCH_OPTIMISTIC
           Required for batch updates.
ATTR_DB_STMT_MAX_RECORDS          long
    Returns the maximum number of records the provider returns
    from the data source.  If 0, the provider returns all
    records.
ATTR_DB_STMT_MARSHAL_OPTIONS      tDBMarshalOpt
    Returns how modified data is written back to the server.
       DB_MARSHAL_OPT_ALL
           All records are written back to the server.
       DB_MARSHAL_OPT_MODIF_ONLY
           Only modified data is written back to the server.
ATTR_DB_STMT_BOOKMARK             Variant
    Returns a bookmark for the current record.
ATTR_DB_STMT_COMMAND_TYPE         tDBCommandType
    Returns how the input text is interpreted.
        DB_COMMAND_UNKNOWN
            ADO cannot determine the command type.
        DB_COMMAND_TEXT
            SQL statement
        DB_COMMAND_TABLE
            Table name.
        DB_COMMAND_STORED_PROC
            Call to a stored procedure.
ATTR_DB_STMT_COMMAND_TIMEOUT      long
    Time in seconds to wait for a command to execute.  If 0,
    wait forever.
ATTR_DB_STMT_PREPARED             long
    Whether the command to save a prepared (compiled) version
    of the statement to speed future executions of the 
    statement.  Applies to statements created with DBPrepareSQL.
ATTR_DB_STMT_ACTIVE_CONNECTION    String
    A string defining a connection.  The same as the connection
    string used for DBConnect.  Applies only to statements
    created with DBPrepareSQL.
ATTR_DB_STMT_NAME                 String
    The name of the command.  Applies only to statements created 
    with DBPrepareSQL.
ATTR_DB_STMT_FILTER               Variant
    Returns the current filter.  The variant can contain:
        a criteria string made up of individual clauses 
            connected by AND or OR.
        an array of bookmarks.
        a filter group value.
            DB_FILTER_NONE
                removes the current filter.
            DB_FILTER_PENDING
                only records that have changed but have not yet
                been sent to the server. Only applicable for
                batch update mode
            DB_FILTER_AFFECTED
                only records affected by the last DBDeleteRecord 
                or DBUpdateBatch.
            DB_FILTER_FETCHED
                records in the current cache.
ATTR_DB_STMT_PAGE_COUNT           long
    Returns the number of pages in the current recordset.  If
    -1, the provider does not support pages.
ATTR_DB_STMT_RECORD_COUNT         long
    Returns the number of records in the current recordset.  If
    -1, the provider cannot determine the number of records.
ATTR_DB_STMT_BOF                  long
    Returns whether the current record pointer is before the 
    begining of the recordset.
ATTR_DB_STMT_EOF                  long
    Returns whether the current record pointer is after the end 
    of the recordset.
ATTR_DB_STMT_EDIT_MODE            tDBEditMode  
    Returns the edit mode of the current record.
        DB_EDIT_MODE_NONE
            no edit in progress
        DB_EDIT_MODE_IN_PROGRESS
            the current record has been changed.
        DB_EDIT_MODE_ADD
            the current record is a new record.
        DB_EDIT_MODE_DELETE
            the current record has been deleted.
ATTR_DB_STMT_STATUS               long
    Returns the status of the current record with respect to
    batch updates or other bulk operations.  The status is the
    sum or one or more of the following tDBRecStatus values:
        DB_REC_STATUS_OK
           The record was successfully updated
        DB_REC_STATUS_NEW
           The record is new
        DB_REC_STATUS_MODIFIED
           The record was modified
        DB_REC_STATUS_DELETED
           The record was deleted
        DB_REC_STATUS_UNMODIFIED
           The record was unmodified
        DB_REC_STATUS_INVALID
           The record was not save because its bookmark is 
           invalid
        DB_REC_STATUS_MULTIPLE_CHANGES
           The record was not saved because it would have 
           affected multiple records
        DB_REC_STATUS_PENDING_CHANGES
           The record was not saved because it refers to a 
           pending insert.
        DB_REC_STATUS_CANCELED
           The record was not saved because the operation was
           cancelled
        DB_REC_STATUS_CANT_RELEASE
           The record was not save because of existing record
           locks.
        DB_REC_STATUS_CONCURRENCY_VIOLATION
           The record was not saved because optimistic 
           concurrency was in use.
        DB_REC_STATUS_INTEGRITY_VILOATION
           The record was not saved because the user violated
           integrity constraints
        DB_REC_STATUS_MAX_CHANGES_EXCEEDED
           The record was not saved because there were too many
           pending changes
        DB_REC_STATUS_OBJECT_OPEN 
           The record was not saved because of a conflict with
           an open storage object
        DB_REC_STATUS_OUT_OF_MEMORY
           The record was not saved because the computer has run
           out of memory
        DB_REC_STATUS_PERMISSION_DENIED
           The record was not saved because the user has
           insufficient permissions
        DB_REC_STATUS_SCHEMA_VIOLATION
           The record was not saved because it violates the
           structure of the underlying database.
        DB_REC_STATUS_DBDELETED
           The record has already been deleted from the data
           source.
ATTR_DB_STMT_STATE                tDBObjectState
    Returns whether the statment is open            
ATTR_DB_STMT_RECORDSET_OBJECT     CAObjHandle
    If the statement uses a recordset, the ActiveX object 
    handle of the recordset, otherwise 0.
ATTR_DB_STMT_COMMAND_OBJECT       CAObjHandle
    If the statement uses a command, the ActiveX object handle 
    of the command, otherwise 0.

    "�    Value for the parameter attribute.  The type of the value varies depending on the attribute.  Some providers do not support all attributes.  

To free the strings that this function returns use DBFree.  To
free any allocated memory within the variants this function returns use CA_VariantClear.  See the documentation for the CVI ActiveX Automation Library for more information about working with Variants.

Attribute                         Type
---------                         ----
ATTR_DB_STMT_PAGE_SIZE            long
    Returns the number of records in a page.
ATTR_DB_STMT_ABSOLUTE_PAGE        long
    Returns the current page.  Page numbers start at 1. 
ATTR_DB_STMT_ABSOLUTE_POSITION    long       
    Returns the absolut position of the current record.  Record
    numbers start at 1.
ATTR_DB_STMT_CACHE_SIZE           long
    Returns the number of records the provider keeps in its in
    memory buffer and how many records the provider retrieves
    at one time.
ATTR_DB_STMT_CURSOR_TYPE          tDBCursorType       
    Returns the cursor type.  The cursor types are:
        DB_CURSOR_TYPE_DYNAMIC
            Additions, changes, and deletions by other users are
            visible, and all types of movement through the
            recordset are allowed.
        DB_CURSOR_TYPE_STATIC
            A static copy of a set of records Additions,     
            changes, or deletions by other users are not
            visible.
        DB_CURSOR_TYPE_FORWARD_ONLY
            Identical to a static cursor except that you can
            only scroll forward through records. This improves
            performance in situations when you only need to make
            a single pass through a recordset.
        DB_CURSOR_TYPE_KEYSET
            Like a dynamic cursor, except that you can't see
            records that other users add.  Records that
            other users delete are inaccessible from your
            recordset). Data changes by other users within
            records are still visible.
ATTR_DB_STMT_CURSOR_LOCATION      tDBCursorLoc
    Returns the cursor location.
       DB_CURSOR_LOC_SERVER
           Uses data provider or driver-supplied cursors. These
           cursors are sometimes very flexible and allow for
           some additional sensitivity to reflecting changes
           that others make to the actual data source. 
       DB_CURSOR_LOC_CLIENT
           Uses client-side cursors supplied by a local cursor
           library. Local cursor engines will often allow many
           features that driver-supplied cursors may not.
ATTR_DB_STMT_LOCK_TYPE            tDBLockType
    Returns the lock type.
       DB_LOCK_READ_ONLY
           You cannot alter the data.
       DB_LOCK_PESSIMISTIC
           The provider does what is necessary to ensure
           successful editing of the records, usually by locking
           records at the data source immediately upon editing.
       DB_LOCK_OPTIMISTIC
           The provider locks records only when you call
           DBUpateRecord.
       DB_LOCK_BATCH_OPTIMISTIC
           Required for batch updates.
ATTR_DB_STMT_MAX_RECORDS          long
    Returns the maximum number of records the provider returns
    from the data source.  If 0, the provider returns all
    records.
ATTR_DB_STMT_MARSHAL_OPTIONS      tDBMarshalOpt
    Returns how modified data is written back to the server.
       DB_MARSHAL_OPT_ALL
           All records are written back to the server.
       DB_MARSHAL_OPT_MODIF_ONLY
           Only modified data is written back to the server.
ATTR_DB_STMT_BOOKMARK             Variant
    Returns a bookmark for the current record.
ATTR_DB_STMT_COMMAND_TYPE         tDBCommandType
    Returns how the input text is interpreted.
        DB_COMMAND_UNKNOWN
            ADO cannot determine the command type.
        DB_COMMAND_TEXT
            SQL statement
        DB_COMMAND_TABLE
            Table name.
        DB_COMMAND_STORED_PROC
            Call to a stored procedure.
ATTR_DB_STMT_COMMAND_TIMEOUT      long
    Time in seconds to wait for a command to execute.  If 0,
    wait forever.
ATTR_DB_STMT_PREPARED             long
    Whether the command to save a prepared (compiled) version
    of the statement to speed future executions of the 
    statement.  Applies to statements created with DBPrepareSQL.
ATTR_DB_STMT_ACTIVE_CONNECTION    String
    A string defining a connection.  The same as the connection
    string used for DBConnect.  Applies only to statements
    created with DBPrepareSQL.
ATTR_DB_STMT_NAME                 String
    The name of the command.  Applies only to statements created 
    with DBPrepareSQL.
ATTR_DB_STMT_FILTER               Variant
    Returns the current filter.  The variant can contain:
        a criteria string made up of individual clauses 
            connected by AND or OR.
        an array of bookmarks.
        a filter group value.
            DB_FILTER_NONE
                removes the current filter.
            DB_FILTER_PENDING
                only records that have changed but have not yet
                been sent to the server. Only applicable for
                batch update mode
            DB_FILTER_AFFECTED
                only records affected by the last DBDeleteRecord 
                or DBUpdateBatch.
            DB_FILTER_FETCHED
                records in the current cache.
ATTR_DB_STMT_PAGE_COUNT           long
    Returns the number of pages in the current recordset.  If
    -1, the provider does not support pages.
ATTR_DB_STMT_RECORD_COUNT         long
    Returns the number of records in the current recordset.  If
    -1, the provider cannot determine the number of records.
ATTR_DB_STMT_BOF                  long
    Returns whether the current record pointer is before the 
    begining of the recordset.
ATTR_DB_STMT_EOF                  long
    Returns whether the current record pointer is after the end 
    of the recordset.
ATTR_DB_STMT_EDIT_MODE            tDBEditMode  
    Returns the edit mode of the current record.
        DB_EDIT_MODE_NONE
            no edit in progress
        DB_EDIT_MODE_IN_PROGRESS
            the current record has been changed.
        DB_EDIT_MODE_ADD
            the current record is a new record.
        DB_EDIT_MODE_DELETE
            the current record has been deleted.
ATTR_DB_STMT_STATUS               long
    Returns the status of the current record with respect to
    batch updates or other bulk operations.  The status is the
    sum or one or more of the following tDBRecStatus values:
        DB_REC_STATUS_OK
           The record was successfully updated
        DB_REC_STATUS_NEW
           The record is new
        DB_REC_STATUS_MODIFIED
           The record was modified
        DB_REC_STATUS_DELETED
           The record was deleted
        DB_REC_STATUS_UNMODIFIED
           The record was unmodified
        DB_REC_STATUS_INVALID
           The record was not save because its bookmark is 
           invalid
        DB_REC_STATUS_MULTIPLE_CHANGES
           The record was not saved because it would have 
           affected multiple records
        DB_REC_STATUS_PENDING_CHANGES
           The record was not saved because it refers to a 
           pending insert.
        DB_REC_STATUS_CANCELED
           The record was not saved because the operation was
           cancelled
        DB_REC_STATUS_CANT_RELEASE
           The record was not save because of existing record
           locks.
        DB_REC_STATUS_CONCURRENCY_VIOLATION
           The record was not saved because optimistic 
           concurrency was in use.
        DB_REC_STATUS_INTEGRITY_VILOATION
           The record was not saved because the user violated
           integrity constraints
        DB_REC_STATUS_MAX_CHANGES_EXCEEDED
           The record was not saved because there were too many
           pending changes
        DB_REC_STATUS_OBJECT_OPEN 
           The record was not saved because of a conflict with
           an open storage object
        DB_REC_STATUS_OUT_OF_MEMORY
           The record was not saved because the computer has run
           out of memory
        DB_REC_STATUS_PERMISSION_DENIED
           The record was not saved because the user has
           insufficient permissions
        DB_REC_STATUS_SCHEMA_VIOLATION
           The record was not saved because it violates the
           structure of the underlying database.
        DB_REC_STATUS_DBDELETED
           The record has already been deleted from the data
           source.
ATTR_DB_STMT_STATE                tDBObjectState
    Returns whether the statment is open            
ATTR_DB_STMT_RECORDSET_OBJECT     CAObjHandle
    If the statement uses a recordset, the ActiveX object 
    handle of the recordset, otherwise 0.
ATTR_DB_STMT_COMMAND_OBJECT       CAObjHandle
    If the statement uses a command, the ActiveX object handle 
    of the command, otherwise 0.
     �    Result code returned by DBSetStatmentAttribute.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   �$ *            Statement Handle                 ȥ ) � �      Attribute                        �( )>         Value                            !���         Result Code                                      �Absolute Positon ATTR_DB_STMT_ABSOLUTE_POSITION Cache Size ATTR_DB_STMT_CACHE_SIZE Cursor Type ATTR_DB_STMT_CURSOR_TYPE Lock Type ATTR_DB_STMT_LOCK_TYPE Max Records ATTR_DB_STMT_MAX_RECORDS Absolute Page ATTR_DB_STMT_ABSOLUTE_PAGE Page Size ATTR_DB_STMT_PAGE_SIZE Cursor Location ATTR_DB_STMT_CURSOR_LOCATION Marshal Options ATTR_DB_STMT_MARSHAL_OPTIONS Bookmark ATTR_DB_STMT_BOOKMARK Command Type ATTR_DB_STMT_COMMAND_TYPE Command Timeout ATTR_DB_STMT_COMMAND_TIMEOUT Prepared ATTR_DB_STMT_PREPARED Active Connection ATTR_DB_STMT_ACTIVE_CONNECTION Name ATTR_DB_STMT_NAME Filter ATTR_DB_STMT_FILTER Recordset Object ATTR_DB_STMT_RECORDSET_OBJECT Command Object ATTR_DB_STMT_COMMAND_OBJECT    	            	           �    Open an SQL statement which was created with DBNewSQLStatement.

Example:
    hstmt = DBNewSQLStatement (hdbc, "SELECT UUT_NUM, MEAS1, \
                               MEAS2 FROM TESTRES");
    resCode = DBSetStatementAttribute(hstmt, 
                                      ATTR_DB_STMT_CURSOR_TYPE,
                                   DB_CURSOR_TYPE_FORWARD_ONLY);
    /* set other attributes */
    ...
    resCode = DBOpenSQLStatement(hstmt);
    ...
    resCode = DBCloseSQLStatement(hstmt);
     9    Handle to the SQL statement DBNewSQLStatement returned.     �    Result code returned by DBOpenSQLStatement.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   �             Statement Handle                 ����         Result Code                            	           Y    Move to the next set of results from a compound SQL statement
(for example, "SELECT * FROM table1;SELECT * FROM table2").
DBMoreResults removes all existing bindings, therefore you must establish bindings again after you use this function.

Most providers support compound select statements only in stored procedures.

Example:
    resCode = DBImmediateSQL(hdbc, "create proc sp_moreres \
            as SELECT * FROM TESTRES \
            SELECT * FROM MORERES");

    hstmt = DBNewSQLStatement (hdbc, "sp_moreres");
    resCode = DBSetStatementAttribute(hstmt, 
                                      ATTR_DB_STMT_COMMAND_TYPE, 
                                      DB_COMMAND_STORED_PROC);
    resCode = DBOpenSQLStatement(hstmt);
    /* bind the columns */
    DBBindColChar(hstmt, 1, serialNumLen, serialNum,
                  &serialNumStat, "");
    ...
    /* first set of values */
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        ...
    }
    resCode = DBMoreResults(hstmt);
    /* Bind the columns in the second record set, which    */
    /* may be different from those in the first record set */
    DBBindColInt(hstmt, 5, &numTries, &numTriesStat);
    ...
    /* second set of values */
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        ...
    }
    DBCloseSQLStatement(hstmt);
    DBDiscardSQLStatement(hstmt);

     \    Handle to the SQL statement returned by DBNewSQLStatement, DBPrepareSQL, or DBActivateSQL.     �    Result code returned by DBMoreResults.  This function returns the set of result codes listed in the function description for DBError.   �             Statement Handle                 ����         Result Code                            	           �    Return the records for the current statement as an array of VARIANT pointers.  DBGetVariantArray is faster, but more complicated to use than the DBFetch... or DBGetCol... functions.

Example:

    hstmt = DBActivateSQL (hdbc, "SELECT * FROM TESTRES");
    
    resCode = DBGetVariantArray(hstmt, &cArray, 
                                &numRecs, &numFields);
    for (i = 0; i < numRecs; i++) {
        for (j = 0; j < numFields; j++) {
            resCode = 
                DBGetVariantArrayValue(cArray, numRecs, 
                                       numFields, CAVT_CSTRING,
                                       i, j, &tempStr);
            if (resCode == DB_NULL_DATA) {
                /* handle null data */
            } else {
                /* Handle other data */
                DBFree(tempStr);
            }
        }
    }
    resCode = DBFreeVariantArray(cArray, 1, numRecs, numFields);

See Also:
    DBGetVariantArrayValue, DBGetVariantArrayColumn and DBClearVariantArray.     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     �    The array of variants containing the values of the records and fields requested.  

When you no longer need the array, use DBFreeVariantArray() to clear all the variants of the array and free the array.     3    The number of records/rows returned in the array.     5    The number of fields/columns returned in the array.     �    Result code returned by DBGetVariantArray.  This function returns the set of result codes listed in the function description for DBError.   � #            Statement Handle                  c j  �       Returned Array                   !7 j �         Records Returned                 !r j         Fields Returned                  !����         Result Code                            	            	            	            	           &    Returns the value at the  specified record and field numbers from the array returned by DBGetVariantArray and converts the value to the specified type.
Example:

    /* Execute a select statement */
    hstmt = DBActivateSQL (hdbc, "SELECT * FROM TESTRES");
    
    resCode = DBGetVariantArray(hstmt, &cArray, 
                                &numRecs, &numFields);
    for (i = 0; i < numRecs; i++) {
        for (j = 0; j < numFields; j++) {
            resCode = 
                DBGetVariantArrayValue(cArray, numRecs, 
                                       numFields, CAVT_CSTRING,
                                       i, j, &tempStr);
            if (resCode == DB_NULL_DATA) {
                /* handle null data */
                ...
            } else {
                /* Handle other data */
                ...
                DBFree(tempStr);
            }
        }
    }
    resCode = DBFreeVariantArray(cArray, 1,numRecs, numFields);

See Also:
    DBGetVariantArray, DBGetVariantArrayColumn and DBClearVariantArray

Known problems:

ADO 2.0 does not properly set variants which contain values of type CAVT_DECIMAL and the value is a multiple of 10.  There are two workarounds for this problem

Use a client side cursor. You must use DBNewSQLStatement instead of DBActivateSQL in order to use this workaround.
    hstmt = DBNewSQLStatement(hdbc, "select * from foo");
    TRY(DBSetStatementAttribute (hstmt,
                               ATTR_DB_STMT_CURSOR_LOCATION,
                               DB_CURSOR_LOC_CLIENT));
    TRY(DBOpenSQLStatement(hstmt));

Use the following function, SP_VariantConvertToType, instead of CA_VariantConvertToType to extract values from the variant.
    #ifndef VT_DECIMAL
    #define VT_DECIMAL 14
    #endif
    typedef struct tagDEC_FAKE {
        USHORT wReserved;
        union {
            struct {
                BYTE scale;
                BYTE sign;
            }s1;
            USHORT signscale;
        }n1;
        ULONG Hi32;
        union {
            struct {
                ULONG Lo32;
                ULONG Mid32;
            }n2;
            char Lo64[8];
        }n3;
    } MSVC_DECIMAL;
    typedef  struct tagVARIANT_FAKE VARIANT_FAKE;

    struct  tagVARIANT_FAKE {
        union         {
            struct  __tagVARIANT {
                VARTYPE vt;
                WORD wReserved1;
                WORD wReserved2;
                WORD wReserved3;
                union                 {
                      char dummy[8];
                } n1; 
            } n2;
            MSVC_DECIMAL decVal;
        } n3;
    };
    static HRESULT CVIFUNC SP_VariantConvertToType(
        VARIANT *variant, 
        unsigned cavt, 
        void *ptrToResult)
    {
        HRESULT firstStat;
        char msg[50];

        firstStat = CA_VariantConvertToType((VARIANT *)variant, 
                                             cavt,ptrToResult);
        if ((firstStat == -2147024809) 
            && (variant->vt == VT_DECIMAL)) {
            double value;
            HRESULT temp;
            char scale;
            VARIANT_FAKE* fakeVariant;
            fakeVariant = (VARIANT_FAKE *)variant;
            scale = fakeVariant->n3.decVal.n1.s1.scale;

            fakeVariant->n3.decVal.n1.s1.scale = 0;

            temp = CA_VariantConvertToType(variant, CAVT_DOUBLE, 
                                           &value);
            if (temp != DB_SUCCESS)
                return firstStat;
            while (scale) {
                if (scale > 0) {
                    value = value / 10;
                    scale--;
                } else {
                    value = value * 10;
                    scale++;
                }
            }
            temp = CA_VariantSetDouble(variant, value);
            if (temp != DB_SUCCESS)
                goto Error;
            temp = CA_VariantConvertToType(variant, cavt, 
                                           ptrToResult);
            if (temp != DB_SUCCESS)
                goto Error;
            return temp;
        }
        return firstStat;
    Error:
        return firstStat;
    }

     �    The array of variants containing the values of the records and fields requested.  

When you no longer need the array, use DBClearVariantArray() to clear all the members of the array at once.  Then use CA_FreeMemory() to free the array.     q    The number of records/rows in the array.  Use the records returned value from DBGetVariantArray for this value.     r    The number of fields/columns in the array.  Use the Fields returned value from DBGetVariantArray for this value.    8    The desired type of the returned value.  

    Type Constant          Value Type
    ------------------------------------------
    CAVT_LONG              long
    CAVT_SHORT             short
    CAVT_INT               int
    CAVT_BOOL              VBOOL
    CAVT_FLOAT             float
    CAVT_DOUBLE            double
    CAVT_CY                CURRENCY
    CAVT_DATE              DATE
    CAVT_CSTRING           char*
    CAVT_BSTR              BSTR
    CAVT_VARIANT           VARIANT
    CAVT_ERROR             SCODE
    CAVT_UCHAR             unsigned char
     =    The record/row number of the value.  The first record is 0.     >    The field/column number of the value.  The first field is 0.    �    The value at the specified record and field numbers converted to the requested type.

Pass the address of a variable large enough to hold the converted value.

If the type of the converted value is char* or BSTR. you must call the appropriate function to free the value when it is no longer needed.  

The functions are:

     char *        DBFree
     BSTR          SysFreeString  (a Windows SDK function) 

     �    Result code returned by DBGetVariantArrayValue.  This function returns the set of result codes listed in the function description for DBError.   3� )   �       Records Array                    4� ) �         Records in Array                 5 )9         Fields in Array                  5� `         Desired Type                     7� ` �         Record Number                    8 `:         Field Number                     8a �          Value                            :���         Result Code                     ���� � ���                                                                  �unsigned char CAVT_UCHAR short CAVT_SHORT long CAVT_LONG int CAVT_LONG float CAVT_FLOAT double CAVT_DOUBLE Currency CAVT_CY Date CAVT_DOUBLE BStr CAVT_BSTR Error CAVT_ERROR Bool CAVT_BOOL Variant CAVT_VARIANT C String CAVT_CSTRING            	            	            6See function help for a workaround for an ADO problem   �    Returns the value at the  specified record and field numbers from the array returned by DBGetVariantArray and converts the value to the specified type.

Note: if any record contains an SQL null value in the specified field, DBGetVariantArrayColumn stops processing records and returns DB_NULL_DATA immediately.

Example:

    double* column;

    hstmt = DBActivateSQL (hdbc, "SELECT * FROM TESTRES");
    
    resCode = DBGetVariantArray(hstmt, &cArray, 
                                &numRecs, &numFields);
    column = malloc(numRecs * sizeof(double));

    resCode = 
        DBGetVariantArrayColumn(cArray, numRecs, numFields, 
                                CAVT_DOUBLE, 1, 2, 3, column);
    if (resCode == DB_NULL_DATA) {
        printf("Cannot process, some fields contain null\n");
    } else {
        for(i = 0; i < 3; i++) {
           /* process values */
           /* Note: because the type of the values is not     */
           /* char*, or BSTR, you should not free the values. */
        }
    }
    resCode = DBFreeVariantArray(cArray, 1, numRecs, numFields);

    free(column);
    
    hstmt = DBDeactivateSQL (hstmt);

See Also:
    DBGetVariantArray, DBGetVariantArrayColumn and DBGetClearVariantArray.

Known problems:

ADO 2.0 does not properly set variants which contain values of type CAVT_DECIMAL and the value is a multiple of 10.  There are two workarounds for this problem

Use a client side cursor. You must use DBNewSQLStatement instead of DBActivateSQL in order to use this workaround.
    hstmt = DBNewSQLStatement(hdbc, "select * from foo");
    TRY(DBSetStatementAttribute (hstmt,
                               ATTR_DB_STMT_CURSOR_LOCATION,
                               DB_CURSOR_LOC_CLIENT));
    TRY(DBOpenSQLStatement(hstmt));

Use the following function, SP_VariantConvertToType, instead of CA_VariantConvertToType to extract values from the variant.
    #ifndef VT_DECIMAL
    #define VT_DECIMAL 14
    #endif
    typedef struct tagDEC_FAKE {
        USHORT wReserved;
        union {
            struct {
                BYTE scale;
                BYTE sign;
            }s1;
            USHORT signscale;
        }n1;
        ULONG Hi32;
        union {
            struct {
                ULONG Lo32;
                ULONG Mid32;
            }n2;
            char Lo64[8];
        }n3;
    } MSVC_DECIMAL;
    typedef  struct tagVARIANT_FAKE VARIANT_FAKE;

    struct  tagVARIANT_FAKE {
        union         {
            struct  __tagVARIANT {
                VARTYPE vt;
                WORD wReserved1;
                WORD wReserved2;
                WORD wReserved3;
                union                 {
                      char dummy[8];
                } n1; 
            } n2;
            MSVC_DECIMAL decVal;
        } n3;
    };
    static HRESULT CVIFUNC SP_VariantConvertToType(
        VARIANT *variant, 
        unsigned cavt, 
        void *ptrToResult)
    {
        HRESULT firstStat;
        char msg[50];

        firstStat = CA_VariantConvertToType((VARIANT *)variant, 
                                             cavt,ptrToResult);
        if ((firstStat == -2147024809) 
            && (variant->vt == VT_DECIMAL)) {
            double value;
            HRESULT temp;
            char scale;
            VARIANT_FAKE* fakeVariant;
            fakeVariant = (VARIANT_FAKE *)variant;
            scale = fakeVariant->n3.decVal.n1.s1.scale;

            fakeVariant->n3.decVal.n1.s1.scale = 0;

            temp = CA_VariantConvertToType(variant, CAVT_DOUBLE, 
                                           &value);
            if (temp != DB_SUCCESS)
                return firstStat;
            while (scale) {
                if (scale > 0) {
                    value = value / 10;
                    scale--;
                } else {
                    value = value * 10;
                    scale++;
                }
            }
            temp = CA_VariantSetDouble(variant, value);
            if (temp != DB_SUCCESS)
                goto Error;
            temp = CA_VariantConvertToType(variant, cavt, 
                                           ptrToResult);
            if (temp != DB_SUCCESS)
                goto Error;
            return temp;
        }
        return firstStat;
    Error:
        return firstStat;
    }

     �    The array of variants containing the values of the records and fields requested.  

When you no longer need the array, use DBClearVariantArray() to clear all the members of the array at once.  Then use CA_FreeMemory() to free the array.     q    The number of records/rows in the array.  Use the records returned value from DBGetVariantArray for this value.     r    The number of fields/columns in the array.  Use the Fields returned value from DBGetVariantArray for this value.    8    The desired type of the returned value.  

    Type Constant          Value Type
    ------------------------------------------
    CAVT_LONG              long
    CAVT_SHORT             short
    CAVT_INT               int
    CAVT_BOOL              VBOOL
    CAVT_FLOAT             float
    CAVT_DOUBLE            double
    CAVT_CY                CURRENCY
    CAVT_DATE              DATE
    CAVT_CSTRING           char*
    CAVT_BSTR              BSTR
    CAVT_VARIANT           VARIANT
    CAVT_ERROR             SCODE
    CAVT_UCHAR             unsigned char
     K    The field/column number to extract as a sub-array.  The first field is 0.     �    The first record/row number from which to extract the value for the specified field/column.  The first record in the array is number 0.     T    The number of records from which to extract values for the specified field/column.    �    Array of field values for the specified field converted to the specified type.

Pass the address of an aray large enough to hold the converted values.

If the type of the converted values is char* or BSTR you must call the appropriate function to free the values when they are no longer needed.  

The functions are:

     char *        DBFree
     BSTR          SysFreeString  (a Windows SDK function) 

        Result code returned by DBGetVariantArrayColumn.  This function returns the set of result codes listed in the function description for DBError.  If any of the records contain null in the specified field, no further records are process and the function returns DB_NULL_DATA.    N� )   �       Records Array                    O� ) �         Number of Records in Array       P3 )/         Number of Fields in Array        P� `         Desired Type                     R� ` �         Field Number                     S@ _/         First Record Number              S� _�          Number of Records to Get         T- �          Values Array                     U����         Result Code                     ���� � ���                                                                  �unsigned char CAVT_UCHAR short CAVT_SHORT long CAVT_LONG int CAVT_LONG float CAVT_FLOAT double CAVT_DOUBLE Currency CAVT_CY Date CAVT_DOUBLE BStr CAVT_BSTR Error CAVT_ERROR Bool CAVT_BOOL Variant CAVT_VARIANT C String CAVT_CSTRING        0        	            	            6See function help for a workaround for an ADO problem   �    Frees the variant array that DBGetVariantArray returned.

Example:

    /* Execute a select statement */
    hstmt = DBActivateSQL (hdbc, "SELECT * FROM TESTRES");
    
    resCode = DBGetVariantArray(hstmt, &cArray, 
                                &numRecs, &numFields);
    for (i = 0; i < numRecs; i++) {
        for (j = 0; j < numFields; j++) {
            resCode = 
                DBGetVariantArrayValue(cArray, numRecs, 
                                       numFields, CAVT_CSTRING,
                                       i, j, &tempStr);
            if (resCode == DB_NULL_DATA) {
                /* handle null data */
            } else {
                /* Handle other data */
                DBFree(tempStr);
            }
        }
    }
    resCode = DBFreeVariantArray(cArray, 1, numRecs, numFields);

See Also:
    DBGetVariantArray, DBGetVariantArrayValue, DBGetVariantArrayColumn.     2    The array of variants from DBGetVariantArray.  
     �    Result code returned by DBFreeVariantArray.  This function returns the set of result codes listed in the function description for DBError.     �    Specifies whether to free any memory allocated within the variants before freeing the array.  You must free the allocated memory in the variants to prevent memory leaks.       q    The number of records/rows in the array.  Use the Records Returned value from DBGetVariantArray for this value.     r    The number of fields/columns in the array.  Use the Fields Returned value from DBGetVariantArray for this value.   ]�    �       Records Array                    ^&���         Result Code                      ^�  �          Clear Member Variants            _o 
         Records in Array                 _� �         Fields in Array                        	           Clear 1 Don't Clear 0           )    Close a statement a statement opened with DBOpenSQLStatement or DBActivateSQL.  The statement still exists and can be reopened with DBOpenSQLStatement until it is discarded with DBDiscardSQLStatement.  Calling DBCloseSQLStatement and then DBDiscardSQLStatement is equivalent to calling DBDeactivateSQL.

DBCloseSQLStatement discards the variable bindings for the statement.  If you reopen the statement, you must create new variable bindings.


Example:
    hstmt = DBNewSQLStatement (hdbc, "SELECT UUT_NUM, MEAS1,\
                                      MEAS2 FROM TESTRES");
    resCode = DBSetStatementAttribute(hstmt,
                                      ATTR_DB_STMT_MAX_RECORDS,
                                      1);
    resCode = DBSetStatementAttribute(hstmt,
                                      ATTR_DB_STMT_CACHE_SIZE,
                                      10);
    resCode = DBOpenSQLStatement(hstmt);
    ...
    resCode = DBGetStatementAttribute(hstmt, 
                                      ATTR_DB_STMT_RECORD_COUNT,
                                      &recordCount
    ...
    resCode = DBCloseSQLStatement(hstmt);
    resCode = DBDiscardSQLStatement(hstmt);

See also:
    DBNewSQLStatement, DBOpenSQLStatement, 
    DBDiscardSQLStatement, DBSetStatementAttribute, 
    DBGetStatementAttribute.     M    Handle to the SQL statement returned by DBNewSQLStatement or DBActivateSQL.     �    Result code returned by DBCloseSQLStatement.  This function returns the set of result codes listed in the function description for DBError.   f�             Statement Handle                 g"���         Result Code                            	               Discards a statement that DBOpenSQLStatement or DBActivateSQL opened.  Calling DBCloseSQLStatement and then  DBDiscardSQLStatement is equivalent to calling DBDeactivateSQL.

Example:
    hstmt = DBNewSQLStatement (hdbc, "SELECT UUT_NUM, MEAS1,\
                                      MEAS2 FROM TESTRES");
    resCode = DBSetStatementAttribute(hstmt,
                                      ATTR_DB_STMT_MAX_RECORDS,
                                      1);
    resCode = DBSetStatementAttribute(hstmt,
                                      ATTR_DB_STMT_CACHE_SIZE,
                                      10);
    resCode = DBOpenSQLStatement(hstmt);
    ...
    resCode = DBGetStatementAttribute(hstmt, 
                                      ATTR_DB_STMT_RECORD_COUNT,
                                      &recordCount
    ...
    resCode = DBCloseSQLStatement(hstmt);
    resCode = DBDiscardSQLStatement(hstmt);

See also:
    DBNewSQLStatement, DBOpenSQLStatement, 
    DBDCloseSQLStatement, DBSetStatementAttribute, 
    DBGetStatementAttribute.     O    Handle to the SQL statement that DBNewSQLStatement or DBActivateSQL returned.     �    Result code returned by DBDiscardSQLStatement.  This function returns the set of result codes listed in the function description for DBError.   lR             Statement Handle                 l����         Result Code                            	           T    Prepares an SQL statement for execution.  DBPrepareSQL is required when the SQL statement contains parameters.

Input parameter example:
    hstmt = DBPrepareSQL (hdbc, "SELECT UUT_NUM, MEAS1, MEAS2 \
        FROM TESTRES WHERE MEAS1 > ?");
    resCode = DBCreateParamDouble(hstmt, "", 
                                  DB_PARAM_INPUT, 1.0);
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        ...
    }
    /* Since there are no output parameters, you do */
    /* not have to close the statment separately.   */
    hstmt = DBDeactivateSQL(hstmt);

Output parameter example:
    int inParam, outParam, retParam;
    ...
    /* This example works with Microsoft SQL Server */

    /* Remove stored procedure if it exist to       */
    /* preven an error when it is created.          */
    resCode = DBImmediateSQL(hdbc, "if exists (select * from \
            sysobjects where id = object_id('dbo.sp_CVITest')\
            and sysstat & 0xf = 4) drop procedure \
            dbo.sp_AdoTest");
    
    /* Create the stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_AdoTest( \
        @InParam int, @OutParam int OUTPUT ) as select 
        @OutParam = @InParam + 10 SELECT * FROM Authors \
        WHERE State <> 'CA' return @OutParam +10");

    /* Force the system to execute as a stored     */
    /* procedure rather than an SQL statement      */    
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);

    /* Prepare a statement which calls the stored procedure */
    hstmt = DBPrepareSQL (hdbc, "sp_CVItest");
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);

    /* Create the parameters, could also use DBRefreshParams */
    resCode = DBCreateParamInt(hstmt, "", 
                               DB_PARAM_RETURN_VALUE, -1);
    resCode = DBCreateParamInt(hstmt, "InParam", 
                               DB_PARAM_INPUT, 10);
    resCode = DBCreateParamShort(hstmt, "OutParam",
                                 DB_PARAM_OUTPUT, -1);

    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);

    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procedure */
    }

    /* you must close (but not deactivate) the statement */
    /* before examining output parameters.               */
    resCode = DBClosePreparedSQL(hstmt);

    /* Get the parameters. */
    resCode = DBGetParamInt(hstmt, 0, &retParam);
    resCode = DBGetParamInt(hstmt, 1, &inParam);
    resCode = DBGetParamInt(hstmt, 2, &outParam);
    printf("return param %d input param %d output param %d\n",
           retParam, inParam, outParam);
    /* discard the statement */
    hstmt = DBDiscarSQLStatement(hstmt);
     S    The handle to the database connection that DBConnect or DBNewConnection returned.     3    The stored procedure or SQL statement to prepare.    �    Returned handle to the statement execution.  This identifies the statement and is a parameter to other functions.  If less than or equal to 0, the statement could not be executed.

Note: prior to version 2.0, the SQL Toolkit always returned 0 on
error.  To minimize changes to programs that depend on this behavior,
set the compatility mode to version 1.1 with:
    DBSetBackwardCompatibility(110);
   y )            Connection Handle                yq * �         SQL Statement                    y�
���         Statement Handle                       ""    	           	�    Creates an integer parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  You cannot create parameters for statements executed with DBActivateSQL.

Input parameter example:
    hstmt = DBPrepareSQL (hdbc, "SELECT UUT_NUM, LOOPNUM MEAS1,\
            MEAS2 FROM REC1000 WHERE LOOPNUM > ?");
    resCode = DBCreateParamInt(hstmt, "", 
                               DB_PARAM_INPUT, 100);
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        ...
    }
    hstmt = DBDeactivateSQL(hstmt);

Output parameter example:
    /* This example works with Microsoft SQL Server */
    /* Create a stored procedure with input, output */
    /* and return value parameters                  */
    resCode = DBImmediateSQL(hdbc, "create proc sp_AdoTest( \ 
            @InParam int, @OutParam int OUTPUT ) as select \
            @OutParam =  @InParam + 10 SELECT * FROM Authors \
            WHERE State <> 'CA' return @OutParam +10");
    
    /* Set command type attribute to stored procedure */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);
    /* prepare the SQL statement */
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");
    /* set the command type attribute back to the default */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);

    /* Create the three parameters */    
    resCode = DBCreateParamInt(hstmt, "",
                               DB_PARAM_RETURN_VALUE, -1);
    resCode = DBCreateParamInt(hstmt, "InParam",
                               DB_PARAM_INPUT, 10);
    resCode = DBCreateParamInt(hstmt, "OutParam",
                               DB_PARAM_OUTPUT, -1);
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by stored procedure */
    }

    /* Close the statement.  The output parameters are */
    /* invalid until the statement is closed.          */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameters */
    resCode = DBGetParamInt(hstmt, 0, &retParam);
    resCode = DBGetParamInt(hstmt, 1, &inParam);
    resCode = DBGetParamInt(hstmt, 2, &outParam);

    hstmt = DBDeactivateSQL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBSetParamInt, DBGetParamInt and DBClosePreparedSQL.     p    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL.     V    The name of the parameter.  Use the empty string "" to create an unnamed parameter.
     K    Direction of the parameter: input, output, input/output or return value.
     *    Integer initial value for the parameter.     �    Result code returned by DBCreateParamInt.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   �� !            Statement Handle                 �Y ! �    �    Parameter Name                   �� V  � �    Parameter Direction              �
 V �          Initial Value                    �<���         Result Code                            ""              �DB_PARAM_INPUT DB_PARAM_INPUT DB_PARAM_OUTPUT DB_PARAM_OUTPUT DB_PARAM_INPUT_OUTPUT DB_PARAM_INPUT_OUTPUT DB_PARAM_RETURN_VALUE DB_PARAM_RETURN_VALUE        	           	�    Creates a short integer parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  You cannot create parameters for statements executed with DBActivateSQL.

Input parameter example:
    hstmt = DBPrepareSQL (hdbc, "SELECT UUT_NUM, LOOPNUM MEAS1,\
            MEAS2 FROM REC1000 WHERE LOOPNUM > ?");
    resCode = DBCreateParamShort(hstmt, "", 
                               DB_PARAM_INPUT, 100);
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        ...
    }
    hstmt = DBDeactivateSQL(hstmt);

Output parameter example:
    /* This example works with Microsoft SQL Server */
    /* Create a stored procedure with input, output */
    /* and return value parameters                  */
    resCode = DBImmediateSQL(hdbc, "create proc sp_AdoTest( \ 
            @InParam int, @OutParam int OUTPUT ) as select \
            @OutParam =  @InParam + 10 SELECT * FROM Authors \
            WHERE State <> 'CA' return @OutParam +10");
    
    /* Set command type attribute to stored procedure */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);
    /* prepare the SQL statement */
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");
    /* set the command type attribute back to the default */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);

    /* Create the three parameters */    
    resCode = DBCreateParamShort(hstmt, "",
                                 DB_PARAM_RETURN_VALUE, -1);
    resCode = DBCreateParamShort(hstmt, "InParam",
                                 DB_PARAM_INPUT, 10);
    resCode = DBCreateParamShort(hstmt, "OutParam",
                                 DB_PARAM_OUTPUT, -1);
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by stored procedure */
    }

    /* Close the statement.  The output parameters are */
    /* invalid until the statement is closed.          */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameters */
    resCode = DBGetParamShort(hstmt, 0, &retParam);
    resCode = DBGetParamShort(hstmt, 1, &inParam);
    resCode = DBGetParamShort(hstmt, 2, &outParam);

    hstmt = DBDeactivateSQL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBSetParamShort, DBGetParamShort and DBClosePreparedSQL.     p    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL.     V    The name of the parameter.  Use the empty string "" to create an unnamed parameter.
     K    Direction of the parameter: input, output, input/output or return value.
     m    Short integer value for the parameter.  For output and return value parameters, this value is overwritten.
     �    Result code returned by DBCreateParamShort.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   �� !            Statement Handle                 �L ! �    �    Parameter Name                   �� V  � �    Parameter Direction              �� V �         Value                            �r���         Result Code                            ""              �DB_PARAM_INPUT DB_PARAM_INPUT DB_PARAM_OUTPUT DB_PARAM_OUTPUT DB_PARAM_INPUT_OUTPUT DB_PARAM_INPUT_OUTPUT DB_PARAM_RETURN_VALUE DB_PARAM_RETURN_VALUE        	           
     Creates a floating-point parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  You cannot create parameters for statements executed with DBActivateSQL.

Input parameter example:
    hstmt = DBPrepareSQL (hdbc, "SELECT UUT_NUM, MEAS1,\
            MEAS2 FROM TESTRES WHERE MEAS1 > ?");
    resCode = DBCreateParamFloat(hstmt, "", 
                                 DB_PARAM_INPUT, 1.5);
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        ...
    }
    hstmt = DBDeactivateSQL(hstmt);

Output parameter example:
    /* This example works with Microsoft SQL Server */
    /* Create a stored procedure with input, output */
    /* and return value parameters                  */
    resCode = DBImmediateSQL(hdbc, "create proc sp_AdoTest( \ 
            @InParam float, @OutParam float OUTPUT ) as select \
            @OutParam =  @InParam + 10.1 SELECT * FROM Authors \
            WHERE State <> 'CA' return @OutParam + 10.1");
    
    /* Set command type attribute to stored procedure */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);
    /* prepare the SQL statement */
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");
    /* set the command type attribute back to the default */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);

    /* Create the three parameters */    
    resCode = DBCreateParamFloat(hstmt, "",
                                 DB_PARAM_RETURN_VALUE, -1);
    resCode = DBCreateParamFloat(hstmt, "InParam",
                                 DB_PARAM_INPUT, 10.1);
    resCode = DBCreateParamFloat(hstmt, "OutParam",
                                 DB_PARAM_OUTPUT, -1);
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by stored procedure */
    }

    /* Close the statement.  The output parameters are */
    /* invalid until the statement is closed.          */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameters */
    resCode = DBGetParamFloat(hstmt, 0, &retParam);
    resCode = DBGetParamFloat(hstmt, 1, &inParam);
    resCode = DBGetParamFloat(hstmt, 2, &outParam);

    hstmt = DBDeactivateSQL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBSetParamFloat, DBGetParamFloat and DBClosePreparedSQL.     p    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL.     V    The name of the parameter.  Use the empty string "" to create an unnamed parameter.
     K    Direction of the parameter: input, output, input/output or return value.
     1    Floatint-point initial value for the parameter.     �    Result code returned by DBCreateParamFloat.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   � !            Statement Handle                 �� ! �    �    Parameter Name                   �� V  � �    Parameter Direction              �9 V �         Initial Value                    �r���         Result Code                            ""               �DB_PARAM_INPUT DB_PARAM_INPUT DB_PARAM_OUTPUT DB_PARAM_OUTPUT DB_PARAM_INPUT_OUTPUT DB_PARAM_INPUT_OUTPUT DB_PARAM_RETURN_VALUE DB_PARAM_RETURN_VALUE        	           
D    Creates a double-precision parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  You cannot create parameters for statements executed with DBActivateSQL.

Input parameter example:
    hstmt = DBPrepareSQL (hdbc, "SELECT UUT_NUM, MEAS1,\
            MEAS2 FROM TESTRES WHERE MEAS1 > ?");
    resCode = DBCreateParamDouble(hstmt, "", 
                                 DB_PARAM_INPUT, 1.5);
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        ...
    }
    hstmt = DBDeactivateSQL(hstmt);

Output parameter example:
    /* This example works with Microsoft SQL Server */
    /* Create a stored procedure with input, output */
    /* and return value parameters                  */
    resCode = DBImmediateSQL(hdbc, "create proc sp_AdoTest( \ 
            @InParam float, @OutParam float OUTPUT ) as select \
            @OutParam =  @InParam + 10.1 SELECT * FROM Authors \
            WHERE State <> 'CA' return @OutParam + 10.1");
    
    /* Set command type attribute to stored procedure */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);
    /* prepare the SQL statement */
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");
    /* set the command type attribute back to the default */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);

    /* Create the three parameters */    
    resCode = DBCreateParamDouble(hstmt, "",
                                 DB_PARAM_RETURN_VALUE, -1);
    resCode = DBCreateParamDouble(hstmt, "InParam",
                                 DB_PARAM_INPUT, 10.1);
    resCode = DBCreateParamDouble(hstmt, "OutParam",
                                 DB_PARAM_OUTPUT, -1);
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by stored procedure */
    }

    /* Close the statement.  The output parameters are */
    /* invalid until the statement is closed.          */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameters */
    resCode = DBGetParamDouble(hstmt, 0, &retParam);
    resCode = DBGetParamDouble(hstmt, 1, &inParam);
    resCode = DBGetParamDouble(hstmt, 2, &outParam);

    hstmt = DBDeactivateSQL(hstmt);
    if (hstmt != DB_SUCCESS) {ShowError(); goto Error;}

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBSetParamDouble, DBGetParamDouble, and DBClosePreparedSQL.     p    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL.     V    The name of the parameter.  Use the empty string "" to create an unnamed parameter.
     K    Direction of the parameter: input, output, input/output or return value.
     3    Double-precision initial value for the parameter.     �    Result code returned by DBCreateParamDouble.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   �T !            Statement Handle                 �� ! �    �    Parameter Name                   �* V  � �    Parameter Direction              �} V �         Initial Value                    �����         Result Code                            ""               �DB_PARAM_INPUT DB_PARAM_INPUT DB_PARAM_OUTPUT DB_PARAM_OUTPUT DB_PARAM_INPUT_OUTPUT DB_PARAM_INPUT_OUTPUT DB_PARAM_RETURN_VALUE DB_PARAM_RETURN_VALUE        	           �    Creates a string parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  You cannot create parameters for statements executed with DBActivateSQL.

Input parameter example:
    char uut[10] = "yyd2860b1";
    ...
    hstmt = DBPrepareSQL (hdbc, "SELECT UUT_NUM, MEAS1,\
            MEAS2 FROM TESTRES WHERE UUT_NUM = ?");
    resCode = DBCreateParamChar(hstmt, "", 
                                 DB_PARAM_INPUT, 
                                "YYD2860b1", 10);
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        ...
    }
    hstmt = DBDeactivateSQL(hstmt);

Output parameter example:
    /* This example works with Microsoft SQL Server */
    char inParam[11] = "in";
    char readInParam[11];
    char outParam[11];
    char* retParam;
    ...
    /* Create the stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( \ 
           @InParam char(10), @OutParam char(10) OUTPUT ) as \
           select @OutParam = 'out' SELECT * FROM Authors \
           WHERE State <> 'CA' return 10.1");

    /* Set the command type attribute to stored procedure */    
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);

    /* Prepare a statement which calls the stored procedure */
    hstmt = DBPrepareSQL (hdbc, "sp_CVItest");

    /* Set the command type attribute back to the default */
    /* for future commands                                */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);

    /* Create the parameters */
    resCode = DBCreateParamChar(hstmt, "", 
                                DB_PARAM_RETURN_VALUE, 
                                inParam, 10);
    resCode = DBCreateParamChar(hstmt, "InParam", 
                                DB_PARAM_INPUT, "", 10);
    resCode = DBCreateParamChar(hstmt, "OutParam", 
                                DB_PARAM_OUTPUT, "", 10);

    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    if (resCode != DB_SUCCESS) {ShowError(); goto Error;}
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procedure */
    }
    
    /* Close the statement.  Output values are invalid */
    /* until the statement is closed                   */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameter values */
    resCode = DBGetParamChar(hstmt, 0, &retParam);
    resCode = DBGetParamCharBuffer(hstmt, 1, readInParam, 10);
    resCode = DBGetParamCharBuffer(hstmt, 2, outParam, 10);
    printf("return param %s input param %s output param %s\n",
           retParam, inParam, outParam);
    DBFree(retParam);

    /* Deactivate the statement */
    hstmt = DBDeactivateSQL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBSetParamChar, DBGetParamChar, DBGetParamCharBuffer and DBClosePreparedSQL.     p    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL.     V    The name of the parameter.  Use the empty string "" to create an unnamed parameter.
     K    Direction of the parameter: input, output, input/output or return value.
     )    String initial value for the parameter.     �    Result code returned by DBCreateParamChar.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.         Size of the value in bytes.   �@ !            Statement Handle                 �� ! �    �    Parameter Name                   � V  � �    Parameter Direction              �i V �         Initial Value                    �����         Result Code                      �g V}          Value Size in Bytes                    ""               �DB_PARAM_INPUT DB_PARAM_INPUT DB_PARAM_OUTPUT DB_PARAM_OUTPUT DB_PARAM_INPUT_OUTPUT DB_PARAM_INPUT_OUTPUT DB_PARAM_RETURN_VALUE DB_PARAM_RETURN_VALUE        	               ;    Creates abinary parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  You cannot create parameters for statements executed with DBActivateSQL.

Input parameter example:
    unsigned char data[10];

    /* Note that binaray data allows embedded NUL characters */
    data[0]='N';data[1]=0;data[2]='C';data[3]=0;
    data[4]='B';data[5]='I';data[6]='S';data[7]='O';
    data[8]='P';data[9]=0;
    ...
    hstmt = DBPrepareSQL (hdbc, "SELECT NAME, DRESS_SIZE,\
            FROM DEVGUYS WHERE NAME = ?");
    resCode = DBCreateParamChar(hstmt, "", DB_PARAM_INPUT, 
                                data, 10);
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        ...
    }
    hstmt = DBDeactivateSQL(hstmt);

Output parameter example:
    /* This example works with Microsoft SQL Server */
    unsigned char inParam[6] = "in";
    unsigned char readInParam[6];
    unsigned char *outParam;
    char* retParam;
    ...
    /* Create the stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( \ 
           @InParam binary(6), @OutParam binary(6) OUTPUT ) as \
           select @OutParam = @InParam SELECT * FROM Authors \
           WHERE State <> 'CA' return 10.1");

    /* Set the command type attribute to stored procedure */    
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);

    /* Prepare a statement which calls the stored procedure */
    hstmt = DBPrepareSQL (hdbc, "sp_CVItest");

    /* Set the command type attribute back to the default */
    /* for future commands                                */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);

    /* Put some data in the input variable          */
    /* note that using binary allows embedded nulls */
    inParam[0]='N';inParam[1]='C';inParam[2]='B';
    inParam[3]='\0'; inParam[4]='O';inParam[5]='K';
    outParam = malloc(6);
    /* Create the parameters */
    resCode = DBCreateParamChar(hstmt, "", 
                                DB_PARAM_RETURN_VALUE, 
                                retParam, 6);
    resCode = DBCreateParamBinary(hstmt, "InParam", 
                                DB_PARAM_INPUT, "", 6);
    resCode = DBCreateParamBinary(hstmt, "OutParam", 
                                DB_PARAM_OUTPUT, "", 6);

    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    if (resCode != DB_SUCCESS) {ShowError(); goto Error;}
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procedure */
    }
    
    /* Close the statement.  Output values are invalid */
    /* until the statement is closed                   */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameter values */
    resCode = DBGetParamChar(hstmt, 0, &retParam);
    resCode = DBGetParamBinaryBuffer(hstmt, 1, readInParam, 6);
    resCode = DBGetParamBinary(hstmt, 2, (void **)&(outParam));
    DBFree(retParam);
    DBFree(outParam);

    /* Deactivate the statement */
    hstmt = DBDeactivateSQL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBSetParamBinary, DBGetParamBinary, DBGetParamBinaryBuffer and DBClosePreparedSQL.
     p    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL.     V    The name of the parameter.  Use the empty string "" to create an unnamed parameter.
     K    Direction of the parameter: input, output, input/output or return value.
     )    Binary initial value for the parameter.     �    Result code returned by DBCreateParamBinary.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.         Size of the value in bytes.   �� !            Statement Handle                 �H ! �    �    Parameter Name                   Ҧ V  � �    Parameter Direction              �� V �         Initial Value                    �*���         Result Code                      �� V|          Value Size in Bytes                    ""               �DB_PARAM_INPUT DB_PARAM_INPUT DB_PARAM_OUTPUT DB_PARAM_OUTPUT DB_PARAM_INPUT_OUTPUT DB_PARAM_INPUT_OUTPUT DB_PARAM_RETURN_VALUE DB_PARAM_RETURN_VALUE        	               �    Set the value of a parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  Typically you need DBSetParamInt only when you use DBRefreshParams.

Example:
    /* Create a stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( 
            @InParam int, @OutParam int OUTPUT ) as  \
            select @OutParam = @InParam + 10 SELECT * FROM \
            Authors WHERE State <> 'CA' return @OutParam +10");
    
    /* Prepare a statement which calls the stored procedure */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);
    
    /* Refresh the parameters from the stored procedure.    */
    resCode = DBRefreshParams(hstmt);
    
    /* Set the input parameter */
    resCode = DBSetParamInt(hstmt, 1, 10);
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procdure */
    }
    
    /* Close the statement.  Output parameters are invalid */
    /* until the statement is closed                       */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameter values */
    resCode = DBGetParamInt(hstmt, 0, &retParam);
    resCode = DBGetParamInt(hstmt, 1, &inParam);
    resCode = DBGetParamInt(hstmt, 2, &outParam);

    /* Discard the statement */
    hstmt = DBDiscardSQLStatementL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL DBGetParamInt, and DBClosePreparedSQL.     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL, DBActivateMap or DBNewSQLStatement.     �    Result code returned by DBSetParamInt.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.         The index of the parameter.     "    Integer value for the parameter.   � !            Statement Handle                 ݯ���         Result Code                      �x ! �          Index                            ޝ !2          Value                                  	            1       �    Set the value of a parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  Typically, you need DBSetParamShort only you use DBRefreshParams.

Example:
    /* Create a stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( 
            @InParam int, @OutParam int OUTPUT ) as  \
            select @OutParam = @InParam + 10 SELECT * FROM \
            Authors WHERE State <> 'CA' return @OutParam +10");
    
    /* Prepare a statement which calls the stored procedure */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);
    
    /* Refresh the parameters from the stored procedure.    */
    resCode = DBRefreshParams(hstmt);
    
    /* Set the input parameter */
    resCode = DBSetParamShort(hstmt, 1, 10);
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procdure */
    }
    
    /* Close the statement.  Output parameters are invalid */
    /* until the statement is closed                       */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameter values */
    resCode = DBGetParamShort(hstmt, 0, &retParam);
    resCode = DBGetParamShort(hstmt, 1, &inParam);
    resCode = DBGetParamShort(hstmt, 2, &outParam);

    /* Discard the statement */
    hstmt = DBDiscardSQLStatement(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBGetParamShort and DBClosePreparedSQL.     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL, DBActivateMap or DBNewSQLStatement.     �    Result code returned by DBSetParamShort.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.         The index of the parameter.     (    Short integer value for the parameter.   � !            Statement Handle                 �K���         Result Code                      � ! �          Index                            �; !2         Value                                  	            1       u    Set the value of a parameter for a stored procedure or SQL statement that you prepared with DBPrepareSQL.  Typically, you  need DBSetParamFloat only when you use DBRefreshParams.

Example:
    /* Create a stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( 
            @InParam float, @OutParam float OUTPUT ) as  \
            select @OutParam = @InParam + 10.1 SELECT * FROM \
            Authors WHERE State <> 'CA' return @OutParam \
            +10.1");

    /* Set the command type attribute to stored procedure */    
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);

    /* Prepare a statement which calls the stored procedure */
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");

    /* Set command type back to the default */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);
    
    /* Refresh the parameters from the stored procedure.    */
    resCode = DBRefreshParams(hstmt);
    
    /* Set the input parameter */
    resCode = DBSetParamFloat(hstmt, 1, 10.5);
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procdure */
    }
    
    /* Close the statement.  Output parameters are invalid */
    /* until the statement is closed                       */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameter values */
    resCode = DBGetParamFloat(hstmt, 0, &retParam);
    resCode = DBGetParamFloat(hstmt, 1, &inParam);
    resCode = DBGetParamFloat(hstmt, 2, &outParam);

    /* Discard the statement */
    hstmt = DBDiscardSQLStatement(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL,  DBGetParamFloat and DBClosePreparedSQL.     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL, DBActivateMap or DBNewSQLStatement.     �    Result code returned by DBSetParamFloat.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.         The index of the parameter.     )    Floating-point value for the parameter.   �� !            Statement Handle                 �q���         Result Code                      �< ! �          Index                            �a !2         Value                                  	            1       �    Set the value of a parameter for a stored procedure or SQL statement that you prepared with DBPrepareSQL.  DBSetParamShort is typically only needed when you use DBRefreshParams.

Example:
    /* Create a stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( 
            @InParam float, @OutParam float OUTPUT ) as  \
            select @OutParam = @InParam + 10.1 SELECT * FROM \
            Authors WHERE State <> 'CA' return @OutParam \
            +10.1");

    /* Set the command type attribute to stored procedure */    
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);

    /* Prepare a statement which calls the stored procedure */
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");

    /* Set command type back to the default */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);
    
    /* Refresh the parameters from the stored procedure.    */
    resCode = DBRefreshParams(hstmt);
    
    /* Set the input parameter */
    resCode = DBSetParamDouble(hstmt, 1, 10.5);
    if (resCode != DB_SUCCESS) {ShowError(); goto Error;}
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    if (resCode != DB_SUCCESS) {ShowError(); goto Error;}
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procdure */
    }
    
    /* Close the statement.  Output parameters are invalid */
    /* until the statement is closed                       */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameter values */
    resCode = DBGetParamDouble(hstmt, 0, &retParam);
    resCode = DBGetParamDouble(hstmt, 1, &inParam);
    resCode = DBGetParamDouble(hstmt, 2, &outParam);

    /* Discard the statement */
    hstmt = DBDiscardSQLStatement(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBGetParamDouble and DBClosePreparedSQL.     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL, DBActivateMap or DBNewSQLStatement.     �    Result code returned by DBSetParamDouble.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.         The index of the parameter.     +    Double-precision value for the parameter.   �s !            Statement Handle                 ����         Result Code                      �� ! �          Index                            �  !2         Value                                  	            1       �    Set the value of a parameter for a stored procedure or SQL statement that you prepared with DBPrepareSQL.  Typically, you need DBSetParamChar only when you use DBRefreshParams.

Example:
    hstmt = DBPrepareSQL (hdbc, "SELECT UUT_NUM, MEAS1,\
            MEAS2 FROM TESTRES WHERE UUT_NUM = ?");
    resCode = DBRefreshParams(hstmt);
    resCode = DBSetParamChar(hstmt, 1, "yyd2860b1");
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        ...
    }
    hstmt = DBDeactivateSQL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBGetParamChar, DBGetParamCharBuffer, DBClosePreparedSQL     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL, DBActivateMap, or DBNewSQLStatement.     �    Result code returned by DBSetParamChar.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.         The index of the parameter.     !    String value for the parameter.    �    Format string.  Use the empty string "" if you want ADO to supply the formatting based on the Windows control panel settings.

Date formats support the following symbols

Symbol    Description
------    -----------
m         Month�s number suppress leading zero
mm        Month�s number with leading zero if applicable
mmm       Month�s three letter abbreviation, lowercase
Mmm       Month�s three letter abbreviation, initial cap
MMM       Month�s three letter abbreviation, upper case
mmmm      Month�s full name, lowercase
Mmmm      Month�s full name, initial cap
MMMM      Month�s full name, upper case
d         Day of the month�s number, suppress leading zero
dd        Day of the month�s number, include leading zero
ddd       Day of the month�s three letter abbreviation, 
          lowercase
Ddd       Day of the month�s three letter abbreviation, initial     
          cap
DDD       Day of the month�s three letter abbreviation, upper 
          case
dddd      Day of the month�s full name, lower case
Dddd      Day of the month�s full name, initial cap
DDDD      Day of the month�s full name, upper case
yy        Last two digits of year
yyyy      Four digit year
h         Hour of the day, suppress leading zero 
          (use am/pm symbol for 12 hour style)
hh        Hour of the day, include leading zero 
          (use am/pm symbol for 12 hour style)
i (or m)  Minute of the hour, suppress leading zero
ii (or mm)Minute of the hour, include leading zero
s         Second of the minute, suppress leading zero
ss        Second of the minute, include leading zero
ss.ssssss Second of the minute with fractional seconds, (use up
          to six �s� symbols after the decimal point)        am/pm     "am" or "pm" string, lower case (forces 12 hour clock)
a/p       "a" or "p" string.  (forces 12 hour clock)
AM/PM     "AM" or "PM" string, upper case (forces 12 hour clock)
A/P       "A" or "P" string, upper case (forces 12 hour clock)
J         Julian value for date/time.
/ - . : , Output the character
<space>   Output a space character
\<char>   Output the character following the �\� character
"<text>"  Output the text
�<text>�  Output the string
GD        Windows Short Date Format (Do not combine other format
          symbols with GD except "[US]"
GDT       Windows Short Date Format + Time Format Do not combine
          with other format symbols except "[US]")
GL        Windows Long Date Format. (Do not combine other format 
          symbols with GL except "[US]")
GLT       Windows Long Date Format + Time Format (Do not combine
          other format symbols with GLT except "[US]")
GT        Windows Time Format (Do not combine any other format
          symbols with GT)
[US]      The information in the International section of the 
          Windows control panel is ignored, instead the United
          States defaults are substituted.

Numeric Format Strings allow you to format numbers in a variety of ways. Numeric formats can have one section or two sections separated by a semicolon. Formats with one section use the same format for positive and negative numbers. Formats with two sections use the second section as the format for negative numbers. 

Number formats support the following symbols

Symbol    Description
------    -----------
$         Output the Windows currency string
.         Output the Windows decimal point character 
,         Output the Windows thousands separator character 
#         Output a digit. If there is no digit to output in the 
          position output nothing.
0         Output a digit, If there is no digit to output in the 
          position output a zero
?         Output a digit, If there is no digit to output in the 
          position output a space
%         Output the value as a percent. The value is multiplied            
          by 100 and the �%� character is output.
e+        Output in scientific notation, show exponent sign only 
          if negative
e-        Output in scientific notation, always show sign of 
          exponent
E+ E-     Upper case analogs of e+ and e-
- + ( ) , Output the character
<space>   Output a space character
\<char>   Output the character following the �\� character
"<text>"  Output the text
�<text>�  Output the text
GN        Windows General Number Format (Note you can only 
          combine GN with symbols which are enclosed in 
          brackets such as "[US]"
GF        Windows General Fixed Format for numbers (Note
          you can only combine GF with symbols which are 
          enclosed in brackets such as "[US]")
GC        Windows General Currency Format for numbers (Note you 
          can only combine GC with symbols which are enclosed 
          in brackets such as "[US]"
[S/n]     Scale (divide) the number by a power of 10 before 
          output.
[S*n]     Scale (multiply) the number by a power of 10 before 
          output. 
[US]      The information in the International section of the 
          Windows control panel is ignored, instead the United
          States defaults are substituted.
    � !            Statement Handle                 c���         Result Code                      - ! �          Index                            R !(         Value                            { !�         Format String                          	            1    ""    ""   <    Set the value of a parameter for a stored procedure or SQL statement that you prepared with DBPrepareSQL.  Typically, you need DBSetParamBinary only when you use DBRefreshParams.

Example:
    unsigned char data[10];

    data[0]='I';data[1]=0;data[2]='h';data[3]='a';data[4]='t';
    data[5]='e';data[6]=0;data[7]='A';data[8]='D';data[9]='O';
    hstmt = DBPrepareSQL (hdbc, "SELECT BUMMER, MEAS1,\
            MEAS2 FROM TESTRES WHERE BUMMER = ?");
    resCode = DBRefreshParams(hstmt);
    resCode = DBSetParamBinary(hstmt, 1, data, 10);
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        ...
    }
    hstmt = DBDeactivateSQL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBGetParamBinary, DBGetParamBinaryBuffer, DBClosePreparedSQL     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL, DBActivateMap or DBNewSQLStatement.     �    Result code returned by DBSetParamBinary.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.         The index of the parameter.     !    Binary value for the parameter.     +    The size of the binary variable in bytes.   � !            Statement Handle                 V���         Result Code                      " ! �          Index                            G !2         Value                            p !�          Size in Bytes                          	            1           S    Set the value of a parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  Variants allow for more types than the traditional integer, short, float, double and string.

Example:
    /* Create a stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( 
            @InParam float, @OutParam float OUTPUT ) as  \
            select @OutParam = @InParam + 10.1 SELECT * FROM \
            Authors WHERE State <> 'CA' return @OutParam \
            +10.1");

    /* Set the command type attribute to stored procedure */    
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);

    /* Prepare a statement which calls the stored procedure */
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");

    /* Set command type back to the default */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);
    
    /* Refresh the parameters from the stored procedure.    */
    resCode = DBRefreshParams(hstmt);
    
    /* Set the input parameter */
    CA_VariantSetInt (&inParamV, 10);
    resCode = DBSetParamVariant(hstmt, 2, inParamV);
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    ...    
    /* Close the statement.  Output parameters are invalid */
    /* until the statement is closed                       */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameter values */
    resCode = DBGetParamVariant(hstmt, 0, &retParamV);
    resCode = DBGetParamVariant(hstmt, 1, &inParamV);
    resCode = DBGetParamVariant(hstmt, 2, &outParamV);

    /* Discard the statement */
    hstmt = DBDiscardSQLStatement(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL,  DBGetParamFloat and DBClosePreparedSQL.

     p    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL.     �    Result code returned by DBSetParamVariant.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.         The index of the parameter.     1    Variant containing the value for the parameter.   %$ !            Statement Handle                 %����         Result Code                      &i ! �          Index                            &� !2 �       Value                                  	            1       ~    Executes a stored procedure or SQL statement that you have prepared with DBPrepareSQL.

Example:
    /* Create a stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( 
            @InParam int, @OutParam int OUTPUT ) as  \
            select @OutParam = @InParam + 10 SELECT * FROM \
            Authors WHERE State <> 'CA' return @OutParam +10");
    
    /* Prepare a statement which calls the stored procedure */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);
    
    /* Refresh the parameters from the stored procedure.    */
    resCode = DBRefreshParams(hstmt);
    
    /* Set the input parameter */
    resCode = DBSetParamShort(hstmt, 1, 10);
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procdure */
    }
    
    /* Close the statement.  Output parameters are invalid */
    /* until the statement is closed                       */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameter values */
    resCode = DBGetParamShort(hstmt, 0, &retParam);
    resCode = DBGetParamShort(hstmt, 1, &inParam);
    resCode = DBGetParamShort(hstmt, 2, &outParam);

    /* Discard the statement */
    hstmt = DBDiscardSQLStatement(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBClosePreparedSQL, DBDiscardSQLStatement     9    Handle to the SQL statement that DBPrepareSQL returned.     �    the statement execution handle that identifies the statement and is a parameter to other functions.  If less than or equal to 0, the toolkit was not able to execute the statement.
   .:             Statement Handle                 .{���         Result Code                            	                Set a parameter attribute.

Example:
    /* This example works with Microsoft SQL server */
    /* Drop the stored procedure if it already exists */
    resCode = DBImmediateSQL(hdbc, "if exists (select * \
        from sysobjects where id = object_id('dbo.sp_AdoTest')\
        and sysstat & 0xf = 4) drop procedure dbo.sp_AdoTest");
    
    /* Create the stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_AdoTest( \
        @InParam float, @OutParam float OUTPUT ) as select \
        @OutParam = @InParam + 1.5 SELECT * FROM Authors \
        WHERE State <> 'CA' return @OutParam +1.7");
    
    /* Prepare a statement which calls the stored procedure */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE, 
        DB_COMMAND_STORED_PROC);
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");

    /* Create the paramters */ 
    resCode = DBCreateParamDouble(hstmt, "", 
                                  DB_PARAM_RETURN_VALUE, -1);
    resCode = DBCreateParamDouble(hstmt, "",
                                  DB_PARAM_INPUT_OUTPUT, 10);
    resCode = DBCreateParamDouble(hstmt, "OutParam",
                                  DB_PARAM_OUTPUT, -1);

    /* Modify the second parameter */
    resCode = DBSetParamAttribute (hstmt, 2
                                   DB_PARAM_ATTR_DIRECTION,
                                   DB_PARAM_INPUT);
    resCode = DBSetParamAttribute (hstmt, 2,
                                   DB_PARAM_ATTR_VALUE, 
                                   CA_VariantDouble (42.42));

    /* Execute the prepared statement */
    resCode = DBExecutePreparedSQL(hstmt);
    /* Close the statement.  The statement must be closed */
    /* before you can examine the output parameters       */
    resCode = DBClosePreparedSQL(hstmt);
     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL, DBActivateMap or DBNewSQLStatement.     :    Index of the parameter.  The first parameter index is 1.        Attribute to set.

Attribute                    Type       Description
ATTR_DB_PARAM_VALUE          VARIANT    Value of parameter.
ATTR_DB_PARAM_DIRECTION      long       Direction of parameter
                                        DB_PARAM_INPUT
                                        DB_PARAM_OUTPUT
                                        DB_PARAM_INPUT_OUTPUT
                                        DB_PARAM_RETURN_VALUE
                                        DB_PARAM_UNKNOWN
 * Note: Some providers cannot determine the direction of 
         parameterss to stored procedures. You cannot rely on
         DBRefreshParams in such cases.
ATTR_DB_PARAM_PRECISION      byte       Total number of digits.
ATTR_DB_PARAM_NUMERIC_SCALE  byte       Number of digits to 
                                        the right of decimal.
ATTR_DB_PARAM_SIZE                      Max size in bytes.
ATTR_DB_PARAM_ATTRIBUTES     long       The sum of zero or more
                                        of the following values:
                                        DB_PARAM_SIGNED
                                        DB_PARAM_NULLABLE
                                        DB_PARAM_LONG
ATTR_DB_PARAM_TYPE           long       Type of parameter
                                        DB_EMPTY
                                        DB_TINYINT
                                        DB_SMALLINT
                                        DB_INTEGER
                                        DB_BIGINT
                                        DB_UNSIGNEDTINYINT
                                        DB_UNSIGNEDSMALLINT
                                        DB_UNSIGNEDINT
                                        DB_UNSIGNEDBIGINT
                                        DB_FLOAT
                                        DB_DOUBLEPRECISION 
                                        DB_CURRENCY
                                        DB_DECIMAL
                                        DB_NUMERIC
                                        DB_BOOLEAN
                                        DB_ERROR
                                        DB_USERDEFINED
                                        DB_VARIANT
                                        DB_IDDISPATCH
                                        DB_IUNKNOWN
                                        DB_GUID
                                        DB_DATE
                                        DB_DBDATE
                                        DB_DBTIME
                                        DB_DATETIME
                                        DB_BSTR
                                        DB_CHAR
                                        DB_VARCHAR
                                        DB_LONGVARCHAR
                                        DB_WCHAR
                                        DB_VARWCHAR
                                        DB_LONGVARWCHAR
                                        DB_BINARY
                                        DB_VARBINARY
                                        DB_LONGVARBINARY
    K    Value for the parameter attribute.  The type of the value varies depending on the attribute.

Attribute                    Type       Description
ATTR_DB_PARAM_VALUE          VARIANT    Value of parameter.
ATTR_DB_PARAM_DIRECTION      long       Direction of parameter
                                        DB_PARAM_INPUT
                                        DB_PARAM_OUTPUT
                                        DB_PARAM_INPUT_OUTPUT
                                        DB_PARAM_RETURN_VALUE
                                        DB_PARAM_UNKNOWN
 * Note: Some providers cannot determine the direction of 
         params to stored procedures. You cannot rely on
         DBRefreshParams in such cases.
ATTR_DB_PARAM_PRECISION      byte       Total number of digits.
ATTR_DB_PARAM_NUMERIC_SCALE  byte       Number of digits to 
                                        the right of decimal.
ATTR_DB_PARAM_SIZE                      Max size in bytes.
ATTR_DB_PARAM_ATTRIBUTES     long       The sum of zero or more
                                        of the following values:
                                        DB_PARAM_SIGNED
                                        DB_PARAM_NULLABLE
                                        DB_PARAM_LONG
ATTR_DB_PARAM_TYPE           long       Type of parameter
                                        DB_EMPTY
                                        DB_TINYINT
                                        DB_SMALLINT
                                        DB_INTEGER
                                        DB_BIGINT
                                        DB_UNSIGNEDTINYINT
                                        DB_UNSIGNEDSMALLINT
                                        DB_UNSIGNEDINT
                                        DB_UNSIGNEDBIGINT
                                        DB_FLOAT
                                        DB_DOUBLEPRECISION 
                                        DB_CURRENCY
                                        DB_DECIMAL
                                        DB_NUMERIC
                                        DB_BOOLEAN
                                        DB_ERROR
                                        DB_USERDEFINED
                                        DB_VARIANT
                                        DB_IDDISPATCH
                                        DB_IUNKNOWN
                                        DB_GUID
                                        DB_DATE
                                        DB_DBDATE
                                        DB_DBTIME
                                        DB_DATETIME
                                        DB_BSTR
                                        DB_CHAR
                                        DB_VARCHAR
                                        DB_LONGVARCHAR
                                        DB_WCHAR
                                        DB_VARWCHAR
                                        DB_LONGVARWCHAR
                                        DB_BINARY
                                        DB_VARBINARY
                                        DB_LONGVARBINARY
     �    Result code returned by DBSetParamAttribute.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   6� *            Statement Handle                 7W * �          Index                            7� ) �      Attribute                        C� )�         Value                            O����         Result Code                            1               �Value ATTR_DB_PARAM_VALUE Type ATTR_DB_PARAM_TYPE Direction ATTR_DB_PARAM_DIRECTION Precision ATTR_DB_PARAM_PRECISION Numeric Scale ATTR_DB_PARAM_NUMERIC_SCALE Size ATTR_DB_PARAM_SIZE Attributes ATTR_DB_PARAM_ATTRIBUTES        	           3    Obtains the attribute of a parameter.

Example:

    resCode = DBImmediateSQL(hdbc, "create proc sp_AdoTest( \
                                    @InParam float, @OutParam \ 
                                    float OUTPUT ) as select \ 
                                    @OutParam = @InParam + 1.5 \ 
                                    SELECT * FROM Authors WHERE\ 
                                    State <> 'CA' return \  
                                    @OutParam +1.7");
    
    /* Prepare a statement which calls the stored procedure */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE, 
                                    DB_COMMAND_UNKNOWN);
    resCode = DBRefreshParams(hstmt);
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    resCode = DBClosePreparedSQL(hstmt);

    resCode = DBGetParamAttribute (hstmt, 2, ATTR_DB_PARAM_NAME,
                                   &tempStr);
    printf(" name %s", tempStr);
    DBFree(tempStr);

    resCode = DBGetParamAttribute (hstmt, 2, 
                                   ATTR_DB_PARAM_DIRECTION, 
                                   &tempLong);
     k    Handle to the SQL statement that DBActivateSQL, DBActivateMap DBNewSQLStatement or DBPrepareSQL returned.     E    The index of the parameter.  The index of the first parameter is 1.        The attribute to get.

Attribute                    Type       Description
ATTR_DB_PARAM_VALUE          VARIANT    Value of parameter.
ATTR_DB_PARAM_DIRECTION      long       Direction of parameter
                                        DB_PARAM_INPUT
                                        DB_PARAM_OUTPUT
                                        DB_PARAM_INPUT_OUTPUT
                                        DB_PARAM_RETURN_VALUE
                                        DB_PARAM_UNKNOWN
 * Note: Some providers cannot determine the direction of 
         params to stored procedures. You cannot rely on
         DBRefreshParams in such cases.
ATTR_DB_PARAM_PRECISION      byte       Total number of digits.
ATTR_DB_PARAM_NUMERIC_SCALE  byte       Number of digits to 
                                        the right of decimal.
ATTR_DB_PARAM_SIZE                      Max size in bytes.
ATTR_DB_PARAM_ATTRIBUTES     long       The sum of zero or more
                                        of the following values:
                                        DB_PARAM_SIGNED
                                        DB_PARAM_NULLABLE
                                        DB_PARAM_LONG
ATTR_DB_PARAM_TYPE           long       Type of parameter
                                        DB_EMPTY
                                        DB_TINYINT
                                        DB_SMALLINT
                                        DB_INTEGER
                                        DB_BIGINT
                                        DB_UNSIGNEDTINYINT
                                        DB_UNSIGNEDSMALLINT
                                        DB_UNSIGNEDINT
                                        DB_UNSIGNEDBIGINT
                                        DB_FLOAT
                                        DB_DOUBLEPRECISION 
                                        DB_CURRENCY
                                        DB_DECIMAL
                                        DB_NUMERIC
                                        DB_BOOLEAN
                                        DB_ERROR
                                        DB_USERDEFINED
                                        DB_VARIANT
                                        DB_IDDISPATCH
                                        DB_IUNKNOWN
                                        DB_GUID
                                        DB_DATE
                                        DB_DBDATE
                                        DB_DBTIME
                                        DB_DATETIME
                                        DB_BSTR
                                        DB_CHAR
                                        DB_VARCHAR
                                        DB_LONGVARCHAR
                                        DB_WCHAR
                                        DB_VARWCHAR
                                        DB_LONGVARWCHAR
                                        DB_BINARY
                                        DB_VARBINARY
                                        DB_LONGVARBINARY
    �    Value for the parameter attribute.  The type of the value varies depending on the attribute.

To free the strings that this function returns use DBFree.  To
free any allocated memory within the variants this function returns use CA_VariantClear.  See the documentation for the CVI ActiveX Automation Library for more information about working with Variants.

Attribute                    Type       Description
---------                    ----       -----------
ATTR_DB_PARAM_VALUE          VARIANT    Value of parameter.
ATTR_DB_PARAM_NAME           char*      Name of parameter
ATTR_DB_PARAM_DIRECTION      long       Direction of parameter
                                        DB_PARAM_INPUT
                                        DB_PARAM_OUTPUT
                                        DB_PARAM_INPUT_OUTPUT
                                        DB_PARAM_RETURN_VALUE
                                        DB_PARAM_UNKNOWN
 * Note: Some providers cannot determine the direction of 
         params to stored procedures. You cannot rely on
         DBRefreshParams in such cases.
ATTR_DB_PARAM_PRECISION      byte       Total number of digits.
ATTR_DB_PARAM_NUMERIC_SCALE  byte       Number of digits to 
                                        the right of decimal.
ATTR_DB_PARAM_SIZE                      Max size in bytes.
ATTR_DB_PARAM_ATTRIBUTES     long       The sum of zero or more
                                        of the following values:
                                        DB_PARAM_SIGNED
                                        DB_PARAM_NULLABLE
                                        DB_PARAM_LONG
ATTR_DB_PARAM_TYPE           long       Type of parameter
                                        DB_EMPTY
                                        DB_TINYINT
                                        DB_SMALLINT
                                        DB_INTEGER
                                        DB_BIGINT
                                        DB_UNSIGNEDTINYINT
                                        DB_UNSIGNEDSMALLINT
                                        DB_UNSIGNEDINT
                                        DB_UNSIGNEDBIGINT
                                        DB_FLOAT
                                        DB_DOUBLEPRECISION 
                                        DB_CURRENCY
                                        DB_DECIMAL
                                        DB_NUMERIC
                                        DB_BOOLEAN
                                        DB_ERROR
                                        DB_USERDEFINED
                                        DB_VARIANT
                                        DB_IDDISPATCH
                                        DB_IUNKNOWN
                                        DB_GUID
                                        DB_DATE
                                        DB_DBDATE
                                        DB_DBTIME
                                        DB_DATETIME
                                        DB_BSTR
                                        DB_CHAR
                                        DB_VARCHAR
                                        DB_LONGVARCHAR
                                        DB_WCHAR
                                        DB_VARWCHAR
                                        DB_LONGVARWCHAR
                                        DB_BINARY
                                        DB_VARBINARY
                                        DB_LONGVARBINARY
     �    Result code returned by DBGetParamAttribute.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   X *            Statement Handle                 X� * �          Index                            X� ) �      Attribute                        d� )�         Value                            r����         Result Code                            1           	  Value ATTR_DB_PARAM_VALUE Properties ATTR_DB_PARAM_PROPERTIES Name ATTR_DB_PARAM_NAME Type ATTR_DB_PARAM_TYPE Direction ATTR_DB_PARAM_DIRECTION Precision ATTR_DB_PARAM_PRECISION Numeric Scale ATTR_DB_PARAM_NUMERIC_SCALE Size ATTR_DB_PARAM_SIZE Attributes ATTR_DB_PARAM_ATTRIBUTES    	            	           �    Obtains the value of a parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  Output values are invalid until you close the statement with DBClosePreparedSQL.

Example:
    /* Create a stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( 
            @InParam int, @OutParam int OUTPUT ) as  \
            select @OutParam = @InParam + 10 SELECT * FROM \
            Authors WHERE State <> 'CA' return @OutParam +10");
    
    /* Prepare a statement which calls the stored procedure */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);
    
    /* Refresh the parameters from the stored procedure.    */
    resCode = DBRefreshParams(hstmt);
    
    /* Set the input parameter */
    resCode = DBSetParamInt(hstmt, 1, 10);
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procdure */
    }
    
    /* Close the statement.  Output parameters are invalid */
    /* until the statement is closed                       */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameter values */
    resCode = DBGetParamInt(hstmt, 0, &retParam);
    resCode = DBGetParamInt(hstmt, 1, &inParam);
    resCode = DBGetParamInt(hstmt, 2, &outParam);

    /* Deactivate the statement */
    hstmt = DBDeactivateSQL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL DBSetParamInt, and DBClosePreparedSQL.     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle that DBActivateSQL, DBActivateMap or DBNewSQLStatement returned.     �    Result code returned by DBGetParamInt.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.     E    The index of the parameter.  The index of the first parameter is 1.     "    Integer value for the parameter.   |� !            Statement Handle                 }l���         Result Code                      ~5 ! �          Index                            ~� !2          Value                                  	            1    	               Obtains the value of a parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  Output parameters are invalid until you close the statement with DBClosePreparedSQL.

Example:
    /* Create a stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( 
            @InParam int, @OutParam int OUTPUT ) as  \
            select @OutParam = @InParam + 10 SELECT * FROM \
            Authors WHERE State <> 'CA' return @OutParam +10");
    
    /* Prepare a statement which calls the stored procedure */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);
    
    /* Refresh the parameters from the stored procedure.    */
    resCode = DBRefreshParams(hstmt);
    
    /* Set the input parameter */
    resCode = DBSetParamShort(hstmt, 1, 10);
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procdure */
    }
    
    /* Close the statement.  Output parameters are invalid */
    /* until the statement is closed                       */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameter values */
    resCode = DBGetParamShort(hstmt, 0, &retParam);
    resCode = DBGetParamShort(hstmt, 1, &inParam);
    resCode = DBGetParamShort(hstmt, 2, &outParam);

    /* Deactivate the statement */
    hstmt = DBDeactivateSQL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBSetParamShort and DBClosePreparedSQL.
     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle that DBActivateSQL, DBActivateMap or DBNewSQLStatement returned.     �    Result code returned by DBGetParamShort.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.     D    The index of the parameter. The index of the first parameter is 1.     (    Short integer value for the parameter.   �� !            Statement Handle                 �V���         Result Code                      �! ! �          Index                            �m !2         Value                                  	            1    	               Obtains the value of a parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  Output parameters are invalid until you close the statement with DBClosePreparedSQL.

Example:
    /* Create a stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( 
            @InParam float, @OutParam float OUTPUT ) as  \
            select @OutParam = @InParam + 10.1 SELECT * FROM \
            Authors WHERE State <> 'CA' return @OutParam \
            +10.1");

    /* Set the command type attribute to stored procedure */    
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);

    /* Prepare a statement which calls the stored procedure */
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");

    /* Set command type back to the default */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);
    
    /* Refresh the parameters from the stored procedure.    */
    resCode = DBRefreshParams(hstmt);
    
    /* Set the input parameter */
    resCode = DBSetParamFloat(hstmt, 1, 10.5);
    if (resCode != DB_SUCCESS) {ShowError(); goto Error;}
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    if (resCode != DB_SUCCESS) {ShowError(); goto Error;}
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procdure */
    }
    
    /* Close the statement.  Output parameters are invalid */
    /* until the statement is closed                       */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameter values */
    resCode = DBGetParamFloat(hstmt, 0, &retParam);
    resCode = DBGetParamFloat(hstmt, 1, &inParam);
    resCode = DBGetParamFloat(hstmt, 2, &outParam);

    /* Deactivate the statement */
    hstmt = DBDeactivateSQL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL,  DBGetParamFloat and DBClosePreparedSQL.     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL, DBActivateMap or DBNewSQLStatement returned.     �    Result code returned by DBGetParamFloat.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.     E    The index of the parameter.  The index of the first parameter is 1.          Float value for the parameter.   �� !            Statement Handle                 �A���         Result Code                      � ! �          Index                            �Y !2         Value                                  	            1    	          �    Obtains the value of a parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  Output parameters are invalid until you close the statement with DBClosePreparedSQL.

Example:
    /* Create a stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( 
            @InParam float, @OutParam float OUTPUT ) as  \
            select @OutParam = @InParam + 10.1 SELECT * FROM \
            Authors WHERE State <> 'CA' return @OutParam \
            +10.1");

    /* Set the command type attribute to stored procedure */    
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);

    /* Prepare a statement which calls the stored procedure */
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");

    /* Set command type back to the default */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);
    
    /* Refresh the parameters from the stored procedure.    */
    resCode = DBRefreshParams(hstmt);
    
    /* Set the input parameter */
    resCode = DBSetParamDouble(hstmt, 1, 10.5);
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procdure */
    }
    
    /* Close the statement.  Output parameters are invalid */
    /* until the statement is closed                       */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameter values */
    resCode = DBGetParamDouble(hstmt, 0, &retParam);
    resCode = DBGetParamDouble(hstmt, 1, &inParam);
    resCode = DBGetParamDouble(hstmt, 2, &outParam);

    /* Deactivate the statement */
    hstmt = DBDeactivateSQL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBSetParamDouble and DBClosePreparedSQL.     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle that DBActivateSQL, DBActivateMap or DBNewSQLStatement returned.     �    Result code returned by DBGetParamDouble.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.     E    The index of the parameter.  The index of the first parameter is 1.     !    Double value for the parameter.   � !            Statement Handle                 �����         Result Code                      �� ! �          Index                            �� !2         Value                                  	            1    	          	;    Obtains the value of a parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  Output parameters are invalid until you close the statement with DBClosePreparedSQL.  You must use DBFree to free the returned string.

Example:
    char inParam[11] = "in";
    char readInParam[11];
    char outParam[11];
    char* retParam;
    ...    
    /* Create the stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_AdoTest( \
        @InParam char(10), @OutParam char(10) OUTPUT ) as \
        select @OutParam = 'out' SELECT * FROM Authors WHERE \
        State <> 'CA' return 10.1");
    
    /* Set the command type attribute to store procedure */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE, 
                                    DB_COMMAND_STORED_PROC);
    /* Prepare a statement which calls the stored procedure */
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");
    /* set command type attribute back to default */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE, 
                                    DB_COMMAND_UNKNOWN);

    /* Create the parameters */
    resCode = DBCreateParamChar(hstmt, "", 
                                DB_PARAM_RETURN_VALUE, 
                                inParam, 10);
    resCode = DBCreateParamChar(hstmt, "InParam", 
                                DB_PARAM_INPUT, "", 10);
    resCode = DBCreateParamChar(hstmt, "OutParam",
                                DB_PARAM_OUTPUT, "", 10);

    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procedure */
    }
    /* Close the statement.  Output parameters are invalid */
    /* until the statement is closed.                      */
    resCode = DBClosePreparedSQL(hstmt);
    /* Examine the parameter values */
    resCode = DBGetParamChar(hstmt, 0, &retParam);
    resCode = DBGetParamCharBuffer(hstmt, 1, readInParam, 10);
    resCode = DBGetParamCharBuffer(hstmt, 2, outParam, 10);
    printf("return param %s input param %s output param %s\n",
           retParam, inParam, outParam);
    DBFree(retParam);
    hstmt = DBDeactivateSQL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBSetParamChar, and DBClosePreparedSQL.     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle that DBActivateSQL, DBActivateMap or DBNewSQLStatement returned.     �    Result code returned by DBGetParamChar.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.     E    The index of the parameter.  The index of the first parameter is 1.     e    String value for the parameter.  You must use DBFree to free the string when you no longer need it.    �    Format string.  Use the empty string "" if you want ADO to supply the formatting based on the Windows control panel settings.

Date formats support the following symbols

Symbol    Description
------    -----------
m         Month�s number suppress leading zero
mm        Month�s number with leading zero if applicable
mmm       Month�s three letter abbreviation, lowercase
Mmm       Month�s three letter abbreviation, initial cap
MMM       Month�s three letter abbreviation, upper case
mmmm      Month�s full name, lowercase
Mmmm      Month�s full name, initial cap
MMMM      Month�s full name, upper case
d         Day of the month�s number, suppress leading zero
dd        Day of the month�s number, include leading zero
ddd       Day of the month�s three letter abbreviation, 
          lowercase
Ddd       Day of the month�s three letter abbreviation, initial     
          cap
DDD       Day of the month�s three letter abbreviation, upper 
          case
dddd      Day of the month�s full name, lower case
Dddd      Day of the month�s full name, initial cap
DDDD      Day of the month�s full name, upper case
yy        Last two digits of year
yyyy      Four digit year
h         Hour of the day, suppress leading zero 
          (use am/pm symbol for 12 hour style)
hh        Hour of the day, include leading zero 
          (use am/pm symbol for 12 hour style)
i (or m)  Minute of the hour, suppress leading zero
ii (or mm)Minute of the hour, include leading zero
s         Second of the minute, suppress leading zero
ss        Second of the minute, include leading zero
ss.ssssss Second of the minute with fractional seconds, (use up
          to six �s� symbols after the decimal point)        am/pm     "am" or "pm" string, lower case (forces 12 hour clock)
a/p       "a" or "p" string.  (forces 12 hour clock)
AM/PM     "AM" or "PM" string, upper case (forces 12 hour clock)
A/P       "A" or "P" string, upper case (forces 12 hour clock)
J         Julian value for date/time.
/ - . : , Output the character
<space>   Output a space character
\<char>   Output the character following the �\� character
"<text>"  Output the text
�<text>�  Output the string
GD        Windows Short Date Format (Do not combine other format
          symbols with GD except "[US]"
GDT       Windows Short Date Format + Time Format Do not combine
          with other format symbols except "[US]")
GL        Windows Long Date Format. (Do not combine other format 
          symbols with GL except "[US]")
GLT       Windows Long Date Format + Time Format (Do not combine
          other format symbols with GLT except "[US]")
GT        Windows Time Format (Do not combine any other format
          symbols with GT)
[US]      The information in the International section of the 
          Windows control panel is ignored, instead the United
          States defaults are substituted.

Numeric Format Strings allow you to format numbers in a variety of ways. Numeric formats can have one section or two sections separated by a semicolon. Formats with one section use the same format for positive and negative numbers. Formats with two sections use the second section as the format for negative numbers. 

Number formats support the following symbols

Symbol    Description
------    -----------
$         Output the Windows currency string
.         Output the Windows decimal point character 
,         Output the Windows thousands separator character 
#         Output a digit. If there is no digit to output in the 
          position output nothing.
0         Output a digit, If there is no digit to output in the 
          position output a zero
?         Output a digit, If there is no digit to output in the 
          position output a space
%         Output the value as a percent. The value is multiplied            
          by 100 and the �%� character is output.
e+        Output in scientific notation, show exponent sign only 
          if negative
e-        Output in scientific notation, always show sign of 
          exponent
E+ E-     Upper case analogs of e+ and e-
- + ( ) , Output the character
<space>   Output a space character
\<char>   Output the character following the �\� character
"<text>"  Output the text
�<text>�  Output the text
GN        Windows General Number Format (Note you can only 
          combine GN with symbols which are enclosed in 
          brackets such as "[US]"
GF        Windows General Fixed Format for numbers (Note
          you can only combine GF with symbols which are 
          enclosed in brackets such as "[US]")
GC        Windows General Currency Format for numbers (Note you 
          can only combine GC with symbols which are enclosed 
          in brackets such as "[US]"
[S/n]     Scale (divide) the number by a power of 10 before 
          output.
[S*n]     Scale (multiply) the number by a power of 10 before 
          output. 
[US]      The information in the International section of the 
          Windows control panel is ignored, instead the United
          States defaults are substituted.
   �/ !            Statement Handle                 �����         Result Code                      �� ! �          Index                            �� !2         Value                            �X !�         Format String                          	            1    	            ""   	+    Obtains the value of a parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  Output parameters are invalid until you close the statement with DBClosePreparedSQL.

Example:
    char inParam[11] = "in";
    char readInParam[11];
    char outParam[11];
    char* retParam;
    ...    
    /* Create the stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_AdoTest( \
        @InParam char(10), @OutParam char(10) OUTPUT ) as \
        select @OutParam = 'out' SELECT * FROM Authors WHERE \
        State <> 'CA' return 10.1");
    
    /* Set the command type attribute to store procedure */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE, 
                                    DB_COMMAND_STORED_PROC);
    /* Prepare a statement which calls the stored procedure */
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");
    /* set command type attribute back to default */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE, 
                                    DB_COMMAND_UNKNOWN);

    /* Create the parameters */
    resCode = DBCreateParamChar(hstmt, "", 
                                DB_PARAM_RETURN_VALUE, 
                                inParam, 10);
    resCode = DBCreateParamChar(hstmt, "InParam", 
                                DB_PARAM_INPUT, "", 10);
    resCode = DBCreateParamChar(hstmt, "OutParam",
                                DB_PARAM_OUTPUT, "", 10);

    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procedure */
    }
    /* Close the statement.  Output parameters are invalid */
    /* until the statement is closed.                      */
    resCode = DBClosePreparedSQL(hstmt);
    /* Examine the parameter values */
    resCode = DBGetParamChar(hstmt, 0, &retParam);
    resCode = DBGetParamCharBuffer(hstmt, 1, readInParam, 10);
    resCode = DBGetParamCharBuffer(hstmt, 2, outParam, 10);
    printf("return param %s input param %s output param %s\n",
           retParam, inParam, outParam);
    DBFree(retParam);
    hstmt = DBDeactivateSQL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBCreateParamChar, DBSetParamChar, DBGetParamChar and DBClosePreparedSQL.     p    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL.     �    Result code returned by DBGetParamCharBuffer.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.     E    The index of the parameter.  The index of the first parameter is 1.     :    Buffer to hold returned string value for the parameter.
          The size of the value buffer.
    �    Format string.  Use the empty string "" if you want ADO to supply the formatting based on the Windows control panel settings.

Date formats support the following symbols

Symbol    Description
------    -----------
m         Month�s number suppress leading zero
mm        Month�s number with leading zero if applicable
mmm       Month�s three letter abbreviation, lowercase
Mmm       Month�s three letter abbreviation, initial cap
MMM       Month�s three letter abbreviation, upper case
mmmm      Month�s full name, lowercase
Mmmm      Month�s full name, initial cap
MMMM      Month�s full name, upper case
d         Day of the month�s number, suppress leading zero
dd        Day of the month�s number, include leading zero
ddd       Day of the month�s three letter abbreviation, 
          lowercase
Ddd       Day of the month�s three letter abbreviation, initial     
          cap
DDD       Day of the month�s three letter abbreviation, upper 
          case
dddd      Day of the month�s full name, lower case
Dddd      Day of the month�s full name, initial cap
DDDD      Day of the month�s full name, upper case
yy        Last two digits of year
yyyy      Four digit year
h         Hour of the day, suppress leading zero 
          (use am/pm symbol for 12 hour style)
hh        Hour of the day, include leading zero 
          (use am/pm symbol for 12 hour style)
i (or m)  Minute of the hour, suppress leading zero
ii (or mm)Minute of the hour, include leading zero
s         Second of the minute, suppress leading zero
ss        Second of the minute, include leading zero
ss.ssssss Second of the minute with fractional seconds, (use up
          to six �s� symbols after the decimal point)        am/pm     "am" or "pm" string, lower case (forces 12 hour clock)
a/p       "a" or "p" string.  (forces 12 hour clock)
AM/PM     "AM" or "PM" string, upper case (forces 12 hour clock)
A/P       "A" or "P" string, upper case (forces 12 hour clock)
J         Julian value for date/time.
/ - . : , Output the character
<space>   Output a space character
\<char>   Output the character following the �\� character
"<text>"  Output the text
�<text>�  Output the string
GD        Windows Short Date Format (Do not combine other format
          symbols with GD except "[US]"
GDT       Windows Short Date Format + Time Format Do not combine
          with other format symbols except "[US]")
GL        Windows Long Date Format. (Do not combine other format 
          symbols with GL except "[US]")
GLT       Windows Long Date Format + Time Format (Do not combine
          other format symbols with GLT except "[US]")
GT        Windows Time Format (Do not combine any other format
          symbols with GT)
[US]      The information in the International section of the 
          Windows control panel is ignored, instead the United
          States defaults are substituted.

Numeric Format Strings allow you to format numbers in a variety of ways. Numeric formats can have one section or two sections separated by a semicolon. Formats with one section use the same format for positive and negative numbers. Formats with two sections use the second section as the format for negative numbers. 

Number formats support the following symbols

Symbol    Description
------    -----------
$         Output the Windows currency string
.         Output the Windows decimal point character 
,         Output the Windows thousands separator character 
#         Output a digit. If there is no digit to output in the 
          position output nothing.
0         Output a digit, If there is no digit to output in the 
          position output a zero
?         Output a digit, If there is no digit to output in the 
          position output a space
%         Output the value as a percent. The value is multiplied            
          by 100 and the �%� character is output.
e+        Output in scientific notation, show exponent sign only 
          if negative
e-        Output in scientific notation, always show sign of 
          exponent
E+ E-     Upper case analogs of e+ and e-
- + ( ) , Output the character
<space>   Output a space character
\<char>   Output the character following the �\� character
"<text>"  Output the text
�<text>�  Output the text
GN        Windows General Number Format (Note you can only 
          combine GN with symbols which are enclosed in 
          brackets such as "[US]"
GF        Windows General Fixed Format for numbers (Note
          you can only combine GF with symbols which are 
          enclosed in brackets such as "[US]")
GC        Windows General Currency Format for numbers (Note you 
          can only combine GC with symbols which are enclosed 
          in brackets such as "[US]"
[S/n]     Scale (divide) the number by a power of 10 before 
          output.
[S*n]     Scale (multiply) the number by a power of 10 before 
          output. 
[US]      The information in the International section of the 
          Windows control panel is ignored, instead the United
          States defaults are substituted.
   Ȍ !            Statement Handle                 ����         Result Code                      �� ! �          Index                            �! !2         Value                            �c !�          Buffer Length                    ʋ f          Format String                          	            1    	                ""   
�    Obtains the value of a parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  Output parameters are invalid until you close the statement with DBClosePreparedSQL. You must use DBFree to free the returned buffer.

Output parameter example:
    /* This example works with Microsoft SQL Server */
    unsigned char inParam[6] = "in";
    unsigned char readInParam[6];
    unsigned char *outParam;
    char* retParam;
    ...
    /* Create the stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( \ 
           @InParam binary(6), @OutParam binary(6) OUTPUT ) as \
           select @OutParam = @InParam SELECT * FROM Authors \
           WHERE State <> 'CA' return 10.1");

    /* Set the command type attribute to stored procedure */    
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);

    /* Prepare a statement which calls the stored procedure */
    hstmt = DBPrepareSQL (hdbc, "sp_CVItest");

    /* Set the command type attribute back to the default */
    /* for future commands                                */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);

    /* Put some data in the input variable          */
    /* note that using binary allows embedded nulls */
    inParam[0]='N';inParam[1]='C';inParam[2]='B';
    inParam[3]='\0'; inParam[4]='O';inParam[5]='K';
    outParam = malloc(6);
    /* Create the parameters */
    resCode = DBCreateParamChar(hstmt, "", 
                                DB_PARAM_RETURN_VALUE, 
                                retParam, 6);
    resCode = DBCreateParamBinary(hstmt, "InParam", 
                                DB_PARAM_INPUT, "", 6);
    resCode = DBCreateParamBinary(hstmt, "OutParam", 
                                DB_PARAM_OUTPUT, "", 6);

    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procedure */
    }
    
    /* Close the statement.  Output values are invalid */
    /* until the statement is closed                   */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameter values */
    resCode = DBGetParamChar(hstmt, 0, &retParam);
    resCode = DBGetParamBinaryBuffer(hstmt, 1, readInParam, 6);
    resCode = DBGetParamBinary(hstmt, 2, (void **)&(outParam));
    DBFree(retParam);
    DBFree(outParam);

    /* Deactivate the statement */
    hstmt = DBDeactivateSQL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBSetParamBinary, DBGetParamBinaryBuffer, and DBClosePreparedSQL.     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle that DBActivateSQL, DBActivateMap, or DBNewSQLStatement returned.     �    Result code returned by DBGetParamBinary.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.         Index of the parameter.     j    Binary value for the parameter.  You must use DBFree to free the binary data when you no longer need it.   � !            Statement Handle                 �<���         Result Code                      � ! �          Index                            �) !2         Value                                  	            1    	           
�    Obtains the value of a parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  Output parameters are invalid until you close the statement with DBClosePreparedSQL.

Example:
    /* This example works with Microsoft SQL Server */
    unsigned char inParam[6] = "in";
    unsigned char readInParam[6];
    unsigned char *outParam;
    char* retParam;
    ...
    /* Create the stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( \ 
           @InParam binary(6), @OutParam binary(6) OUTPUT ) as \
           select @OutParam = @InParam SELECT * FROM Authors \
           WHERE State <> 'CA' return 10.1");

    /* Set the command type attribute to stored procedure */    
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);

    /* Prepare a statement which calls the stored procedure */
    hstmt = DBPrepareSQL (hdbc, "sp_CVItest");

    /* Set the command type attribute back to the default */
    /* for future commands                                */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);

    /* Put some data in the input variable          */
    /* note that using binary allows embedded nulls */
    inParam[0]='N';inParam[1]='C';inParam[2]='B';
    inParam[3]='\0'; inParam[4]='O';inParam[5]='K';
    outParam = malloc(6);
    /* Create the parameters */
    resCode = DBCreateParamChar(hstmt, "", 
                                DB_PARAM_RETURN_VALUE, 
                                retParam, 6);
    resCode = DBCreateParamBinary(hstmt, "InParam", 
                                DB_PARAM_INPUT, "", 6);
    resCode = DBCreateParamBinary(hstmt, "OutParam", 
                                DB_PARAM_OUTPUT, "", 6);

    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procedure */
    }
    
    /* Close the statement.  Output values are invalid */
    /* until the statement is closed                   */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameter values */
    resCode = DBGetParamChar(hstmt, 0, &retParam);
    resCode = DBGetParamBinaryBuffer(hstmt, 1, readInParam, 6);
    resCode = DBGetParamBinary(hstmt, 2, (void **)&(outParam));
    DBFree(retParam);
    DBFree(outParam);

    /* Deactivate the statement */
    hstmt = DBDeactivateSQL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBCreateParamBinary, DBSetParamBinary, DBGetParamBinary and DBClosePreparedSQL.     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL, DBActivateMap or DBNewSQLStatement returned.     �    Result code returned by DBGetParamBinaryBuffer.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.     >    The index of the parameter.  The first parameter index is 1.     :    Buffer to hold returned binary value for the parameter.
     )    The size of the value buffer in bytes.
   �- !            Statement Handle                 �����         Result Code                      �� ! �          Index                            �� !2         Value                            �, !�         Size in Bytes                          	            1    	               9    Gets the value of a parameter for a stored procedure or SQL statement that you previously prepared with DBPrepareSQL.  Output parameters are invalid until you close the statement with DBClosePreparedSQL.

Example:
    /* Create a stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( 
            @InParam float, @OutParam float OUTPUT ) as  \
            select @OutParam = @InParam + 10.1 SELECT * FROM \
            Authors WHERE State <> 'CA' return @OutParam \
            +10.1");

    /* Set the command type attribute to stored procedure */    
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);

    /* Prepare a statement which calls the stored procedure */
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");

    /* Set command type back to the default */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);
    
    /* Refresh the parameters from the stored procedure.    */
    resCode = DBRefreshParams(hstmt);
    
    /* Set the input parameter */
    resCode = DBSetParamVariant(hstmt, 1, inParamV);
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    ...    
    /* Close the statement.  Output parameters are invalid */
    /* until the statement is closed                       */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameter values */
    resCode = DBGetParamVariant(hstmt, 0, &retParamV);
    resCode = DBGetParamVariant(hstmt, 1, &inParamV);
    resCode = DBGetParamVariant(hstmt, 2, &outParamV);

    /* Deactivate the statement */
    hstmt = DBDeactivateSQL(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBSetParamDouble and DBClosePreparedSQL.

Known problems:

ADO 2.0 does not properly set variants which contain values of type CAVT_DECIMAL and the value is a multiple of 10.  There are two workarounds for this problem

Use a client side cursor. You must use DBNewSQLStatement instead of DBActivateSQL in order to use this workaround.
    hstmt = DBNewSQLStatement(hdbc, "select * from foo");
    TRY(DBSetStatementAttribute (hstmt,
                               ATTR_DB_STMT_CURSOR_LOCATION,
                               DB_CURSOR_LOC_CLIENT));
    TRY(DBOpenSQLStatement(hstmt));

Use the following function, SP_VariantConvertToType, instead of CA_VariantConvertToType to extract values from the variant.
    #ifndef VT_DECIMAL
    #define VT_DECIMAL 14
    #endif
    typedef struct tagDEC_FAKE {
        USHORT wReserved;
        union {
            struct {
                BYTE scale;
                BYTE sign;
            }s1;
            USHORT signscale;
        }n1;
        ULONG Hi32;
        union {
            struct {
                ULONG Lo32;
                ULONG Mid32;
            }n2;
            char Lo64[8];
        }n3;
    } MSVC_DECIMAL;
    typedef  struct tagVARIANT_FAKE VARIANT_FAKE;

    struct  tagVARIANT_FAKE {
        union         {
            struct  __tagVARIANT {
                VARTYPE vt;
                WORD wReserved1;
                WORD wReserved2;
                WORD wReserved3;
                union                 {
                      char dummy[8];
                } n1; 
            } n2;
            MSVC_DECIMAL decVal;
        } n3;
    };
    static HRESULT CVIFUNC SP_VariantConvertToType(
        VARIANT *variant, 
        unsigned cavt, 
        void *ptrToResult)
    {
        HRESULT firstStat;
        char msg[50];

        firstStat = CA_VariantConvertToType((VARIANT *)variant, 
                                             cavt,ptrToResult);
        if ((firstStat == -2147024809) 
            && (variant->vt == VT_DECIMAL)) {
            double value;
            HRESULT temp;
            char scale;
            VARIANT_FAKE* fakeVariant;
            fakeVariant = (VARIANT_FAKE *)variant;
            scale = fakeVariant->n3.decVal.n1.s1.scale;

            fakeVariant->n3.decVal.n1.s1.scale = 0;

            temp = CA_VariantConvertToType(variant, CAVT_DOUBLE, 
                                           &value);
            if (temp != DB_SUCCESS)
                return firstStat;
            while (scale) {
                if (scale > 0) {
                    value = value / 10;
                    scale--;
                } else {
                    value = value * 10;
                    scale++;
                }
            }
            temp = CA_VariantSetDouble(variant, value);
            if (temp != DB_SUCCESS)
                goto Error;
            temp = CA_VariantConvertToType(variant, cavt, 
                                           ptrToResult);
            if (temp != DB_SUCCESS)
                goto Error;
            return temp;
        }
        return firstStat;
    Error:
        return firstStat;
    }

     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL, DBActivateMap or DBNewSQLStatement.     �    Result code returned by DBGetParamVariant.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.     E    The index of the parameter.  The index of the first parameter is 1.        Variant which receives the value of the parameter.  To
free any allocated memory within the variant this function returns use CA_VariantClear.  

See the documentation for the CVI ActiveX Automation Library for more information about working with Variants.

   � !            Statement Handle                 h���         Result Code                      5 ! �          Index                            � !2 �       Value                           ���� � r��                                                	            1    	           6See function help for a workaround for an ADO problem   �    Close a statement executed with DBExecutePreparedSQL.  You must close the statement before you can examine output parameters of a stored procedure.  You must discard a closed statement with DBDiscardSQLStatement to properly free resources.  

You do not need to call DBClosePreparedSQL for stored procedures which use only input parameters, you can call DBDeactivateSQL to close and discard the statement in one step.

DBClosePreparedSQL discards the variable bindings for the statement.  If you reuse the statement, you must create new variable bindings.

Example:
    /* Create a stored procedure */
    /* This syntax is for Microsoft SQL Server */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( 
            @InParam int, @OutParam int OUTPUT ) as  \
            select @OutParam = @InParam + 10 SELECT * FROM \
            Authors WHERE State <> 'CA' return @OutParam +10");
    
    /* Prepare a statement which calls the stored procedure */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);
    hstmt = DBPrepareSQL (hdbc, "sp_Adotest");
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_UNKNOWN);
    
    /* Refresh the parameters from the stored procedure.    */
    resCode = DBRefreshParams(hstmt);
    
    /* Set the input parameter */
    resCode = DBSetParamShort(hstmt, 1, 10);
    if (resCode != DB_SUCCESS) {ShowError(); goto Error;}
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    if (resCode != DB_SUCCESS) {ShowError(); goto Error;}
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procdure */
    }
    
    /* Close the statement.  Output parameters are invalid */
    /* until the statement is closed                       */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameter values */
    resCode = DBGetParamShort(hstmt, 0, &retParam);
    resCode = DBGetParamShort(hstmt, 1, &inParam);
    resCode = DBGetParamShort(hstmt, 2, &outParam);

    /* Discard the statement */
    hstmt = DBDiscardSQLStatement(hstmt);

See also:
    DBPrepareSQL, DBRefreshParams, DBExecutePreparedSQL, DBDiscardSQLStatement     9    Handle to the SQL statement that DBPrepareSQL returned.     �    Result code returned by DBClosePreparedSQL.  This function returns the set of result codes listed in the function description for DBError.   �             Statement Handle                 5���         Result Code                            	           �    Puts a string value into the current record. You can fetch a record then use DBPutColChar as an alternative to binding values then fetching a record.

Note: You can use DBPutColChar while you use binding or mapping for other fields/columns

Example:
    /* Execute a select statement */
    hstmt = DBActivateSQL (hdbc, "SELECT UUT_NUM, \
        LOOPNUM, MEAS1, MEAS2, CHANGER FROM REC1000");

    /* Create a new record */
    resCode = DBCreateRecord(hstmt);

    /* Put values into the record. */
    resCode = DBPutColChar(hstmt, 1, "newrec");
    resCode = DBPutColInt(hstmt, 2, 47);
    resCode = DBPutColFloat(hstmt, 3, 23.2);
    resCode = DBPutColDouble(hstmt, 4, 42.6);
    resCode = DBPutColShort(hstmt, 5, 32);
    
    /* Put the record to the database. */
    resCode = DBPutRecord(hstmt);

    /* Deactivate the SQL statement */
    hstmt = DBDeactivateSQL (hstmt);

See also:
    DBBindColChar and DBMapColumnToChar.     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     h    Field/column number within the record where you place the value.  The first field/column number is 1.
     M    String value to place in the specified field/column of the current record.
     �    Result code returned by DBPutColChar.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
    �    Format string.  Use the empty string "" if you want ADO to supply the formatting based on the Windows control panel settings.

Date formats support the following symbols

Symbol    Description
------    -----------
m         Month�s number suppress leading zero
mm        Month�s number with leading zero if applicable
mmm       Month�s three letter abbreviation, lowercase
Mmm       Month�s three letter abbreviation, initial cap
MMM       Month�s three letter abbreviation, upper case
mmmm      Month�s full name, lowercase
Mmmm      Month�s full name, initial cap
MMMM      Month�s full name, upper case
d         Day of the month�s number, suppress leading zero
dd        Day of the month�s number, include leading zero
ddd       Day of the month�s three letter abbreviation, 
          lowercase
Ddd       Day of the month�s three letter abbreviation, initial     
          cap
DDD       Day of the month�s three letter abbreviation, upper 
          case
dddd      Day of the month�s full name, lower case
Dddd      Day of the month�s full name, initial cap
DDDD      Day of the month�s full name, upper case
yy        Last two digits of year
yyyy      Four digit year
h         Hour of the day, suppress leading zero 
          (use am/pm symbol for 12 hour style)
hh        Hour of the day, include leading zero 
          (use am/pm symbol for 12 hour style)
i (or m)  Minute of the hour, suppress leading zero
ii (or mm)Minute of the hour, include leading zero
s         Second of the minute, suppress leading zero
ss        Second of the minute, include leading zero
ss.ssssss Second of the minute with fractional seconds, (use up
          to six �s� symbols after the decimal point)        am/pm     "am" or "pm" string, lower case (forces 12 hour clock)
a/p       "a" or "p" string.  (forces 12 hour clock)
AM/PM     "AM" or "PM" string, upper case (forces 12 hour clock)
A/P       "A" or "P" string, upper case (forces 12 hour clock)
J         Julian value for date/time.
/ - . : , Output the character
<space>   Output a space character
\<char>   Output the character following the �\� character
"<text>"  Output the text
�<text>�  Output the string
GD        Windows Short Date Format (Do not combine other format
          symbols with GD except "[US]"
GDT       Windows Short Date Format + Time Format Do not combine
          with other format symbols except "[US]")
GL        Windows Long Date Format. (Do not combine other format 
          symbols with GL except "[US]")
GLT       Windows Long Date Format + Time Format (Do not combine
          other format symbols with GLT except "[US]")
GT        Windows Time Format (Do not combine any other format
          symbols with GT)
[US]      The information in the International section of the 
          Windows control panel is ignored, instead the United
          States defaults are substituted.

Numeric Format Strings allow you to format numbers in a variety of ways. Numeric formats can have one section or two sections separated by a semicolon. Formats with one section use the same format for positive and negative numbers. Formats with two sections use the second section as the format for negative numbers. 

Number formats support the following symbols

Symbol    Description
------    -----------
$         Output the Windows currency string
.         Output the Windows decimal point character 
,         Output the Windows thousands separator character 
#         Output a digit. If there is no digit to output in the 
          position output nothing.
0         Output a digit, If there is no digit to output in the 
          position output a zero
?         Output a digit, If there is no digit to output in the 
          position output a space
%         Output the value as a percent. The value is multiplied            
          by 100 and the �%� character is output.
e+        Output in scientific notation, show exponent sign only 
          if negative
e-        Output in scientific notation, always show sign of 
          exponent
E+ E-     Upper case analogs of e+ and e-
- + ( ) , Output the character
<space>   Output a space character
\<char>   Output the character following the �\� character
"<text>"  Output the text
�<text>�  Output the text
GN        Windows General Number Format (Note you can only 
          combine GN with symbols which are enclosed in 
          brackets such as "[US]"
GF        Windows General Fixed Format for numbers (Note
          you can only combine GF with symbols which are 
          enclosed in brackets such as "[US]")
GC        Windows General Currency Format for numbers (Note you 
          can only combine GC with symbols which are enclosed 
          in brackets such as "[US]"
[S/n]     Scale (divide) the number by a power of 10 before 
          output.
[S*n]     Scale (multiply) the number by a power of 10 before 
          output. 
[US]      The information in the International section of the 
          Windows control panel is ignored, instead the United
          States defaults are substituted.
    �             Statement Handle                 !s   �          Column Number                    !�      `    Value                            "8���         Result Code                      #  �         Format String                          1        	            ""   �    Puts a short integer value into the current record.  You can fetch a record then use DBPutColShort as an alternative to binding values then fetching a record.

Note: you can use DBPutColShort even if you use binding or mapping for other fields/columns.

Example:
    /* Execute a select statement */
    hstmt = DBActivateSQL (hdbc, "SELECT UUT_NUM, \
        LOOPNUM, MEAS1, MEAS2, CHANGER FROM REC1000");

    /* Create a new record */
    resCode = DBCreateRecord(hstmt);

    /* Put values into the recorc. */
    resCode = DBPutColChar(hstmt, 1, "newrec");
    resCode = DBPutColInt(hstmt, 2, 47);
    resCode = DBPutColFloat(hstmt, 3, 23.2);
    resCode = DBPutColDouble(hstmt, 4, 42.6);
    resCode = DBPutColShort(hstmt, 5, 32);
    
    /* Put the record to the database */
    resCode = DBPutRecord(hstmt);

    /* Deactivate the SQL statement. */
    hstmt = DBDeactivateSQL (hstmt);

See also:
    DBBindColShort and DBMapColumnToShort.     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     l    The field/column number within the record where the value is placed.  The first field/column number is 1.
     P    The short value to place in the specified field/column of the current record.
     �    Result code returned by DBPutColShort.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
   ;�             Statement Handle                 <9   �          Column Number                    <�  [    `    Value                            =���         Result Code                            1        	           �    Puts an integer value into the current record.  You can fetch a record then use DBPutColInt as an alternative to binding values then fetching a record.

Note: you can use DBPutColInt while you use binding or mapping for other fields/columns

Example:
    /* Execute a select statement */
    hstmt = DBActivateSQL (hdbc, "SELECT UUT_NUM, \
        LOOPNUM, MEAS1, MEAS2, CHANGER FROM REC1000");

    /* Create a new record */
    resCode = DBCreateRecord(hstmt);

    /* Put values into the recorc. */
    resCode = DBPutColChar(hstmt, 1, "newrec");
    resCode = DBPutColInt(hstmt, 2, 47);
    resCode = DBPutColFloat(hstmt, 3, 23.2);
    resCode = DBPutColDouble(hstmt, 4, 42.6);
    resCode = DBPutColShort(hstmt, 5, 32);
    
    /* Put the record to the database */
    resCode = DBPutRecord(hstmt);

    /* Deactivate the SQL statement. */
    hstmt = DBDeactivateSQL (hstmt);

See also:
    DBBindColInt and DBMapColumnToInt.     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     l    The field/column number within the record where you place the value.  The first field/column number is 1.
     N    Integer value to place in the specified field/column of the current record.
     �    Result code returned by DBPutColInt.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
   Bj             Statement Handle                 B�   �          Column Number                    C_  [     `    Value                            C����         Result Code                            1        	           �    Puts a float value into the current record.  You can fetch a record then use DBPutColFloat as an alternative to binding values then fetching a record.

Note: you can use DBPutColFloat while you use binding or mapping for other fields/columns
Example:
    /* Execute a select statement */
    hstmt = DBActivateSQL (hdbc, "SELECT UUT_NUM, \
        LOOPNUM, MEAS1, MEAS2, CHANGER FROM REC1000");

    /* Create a new record */
    resCode = DBCreateRecord(hstmt);

    /* Put values into the recorc. */
    resCode = DBPutColChar(hstmt, 1, "newrec");
    resCode = DBPutColInt(hstmt, 2, 47);
    resCode = DBPutColFloat(hstmt, 3, 23.2);
    resCode = DBPutColDouble(hstmt, 4, 42.6);
    resCode = DBPutColShort(hstmt, 5, 32);
    
    /* Put the record to the database */
    resCode = DBPutRecord(hstmt);

    /* Deactivate the SQL statement. */
    hstmt = DBDeactivateSQL (hstmt);

See also:
    DBBindColFloat and DBMapColumnToFloat.     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     l    The field/column number within the record where the value is placed.  The first field/column number is 1.
     P    The float value to place in the specified field/column of the current record.
     �    Result code returned by DBPutColFloat.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
   I             Statement Handle                 I�   �          Column Number                    J  [    `    Value                            Ji���         Result Code                            1        	           �    Puts a double value into the current record. You can fetch a record then use DBPutColDouble as an alternative to binding values then fetching a record.

Note: you can use DBPutColDouble while you use binding or mapping for other fields/columns.

Example:
    /* Execute a select statement */
    hstmt = DBActivateSQL (hdbc, "SELECT UUT_NUM, \
        LOOPNUM, MEAS1, MEAS2, CHANGER FROM REC1000");

    /* Create a new record */
    resCode = DBCreateRecord(hstmt);

    /* Put values into the recorc. */
    resCode = DBPutColChar(hstmt, 1, "newrec");
    resCode = DBPutColInt(hstmt, 2, 47);
    resCode = DBPutColFloat(hstmt, 3, 23.2);
    resCode = DBPutColDouble(hstmt, 4, 42.6);
    resCode = DBPutColShort(hstmt, 5, 32);
    
    /* Put the record to the database */
    resCode = DBPutRecord(hstmt);

    /* Deactivate the SQL statement. */
    hstmt = DBDeactivateSQL (hstmt);

See also:
    DBBindColDouble and DBMapColumnToDouble.     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     l    The field/column number within the record where you place the value.  The first field/column number is 1.
     W    Double-precision value to place in the specified field/column of the current record.
     �    Result code returned by DBPutColDouble.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
   O�             Statement Handle                 PY   �          Column Number                    P�  [    `    Value                            Q,���         Result Code                            1        	           �    Puts a SQL Null value into the current record.  Note that SQL Null is distinct from NULL in C.  DBPutColNull returns an error if the field/column specified does not allow SQL Null values.

Note: you can use DBPutColNull while you use binding or mapping for other fields/columns

Example:
    /* Execute a select statement */
    hstmt = DBActivateSQL (hdbc, "SELECT UUT_NUM, \
        LOOPNUM, MEAS1, MEAS2, CHANGER FROM REC1000");

    /* Create a new record */
    resCode = DBCreateRecord(hstmt);

    /* Put values into the recorc. */
    resCode = DBPutColChar(hstmt, 1, "newrec");
    resCode = DBPutColInt(hstmt, 2, 47);
    /* If we don't want to save measurements, */
    /* we can put SQL Nulls in both columns   */
    resCode = DBPutColNull(hstmt, 3);
    resCode = DBPutColNull(hstmt, 4);
    resCode = DBPutColShort(hstmt, 5, 32);
    
    /* Put the record to the database */
    resCode = DBPutRecord(hstmt);

    /* Deactivate the SQL statement. */
    hstmt = DBDeactivateSQL (hstmt);
     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     o    The field/column number within the record where you place the SQL Null.  The first field/column number is 1.
     �    Result code returned by DBPutColNull.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
   V�             Statement Handle                 WZ   �          Column Number                    W����         Result Code                            1    	           r    Puts a binary value into the current record.  You can fetch a record then use DBPutColBinary as an alternative to binding values then fetching a record.

Note: you can use DBPutColBinary while you use binding or mapping for other fields/columns.

Example:
    unsigned char *toDBBits = NULL;
    int bitsSize = 6;

    toDBBits = malloc(bitsSize);
    /* writing this data as a sting would fail     */
    /* because it contains embedded NUL characters */
    toDBBits[0] = 'N'; toDBBits[1] = 0; toDBBits[2] = 'C';
    toDBBits[3] = 'B'; toDBBits[4] = 0; toDBBits[5] = 250;

    hstmt = DBActivateSQL(hdbc, "SELECT THEBITS FROM BINTEST");

    resCode = DBCreateRecord(hstmt);
    resCode = DBPutColBinary(hstmt, 1, toDBBits, bitsSize);
    resCode = DBPutRecord(hstmt);

    resCode = DBDeactivateSQL(hstmt);
    htmst = 0;

See also:
    DBBindColBinary and DBMapColumnToBinary.     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     l    The field/column number within the record where you place the value.  The first field/column number is 1.
     M    Binary value to place in the specified field/column of the current record.
     �    Result code returned by DBPutColBinary.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
     #    Size in bytes of the binary data.   \�             Statement Handle                 ]I   �          Column Number                    ]�      `    Value                            ^���         Result Code                      ^�  �         Size in Bytes                          1        	               �    Puts the value contained in a variant into the current record.  Variants allow additional datatypes beyond the traditional integer, short, float, double and string.

Note: you can use DBPutColVariant while you use binding or mapping for other fields/columns.

Example:
    VARIANT loopNumV;
    ...

    /* Create a new record */
    resCode = DBCreateRecord(hstmt);

    /* Put values into the recorc. */
    ...
    vStatus = CA_VariantSetInt (&loopNumV, loopNum); 
    ...
    resCode = DBPutColVariant(hstmt, 2, loopNumV);
    
    /* Put the record to the database */
    resCode = DBPutRecord(hstmt);

    /* Deactivate the SQL statement. */
    hstmt = DBDeactivateSQL (hstmt);

See also:
    DBBindColDouble and DBMapColumnToDouble.     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     l    The field/column number within the record where you place the value.  The first field/column number is 1.
     ]    Variant containing the value to place in the specified field/column of the current record.
     �    Result code returned by DBPutColVariant.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
   c             Statement Handle                 c�   �          Column Number                    d  [ �  `    Value                            dv���         Result Code                            1        	           �    Gets a string value from the current record.  You can fetch a record then use DBGetColChar as an alternative to binding values then fetching a record.  You must use DBFree to free the string.

Note: you can use DBGetColChar while you use binding or mapping for other fields/columns.

Example:
    /* Execute a select statement */
    hstmt = DBActivateSQL (hdbc, "SELECT UUT_NUM, CHANGER, \
        LOOPNUM, MEAS1, MEAS2 FROM REC1000");

    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
    /* Get values into the record. */
        resCode = DBGetColChar(hstmt, 1, &uutNum);
        resCode = DBGetColInt(hstmt, 2, &changer);
        resCode = DBGetColFloat(hstmt, 3, &meas1);
        resCode = DBGetColDouble(hstmt, 4, &meas2);
        resCode = DBGetColShort(hstmt, 5, &loopNum);
        /* process values */
        ...
        DBFree(uutNum);
   } 

    /* Deactivate the SQL statement */
    hstmt = DBDeactivateSQL (hstmt);

See also:
    DBBindColChar and DBMapColumnToChar.     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     b    The field/column number within the record to get the value from.  The first column number is 1.
     w    The variable which receives the value from the specified field/column in the record.  Use DBFree to free the string.
     �    Result code returned by DBGetColChar.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
    �    Format string.  Use the empty string "" if you want ADO to supply the formatting based on the Windows control panel settings.

Date formats support the following symbols

Symbol    Description
------    -----------
m         Month�s number suppress leading zero
mm        Month�s number with leading zero if applicable
mmm       Month�s three letter abbreviation, lowercase
Mmm       Month�s three letter abbreviation, initial cap
MMM       Month�s three letter abbreviation, upper case
mmmm      Month�s full name, lowercase
Mmmm      Month�s full name, initial cap
MMMM      Month�s full name, upper case
d         Day of the month�s number, suppress leading zero
dd        Day of the month�s number, include leading zero
ddd       Day of the month�s three letter abbreviation, 
          lowercase
Ddd       Day of the month�s three letter abbreviation, initial     
          cap
DDD       Day of the month�s three letter abbreviation, upper 
          case
dddd      Day of the month�s full name, lower case
Dddd      Day of the month�s full name, initial cap
DDDD      Day of the month�s full name, upper case
yy        Last two digits of year
yyyy      Four digit year
h         Hour of the day, suppress leading zero 
          (use am/pm symbol for 12 hour style)
hh        Hour of the day, include leading zero 
          (use am/pm symbol for 12 hour style)
i (or m)  Minute of the hour, suppress leading zero
ii (or mm)Minute of the hour, include leading zero
s         Second of the minute, suppress leading zero
ss        Second of the minute, include leading zero
ss.ssssss Second of the minute with fractional seconds, (use up
          to six �s� symbols after the decimal point)        am/pm     "am" or "pm" string, lower case (forces 12 hour clock)
a/p       "a" or "p" string.  (forces 12 hour clock)
AM/PM     "AM" or "PM" string, upper case (forces 12 hour clock)
A/P       "A" or "P" string, upper case (forces 12 hour clock)
J         Julian value for date/time.
/ - . : , Output the character
<space>   Output a space character
\<char>   Output the character following the �\� character
"<text>"  Output the text
�<text>�  Output the string
GD        Windows Short Date Format (Do not combine other format
          symbols with GD except "[US]"
GDT       Windows Short Date Format + Time Format Do not combine
          with other format symbols except "[US]")
GL        Windows Long Date Format. (Do not combine other format 
          symbols with GL except "[US]")
GLT       Windows Long Date Format + Time Format (Do not combine
          other format symbols with GLT except "[US]")
GT        Windows Time Format (Do not combine any other format
          symbols with GT)
[US]      The information in the International section of the 
          Windows control panel is ignored, instead the United
          States defaults are substituted.

Numeric Format Strings allow you to format numbers in a variety of ways. Numeric formats can have one section or two sections separated by a semicolon. Formats with one section use the same format for positive and negative numbers. Formats with two sections use the second section as the format for negative numbers. 

Number formats support the following symbols

Symbol    Description
------    -----------
$         Output the Windows currency string
.         Output the Windows decimal point character 
,         Output the Windows thousands separator character 
#         Output a digit. If there is no digit to output in the 
          position output nothing.
0         Output a digit, If there is no digit to output in the 
          position output a zero
?         Output a digit, If there is no digit to output in the 
          position output a space
%         Output the value as a percent. The value is multiplied            
          by 100 and the �%� character is output.
e+        Output in scientific notation, show exponent sign only 
          if negative
e-        Output in scientific notation, always show sign of 
          exponent
E+ E-     Upper case analogs of e+ and e-
- + ( ) , Output the character
<space>   Output a space character
\<char>   Output the character following the �\� character
"<text>"  Output the text
�<text>�  Output the text
GN        Windows General Number Format (Note you can only 
          combine GN with symbols which are enclosed in 
          brackets such as "[US]"
GF        Windows General Fixed Format for numbers (Note
          you can only combine GF with symbols which are 
          enclosed in brackets such as "[US]")
GC        Windows General Currency Format for numbers (Note you 
          can only combine GC with symbols which are enclosed 
          in brackets such as "[US]"
[S/n]     Scale (divide) the number by a power of 10 before 
          output.
[S*n]     Scale (multiply) the number by a power of 10 before 
          output. 
[US]      The information in the International section of the 
          Windows control panel is ignored, instead the United
          States defaults are substituted.
   j             Statement Handle                 j�   �          Column Number                    k  3    `    Value                            k����         Result Code                      lM  �         Format String                          1    	            	            ""       Gets a string value from the current record into a buffer.  You can fetch a record and then use DBGetColCharBuffer as an alternative to binding values then fetching a record.

Note: you can use DBGetColCharBuffer while you use binding or mapping for other fields/columns.

Example:
    /* Execute a select statement */
    hstmt = DBActivateSQL (hdbc, "SELECT UUT_NUM, CHANGER, \
        LOOPNUM, MEAS1, MEAS2 FROM REC1000");

    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
    /* Get values into the record. */
        resCode = DBGetColCharBuffer(hstmt, 1, uutNum, 10);
        ...
        /* process values */
        ...
   } 

    /* Deactivate the SQL statement */
    hstmt = DBDeactivateSQL (hstmt);

See also:
    DBBindColChar and DBMapColumnToChar.     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     b    The field/column number within the record to get the value from.  The first column number is 1.
     W    The variable which receives the value from the specified field/column in the record.
     �    Result code returned by DBGetColCharBuffer.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
         The length of the buffer.
    �    Format string.  Use the empty string "" if you want ADO to supply the formatting based on the Windows control panel settings.

Date formats support the following symbols

Symbol    Description
------    -----------
m         Month�s number suppress leading zero
mm        Month�s number with leading zero if applicable
mmm       Month�s three letter abbreviation, lowercase
Mmm       Month�s three letter abbreviation, initial cap
MMM       Month�s three letter abbreviation, upper case
mmmm      Month�s full name, lowercase
Mmmm      Month�s full name, initial cap
MMMM      Month�s full name, upper case
d         Day of the month�s number, suppress leading zero
dd        Day of the month�s number, include leading zero
ddd       Day of the month�s three letter abbreviation, 
          lowercase
Ddd       Day of the month�s three letter abbreviation, initial     
          cap
DDD       Day of the month�s three letter abbreviation, upper 
          case
dddd      Day of the month�s full name, lower case
Dddd      Day of the month�s full name, initial cap
DDDD      Day of the month�s full name, upper case
yy        Last two digits of year
yyyy      Four digit year
h         Hour of the day, suppress leading zero 
          (use am/pm symbol for 12 hour style)
hh        Hour of the day, include leading zero 
          (use am/pm symbol for 12 hour style)
i (or m)  Minute of the hour, suppress leading zero
ii (or mm)Minute of the hour, include leading zero
s         Second of the minute, suppress leading zero
ss        Second of the minute, include leading zero
ss.ssssss Second of the minute with fractional seconds, (use up
          to six �s� symbols after the decimal point)        am/pm     "am" or "pm" string, lower case (forces 12 hour clock)
a/p       "a" or "p" string.  (forces 12 hour clock)
AM/PM     "AM" or "PM" string, upper case (forces 12 hour clock)
A/P       "A" or "P" string, upper case (forces 12 hour clock)
J         Julian value for date/time.
/ - . : , Output the character
<space>   Output a space character
\<char>   Output the character following the �\� character
"<text>"  Output the text
�<text>�  Output the string
GD        Windows Short Date Format (Do not combine other format
          symbols with GD except "[US]"
GDT       Windows Short Date Format + Time Format Do not combine
          with other format symbols except "[US]")
GL        Windows Long Date Format. (Do not combine other format 
          symbols with GL except "[US]")
GLT       Windows Long Date Format + Time Format (Do not combine
          other format symbols with GLT except "[US]")
GT        Windows Time Format (Do not combine any other format
          symbols with GT)
[US]      The information in the International section of the 
          Windows control panel is ignored, instead the United
          States defaults are substituted.

Numeric Format Strings allow you to format numbers in a variety of ways. Numeric formats can have one section or two sections separated by a semicolon. Formats with one section use the same format for positive and negative numbers. Formats with two sections use the second section as the format for negative numbers. 

Number formats support the following symbols

Symbol    Description
------    -----------
$         Output the Windows currency string
.         Output the Windows decimal point character 
,         Output the Windows thousands separator character 
#         Output a digit. If there is no digit to output in the 
          position output nothing.
0         Output a digit, If there is no digit to output in the 
          position output a zero
?         Output a digit, If there is no digit to output in the 
          position output a space
%         Output the value as a percent. The value is multiplied            
          by 100 and the �%� character is output.
e+        Output in scientific notation, show exponent sign only 
          if negative
e-        Output in scientific notation, always show sign of 
          exponent
E+ E-     Upper case analogs of e+ and e-
- + ( ) , Output the character
<space>   Output a space character
\<char>   Output the character following the �\� character
"<text>"  Output the text
�<text>�  Output the text
GN        Windows General Number Format (Note you can only 
          combine GN with symbols which are enclosed in 
          brackets such as "[US]"
GF        Windows General Fixed Format for numbers (Note
          you can only combine GF with symbols which are 
          enclosed in brackets such as "[US]")
GC        Windows General Currency Format for numbers (Note you 
          can only combine GC with symbols which are enclosed 
          in brackets such as "[US]"
[S/n]     Scale (divide) the number by a power of 10 before 
          output.
[S*n]     Scale (multiply) the number by a power of 10 before 
          output. 
[US]      The information in the International section of the 
          Windows control panel is ignored, instead the United
          States defaults are substituted.
   �\             Statement Handle                 ��   �          Column Number                    �G      `    Value                            �����         Result Code                      �u �          Buffer Length                    �� c          Format String                          1    	            	                ""   �    Gets a short integer value from the current record.  You can fetch a record and then use DBGetColShort as an alternative to binding values then fetching a record. 

Note: you can use DBGetColShort while you use binding or mapping for other fields/columns

Example:
    /* Execute a select statement */
    hstmt = DBActivateSQL (hdbc, "SELECT UUT_NUM, CHANGER, \
        LOOPNUM, MEAS1, MEAS2 FROM REC1000");

    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
    /* Get values into the record. */
        resCode = DBGetColChar(hstmt, 1, &uutNum);
        resCode = DBGetColInt(hstmt, 2, &changer);
        resCode = DBGetColFloat(hstmt, 3, &meas1);
        resCode = DBGetColDouble(hstmt, 4, &meas2);
        resCode = DBGetColShort(hstmt, 5, &loopNum);
        /* process values */
        ...
        DBFree(uutNum);
   } 

    /* Deactivate the SQL statement */
    hstmt = DBDeactivateSQL (hstmt);

See also:
    DBBindColShort and DBMapColumnToShort.     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     b    The field/column number within the record to get the value from.  The first column number is 1.
     e    The short integer variable which receives the value from the specified field/column in the record.
     �    Result code returned by DBGetColShort.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
   ��             Statement Handle                 �%   �          Column Number                    ��  [    `    Value                            �����         Result Code                            1    	            	           �    Gets an integer value from the current record. You can fetch a record then use DBGetColInt as an alternative to binding values then fetching a record.  

Note: you can use DBGetColInt while you use binding or mapping for other fields/columns

Example:
    /* Execute a select statement */
    hstmt = DBActivateSQL (hdbc, "SELECT UUT_NUM, CHANGER, \
        LOOPNUM, MEAS1, MEAS2 FROM REC1000");

    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
    /* Get values from the current record. */
        resCode = DBGetColChar(hstmt, 1, &uutNum);
        resCode = DBGetColInt(hstmt, 2, &changer);
        resCode = DBGetColFloat(hstmt, 3, &meas1);
        resCode = DBGetColDouble(hstmt, 4, &meas2);
        resCode = DBGetColShort(hstmt, 5, &loopNum);
        /* process values */
        ...
        DBFree(uutNum);
   } 

    /* Deactivate the SQL statement */
    hstmt = DBDeactivateSQL (hstmt);

See also:
    DBBindColInt and DBMapColumnToInt.     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     b    The field/column number within the record to get the value from.  The first column number is 1.
     _    The integer variable which receives the value from the specified field/column in the record.
     �    Result code returned by DBGetColInt.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
   ��             Statement Handle                 �   �          Column Number                    �n  [     `    Value                            �����         Result Code                            1    	            	           �    Gets a float value from the current record.  You can fetch a record then use DBGetColFloat as an alternative to binding values then fetching a record.

Note: you can use DBGetColFloat while you use binding or mapping for other fields/columns

Example:
    /* Execute a select statement */
    hstmt = DBActivateSQL (hdbc, "SELECT UUT_NUM, CHANGER, \
        LOOPNUM, MEAS1, MEAS2 FROM REC1000");

    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
    /* Get values into the record. */
        resCode = DBGetColChar(hstmt, 1, &uutNum);
        resCode = DBGetColInt(hstmt, 2, &loopNum);
        resCode = DBGetColFloat(hstmt, 3, &meas1);
        resCode = DBGetColDouble(hstmt, 4, &meas2);
        resCode = DBGetColShort(hstmt, 5, &changer);
        /* process values */
        ...
        DBFree(uutNum);
   } 

    /* Deactivate the SQL statement */
    hstmt = DBDeactivateSQL (hstmt);

See also:
    DBBindColFloat and DBMapColumnToFloat.     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     b    The field/column number within the record to get the value from.  The first column number is 1.
     f    The floating point variable which receives the value from the specified field/column in the record.
     �    Result code returned by DBGetColFloat.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
   �V             Statement Handle                 ��   �          Column Number                    �A  [    `    Value                            �����         Result Code                            1    	           	           �    Gets a double value from the current record.  You can fetch a record then use DBGetColDouble as an alternative to binding values then fetching a record.

Note: you can use DBGetColDouble while you use binding or mapping for other fields/columns

Example:
    /* Execute a select statement */
    hstmt = DBActivateSQL (hdbc, "SELECT UUT_NUM, CHANGER, \
        LOOPNUM, MEAS1, MEAS2 FROM REC1000");

    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
    /* Get values into the record. */
        resCode = DBGetColChar(hstmt, 1, &uutNum);
        resCode = DBGetColInt(hstmt, 2, &loopNum);
        resCode = DBGetColFloat(hstmt, 3, &meas1);
        resCode = DBGetColDouble(hstmt, 4, &meas2);
        resCode = DBGetColShort(hstmt, 5, &changer);
        /* process values */
        ...
        DBFree(uutNum);
   } 

    /* Deactivate the SQL statement */
    hstmt = DBDeactivateSQL (hstmt);

See also:
    DBBindColDouble and DBMapColumnToDouble.     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     b    The field/column number within the record to get the value from.  The first column number is 1.
     h    The double precision variable which receives the value from the specified field/column in the record.
     �    Result code returned by DBGetColDouble.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
   �7             Statement Handle                 ��   �          Column Number                    �"  [    `    Value                            �����         Result Code                            1    	           	           E    Gets a binary value from the current record.  You can fetch a record then use DBGetColBinary as an alternative to binding values then fetching a record.  You must use DBFree to free the value.

Note: you can use DBGetColBinary while you use binding or mapping for other fields/columns

Example:
    unsigned char* fromDBBits = NULL;

    hstmt = DBActivateSQL(hdbc, "SELECT THEBITS FROM BINTEST");

    while ((dbStatus = DBFetchNext(hstmt) == DB_SUCCESS) {
        dbStatus = DBGetColBinary(hstmt, 1, 
                                  (void **)(&fromDBBits));
        if (dbStatus == DB_NULL_DATA) {
           /* processing for NULL data */
        }
        ...
        DBFree(fromDBBits);
    }
    dbStatus = DBDeactivateSQL(hstmt);
    hstmt = 0;

See also:
    DBGEtColBinaryBuffer, DBBindColBinary and
    DBMapColumnToBinary.     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     b    The field/column number within the record to get the value from.  The first column number is 1.
     �    The variable which receives the binary value from the specified field/column in the record.  You must use DBFree to free the value.
     �    Result code returned by DBGetColBinary.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
   ��             Statement Handle                 �    �          Column Number                    ��  [    `    Value                            ����         Result Code                            1    	            	               Gets a binary value from the current record into a buffer.  You can fetch a record then use DBGetColBinaryBuffer as an alternative to binding values then fetching a record.

Note: you can use DBGetColBinaryBuffer while you use binding or mapping for other fields/columns

Example:
    unsigned char fromDBBits[6];

    hstmt = DBActivateSQL(hdbc, "SELECT THEBITS FROM BINTEST");

    while ((dbStatus = DBFetchNext(hstmt)) == DB_SUCCESS) {
        dbStatus = DBGetColBinaryBuffer(hstmt, 1, fromDBBits,
                                        bitsSize);
        if (dbStatus == DB_NULL_DATA) {
            /* handle NULLs */
        }
        /* Use the value */
    }
    dbStatus = DBDeactivateSQL(hstmt);
    hstmt = 0;

See also:
    DBBindColChar and DBMapColumnToChar.     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     b    The field/column number within the record to get the value from.  The first column number is 1.
     U    The buffer which receives the value from the specified field/column in the record.
     �    Result code returned by DBGetColBinaryBuffer.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
         The length of the buffer.
   ��             Statement Handle                 �h   �          Column Number                    ��      `    Value                            �/���         Result Code                      �  �         Buffer Length                          1    	            	               V    Gets a value from the current record as a Variant.  Variants are useful for datatypes beyond the traditional integer, short, float, double and string types.

Note: you can use DBGetColVariant while you use binding or mapping for other fields/columns

Example:
    VARIANT loopNumV
    ...
    /* Execute a select statement */
    hstmt = DBActivateSQL (hdbc, "SELECT UUT_NUM, CHANGER, \
        LOOPNUM, MEAS1, MEAS2 FROM REC1000");

    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        ...
        resCode = DBGetColVariant(hstmt, 2, &loopNumV);
        vStatus = CA_VariantConvertToType (&loopNumV, CAVT_INT,
                                           &loopNum);
        ...
   } 

    /* Deactivate the SQL statement */
    hstmt = DBDeactivateSQL (hstmt);

See also:
    DBBindColFloat and DBMapColumnToFloat.

Known problems:

ADO 2.0 does not properly set variants which contain values of type CAVT_DECIMAL and the value is a multiple of 10.  There are two workarounds for this problem

Use a client side cursor. You must use DBNewSQLStatement instead of DBActivateSQL in order to use this workaround.
    hstmt = DBNewSQLStatement(hdbc, "select * from foo");
    TRY(DBSetStatementAttribute (hstmt,
                               ATTR_DB_STMT_CURSOR_LOCATION,
                               DB_CURSOR_LOC_CLIENT));
    TRY(DBOpenSQLStatement(hstmt));

Use the following function, SP_VariantConvertToType, instead of CA_VariantConvertToType to extract values from the variant.
    #ifndef VT_DECIMAL
    #define VT_DECIMAL 14
    #endif
    typedef struct tagDEC_FAKE {
        USHORT wReserved;
        union {
            struct {
                BYTE scale;
                BYTE sign;
            }s1;
            USHORT signscale;
        }n1;
        ULONG Hi32;
        union {
            struct {
                ULONG Lo32;
                ULONG Mid32;
            }n2;
            char Lo64[8];
        }n3;
    } MSVC_DECIMAL;
    typedef  struct tagVARIANT_FAKE VARIANT_FAKE;

    struct  tagVARIANT_FAKE {
        union         {
            struct  __tagVARIANT {
                VARTYPE vt;
                WORD wReserved1;
                WORD wReserved2;
                WORD wReserved3;
                union                 {
                      char dummy[8];
                } n1; 
            } n2;
            MSVC_DECIMAL decVal;
        } n3;
    };
    static HRESULT CVIFUNC SP_VariantConvertToType(
        VARIANT *variant, 
        unsigned cavt, 
        void *ptrToResult)
    {
        HRESULT firstStat;
        char msg[50];

        firstStat = CA_VariantConvertToType((VARIANT *)variant, 
                                             cavt,ptrToResult);
        if ((firstStat == -2147024809) 
            && (variant->vt == VT_DECIMAL)) {
            double value;
            HRESULT temp;
            char scale;
            VARIANT_FAKE* fakeVariant;
            fakeVariant = (VARIANT_FAKE *)variant;
            scale = fakeVariant->n3.decVal.n1.s1.scale;

            fakeVariant->n3.decVal.n1.s1.scale = 0;

            temp = CA_VariantConvertToType(variant, CAVT_DOUBLE, 
                                           &value);
            if (temp != DB_SUCCESS)
                return firstStat;
            while (scale) {
                if (scale > 0) {
                    value = value / 10;
                    scale--;
                } else {
                    value = value * 10;
                    scale++;
                }
            }
            temp = CA_VariantSetDouble(variant, value);
            if (temp != DB_SUCCESS)
                goto Error;
            temp = CA_VariantConvertToType(variant, cavt, 
                                           ptrToResult);
            if (temp != DB_SUCCESS)
                goto Error;
            return temp;
        }
        return firstStat;
    Error:
        return firstStat;
    }

     y    Handle to the SQL statement from DBActivateSQL, DBActivateMap or any of the functions that returns a statement handle.
     b    The field/column number within the record to get the value from.  The first column number is 1.
    -    The variant variable which receives the value from the specified field/column in the record.  To free any allocated memory within the variant this function returns use CA_VariantClear.  

See the documentation for the CVI ActiveX Automation Library for more information about working with Variants.
     �    Result code returned by DBGetColVariant.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.
   Ӱ             Statement Handle                 �1   �          Column Number                    ԛ  [ �  `    Value                            �����         Result Code                     ���� � ���                                                1    	           	            6See function help for a workaround for an ADO problem   �    Retrieves provider-side parameter information for the stored procedure or parameterized query associated with the statement.
Using DBRefreshParams can cause your program to run more slowly than when you specify the parameters with the DBCreateParam functions.

DBRefreshParams is not supported by all providers and database drivers.

Example:
    int inParam, outParam, retParam;
    ...    
    /* Create the stored procedure */
    resCode = DBImmediateSQL(hdbc, "create proc sp_CVITest( \
            @InParam int, @OutParam int OUTPUT ) as select \
            @OutParam = @InParam + 10 SELECT * FROM Authors \
            WHERE State <> 'CA' return @OutParam +10");
    
    /* Specify that the next command is a stored procedure */
    resCode = DBSetAttributeDefault(hdbc, ATTR_DB_COMMAND_TYPE,
                                    DB_COMMAND_STORED_PROC);
    hstmt = DBPrepareSQL (hdbc, "sp_CVItest");
    
    /* Refresh the parameters from the stored procedure.    */
    /* Note: we could also create the parameters instead    */
    resCode = DBRefreshParams(hstmt);
    
    /* Set the input parameter */
    resCode = DBSetParamInt(hstmt, 1, 10);
    
    /* Execute the statement */
    resCode = DBExecutePreparedSQL(hstmt);
    while ((resCode = DBFetchNext (hstmt)) == DB_SUCCESS) {
        /* process records returned by the stored procedure */
    }
    /* You must close the statement before you can */
    /* examine output parameters.                  */
    resCode = DBClosePreparedSQL(hstmt);

    /* Examine the parameters */
    resCode = DBGetParamInt(hstmt, 0, &retParam);
    resCode = DBGetParamInt(hstmt, 1, &inParam);
    resCode = DBGetParamInt(hstmt, 2, &outParam);

    /* Discard the statement. */
    hstmt = DBDiscardSQLStatement(hstmt);
     9    Handle to the SQL statement that DBPrepareSQL returned.     �    Result code returned by DBRefreshParams.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.   �� &            Statement Handle                 �<���         Result Code                            	               Clear the value of a parameter by setting the value to empty.  You do not need to call this function before changing the value of a parameter.  You do not need to call this function before closing a prepared statement.  You do not need to call this function.
     �    Handle to the SQL statement that DBPrepareSQL returned.  You cannot use a statement handle from DBActivateSQL, DBActivateMap, or DBNewSQLStatement.     �    Result code returned by DBSetParamInt.  This function returns the set of result codes listed in the function description for DBError.  Use DBErrorMessage to get the text of the error message.         The index of the parameter.   � !            Statement Handle                 �+���         Result Code                      �� ! �          Index                                  	            1   �    Enables or disables fetching SELECT statement results in either direction for a database connection.  This function must be called before DBActivateSQL DBActivateMap, DBPrepareSQL or DBNewSQLStatement.

DBAllowFetchAnyDirection is obsolete. Use DBSetAttributeDefault with ATTR_DB_CURSOR_TYPE instead.


Example:

    resCode = DBAllowFetchAnyDirection(hdbc,TRUE);
    hstmt = DBActivateSQL(hdbc, "SELECT * FROM TESTLOG");
    numRecs = DBNumberOfRecords(hstmt)
    /* Fetch the last record. */
    resCode = DBFetchRandom(hstmt,numRecs);
    ...
    resCode = DBDeactivateSQL();

See Also:
    DBFetchNext, DBFetchPrev, DBFetchRandom, DBSetAttributeDefault
     K    The handle to the database connection that DBConnect previously returned.     J    1 enable fetching in any direction
0 disable fetching in any direction.
     �    Result code that DBAllowFetchAnyDirection returns.  This function returns the set of result codes listed in the function description for DBError.
   �h 4 T           Connection Handle                � 5 �          Enable                           ����         Result Code                           Yes 1 No 0    	         ����         �  _     K.    DBInit                          ����         "  �     K.    DBConnect                       ����         A  +{     K.    DBSetAttributeDefault           ����         ,�  /�     K.    DBDisconnect                    ����         00  2�     K.    DBSetDatabase                   ����         3`  8�     K.    DBBeginMap                      ����         9)  W"     K.    DBMapColumnToChar               ����         X�  b$     K.    DBMapColumnToShort              ����         c[  l�     K.    DBMapColumnToInt                ����         m�  ws     K.    DBMapColumnToFloat              ����         x�  �(     K.    DBMapColumnToDouble             ����         �_  �Y     K.    DBMapColumnToBinary             ����         ��  ��     K.    DBCreateTableFromMap            ����         �S  �,     K.    DBActivateMap                   ����         ��  �     K.    DBDeactivateMap                 ����         ��  ��     K.    DBImmediateSQL                  ����         �>  ��     K.    DBActivateSQL                   ����         �e  Ğ     K.    DBBindColChar                   ����         �H  ��     K.    DBBindColShort                  ����         �#  ��     K.    DBBindColInt                    ����         �  ��     K.    DBBindColFloat                  ����         �  ��     K.    DBBindColDouble                 ����         ��  �n     K.    DBBindColBinary                 ����         ��  ��     K.    DBDeactivateSQL                 ����         �@  ��     K.    DBFetchNext                     ����         �v (     K.    DBFetchPrev                     ����         	�     K.    DBFetchRandom                   ����        
� f     K.    DBCreateRecord                  ����        � @     K.    DBDeleteRecord                  ����        � �     K.    DBPutRecord                     ����        D �     K.    DBCancelRecordChanges           ����        1 $�     K.    DBUpdateBatch                   ����        %} *�     K.    DBSources                       ����        +| 0"     K.    DBDatabases                     ����        0� ;�     K.    DBTables                        ����        =B P�     K.    DBIndexes                       ����        Q� Z     K.    DBPrimaryKeys                   ����        Z� j�     K.    DBForeignKeys                   ����        k� �V     K.    DBOpenSchema                    ����        �$ ��     K.    DBNumberOfRecords               ����        �� �     K.    DBNumberOfColumns               ����        �{ �?     K.    DBColumnName                    ����        �� ��     K.    DBColumnWidth                   ����        �t �m     K.    DBColumnType                    ����        �! ̵     K.    DBSetColumnAttribute            ����        �( �     K.    DBGetColumnAttribute            ����        �7 ��     K.    DBNumberOfModifiedRecords       ����        �t ��     K.    DBBeginTran                     ����        �I �`     K.    DBCommit                        ����        �� N     K.    DBRollback                      ����        � y     K.    DBError                         ����        � 
     K.    DBWarning                       ����        
I h     K.    DBNativeError                   ����        � h     K.    DBErrorMessage                  ����        � �     K.    DBFree                          ����        � �     K.    DBGetSQLToolkitVersion          ����        � S     K.    DBSetBackwardCompatibility      ����        � �     K.    DBNewConnection                 ����        	 B�     K.    DBSetConnectionAttribute        ����        E5 ni     K.    DBGetConnectionAttribute        ����        qB u<     K.    DBOpenConnection                ����        u� y`     K.    DBCloseConnection               ����        y� }�     K.    DBDiscardConnection             ����        ~ �y     K.    DBNewSQLStatement               ����        �. ��     K.    DBSetStatementAttribute         ����        �$ �     K.    DBGetStatementAttribute         ����        � �     K.    DBOpenSQLStatement              ����        % y     K.    DBMoreResults                   ����        � "B     K.    DBGetVariantArray               ����        # :� 	    K.    DBGetVariantArrayValue          ����        =� V� 
    K.    DBGetVariantArrayColumn         ����        ZZ `b     K.    DBFreeVariantArray              ����        a� g�     K.    DBCloseSQLStatement             ����        h1 m@     K.    DBDiscardSQLStatement           ����        m� {E     K.    DBPrepareSQL                    ����        {� �     K.    DBCreateParamInt                ����        �� �@     K.    DBCreateParamShort              ����        � �@     K.    DBCreateParamFloat              ����        � ��     K.    DBCreateParamDouble             ����        �O      K.    DBCreateParamChar               ����        č �     K.    DBCreateParamBinary             ����        � ��     K.    DBSetParamInt                   ����        ߴ �k     K.    DBSetParamShort                 ����        �X �     K.    DBSetParamFloat                 ����        � �3     K.    DBSetParamDouble                ����        �  L     K.    DBSetParamChar                  ����        v �     K.    DBSetParamBinary                ����        � &�     K.    DBSetParamVariant               ����        '� /9     K.    DBExecutePreparedSQL            ����        /� P�     K.    DBSetParamAttribute             ����        R� su     K.    DBGetParamAttribute             ����        u� ~�     K.    DBGetParamInt                   ����        � ��     K.    DBGetParamShort                 ����        �� ��     K.    DBGetParamFloat                 ����        �v ��     K.    DBGetParamDouble                ����        �� �)     K.    DBGetParamChar                  ����        �Y �\     K.    DBGetParamCharBuffer            ����        �� �     K.    DBGetParamBinary                ����        � �]     K.    DBGetParamBinaryBuffer          ����        �� �     K.    DBGetParamVariant               ����        � �     K.    DBClosePreparedSQL              ����        C 6�     K.    DBPutColChar                    ����        7� =�     K.    DBPutColShort                   ����        >� D}     K.    DBPutColInt                     ����        Ej K3     K.    DBPutColFloat                   ����        L  Q�     K.    DBPutColDouble                  ����        R� X�     K.    DBPutColNull                    ����        YN _     K.    DBPutColBinary                  ����        `. eB     K.    DBPutColVariant                 ����        f/ �     K.    DBGetColChar                    ����        �N �j     K.    DBGetColCharBuffer              ����        �� ��     K.    DBGetColShort                   ����        �� ��     K.    DBGetColInt                     ����        �� �y     K.    DBGetColFloat                   ����        �n �]     K.    DBGetColDouble                  ����        �R ��     K.    DBGetColBinary                  ����        �� �$     K.    DBGetColBinaryBuffer            ����        �R ֜     K.    DBGetColVariant                 ����        �� �     K.    DBRefreshParams                 ����        �� �     K.    DBClearParam                    ����        �� �     K.    DBAllowFetchAnyDirection              y                                     DInitialize Threading                CConnection                           DOpen New Connection                  DSet Default Attribute                DClose and Discard Connection         DSet Database                        �Automatic SQL (maps)                 DBegin Map                            DMap Column to String                 DMap Column to Short Integer          DMap Column to Integer                DMap Column to Float                  DMap Column to Double                 DMap Column to Binary                 DCreate Table From Map                DActivate Map                         DDeactivate Map                      �Explicit SQL                         DImmediate SQL Statement              DActivate SQL Statement               DBind Column to String                DBind Column to Short Integer         DBind Column to Integer               DBind Column to Float                 DBind Column to Double                DBind Column to Binary                DDeactivate SQL Statement            �Fetch Records                        DFetch Next Record                    DFetch Previous Record                DFetch Random Record                 IInsert/Delete/Update Records         DCreate New Record                    DDelete Record                        DPut Record                           DCancel Record Changes                DBatch Update                        �Information Functions               gData Source Information              DAvailable Sources                    DAvailable Databases                  DAvailable Tables                     DIndexes Information                  DPrimary Keys Information             DForeign Keys Information             DOpen Schema                         �SELECT Information                   DNumber of Records                    DNumber Of Columns                    DColumn Name                          DColumn Width                         DColumn Type                          DSet Column Attribute                 DGet Column Attribute                 DNumber of Modified Records          Transactions                         DBegin Transaction                    DCommit Transaction                   DRollback Transaction                �Errors                               DError Code                           DWarning Code                         DNative Error Code                    DError/Warning Text                  �Freeing Resources                    DFree Memory                          Compatibility                        DGet Toolkit Version                  DSet Backward Compatibility          oAdvanced Functions                  Advanced Connections                 DNew Connection                       DSet Connection Attribute             DGet Connection Attribute             DOpen Connection                      DClose Connection                     DDiscard Connection                  �Advanced Statements                  DNew SQL Statement                    DSet Statement Attribute              DGet Statement Attribute              DOpen SQL Statement                   DMore Results                        	�Get Records as Array                 DGet Records as Array                 DGet Record Array Element             DGet Record Array Column              DFree Variant Array                   DClose SQL Statement                  DDiscard SQL Statement             ����SQL with Parameters                  DPrepare SQL Statement               	�Create Parameters                    DCreate Integer Parameter             DCreate Short Integer Parameter       DCreate Float Parameter               DCreate Double Parameter              DCreate String Parameter              DCreate Binary Parameter             
ASet Parameters                       DSet Parameter to Integer             DSet Parameter to Short               DSet Parameter to Float               DSet Parameter to Double              DSet Parameter to String              DSet Parameter to Binary              DSet Parameter to Variant             DExecute Prepared SQL                 DSet Parameter Attribute              DGet Parameter Attribute             
�Get Parameter Values                 DGet Parameter as Integer             DGet Parameter as Short               DGet Parameter as Float               DGet Parameter as Double              DGet Parameter as String              DGet Parameter as String Buffer       DGet Parameter as Binary              DGet Parameter as Binary Buffer       DGet Parameter as Variant             DClose Prepared SQL                  
�Put Values Directly to Record        DPut String in Record                 DPut Short Integer in Record          DPut Integer in Record                DPut Float in Record                  DPut Double in Record                 DPut Null in Record                   DPut Binary Data in Record            DPut Variant in Record               IGet Values Directly from Record      DGet String from Record               DGet String Buffer                    DGet Short from Record                DGet Integer from Record              DGet Float from Record                DGet Double from Record               DGet Binary Data from Record          DGet Binary Buffer                    DGet Variant from Record           ����Obsolete or Deprecated               DRefresh Parameters                   DClear Parameter                      DAllow Previous or Random Fetch  