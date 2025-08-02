module aclk_timegen(input clk,reset,reset_count,fast_watch, output reg one_minute,one_second);

reg [13:0] count;
reg one_minute_reg;

//one minute pulse generation
always@(posedge clk or posedge reset)
begin
	if(reset)
	begin
		count<=14'b0;
		one_minute_reg<=1'b0;
	end
	else if(reset_count)
	begin
		count<=14'b0;
		one_minute_reg<=1'b0;
	end
	else if(count[13:0] == 14'd15359)
	begin
		count<=14'b0;
		one_minute_reg<=1'b1;
	end
	else 
	begin
		count<=count+1;
		one_minute_reg<=1'b0;
	end
end
//one second pulse generation
always@(posedge clk or posedge reset)
begin
	if(reset)
	one_second<=1'b0;
	else if(reset_count)
	one_second<=1'b0;
	else if(count[7:0] ==259)
	one_second<=1'b1;
	else 
	one_second<=1'b0;
end
//Fast watch logic
always@(*)
begin
	if (fast_watch)
	one_minute=one_second;
	else
	one_minute=one_minute_reg;
end
endmodule