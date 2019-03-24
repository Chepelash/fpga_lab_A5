module priority_encoder_tb;

parameter int CLK_T = 100;
parameter int WIDTH = 8;

logic             clk;
logic             rst;

logic [WIDTH-1:0] data_i;

logic [WIDTH-1:0] data_left_o;
logic [WIDTH-1:0] data_right_o;

priority_encoder #(
  .WIDTH        ( WIDTH        )
) pe (
  .clk_i        ( clk          ),
  .srst_i       ( rst          ),
  
  .data_i       ( data_i       ),
  .data_left_o  ( data_left_o  ),
  .data_right_o ( data_right_o )
);


task automatic clk_gen;

  forever
    begin
      #( CLK_T / 2 );
      clk <= ~clk;
    end

endtask


task automatic apply_rst;

  rst <= 1'b1;
  @( posedge clk );
  rst <= 1'b0;
  @( posedge clk );

endtask


 always
  begin
    clk_gen();
  end

always
  begin
    clk <= 0;
    rst <= 0;
   
    $display("Starting!\n");
    
    apply_rst();
    
//    bit [WIDTH-1:0] check_val;
    
    for( int i = 0; i < 5; i++ )
      begin
        data_i <= $urandom_range(0, 2**WIDTH - 1);
        @( posedge clk );             
      end
    
    @( posedge clk );
    @( posedge clk );
    @( posedge clk );
    @( posedge clk );
    $stop();
  end




endmodule