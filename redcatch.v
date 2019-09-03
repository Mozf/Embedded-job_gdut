//==============================================================================
// Module name: redcatch
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.7.30
// Description: 
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module redcatch
(
  input       clk,
  input       rstn,

  input       red1_in,
  input       red2_in,
  input       red3_in,

  output reg  red1_up,
  output reg  red2_up,
  output reg  red3_up,

  output reg  red1_down,
  output reg  red2_down,
  output reg  red3_down
);

  reg [3:0] red1_reg;
  reg [3:0] red2_reg;
  reg [3:0] red3_reg;

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      red1_reg <= 4'b1111;
    end
    else begin
      red1_reg <= {red1_reg[2:0],red1_in};
    end
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      red2_reg <= 4'b1111;
    end
    else begin
      red2_reg <= {red2_reg[2:0],red2_in};
    end
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      red3_reg <= 4'b1111;
    end
    else begin
      red3_reg <= {red3_reg[2:0],red3_in};
    end
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      red1_up <= 1'b0;
    end
    else if(red1_reg == 4'b0111) begin
      red1_up <= 1'b1;
    end
    else begin
      red1_up <= 1'b0;
    end
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      red2_up <= 1'b0;
    end
    else if(red2_reg == 4'b0111) begin
      red2_up <= 1'b1;
    end
    else begin
      red2_up <= 1'b0;
    end
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      red3_up <= 1'b0;
    end
    else if(red3_reg == 4'b0111) begin
      red3_up <= 1'b1;
    end
    else begin
      red3_up <= 1'b0;
    end
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      red1_down <= 1'b0;
    end
    else if(red1_reg == 4'b1000) begin
      red1_down <= 1'b1;
    end
    else begin
      red1_down <= 1'b0;
    end
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      red2_down <= 1'b0;
    end
    else if(red2_reg == 4'b1000) begin
      red2_down <= 1'b1;
    end
    else begin
      red2_down <= 1'b0;
    end
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      red3_down <= 1'b0;
    end
    else if(red3_reg == 4'b1000) begin
      red3_down <= 1'b1;
    end
    else begin
      red3_down <= 1'b0;
    end
  end

endmodule