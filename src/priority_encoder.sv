module priority_encoder #(
  parameter WIDTH = 8
)(
  input                    clk_i,
  input                    srst_i,
  input        [WIDTH-1:0] data_i,
  
  output logic [WIDTH-1:0] data_left_o,
  output logic [WIDTH-1:0] data_right_o
);

logic [0:WIDTH-1] input_data_left;
logic [WIDTH-1:0] input_data_right;

logic [0:WIDTH-1] output_data_left;
logic [WIDTH-1:0] output_data_right;


always_ff @( posedge clk_i )
  begin
    data_left_o  <= output_data_left;
    data_right_o <= output_data_right;
    if ( srst_i )
      begin
        data_left_o  <= '0;
        data_right_o <= '0;       
      end
    else
      begin
        input_data_left  <= data_i;
        input_data_right <= data_i;
      end
  end


always_comb
  begin
    output_data_left  = '0;
    output_data_right = '0;
    
    for( int i = 0; i < WIDTH; i++ )
      begin : left_for_loop
        if( input_data_left[i] )
          begin
            output_data_left[i] = 1'b1;
            break;
          end
      end : left_for_loop
      
    for ( int i = 0; i < WIDTH; i++ )
      begin : right_for_loop
        if( input_data_right[i] )
          begin
            output_data_right[i] = 1'b1;
            break;
          end
      end : right_for_loop
  end
    
endmodule