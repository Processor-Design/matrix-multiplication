transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Academic\ Content/Semester\ 5/Processor\ Design/mattrix\ multiplication {C:/Academic Content/Semester 5/Processor Design/mattrix multiplication/IROM.v}
vlog -vlog01compat -work work +incdir+C:/Academic\ Content/Semester\ 5/Processor\ Design/mattrix\ multiplication {C:/Academic Content/Semester 5/Processor Design/mattrix multiplication/DRAM.v}
vlog -vlog01compat -work work +incdir+C:/Academic\ Content/Semester\ 5/Processor\ Design/mattrix\ multiplication {C:/Academic Content/Semester 5/Processor Design/mattrix multiplication/processor.v}
vlog -vlog01compat -work work +incdir+C:/Academic\ Content/Semester\ 5/Processor\ Design/mattrix\ multiplication {C:/Academic Content/Semester 5/Processor Design/mattrix multiplication/top_processor.v}
vlog -vlog01compat -work work +incdir+C:/Academic\ Content/Semester\ 5/Processor\ Design/mattrix\ multiplication {C:/Academic Content/Semester 5/Processor Design/mattrix multiplication/Register.v}
vlog -vlog01compat -work work +incdir+C:/Academic\ Content/Semester\ 5/Processor\ Design/mattrix\ multiplication {C:/Academic Content/Semester 5/Processor Design/mattrix multiplication/clock_divider.v}
vlog -vlog01compat -work work +incdir+C:/Academic\ Content/Semester\ 5/Processor\ Design/mattrix\ multiplication {C:/Academic Content/Semester 5/Processor Design/mattrix multiplication/bus.v}
vlog -vlog01compat -work work +incdir+C:/Academic\ Content/Semester\ 5/Processor\ Design/mattrix\ multiplication {C:/Academic Content/Semester 5/Processor Design/mattrix multiplication/ACRegister.v}
vlog -vlog01compat -work work +incdir+C:/Academic\ Content/Semester\ 5/Processor\ Design/mattrix\ multiplication {C:/Academic Content/Semester 5/Processor Design/mattrix multiplication/state_controller.v}
vlog -vlog01compat -work work +incdir+C:/Academic\ Content/Semester\ 5/Processor\ Design/mattrix\ multiplication {C:/Academic Content/Semester 5/Processor Design/mattrix multiplication/ALU.v}
vlog -vlog01compat -work work +incdir+C:/Academic\ Content/Semester\ 5/Processor\ Design/mattrix\ multiplication {C:/Academic Content/Semester 5/Processor Design/mattrix multiplication/control_unit.v}

