# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "lsb_val" -parent ${Page_0}


}

proc update_PARAM_VALUE.lsb_val { PARAM_VALUE.lsb_val } {
	# Procedure called to update lsb_val when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.lsb_val { PARAM_VALUE.lsb_val } {
	# Procedure called to validate lsb_val
	return true
}


proc update_MODELPARAM_VALUE.lsb_val { MODELPARAM_VALUE.lsb_val PARAM_VALUE.lsb_val } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.lsb_val}] ${MODELPARAM_VALUE.lsb_val}
}

