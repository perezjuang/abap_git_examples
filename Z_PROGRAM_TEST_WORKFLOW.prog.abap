REPORT Z_PROGRAM_TEST.


CLASS lcl_data DEFINITION.
  PUBLIC SECTION.
    METHODS: constructor.
ENDCLASS.                    "lcl_Data DEFINITION
*
INTERFACE lif_write.
  METHODS: write_data.
ENDINTERFACE.                    "lif_write DEFINITION
*
CLASS lcl_open_workflow DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_write.
ENDCLASS.                    "lcl_open_workflow DEFINITION
*
CLASS lcl_write_log DEFINITION.
  PUBLIC SECTION.
    INTERFACES: lif_write.
ENDCLASS.                    "lcl_write_log DEFINITION
*
CLASS lcl_facade DEFINITION.
  PUBLIC SECTION.
    METHODS: process_report IMPORTING iv_write_type TYPE char1.
ENDCLASS.                    "lcl_facade DEFINITION
*
CLASS lcl_data IMPLEMENTATION.
  METHOD constructor.
    WRITE: / 'Getting Data'.
  ENDMETHOD.                    "constructor
ENDCLASS.                    "lcl_Data IMPLEMENTATION
*
CLASS lcl_open_workflow IMPLEMENTATION.
  METHOD lif_write~write_data.

* Data Declarations
  DATA: lv_class            TYPE sibftypeid,
        lv_event             TYPE sibfevent,
         lv_objkey           TYPE sibfinstid,
  lr_event_parameters TYPE REF TO if_swf_ifs_parameter_container,
  lv_param_name       TYPE swfdname,
  lv_id               TYPE char10.


  lv_class = 'ZCL_TEST_WORKFLOW'.
  lv_event   = 'TRIGGER_RUN_WORKFLOW'.

* Instantiate an empty event container
  CALL METHOD cl_swf_evt_event=>get_event_container
    EXPORTING
      im_objcateg  = cl_swf_evt_event=>mc_objcateg_cl
      im_objtype   = lv_class
      im_event     = lv_event
    RECEIVING
      re_reference = lr_event_parameters.

* Set up the name/value pair to be added to the container
  lv_param_name  = 'I_ID'.  " parameter name of the event
  lv_id          = '1111111111'.

  TRY.
      CALL METHOD lr_event_parameters->set
        EXPORTING
          name  = lv_param_name
          value = lv_id.

    CATCH cx_swf_cnt_cont_access_denied .
    CATCH cx_swf_cnt_elem_access_denied .
    CATCH cx_swf_cnt_elem_not_found .
    CATCH cx_swf_cnt_elem_type_conflict .
    CATCH cx_swf_cnt_unit_type_conflict .
    CATCH cx_swf_cnt_elem_def_invalid .
    CATCH cx_swf_cnt_container .
  ENDTRY.

* Raise the event passing the event container
  TRY.
      CALL METHOD cl_swf_evt_event=>raise
        EXPORTING
          im_objcateg        = cl_swf_evt_event=>mc_objcateg_cl
          im_objtype         = lv_class
          im_event           = lv_event
          im_objkey          = lv_objkey
          im_event_container = lr_event_parameters.
    CATCH cx_swf_evt_invalid_objtype .
    CATCH cx_swf_evt_invalid_event .
  ENDTRY.

  COMMIT WORK.



    WRITE: / 'Workflow Lanzado'.
  ENDMETHOD.                    "lif_write~write_Data
ENDCLASS.                    "lcl_open_workflow IMPLEMENTATION
*
CLASS lcl_write_log IMPLEMENTATION.
  METHOD lif_write~write_data.




    WRITE: / 'Escribiendo algo sin lanzar workflow'.
  ENDMETHOD.                    "lif_write~write_Data
ENDCLASS.                    "lcl_write_log IMPLEMENTATION
*
CLASS lcl_facade IMPLEMENTATION.
  METHOD process_report.
    DATA: lo_data TYPE REF TO lcl_data.
    CREATE OBJECT lo_data.

    DATA: lo_write TYPE REF TO lif_write.
    IF iv_write_type = abap_true.
      CREATE OBJECT lo_write TYPE lcl_open_workflow.
    ELSE.
      CREATE OBJECT lo_write TYPE lcl_write_log.
    ENDIF.
    lo_write->write_data( ).
  ENDMETHOD.                    "process_report
ENDCLASS.                    "lcl_facade IMPLEMENTATION


PARAMETERS : P_CHK AS CHECKBOX .

START-OF-SELECTION.
  DATA: lo_facade TYPE REF TO lcl_facade.
  CREATE OBJECT lo_facade.
  lo_facade->process_report( iv_write_type = P_CHK ).
