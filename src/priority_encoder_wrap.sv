module priority_encoder_wrap #(
  parameter WIDTH = 8
)(
  input                    clk_i,
  input                    srst_i,
  input        [WIDTH-1:0] data_i,
  
  output logic [WIDTH-1:0] data_left_o,
  output logic [WIDTH-1:0] data_right_o
);

logic             rst_wrap;

logic [WIDTH-1:0] data_i_wrap;
  
logic [WIDTH-1:0] data_left_o_wrap;
logic [WIDTH-1:0] data_right_o_wrap;


priority_encoder #(
  .WIDTH        ( WIDTH             )
) pe (
  .clk_i        ( clk_i             ),
  .srst_i       ( rst_wrap          ),
  
  .data_i       ( data_i_wrap       ),
  .data_left_o  ( data_left_o_wrap  ),
  .data_right_o ( data_right_o_wrap )
);


always_ff @( posedge clk_i )
  begin
    
    rst_wrap     <= srst_i;
    
    data_i_wrap  <= data_i;
    
    data_left_o  <= data_left_o_wrap;
    data_right_o <= data_right_o_wrap;
    
  end

endmodule
