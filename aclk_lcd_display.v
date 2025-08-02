module aclk_lcd_display (input show_new_time,show_a,
							input [3:0] current_time_ms_hr,current_time_ls_hr,current_time_ms_min,current_time_ls_min,
										alarm_time_ms_hr,alarm_time_ls_hr,alarm_time_ms_min,alarm_time_ls_min,
										key_ms_hr,key_ls_hr,key_ms_min,key_ls_min,
							output sound_alarm,
							output [7:0] display_ms_hr,display_ls_hr,display_ms_min,display_ls_min);
wire sound_alarm_1,sound_alarm_2,sound_alarm_3,sound_alarm_4;
assign sound_alarm = sound_alarm_1 & sound_alarm_2 & sound_alarm_3 & sound_alarm_4;
//
aclk_lcd_driver ms_hr(.show_a(show_a),.show_new_time(show_new_time),.alarm_time(alarm_time_ms_hr),.current_time(current_time_ms_hr),
							.key(key_ms_hr),.sound_alarm(sound_alarm_1),.display_time(display_ms_hr));
aclk_lcd_driver ms_min(.show_a(show_a),.show_new_time(show_new_time),.alarm_time(alarm_time_ms_min),.current_time(current_time_ms_min),
							.key(key_ms_min),.sound_alarm(sound_alarm_2),.display_time(display_ms_min));
aclk_lcd_driver ls_hr(.show_a(show_a),.show_new_time(show_new_time),.alarm_time(alarm_time_ls_hr),.current_time(current_time_ls_hr),
							.key(key_ls_hr),.sound_alarm(sound_alarm_3),.display_time(display_ls_hr));
aclk_lcd_driver ls_min(.show_a(show_a),.show_new_time(show_new_time),.alarm_time(alarm_time_ls_min),.current_time(current_time_ls_min),
							.key(key_ls_min),.sound_alarm(sound_alarm_4),.display_time(display_ls_min));
//
endmodule