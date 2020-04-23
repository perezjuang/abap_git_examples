report Y_PROGRAM_TEST.


class lcl_data definition.
  public section.
  methods: constructor.
endclass.                    "lcl_Data DEFINITION
*
interface lif_write.
  methods: write_data.
endinterface.                    "lif_write DEFINITION
*
class lcl_open_workflow definition.
  public section.
  interfaces: lif_write.
endclass.                    "lcl_open_workflow DEFINITION
*
class lcl_write_log definition.
  public section.
  interfaces: lif_write.
endclass.                    "lcl_write_log DEFINITION
*
class lcl_facade definition.
  public section.
  methods: process_report importing iv_write_type type char1.
endclass.                    "lcl_facade DEFINITION
*
class lcl_data implementation.
  method constructor.
    write: / 'Getting Data'.
  endmethod.                    "constructor
endclass.                    "lcl_Data IMPLEMENTATION
*
class lcl_open_workflow implementation.
  method lif_write~write_data.

* Data Declarations
    data: lv_class            type sibftypeid,
          lv_event             type sibfevent,
          lv_objkey           type sibfinstid,
          lr_event_parameters type ref to if_swf_ifs_parameter_container,
          lv_param_name       type swfdname,
          lv_id               type char10.


    lv_class = 'YCL_TEST_WORKFLOW_JUGPEREZ'.
    lv_event   = 'RUN_WORKFLOW'.

* Instantiate an empty event container
    call method cl_swf_evt_event=>get_event_container
    exporting
      im_objcateg  = cl_swf_evt_event=>mc_objcateg_cl
      im_objtype   = lv_class
      im_event     = lv_event
      RECEIVING
      re_reference = lr_event_parameters.

* Set up the name/value pair to be added to the container
    lv_param_name  = 'I_P1'.  " parameter name of the event
    lv_id          = '10'.

    try.
      call method lr_event_parameters->set
      exporting
        name  = lv_param_name
        value = lv_id.

    catch cx_swf_cnt_cont_access_denied .
    catch cx_swf_cnt_elem_access_denied .
    catch cx_swf_cnt_elem_not_found .
    catch cx_swf_cnt_elem_type_conflict .
    catch cx_swf_cnt_unit_type_conflict .
    catch cx_swf_cnt_elem_def_invalid .
    catch cx_swf_cnt_container .
    endtry.

* Raise the event passing the event container
    try.
      call method cl_swf_evt_event=>raise
      exporting
        im_objcateg        = cl_swf_evt_event=>mc_objcateg_cl
        im_objtype         = lv_class
        im_event           = lv_event
        im_objkey          = lv_objkey
        im_event_container = lr_event_parameters.
    catch cx_swf_evt_invalid_objtype .
    catch cx_swf_evt_invalid_event .
    endtry.

    commit work.



    write: / 'Workflow Lanzado'.
  endmethod.                    "lif_write~write_Data
endclass.                    "lcl_open_workflow IMPLEMENTATION
*
class lcl_write_log implementation.
  method lif_write~write_data.




    write: / 'Escribiendo algo sin lanzar workflow'.
  endmethod.                    "lif_write~write_Data
endclass.                    "lcl_write_log IMPLEMENTATION
*
class lcl_facade implementation.
  method process_report.
    data: lo_data type ref to lcl_data.
    create OBJECT lo_data.

    data: lo_write type ref to lif_write.
    if iv_write_type = abap_true.
      create OBJECT lo_write type lcl_open_workflow.
    else.
      create OBJECT lo_write type lcl_write_log.
    endif.
    lo_write->write_data( ).
  endmethod.                    "process_report
endclass.                    "lcl_facade IMPLEMENTATION


parameters : P_CHK as checkbox .

START-of-SELECTION.
data: lo_facade type ref to lcl_facade.
create OBJECT lo_facade.
lo_facade->process_report( iv_write_type = P_CHK ).
