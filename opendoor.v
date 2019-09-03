//==============================================================================
// Module name: opendoor
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.7.9
// Description: 电梯�???门控制，根据上一个状态决�???
//LED5_R要在top中加与操�???
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

  output  reg           LED5_R,

  output  reg           close
);

  reg  [6:0]  cnt100;
  reg  [9:0]  cnt1000us;
  reg  [9:0]  cnt1000ms;
  reg  [1:0]  cnt4s;

  always@(posedge clk or negedge rstn) begin //100 * 10 = 1000 ns = 1us
    if(!rstn) begin
      cnt100 <= 7'd0;
    end
    else if(open) begin
      if(cnt100 == 7'd9) begin
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
    else if(open) begin
      if(cnt1000us == 10'd999) begin
        cnt1000us <= 10'd0;
      end
      else if(cnt100 == 7'd9) begin
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
    else if(open) begin
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
      close  <= 1'b0;
      cnt4s  <= 2'b00;
    end
    else if(open) begin
      if(cnt4s == 2'd3) begin
        cnt4s <= 2'd0;
        close <= 1'b1;
      end
      else if(cnt1000ms == 10'd999) begin
        cnt4s <= cnt4s + 1'b1;
      end
    end
    else begin
      close  <= 1'b0;
      cnt4s  <= 2'b00;
    end
  end

  always@(posedge clk or negedge rstn)  begin
    if(!rstn) 
      LED5_R <= 1'b0;
    else if(open)
      LED5_R <= 1'b1;
    else 
      LED5_R <= 1'b0;
  end

endmodule