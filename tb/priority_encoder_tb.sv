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


task automatic wait_for_data;
  @( posedge clk );
  @( posedge clk );
  @( posedge clk );
endtask


task automatic rand_numb_test;

  bit [WIDTH-1:0] check_val_left;
  bit [WIDTH-1:0] check_val_right;
  bit [WIDTH-1:0] check_val_input;
  
  for( int j = 0; j < 5; j++ )
      begin
        check_val_input  = $urandom_range(0, 2**WIDTH - 1);
        data_i          <= check_val_input;        
        
        for( int i = 0; i < WIDTH; i++ )
          begin
            if( check_val_input[i] )
              begin
                check_val_right[i] = 1'b1;
                break;
              end
          end
        for( int i = WIDTH - 1; i >= 0; i-- )
          begin
            if ( check_val_input[i] )
              begin
                check_val_left[i] = 1'b1;
                break;
              end
          end
          
        wait_for_data();
        
        if( ( data_left_o == check_val_left ) && ( data_right_o == check_val_right ) )
          begin
            $display("OK! Input = %8b; Output left = %8b; Output right = %8b;", 
                      data_i, data_left_o, data_right_o);
          end
        else
          begin
            $display("Fail! Input = %8b; Output left = %8b; Output right = %8b;",
                      data_i, data_left_o, data_right_o);
            $stop();
          end
        check_val_left  = '0;
        check_val_right = '0;
      end

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
    rand_numb_test();
    
    $display("Everything is OK!");
    $stop();
  end


endmodule
