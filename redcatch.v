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

  output reg  red1_reg,
  output reg  red2_reg,
  output reg  red3_reg,

  output reg  red1_up,
  output reg  red2_up,
  output reg  red3_up,

  output reg  red1_down,
  output reg  red2_down,
  output reg  red3_down
);

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      red1_reg <= 1'b0;
    end
    else begin
      red1_reg <= red1_in;
    end
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      red2_reg <= 1'b0;
    end
    else begin
      red2_reg <= red2_in;
    end
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      red3_reg <= 1'b0;
    end
    else begin
      red3_reg <= red3_in;
    end
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      red1_up <= 1'b0;
    end
    else if(red1_reg == 1'b0 && red1_in == 1'b1) begin
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
    else if(red2_reg == 1'b0 && red2_in == 1'b1) begin
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
    else if(red3_reg == 1'b0 && red3_in == 1'b1) begin
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
    else if(red1_reg == 1'b1 && red1_in == 1'b0) begin
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
    else if(red2_reg == 1'b1 && red2_in == 1'b0) begin
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
    else if(red3_reg == 1'b1 && red3_in == 1'b0) begin
      red3_down <= 1'b1;
    end
    else begin
      red3_down <= 1'b0;
    end
  end

endmodule