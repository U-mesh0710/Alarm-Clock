module aclk_controller(input clk,reset,one_second,alarm_button,time_button,
							input [3:0]key,output reset_count,load_new_c,show_new_time,show_a,load_new_a,shift);
reg [2:0] present_state,next_state;
wire time_out;
reg [3:0] count1,count2;

parameter show_time=3'b000;
parameter key_entry=3'b001;
parameter key_stored=3'b010;
parameter show_alarm=3'b011;
parameter set_alarm_time=3'b100;
parameter set_current_time=3'b101;
parameter key_waited=3'b110;
parameter nokey=10;
always@(posedge clk or posedge reset)
	begin
		if(reset)
		count1<=4'd0;
		else if(!(present_state==key_entry))
		count1<=4'd0;
		else if(count1==9)
		count1<=4'd0;
		else if(one_second)
		count1<=count1+1'b1;
	end 
always@(posedge clk or posedge reset)
	begin
		if(reset)
		count2<=4'd0;
		else if(!(present_state==key_waited))
		count2<=4'd0;
		else if(count2==9)
		count2<=4'd0;
		else if(one_second)
		count2<=count2+1'b1;
	end
assign time_out=((count1==9)||(count2==9))?0:1;
//present state logic
always@(posedge clk or posedge reset)
	begin
		if(reset)
		present_state<=show_time;
		else
		present_state<=next_state; 
	end
//next state logic
always@(*)
	begin
		case(present_state)
		show_time: begin 
					if(alarm_button)
					next_state=show_alarm;
					else if(key!= nokey)
					next_state=key_stored;
					else
					next_state=show_time;
					end
		key_stored:next_state=key_waited;
		key_waited:begin
					if(key==nokey)
					next_state=key_entry;
					else if (time_out==0)
					next_state=show_time;
					else
					next_state=key_waited;
					end
		key_entry:begin
					if(alarm_button)
					next_state=set_alarm_time;
					else if(time_button)
					next_state=set_current_time;
					else if (time_out==0)
					next_state=show_time;
					else
					next_state=key_entry;
				   end
 		show_alarm:begin
 					if(!alarm_button)
 					next_state=show_time;
 					else
 					next_state=show_alarm;
 					end
 					
 		set_alarm_time:next_state=show_time;
 		set_current_time:next_state=show_time;
 		default:next_state=show_time;
		endcase
 	end
assign reset_count=(present_state==set_current_time)?1:0;
assign load_new_c=(present_state==set_current_time)?1:0;
assign show_new_time=((present_state==key_entry)||(present_state==key_waited)||(present_state==key_stored))?1:0;
assign show_a=(present_state==show_alarm)?1:0;
assign load_new_a=(present_state==set_alarm_time)?1:0;
assign shift=(present_state==key_stored)?1:0;

endmodule 	
				  
				

		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
			