module aclk_top_rtl(input clk,reset,fastwatch,alarm_button,time_button,
							input [3:0] key,output sound_alarm,
						output [7:0] display_ms_hr,display_ls_hr,display_ms_min,display_ls_min);
//
wire one_minute,one_second,reset_count,load_new_c,show_new_time,show_a,
			load_new_a,shift;
wire [3:0] current_time_ms_hr,current_time_ms_min,current_time_ls_hr,current_time_ls_min,
			alarm_time_ms_hr,alarm_time_ls_hr,alarm_time_ms_min,alarm_time_ls_min,
			key_ms_hr,key_ls_hr,key_ms_min,key_ls_min;
//			
aclk_areg alarm_register (.clk(clk),.reset(reset),.load_new_a(load_new_a),.new_alarm_ms_hr(key_ms_hr),.new_alarm_ls_hr(key_ls_hr),.new_alarm_ms_min(key_ms_min),.new_alarm_ls_min(key_ls_min),
                   .alarm_time_ms_hr(alarm_time_ms_hr),.alarm_time_ls_hr(alarm_time_ls_hr),.alarm_time_ms_min(alarm_time_ms_min),.alarm_time_ls_min(alarm_time_ls_min));
aclk_controller alarm_controller (.clk(clk),.reset(reset),.one_second(one_second),.alarm_button(alarm_button),.time_button(time_button),
							.key(key),.reset_count(reset_count),.load_new_c(load_new_c),.show_new_time(show_new_time),.show_a(show_a),.load_new_a(load_new_a),.shift(shift));
aclk_counter counter ( .clk(clk),.reset(reset),.one_minute(one_minute),.load_new_c(load_new_c),
						 .new_current_time_ms_hr(key_ms_hr),.new_current_time_ls_hr(key_ls_hr),.new_current_time_ms_min(key_ms_min),.new_current_time_ls_min(key_ls_min),
						.current_time_ms_hr(current_time_ms_hr),.current_time_ls_hr(current_time_ls_hr),.current_time_ms_min(current_time_ms_min),.current_time_ls_min(current_time_ls_min));
aclk_keyreg key_register (.clk(clk),.reset(reset),.key(key),.shift(shift),.key_buffer_ms_hr(key_ms_hr),.key_buffer_ls_hr(key_ls_hr),.key_buffer_ms_min(key_ms_min),.key_buffer_ls_min(key_ls_min));
aclk_lcd_display lcd_display(.show_new_time(show_new_time),.show_a(show_a),.current_time_ms_hr(current_time_ms_hr),.current_time_ls_hr(current_time_ls_hr),.current_time_ms_min(current_time_ms_min),.current_time_ls_min(current_time_ls_min),
					.alarm_time_ms_hr(alarm_time_ms_hr),.alarm_time_ls_hr(alarm_time_ls_hr),.alarm_time_ms_min(alarm_time_ms_min),.alarm_time_ls_min(alarm_time_ls_min),.key_ms_hr(key_ms_hr),.key_ls_hr(key_ls_hr),.key_ms_min(key_ms_min),
					.key_ls_min(key_ls_min),.sound_alarm(sound_alarm),.display_ms_hr(display_ms_hr),.display_ls_hr(display_ls_hr),.display_ms_min(display_ms_min),.display_ls_min(display_ls_min));
aclk_timegen timing_generator (.clk(clk),.reset(reset),.reset_count(reset_count),.fast_watch(fastwatch),.one_minute(one_minute),.one_second(one_second));
endmodule