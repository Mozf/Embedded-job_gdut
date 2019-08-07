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

  //外呼灯
  input       LED0_in,
  input       LED1_in,
  input       LED2_in,
  input       LED3_in,

  output reg  LED0,
  output reg  LED1,
  output reg  LED2,
  output reg  LED3,
  
  //内呼灯
  input       LED6_in,
  input       LED7_in,
  input       LED8_in,

  output reg  LED6,
  output reg  LED7,
  output reg  LED8
);

  reg  LED0_reg;
  reg  LED1_reg;
  reg  LED2_reg;
  reg  LED3_reg;
  reg  LED6_reg;
  reg  LED7_reg;
  reg  LED8_reg;

  always@(posedge clk or negedge rstn) begin 
    if(!rstn)  LED0_reg <= 1'b0;
    else       LED0_reg <= LED0_in;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      LED0 <= 1'b0;
    end
    else if(BTN0) begin
      LED0 <= 1'b1;
    end
    else if(LED0_reg == 1'b0 && LED0_in == 1'b1) begin
      LED0 <= 1'b0;
    end
    else 
      LED0 <= LED0;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn)  LED1_reg <= 1'b0;
    else       LED1_reg <= LED1_in;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      LED1 <= 1'b0;
    end
    else if(BTN1) begin
      LED1 <= 1'b1;
    end
    else if(LED1_reg == 1'b0 && LED1_in == 1'b1) begin
      LED1 <= 1'b0;
    end
    else 
      LED1 <= LED1;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn)  LED2_reg <= 1'b0;
    else       LED2_reg <= LED2_in;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      LED2 <= 1'b0;
    end
    else if(BTN2) begin
      LED2 <= 1'b1;
    end
    else if(LED2_reg == 1'b0 && LED2_in == 1'b1) begin
      LED2 <= 1'b0;
    end
    else 
      LED2 <= LED2;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn)  LED3_reg <= 1'b0;
    else       LED3_reg <= LED3_in;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      LED3 <= 1'b0;
    end
    else if(BTN3) begin
      LED3 <= 1'b1;
    end
    else if(LED3_reg == 1'b0 && LED3_in == 1'b1) begin
      LED3 <= 1'b0;
    end
    else 
      LED3 <= LED3;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn)  LED6_reg <= 1'b1;
    else       LED6_reg <= LED6_in;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      LED6 <= 1'b1;
    end
    else if(BTN4) begin
      LED6 <= 1'b0;
    end
    else if(LED6_reg == 1'b1 && LED6_in == 1'b0) begin
      LED6 <= 1'b1;
    end
    else 
      LED6 <= LED6;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn)  LED7_reg <= 1'b1;
    else       LED7_reg <= LED7_in;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      LED7 <= 1'b1;
    end
    else if(BTN5) begin
      LED7 <= 1'b0;
    end
    else if(LED7_reg == 1'b1 && LED7_in == 1'b0) begin
      LED7 <= 1'b1;
    end
    else 
      LED7 <= LED7;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn)  LED8_reg <= 1'b1;
    else       LED8_reg <= LED8_in;
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      LED8 <= 1'b1;
    end
    else if(BTN6) begin
      LED8 <= 1'b0;
    end
    else if(LED8_reg == 1'b1 && LED8_in == 1'b0) begin
      LED8 <= 1'b1;
    end
    else 
      LED8 <= LED8;
  end
endmodule