//==============================================================================
// Module name: ledcontrol
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.7.9
// Description: 电梯灯控制
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module ledcontrol
(
  input       clk,
  input       rstn,

  //外呼
  input       BTN0,
  input       BTN1,
  input       BTN2,
  input       BTN3,

  //内呼
  input       BTN4,
  input       BTN5,
  input       BTN6,

  output reg  LED0,
  output reg  LED1,
  output reg  LED2,
  output reg  LED3,

  output reg  LED6,
  output reg  LED7,
  output reg  LED8,

  input       open,
  input [4:0] out_state,
  input       LED4_R,
  input       LED4_G,
  input       LED4_B
);

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      LED0 <= 1'b0;
    end
    else if(BTN0) begin
      LED0 <= 1'b1;
    end
    else if(open & ((out_state == 4'd2) | (out_state == 4'd8)) & LED4_R) begin
      LED0 <= 1'b0;
    end
    else 
      LED0 <= LED0;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      LED1 <= 1'b0;
    end
    else if(BTN1) begin
      LED1 <= 1'b1;
    end
    else if(open & LED4_G & (((out_state == 4'd3) & LED1) | (out_state == 4'd8) | ((out_state == 4'd7) & (!LED2) & (!LED3) & LED7))) begin
      LED1 <= 1'b0;
    end
    else 
      LED1 <= LED1;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      LED2 <= 1'b0;
    end
    else if(BTN2) begin
      LED2 <= 1'b1;
    end
    else if(open & LED4_G & (((out_state == 4'd3) & LED2) | (out_state == 4'd7))) begin
      LED2 <= 1'b0;
    end
    else 
      LED2 <= LED2;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      LED3 <= 1'b0;
    end
    else if(BTN3) begin
      LED3 <= 1'b1;
    end
    else if(open & LED4_B & ((out_state == 4'd4) | (out_state == 4'd7))) begin
      LED3 <= 1'b0;
    end
    else 
      LED3 <= LED3;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      LED6 <= 1'b1;
    end
    else if(BTN4) begin
      LED6 <= 1'b0;
    end
    else if(open & LED4_R & (out_state == 4'd8)) begin
      LED6 <= 1'b1;
    end
    else 
      LED6 <= LED6;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      LED7 <= 1'b1;
    end
    else if(BTN5) begin
      LED7 <= 1'b0;
    end
    else if(open & LED4_G & ((out_state == 4'd7) | (out_state == 4'd8))) begin
      LED7 <= 1'b1;
    end
    else 
      LED7 <= LED7;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      LED8 <= 1'b1;
    end
    else if(BTN6) begin
      LED8 <= 1'b0;
    end
    else if(open & LED4_B) begin
      LED8 <= 1'b1;
    end
    else 
      LED8 <= LED8;
  end
endmodule