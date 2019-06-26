class ZCL_TEST_WORKFLOW definition
  public
  final
  create public .

public section.

  interfaces BI_OBJECT .
  interfaces BI_PERSISTENT .
  interfaces IF_WORKFLOW .

  data M_KEY type CHAR10 value '1234567890'. "#EC NOTEXT .  .  .  .  .  .  . " .

  methods GET_RESULT
    importing
      value(I_P1) type I optional
      value(I_P2) type I optional
    exporting
      value(E_P3) type I .
  methods CONSTRUCTOR
    importing
      value(I_ID) type CHAR10 default '1234567890' .
  methods CREATE
    importing
      value(I_ID) type CHAR10 optional .
protected section.
private section.

  data E_INSTANCE type ref to ZCL_TEST_WORKFLOW .
  data M_LPOR type SIBFLPOR .               " .
ENDCLASS.



CLASS ZCL_TEST_WORKFLOW IMPLEMENTATION.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Static Public Method ZCL_TEST_WORKFLOW=>BI_PERSISTENT~FIND_BY_LPOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] LPOR                           TYPE        SIBFLPOR
* | [<-()] RESULT                         TYPE REF TO BI_PERSISTENT
* +--------------------------------------------------------------------------------------</SIGNATURE>
method bi_persistent~find_by_lpor.
  BREAK-POINT.
CREATE OBJECT result TYPE zcl_test_workflow EXPORTING i_id = lpor-instid(10).
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_TEST_WORKFLOW->BI_PERSISTENT~LPOR
* +-------------------------------------------------------------------------------------------------+
* | [<-()] RESULT                         TYPE        SIBFLPOR
* +--------------------------------------------------------------------------------------</SIGNATURE>
method BI_PERSISTENT~LPOR.
  BREAK-POINT.
"Called by workflow requesting an instance's key
result = ME->m_lpor.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_TEST_WORKFLOW->BI_PERSISTENT~REFRESH
* +-------------------------------------------------------------------------------------------------+
* +--------------------------------------------------------------------------------------</SIGNATURE>
method BI_PERSISTENT~REFRESH.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_TEST_WORKFLOW->CONSTRUCTOR
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ID                           TYPE        CHAR10 (default ='1234567890')
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CONSTRUCTOR.
m_lpor-catid = 'CL'.
m_lpor-typeid = 'ZCL_TEST_WORKFLOW'.
m_lpor-instid = i_ID.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_TEST_WORKFLOW->CREATE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ID                           TYPE        CHAR10(optional)
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE.
CREATE OBJECT e_instance TYPE zcl_test_workflow EXPORTING i_id = i_id.
endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_TEST_WORKFLOW->GET_RESULT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_P1                           TYPE        I(optional)
* | [--->] I_P2                           TYPE        I(optional)
* | [<---] E_P3                           TYPE        I
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_RESULT.
E_P3 = I_P1 * I_P2.
endmethod.
ENDCLASS.
