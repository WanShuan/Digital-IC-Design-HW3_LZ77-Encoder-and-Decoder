module LZ77_Encoder(clk,reset,chardata,valid,encode,finish,offset,match_len,char_nxt);


input 				clk;
input 				reset;
input 		[7:0] 	chardata;
output reg 			valid;
output reg  		encode;
output reg  		finish;
output reg	[3:0] 	offset;
output reg	[2:0] 	match_len;
output reg	[7:0] 	char_nxt;

reg [16391:0] data;
reg [11:0] count; 
reg [1:0] CurrtState, NextState;
//reg [3:0] offset_temp[0:8];
//reg [2:0] match_len_temp[0:8];
//reg [7:0] char_nxt_temp[0:8];
//reg [3:0] offset_out0, offset_out1, offset_out2, offset_out3, offset_out4, offset_out5, offset_out6;
//reg [2:0] match_len_out0, match_len_out1, match_len_out2, match_len_out3, match_len_out4, match_len_out5, match_len_out6;
//reg [7:0] char_nxt_out0, char_nxt_out1, char_nxt_out2, char_nxt_out3, char_nxt_out4, char_nxt_out5, char_nxt_out6;
reg [2:0] match_max;
reg [3:0] offset_max;
reg [7:0] char_nxt_max;
//reg [11:0] M;
//[7:0] char_nxt_max, [11:8] offset_max, [14:12] match_max
integer M;

parameter [1:0] READ=0, RESULT=1, COMPARE=2, FIRST=3; // COMPARE1=2, COMPARE2=3, COMPARE3=4, COMPARE4=5, END=4


/*
	Write Your Design Here ~
*/

always@(posedge clk or posedge reset) begin
    if(reset) begin
	    CurrtState <= READ;
	end
	else begin
	    CurrtState <= NextState;
	end
end

always@(posedge clk or posedge reset) begin
	//encode <= 1;
	if(reset) begin
		count <= 1;
		finish <= 0;
		valid <= 0;
		match_max <= 0;
		offset_max <= 0;
	end
	else begin
		case(CurrtState)
			READ: begin
				count <= count+1;
				for(M=1; M<=2049; M=M+1) begin
					if(count == M) begin
						data[8*(2049-M) +: 8] <= chardata;
					end
				end
			end
			FIRST: begin 
					valid <= 1;
					offset <= 0;
					match_len <= 0;
					char_nxt <= data[16391:16384];
					count <= 0;
			end
			RESULT: begin
				//else begin
					valid <= 0;
					if(count >= 8 && (data[16384-8*(count-2) +: 56] == data[16384-8*(count+7) +: 56])) begin
						match_max <= 3'd7;
						offset_max <= 8;
						char_nxt_max <= data[16384-8*(count+8) +: 8];
						count <= count + 8;
					end
					else if(count >= 7 && (data[16384-8*(count-1) +: 56] == data[16384-8*(count+7) +: 56])) begin
						match_max <= 3'd7;
						offset_max <= 7;
						char_nxt_max <= data[16384-8*(count+8) +: 8];
						count <= count + 8;
					end
					else if(count >= 6 && (data[16384-8*(count+0) +: 56] == data[16384-8*(count+7) +: 56])) begin
						match_max <= 3'd7;
						offset_max <= 6;
						char_nxt_max <= data[16384-8*(count+8) +: 8];
						count <= count + 8;
					end
					else if(count >= 5 && (data[16384-8*(count+1) +: 56] == data[16384-8*(count+7) +: 56]))begin
						match_max <= 3'd7;
						offset_max <= 5;
						char_nxt_max <= data[16384-8*(count+8) +: 8];
						count <= count + 8;
					end
					else if(count >= 4 && (data[16384-8*(count+2) +: 56] == data[16384-8*(count+7) +: 56]))begin
						match_max <= 3'd7;
						offset_max <= 4;
						char_nxt_max <= data[16384-8*(count+8) +: 8];
						count <= count + 8;
					end
					else if(count >= 3 && (data[16384-8*(count+3) +: 56] == data[16384-8*(count+7) +: 56]))begin
						match_max <= 3'd7;
						offset_max <= 3;
						char_nxt_max <= data[16384-8*(count+8) +: 8];
						count <= count + 8;
					end
					else if(count >= 2 && (data[16384-8*(count+4) +: 56] == data[16384-8*(count+7) +: 56]))begin
						match_max <= 3'd7;
						offset_max <= 2;
						char_nxt_max <= data[16384-8*(count+8) +: 8];
						count <= count + 8;
					end
					else if(count >= 1 && (data[16384-8*(count+5) +: 56] == data[16384-8*(count+7) +: 56]))begin
						match_max <= 3'd7;
						offset_max <= 1;
						char_nxt_max <= data[16384-8*(count+8) +: 8];
						count <= count + 8;
					end
					else if(data[16384-8*(count+6) +: 56] == data[16384-8*(count+7) +: 56])begin
						match_max <= 3'd7;
						offset_max <= 0;
						char_nxt_max <= data[16384-8*(count+8) +: 8];
						count <= count + 8;
					end
					else if(count >= 8 && (data[16384-8*(count-3) +: 48] == data[16384-8*(count+6) +: 48]))begin
						match_max <= 6;
						offset_max <= 8;
						char_nxt_max <= data[16384-8*(count+7) +: 8];
						count <= count + 7;
					end
					else if(count >= 7 && (data[16384-8*(count-2) +: 48] == data[16384-8*(count+6) +: 48]))begin
						match_max <= 3'd6;
						offset_max <= 7;
						char_nxt_max <= data[16384-8*(count+7) +: 8];
						count <= count + 7;
					end
					else if(count >= 6 && (data[16384-8*(count-1) +: 48] == data[16384-8*(count+6) +: 48]))begin
						match_max <= 3'd6;
						offset_max <= 6;
						char_nxt_max <= data[16384-8*(count+7) +: 8];
						count <= count + 7;
					end
					else if(count >= 5 && (data[16384-8*(count) +: 48] == data[16384-8*(count+6) +: 48]))begin
						match_max <= 3'd6;
						offset_max <= 5;
						char_nxt_max <= data[16384-8*(count+7) +: 8];
						count <= count + 7;
					end
					else if(count >= 4 && (data[16384-8*(count+1) +: 48] == data[16384-8*(count+6) +: 48]))begin
						match_max <= 3'd6;
						offset_max <= 4;
						char_nxt_max <= data[16384-8*(count+7) +: 8];
						count <= count + 7;
					end
					else if(count >= 3 && (data[16384-8*(count+2) +: 48] == data[16384-8*(count+6) +: 48]))begin
						match_max <= 3'd6;
						offset_max <= 3;
						char_nxt_max <= data[16384-8*(count+7) +: 8];
						count <= count + 7;
					end
					else if(count >= 2 && (data[16384-8*(count+3) +: 48] == data[16384-8*(count+6) +: 48]))begin
						match_max <= 3'd6;
						offset_max <= 2;
						char_nxt_max <= data[16384-8*(count+7) +: 8];
						count <= count + 7;
					end
					else if(count >= 1 && (data[16384-8*(count+4) +: 48] == data[16384-8*(count+6) +: 48]))begin
						match_max <= 3'd6;
						offset_max <= 1;
						char_nxt_max <= data[16384-8*(count+7) +: 8];
						count <= count + 7;
					end
					else if(data[16384-8*(count+5) +: 48] == data[16384-8*(count+6) +: 48])begin
						match_max <= 3'd6;
						offset_max <= 0;
						char_nxt_max <= data[16384-8*(count+7) +: 8];
						count <= count + 7;
					end
					else if(count >= 8 && (data[16384-8*(count-4) +: 40] == data[16384-8*(count+5) +: 40]))begin
						match_max <= 3'd5;
						offset_max <= 8;
						char_nxt_max <= data[16384-8*(count+6) +: 8];
						count <= count + 6;
					end
					else if(count >= 7 && (data[16384-8*(count-3) +: 40] == data[16384-8*(count+5) +: 40]))begin
						match_max <= 3'd5;
						offset_max <= 7;
						char_nxt_max <= data[16384-8*(count+6) +: 8];
						count <= count + 6;
					end
					else if(count >= 6 && (data[16384-8*(count-2) +: 40] == data[16384-8*(count+5) +: 40]))begin
						match_max <= 3'd5;
						offset_max <= 6;
						char_nxt_max <= data[16384-8*(count+6) +: 8];
						count <= count + 6;
					end
					else if(count >= 5 && (data[16384-8*(count-1) +: 40] == data[16384-8*(count+5) +: 40]))begin
						match_max <= 3'd5;
						offset_max <= 5;
						char_nxt_max <= data[16384-8*(count+6) +: 8];
						count <= count + 6;
					end
					else if(count >= 4 && (data[16384-8*(count) +: 40] == data[16384-8*(count+5) +: 40]))begin
						match_max <= 3'd5;
						offset_max <= 4;
						char_nxt_max <= data[16384-8*(count+6) +: 8];
						count <= count + 6;
					end
					else if(count >= 3 && (data[16384-8*(count+1) +: 40] == data[16384-8*(count+5) +: 40]))begin
						match_max <= 3'd5;
						offset_max <= 3;
						char_nxt_max <= data[16384-8*(count+6) +: 8];
						count <= count + 6;
					end
					else if(count >= 2 && (data[16384-8*(count+2) +: 40] == data[16384-8*(count+5) +: 40]))begin
						match_max <= 3'd5;
						offset_max <= 2;
						char_nxt_max <= data[16384-8*(count+6) +: 8];
						count <= count + 6;
					end
					else if(count >= 1 && (data[16384-8*(count+3) +: 40] == data[16384-8*(count+5) +: 40]))begin
						match_max <= 3'd5;
						offset_max <= 1;
						char_nxt_max <= data[16384-8*(count+6) +: 8];
						count <= count + 6;
					end
					else if(data[16384-8*(count+4) +: 40] == data[16384-8*(count+5) +: 40])begin
						match_max <= 3'd5;
						offset_max <= 0;
						char_nxt_max <= data[16384-8*(count+6) +: 8];
						count <= count + 6;
					end
					else if(count >= 8 && (data[16384-8*(count-5) +: 32] == data[16384-8*(count+4) +: 32]))begin
						match_max <= 3'd4;
						offset_max <= 8;
						char_nxt_max <= data[16384-8*(count+5) +: 8];
						count <= count + 5;
					end
					else if(count >= 7 && (data[16384-8*(count-4) +: 32] == data[16384-8*(count+4) +: 32]))begin
						match_max <= 3'd4;
						offset_max <= 7;
						char_nxt_max <= data[16384-8*(count+5) +: 8];
						count <= count + 5;
					end
					else if(count >= 6 && (data[16384-8*(count-3) +: 32] == data[16384-8*(count+4) +: 32]))begin
						match_max <= 3'd4;
						offset_max <= 6;
						char_nxt_max <= data[16384-8*(count+5) +: 8];
						count <= count + 5;
					end
					else if(count >= 5 && (data[16384-8*(count-2) +: 32] == data[16384-8*(count+4) +: 32]))begin
						match_max <= 3'd4;
						offset_max <= 5;
						char_nxt_max <= data[16384-8*(count+5) +: 8];
						count <= count + 5;
					end
					else if(count >= 4 && (data[16384-8*(count-1) +: 32] == data[16384-8*(count+4) +: 32]))begin
						match_max <= 3'd4;
						offset_max <= 4;
						char_nxt_max <= data[16384-8*(count+5) +: 8];
						count <= count + 5;
					end
					else if(count >= 3 && (data[16384-8*(count) +: 32] == data[16384-8*(count+4) +: 32]))begin
						match_max <= 3'd4;
						offset_max <= 3;
						char_nxt_max <= data[16384-8*(count+5) +: 8];
						count <= count + 5;
					end
					else if(count >= 2 && (data[16384-8*(count+1) +: 32] == data[16384-8*(count+4) +: 32]))begin
						match_max <= 3'd4;
						offset_max <= 2;
						char_nxt_max <= data[16384-8*(count+5) +: 8];
						count <= count + 5;
					end
					else if(count >= 1 && (data[16384-8*(count+2) +: 32] == data[16384-8*(count+4) +: 32]))begin
						match_max <= 3'd4;
						offset_max <= 1;
						char_nxt_max <= data[16384-8*(count+5) +: 8];
						count <= count + 5;
					end
					else if(data[16384-8*(count+3) +: 32] == data[16384-8*(count+4) +: 32])begin
						match_max <= 3'd4;
						offset_max <= 0;
						char_nxt_max <= data[16384-8*(count+5) +: 8];
						count <= count + 5;
					end
					else if(count >= 8 && (data[16384-8*(count-6) +: 24] == data[16384-8*(count+3) +: 24]))begin
						match_max <= 3'd3;
						offset_max <= 8;
						char_nxt_max <= data[16384-8*(count+4) +: 8];
						count <= count + 4;
					end
					else if(count >= 7 && (data[16384-8*(count-5) +: 24] == data[16384-8*(count+3) +: 24]))begin
						match_max <= 3'd3;
						offset_max <= 7;
						char_nxt_max <= data[16384-8*(count+4) +: 8];
						count <= count + 4;
					end
					else if(count >= 6 && (data[16384-8*(count-4) +: 24] == data[16384-8*(count+3) +: 24]))begin
						match_max <= 3'd3;
						offset_max <= 6;
						char_nxt_max <= data[16384-8*(count+4) +: 8];
						count <= count + 4;
					end
					else if(count >= 5 && (data[16384-8*(count-3) +: 24] == data[16384-8*(count+3) +: 24]))begin
						match_max <= 3'd3;
						offset_max <= 5;
						char_nxt_max <= data[16384-8*(count+4) +: 8];
						count <= count + 4;
					end
					else if(count >= 4 && (data[16384-8*(count-2) +: 24] == data[16384-8*(count+3) +: 24]))begin
						match_max <= 3'd3;
						offset_max <= 4;
						char_nxt_max <= data[16384-8*(count+4) +: 8];
						count <= count + 4;
					end
					else if(count >= 3 && (data[16384-8*(count-1) +: 24] == data[16384-8*(count+3) +: 24]))begin
						match_max <= 3'd3;
						offset_max <= 3;
						char_nxt_max <= data[16384-8*(count+4) +: 8];
						count <= count + 4;
					end
					else if(count >= 2 && (data[16384-8*(count) +: 24] == data[16384-8*(count+3) +: 24]))begin
						match_max <= 3'd3;
						offset_max <= 2;
						char_nxt_max <= data[16384-8*(count+4) +: 8];
						count <= count + 4;
					end
					else if(count >= 1 && (data[16384-8*(count+1) +: 24] == data[16384-8*(count+3) +: 24]))begin
						//count <= {3'd3,4'd1,data[16367:16360]};
						match_max <= 3'd3;
						offset_max <= 1;
						char_nxt_max <= data[16384-8*(count+4) +: 8];
						count <= count + 4;
					end
					else if(data[16384-8*(count+2) +: 24] == data[16384-8*(count+3) +: 24])begin
						match_max <= 3'd3;
						offset_max <= 0;
						char_nxt_max <= data[16384-8*(count+4) +: 8];
						count <= count + 4;
					end
					else if(count >= 8 && (data[16384-8*(count-7) +: 16] == data[16384-8*(count+2) +: 16]))begin
						match_max <= 3'd2;
						offset_max <= 8;
						char_nxt_max <= data[16384-8*(count+3) +: 8];
						count <= count + 3;
					end
					else if(count >= 7 && (data[16384-8*(count-6) +: 16] == data[16384-8*(count+2) +: 16]))begin
						match_max <= 3'd2;
						offset_max <= 7;
						char_nxt_max <= data[16384-8*(count+3) +: 8];
						count <= count + 3;
					end
					else if(count >= 6 && (data[16384-8*(count-5) +: 16] == data[16384-8*(count+2) +: 16]))begin
						match_max <= 3'd2;
						offset_max <= 6;
						char_nxt_max <= data[16384-8*(count+3) +: 8];
						count <= count + 3;
					end
					else if(count >= 5 && (data[16384-8*(count-4) +: 16] == data[16384-8*(count+2) +: 16]))begin
						match_max <= 3'd2;
						offset_max <= 5;
						char_nxt_max <= data[16384-8*(count+3) +: 8];
						count <= count + 3;
					end
					else if(count >= 4 && (data[16384-8*(count-3) +: 16] == data[16384-8*(count+2) +: 16]))begin
						match_max <= 3'd2;
						offset_max <= 4;
						char_nxt_max <= data[16384-8*(count+3) +: 8];
						count <= count + 3;
					end
					else if(count >= 3 && (data[16384-8*(count-2) +: 16] == data[16384-8*(count+2) +: 16]))begin
						match_max <= 3'd2;
						offset_max <= 3;
						char_nxt_max <= data[16384-8*(count+3) +: 8];
						count <= count + 3;
					end
					else if(count >= 2 && (data[16384-8*(count-1) +: 16] == data[16384-8*(count+2) +: 16]))begin
						match_max <= 3'd2;
						offset_max <= 2;
						char_nxt_max <= data[16384-8*(count+3) +: 8];
						count <= count + 3;
					end
					else if(count >= 1 && (data[16384-8*(count) +: 16] == data[16384-8*(count+2) +: 16]))begin
						match_max <= 3'd2;
						offset_max <= 1;
						char_nxt_max <= data[16384-8*(count+3) +: 8];
						count <= count + 3;
					end
					else if(data[16384-8*(count+1) +: 16] == data[16384-8*(count+2) +: 16])begin
						match_max <= 3'd2;
						offset_max <= 0;
						char_nxt_max <= data[16384-8*(count+3) +: 8];
						count <= count + 3;
					end
					else if(count >= 8 && (data[16384-8*(count-8) +: 8] == data[16384-8*(count+1) +: 8]))begin
						match_max <= 3'd1;
						offset_max <= 8;
						char_nxt_max <= data[16384-8*(count+2) +: 8];
						count <= count + 2;
					end
					else if(count >= 7 && (data[16384-8*(count-7) +: 8] == data[16384-8*(count+1) +: 8]))begin
						match_max <= 3'd1;
						offset_max <= 7;
						char_nxt_max <= data[16384-8*(count+2) +: 8];
						count <= count + 2;
					end
					else if(count >= 6 && (data[16384-8*(count-6) +: 8] == data[16384-8*(count+1) +: 8]))begin
						match_max <= 3'd1;
						offset_max <= 6;
						char_nxt_max <= data[16384-8*(count+2) +: 8];
						count <= count + 2;
					end
					else if(count >= 5 && (data[16384-8*(count-5) +: 8] == data[16384-8*(count+1) +: 8]))begin
						match_max <= 3'd1;
						offset_max <= 5;
						char_nxt_max <= data[16384-8*(count+2) +: 8];
						count <= count + 2;
					end
					else if(count >= 4 && (data[16384-8*(count-4) +: 8] == data[16384-8*(count+1) +: 8]))begin
						match_max <= 3'd1;
						offset_max <= 4;
						char_nxt_max <= data[16384-8*(count+2) +: 8];
						count <= count + 2;
					end
					else if(count >= 3 && (data[16384-8*(count-3) +: 8] == data[16384-8*(count+1) +: 8]))begin
						//count <= {3'd1,4'd3,data[16384-8*(count+2) +: 8]};
						match_max <= 3'd1;
						offset_max <= 3;
						char_nxt_max <= data[16384-8*(count+2) +: 8];
						count <= count + 2;
					end
					else if(count >= 2 && (data[16384-8*(count-2) +: 8] == data[16384-8*(count+1) +: 8]))begin
						match_max <= 3'd1;
						offset_max <= 2;
						char_nxt_max <= data[16384-8*(count+2) +: 8];
						count <= count + 2;
					end
					else if(count >= 1 && (data[16384-8*(count-1) +: 8] == data[16384-8*(count+1) +: 8]))begin
						match_max <= 3'd1;
						offset_max <= 1;
						char_nxt_max <= data[16384-8*(count+2) +: 8];
						count <= count + 2;
					end
					else if(data[16384-8*(count) +: 8] == data[16384-8*(count+1) +: 8])begin
						match_max <= 3'd1;
						offset_max <= 0;
						char_nxt_max <= data[16384-8*(count+2) +: 8];
						count <= count + 2;
					end
					else begin
						match_max <= 3'd0;
						offset_max <= 4'd0;
						char_nxt_max <= data[16384-8*(count+1) +: 8];
						count <= count + 1;
					end
				//end
			end
			COMPARE: begin
				if(match_max == 0) begin
					valid <= 1;
					match_len <= 0;
					offset <= 0;
					char_nxt <= char_nxt_max;
				end
				else begin
					valid <= 1;
					match_len <= match_max;
					offset <= offset_max;
					char_nxt <= char_nxt_max;
					//count[14:12] <= 0;
				end
				if(char_nxt == 8'h24) begin
				finish <= 1;
				valid <= 0;
				end
			end
			/*END: begin
				valid <= 0;
				if(char_nxt_max == 8'h24) finish <= 1;
			end*/
			/*SHIFT: begin
				valid <= 0;
				case(match_len+1)
					1: data <= data << 8;
					2: data <= data << 16;
					3: data <= data << 24;
					4: data <= data << 32;
					5: data <= data << 40;
					6: data <= data << 48;
					7: data <= data << 56;
					8: data <= data << 64;
				endcase
				if(char_nxt_max == 8'h24) finish <= 1;
			end*/
		endcase
		
	end
end

//next state
always@(*) begin
encode = 1;
case(CurrtState)
	READ: begin
		if(count == 2049) begin
			NextState = FIRST;
		end
		else begin
			NextState = READ;
		end
	end
	FIRST: begin
		NextState = RESULT;
	end
	RESULT: begin
		NextState = COMPARE;
	end
	COMPARE: begin
	if(char_nxt == 8'h24) begin
		NextState = COMPARE;
	end
	else NextState = RESULT;
	end
	/*END: begin
		NextState = RESULT;
	end
	default: NextState = END;*/
	
endcase
end

endmodule

