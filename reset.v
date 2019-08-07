//==============================================================================
// Module name: reset
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.8.6
// Description: 
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module reset
(
  input  clk,
  input  SW0,

  output rstn
  
);

  reg SW0_reg;

  always@(posedge clk) begin 
    SW0_reg <= SW0;
  end

  assign rstn = SW0_reg;

endmodule