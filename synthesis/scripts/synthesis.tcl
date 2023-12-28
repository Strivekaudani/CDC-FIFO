set search_path [list . $search_path} "/apps/design_kits/ibm_kits/IBM_IP/ibm_cmos8hp/std_cell/sc/v.20110613/synopsys/ss_125" "../src" "../db"]
set target_library IBM_CMOS8HP_SS125.db
set link_library { * IBM_CMOS8HP_SS125.db }
set acs_work_dir "."

set DESIGN "tail_light_control"

# analyze design
analyze -format verilog { ../source/tail_light_control.v }

# elaborate design
elaborate program_counter -architecture verilog -library DEFAULT
uniquify

# constraints
source ../constraints/constraints.tcl

# check design for issues
check_design

# compile design
compile -exact_map

#compile -map_effort high -incremental

# reports
## worst case timing paths
redirect ../reports/${DESIGN}_timing_worst.rpt {report_timing -path full -delay max -nworst 20 -max_paths 20 -significant_digits 3 -sort_by group }

redirect ../reports/${DESIGN}_area.rpt {report_area}

redirect ../reports/${DESIGN}_area_hier.rpt {report_area -hierarchy }

# write netlist
write -hierarchy -format verilog -output ../netlists/${DESIGN}_syn.v
