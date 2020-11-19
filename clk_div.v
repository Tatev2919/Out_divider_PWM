module clk_div(clk_in,clk_out,rst,inc,dec);
  input clk_in,rst,inc,dec;
  output reg clk_out; 
  reg[4:0] counter=5'd0;
  parameter div = 5'd20;
  reg [4:0] tmp_i;
  reg inc_r,dec_r,inc_rr,dec_rr;  
  always @(posedge clk_in or negedge rst) begin
    if (rst) begin
        counter <= 5'd0;
    end 
    else begin 
        counter <= counter + 5'd1;
        if(counter>=(div-1))
            counter <= 5'd0;
    end
  end
  
  always @(posedge clk_in) begin
      if(rst) begin 
        tmp_i <= 4'd10;
        inc_r <= 1'b0;
        inc_rr <= 1'b0;
      end 
      else begin
        inc_r <= inc;
        inc_rr <= inc & !inc_r;
        dec_r <= dec;
        dec_rr <= dec & !dec_r;
        if (inc_rr) begin
        	if(tmp_i != 5'd20) begin
            	tmp_i <= tmp_i + 5'd1;
            end
        end
        if (dec_rr) begin
        	if(tmp_i != 5'd0) begin
            	tmp_i <= tmp_i - 5'd1;
            end
        end
      end
    end
  always @(*)
    begin
      if (rst)
        begin 
        	clk_out = 0;  
        end
      else 
        begin 
          if (counter < tmp_i)
            clk_out = 1;
          else 
            clk_out = 0;
        end
    end
endmodule