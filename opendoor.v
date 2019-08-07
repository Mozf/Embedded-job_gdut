//==============================================================================
// Module name: opendoor
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.7.9
// Description: 电梯开门控制，根据上一个状态决定
//LED5_R要在top中加与操作
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module opendoor
#(
  parameter  STATE = 4
)
(
  input                 clk,
  input                 rstn,

  input                 open,

  input       [STATE:0] out_state;

  output  reg           LED5_R，

  output  reg           close,

  //外呼灯
  output  reg           LED0,
  output  reg           LED1,
  output  reg           LED2,
  output  reg           LED3,
  
  //内呼灯
  output  reg           LED6,
  output  reg           LED7,
  output  reg           LED8
);

  reg  [6:0]  cnt100;
  reg  [9:0]  cnt1000us;
  reg  [9:0]  cnt1000ms;
  reg  [1:0]  cnt4s;
  reg  [1:0]  open_reg;

  always@(posedge clk or negedge rstn) begin //10 * 100 = 1000 ns = 1us
    if(!rstn) begin
      cnt100 <= 7'd0;
    end
    else if(open == 1'b1) begin
      if(cnt100 == 7'd99) begin
        cnt100 <= 7'd0;
      end
      else begin
        cnt100 <= cnt100 + 1'b1;
      end
    end
    else begin
      cnt100 <= 7'd0;
    end
  end

  always@(posedge clk or negedge rstn) begin //1 * 1000 = 1000 us = 1ms
    if(!rstn) begin
      cnt1000us <= 10'd0;
    end
    else if(open == 1'b1) begin
      if(cnt1000us == 10'd999) begin
        cnt1000us <= 10'd0;
      end
      else if(cnt100 == 7'd99) begin
        cnt1000us <= cnt1000us + 1'b1;
      end
    end
    else begin
      cnt1000us <= 10'd0;
    end
  end

  always@(posedge clk or negedge rstn) begin //1 * 1000 = 1000 ms = 1s
    if(!rstn) begin
      cnt1000ms <= 10'd0;
    end
    else if(open == 1'b1) begin
      if(cnt1000ms == 10'd999) begin
        cnt1000ms <= 10'd0;
      end
      else if(cnt1000us == 10'd999) begin
        cnt1000ms <= cnt1000ms + 1'b1;
      end
    end
    else begin
      cnt1000ms <= 10'd0;
    end
  end

  always@(posedge clk or negedge rstn) begin //1s * 4 = 4s
    if(!rstn) begin
      LED5_R <= 1'b0;
      close  <= 1'b0;
      LED0   <= 1'b0;
      LED1   <= 1'b0;
      LED2   <= 1'b0;
      LED3   <= 1'b0;
      LED6   <= 1'b1;
      LED7   <= 1'b1;
      LED8   <= 1'b1;
    end
    else if(open == 1'b1) begin
      LED5_R <= 1'b1;
      if(cnt4s == 2'd3) begin
        cnt4s <= 2'd0;
        close <= 1'b1;
      end
      else if(cnt1000ms == 10'd999) begin
        cnt4s <= cnt4s + 1'b1;
      end
      //开门关灯
      if(out_state == STATE'd2 || out_state == STATE'd3 || out_state == STATE'd4) begin
        if(open_reg == 2'01)begin
          if(LED4_R)
            LED0 <= 1'b1;
          else if(LED4_G) begin
            if(LED1 && LED2)
              LED1 <= 1'b1;
            else if(LED1)
              LED1 <= 1'b1;
            else if(LED2)
              LED2 <= 1'b1;
          end
          else if(LED4_B)
            LED3 <= 1'b1;
        end 
      end
      else if(out_state == STATE'd7) begin
        if(open_reg == 2'01)begin
          if(LED4_G) begin
            LED2 <= 1'b1;
            LED7 <= 1'b0;
          end
          else if(LED4_B) begin
            LED3 <= 1'b1;
            LED8 <= 1'b0;
          end
        end
      end
      else if(out_state == STATE'd8) begin
        if(open_reg == 2'01) begin
          if(LED4_R) begin
            LED0 <= 1'b1;
            LED6 <= 1'b0;
          end
          else if(LED4_G) begin
            LED1 <= 1'b1;
            LED7 <= 1'b0;
          end
        end
      end
    end
    else begin
      close  <= 1'b0;
      LED5_R <= 1'b0;
      LED0   <= 1'b0;
      LED1   <= 1'b0;
      LED2   <= 1'b0;
      LED3   <= 1'b0;
      LED6   <= 1'b1;
      LED7   <= 1'b1;
      LED8   <= 1'b1;
    end
  end

  always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin
      open_reg <= 2'd0;
    end
    else begin
      open_reg <= {open_reg[0],open};
    end
  end

endmodule