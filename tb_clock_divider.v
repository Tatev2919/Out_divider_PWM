module tb_clock_divider;
 reg clk_in,rst,inc,dec;
 wire clk_out;

 clk_div uut (
   .clk_in(clk_in), 
   .clk_out(clk_out),
   .rst(rst),
   .inc(inc),
   .dec(dec)
 );
  initial 
    begin
      $dumpfile("wave.vcd");
      $dumpvars();
    end
  
  initial begin
      clk_in = 0;
      forever #10 clk_in = ~clk_in;
  end
  
  initial 
      begin 
          rst = 1;
          #20 rst = 0;
      end
  initial 
    begin
      inc <= 0;
      dec <= 0;
      #11;
      while (rst == 1'b1)
        begin 
          @(negedge clk_in);
        end
      @(negedge clk_in) inc <= 1;
      @(negedge clk_in) inc <= 0;
      @(negedge clk_in) inc <= 1;
      #102;
      @(negedge clk_in) inc <= 0;
      #102;
      @(negedge clk_in) inc <= 1;
      #102;
      @(negedge clk_in) inc <= 0;
      #102;
      @(negedge clk_in) inc <= 1;
      #102;
      @(negedge clk_in) dec <= 0;
      #102;
      @(negedge clk_in) dec <= 1;
      #102;
      @(negedge clk_in) dec <= 0;
      #102;
      @(negedge clk_in) dec <= 1;
      @(negedge clk_in) dec <= 0;
      @(negedge clk_in) dec <= 1;  
      @(posedge clk_in) inc <= 0;
      
      @(posedge clk_in) inc <= 1;
      @(posedge clk_in) inc <= 0;
      
      
      #1000;
      $finish;
    end
endmodule