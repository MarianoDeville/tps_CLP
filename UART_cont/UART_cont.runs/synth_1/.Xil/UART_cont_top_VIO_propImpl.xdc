set_property SRC_FILE_INFO {cfile:E:/Facultad/CLP/tps_CLP/UART_cont/UART_cont.srcs/constrs_1/imports/fuentes/uart_led_pins_ArtyZ7.xdc rfile:../../../UART_cont.srcs/constrs_1/imports/fuentes/uart_led_pins_ArtyZ7.xdc id:1} [current_design]
set_property SRC_FILE_INFO {cfile:E:/Facultad/CLP/tps_CLP/UART_cont/UART_cont.srcs/constrs_1/imports/fuentes/uart_led_timing_ArtyZ7.xdc rfile:../../../UART_cont.srcs/constrs_1/imports/fuentes/uart_led_timing_ArtyZ7.xdc id:2} [current_design]
set_property src_info {type:XDC file:1 line:8 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN H16    IOSTANDARD LVCMOS33 } [get_ports { clk_pin }];
set_property src_info {type:XDC file:1 line:11 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { rxd_pin }]; #IO_L17P_T2_34 Sch=JA1_P
set_property src_info {type:XDC file:1 line:12 export:INPUT save:INPUT read:READ} [current_design]
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { txd_pin }];
set_property src_info {type:XDC file:2 line:9 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay -clock virtual_clock -max 0.000 [get_ports rst_pin]
set_property src_info {type:XDC file:2 line:10 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay -clock virtual_clock -min -0.500 [get_ports rst_pin]
set_property src_info {type:XDC file:2 line:12 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay -clock virtual_clock -max 0.000 [get_ports btn_pin]
set_property src_info {type:XDC file:2 line:13 export:INPUT save:INPUT read:READ} [current_design]
set_input_delay -clock virtual_clock -min -0.500 [get_ports btn_pin]
set_property src_info {type:XDC file:2 line:16 export:INPUT save:INPUT read:READ} [current_design]
set_output_delay -clock virtual_clock 0.000 [get_ports {led_pins[*]}]
