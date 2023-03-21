module LZ77_Decoder(clk,reset,code_pos,code_len,chardata,encode,finish,char_nxt);

input 				clk;
input 				reset;
input 		[3:0] 	code_pos;
input 		[2:0] 	code_len;
input 		[7:0] 	chardata;
output  reg			encode;
output  reg			finish;
output 	reg [7:0] 	char_nxt;

reg [1:0] CurrtState, NextState;
reg [71:0] search;
reg [2:0] count;

parameter [1:0] READ=0, END=1;

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
	//encode <= 0;
	if(reset) begin
		finish <= 0;
		count <= 0;
	end
	/*else if(chardata == 8'h24) begin
		finish <= 1;
	end*/
	else begin
	case(CurrtState)
	READ: begin
		case(code_pos)
			0: begin
				if(code_len == 0) begin
					char_nxt <= chardata;
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= chardata;
				end
				else begin
					if(count == code_len) begin
						char_nxt <= chardata;
						search[71:64] <= search[63:56];
						search[63:56] <= search[55:48];
						search[55:48] <= search[47:40];
						search[47:40] <= search[39:32];
						search[39:32] <= search[31:24];
						search[31:24] <= search[23:16];
						search[23:16] <= search[15:8] ;
						search[15:8]  <= search[7:0];
						search[7:0]   <= chardata;
						count <= 0;
					end
					else begin
						char_nxt <= search[7:0];
						search[71:64] <= search[63:56];
						search[63:56] <= search[55:48];
						search[55:48] <= search[47:40];
						search[47:40] <= search[39:32];
						search[39:32] <= search[31:24];
						search[31:24] <= search[23:16];
						search[23:16] <= search[15:8] ;
						search[15:8]  <= search[7:0];
						search[7:0]   <= search[7:0];
						count <= count + 3'b001;
					end
				end
			end
			1: begin
				if(count == code_len) begin
					char_nxt <= chardata;
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= chardata;
					count <= 0;
				end
				else begin
					char_nxt <= search[15:8];
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= search[15:8];
					count <= count + 3'b001;
				end
			end
			2: begin
				if(count == code_len) begin
					char_nxt <= chardata;
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= chardata;
					count <= 0;
				end
				else begin
					char_nxt <= search[23:16];
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= search[23:16];
					count <= count + 3'b001;
				end
			end
			3: begin
				if(count == code_len) begin
					char_nxt <= chardata;
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= chardata;
					count <= 0;
				end
				else begin
					char_nxt <= search[31:24];
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= search[31:24];
					count <= count + 3'b001;
				end
			end
			4: begin
				if(count == code_len) begin
					char_nxt <= chardata;
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= chardata;
					count <= 0;
				end
				else begin
					char_nxt <= search[39:32];
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= search[39:32];
					count <= count + 3'b001;
				end
			end
			5: begin
				if(count == code_len) begin
					char_nxt <= chardata;
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= chardata;
					count <= 0;
				end
				else begin
					char_nxt <= search[47:40];
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= search[47:40];
					count <= count + 3'b001;
				end
			end
			6: begin
				if(count == code_len) begin
					char_nxt <= chardata;
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= chardata;
					count <= 0;
				end
				else begin
					char_nxt <= search[55:48];
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= search[55:48];
					count <= count + 3'b001;
				end
			end
			7: begin
				if(count == code_len) begin
					char_nxt <= chardata;
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= chardata;
					count <= 0;
				end
				else begin
					char_nxt <= search[63:56];
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= search[63:56];
					count <= count + 3'b001;
				end
			end
			8: begin
				if(count == code_len) begin
					char_nxt <= chardata;
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= chardata;
					count <= 0;
				end
				else begin
					char_nxt <= search[71:64];
					search[71:64] <= search[63:56];
					search[63:56] <= search[55:48];
					search[55:48] <= search[47:40];
					search[47:40] <= search[39:32];
					search[39:32] <= search[31:24];
					search[31:24] <= search[23:16];
					search[23:16] <= search[15:8] ;
					search[15:8]  <= search[7:0];
					search[7:0]   <= search[71:64];
					count <= count + 3'b001;
				end
			end
		endcase
	end
	END: begin
		finish <= 1;
		
	end
	endcase
	end
end

//next state
always@(*) begin
	encode = 0;
	case(CurrtState)
		READ: begin
			if(chardata == 8'h24 && count == code_len) begin
				NextState = END;
			end
			else NextState = READ;
		end
		END: begin
			NextState = END;
		end
		default: NextState = READ;
	endcase
end

endmodule

