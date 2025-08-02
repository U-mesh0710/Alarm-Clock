module aclk_lcd_driver(show_a,show_new_time,alarm_time,current_time,key,sound_alarm,display_time);
input show_a,show_new_time;
input [3:0] alarm_time,current_time,key;
output reg sound_alarm;
output reg [7:0] display_time;
reg [3:0] display_value;
//
parameter zero=8'h30;
parameter one=8'h31;
parameter two=8'h32;
parameter three=8'h33;
parameter four=8'h34;
parameter five=8'h35;
parameter six=8'h36;
parameter seven=8'h37;
parameter eight=8'h38;
parameter nine=8'h39;
//
always@(*)
	begin
		if(show_a)
		display_value=alarm_time;
		else if (show_new_time)
		display_value=key;
		else
		display_value=current_time;
		
		if(current_time==alarm_time)
		sound_alarm=1'b1;
		else
		sound_alarm=1'b0;
	end
//
always@(display_value)
	begin
		case(display_value)
		1'd0:display_time=zero;
		1'd1:display_time=one;
		1'd2:display_time=two;
		1'd3:display_time=three;
		1'd4:display_time=four;
		1'd5:display_time=five;
		1'd6:display_time=six;
		1'd7:display_time=seven;
		1'd8:display_time=eight;
		1'd9:display_time=nine;
		endcase
	end
endmodule
		


















































		