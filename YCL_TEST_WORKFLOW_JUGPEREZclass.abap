class YCL_TEST_WORKFLOW_JUGPEREZ definition
  public
  final
  create public .

public section.

  interfaces BI_OBJECT .
  interfaces BI_PERSISTENT .
  interfaces IF_WORKFLOW .

  data GS_KEY type CHAR100 read-only .
  data GS_LPOR type SIBFLPOR .

  methods GET_RESULT
    importing
      value(IS_P1) type I optional
      value(IS_P2) type I optional
    exporting
      value(ES_RE) type I .
  methods CONSTRUCTOR
    importing
      value(IS_ID) type CHAR10 default '1234567890' .
  methods CREATE
    importing
      value(IS_ID) type CHAR10 optional .
protected section.
private section.

  data GO_INSTANCE type ref to YCL_TEST_WORKFLOW_JUGPEREZ .
ENDCLASS.



CLASS YCL_TEST_WORKFLOW_JUGPEREZ IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method YCL_TEST_WORKFLOW_JUGPEREZ->BI_OBJECT~DEFAULT_ATTRIBUTE_VALUE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RESULT                         TYPE REF TO DATA
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method BI_OBJECT~DEFAULT_ATTRIBUTE_VALUE.
  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method YCL_TEST_WORKFLOW_JUGPEREZ->BI_OBJECT~EXECUTE_DEFAULT_METHOD
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method BI_OBJECT~EXECUTE_DEFAULT_METHOD.
  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method YCL_TEST_WORKFLOW_JUGPEREZ->BI_OBJECT~RELEASE
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method BI_OBJECT~RELEASE.
  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method YCL_TEST_WORKFLOW_JUGPEREZ=>BI_PERSISTENT~FIND_BY_LPOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] LPOR                           TYPE        SIBFLPOR
* | [<-()] RESULT                         TYPE REF TO BI_PERSISTENT
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method BI_PERSISTENT~FIND_BY_LPOR.

  create OBJECT result
  type YCL_TEST_WORKFLOW_JUGPEREZ
  exporting IS_ID = LPOR-instid(10).

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method YCL_TEST_WORKFLOW_JUGPEREZ->BI_PERSISTENT~LPOR
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RESULT                         TYPE        SIBFLPOR
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method BI_PERSISTENT~LPOR.
  result = ME->GS_LPOR.
  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method YCL_TEST_WORKFLOW_JUGPEREZ->BI_PERSISTENT~REFRESH
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method BI_PERSISTENT~REFRESH.
  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method YCL_TEST_WORKFLOW_JUGPEREZ->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] IS_ID                          TYPE        CHAR10 (default ='1234567890')
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method CONSTRUCTOR.

  GS_LPOR-catid = 'CL'.
  GS_LPOR-typeid = 'YCL_TEST_WORKFLOW_JUGPEREZ'.
  GS_LPOR-instid = IS_ID.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method YCL_TEST_WORKFLOW_JUGPEREZ->CREATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] IS_ID                          TYPE        CHAR10(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method CREATE.

  create OBJECT Go_instance
  type YCL_TEST_WORKFLOW_JUGPEREZ
  exporting IS_ID = IS_ID.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method YCL_TEST_WORKFLOW_JUGPEREZ->GET_RESULT
* +-------------------------------------------------------------------------------------------------+
* | [--->] IS_P1                          TYPE        I(optional)
* | [--->] IS_P2                          TYPE        I(optional)
* | [<---] ES_RE                          TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method GET_RESULT.

      ES_RE = IS_P1 + IS_P2.

  endmethod.
ENDCLASS.
