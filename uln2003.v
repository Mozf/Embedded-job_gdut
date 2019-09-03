//==============================================================================
// Module name: uln2003
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.7.8
// Description: 
//1. 电梯上升或下降,通过up和down调动
//2. 速度6ms，速度可以在程序中改变，范围为4~15.
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module ULN2003
(
  input               clk,
  input               rstn,

  input               up,
  input               down,
  output  reg  [3:0]  INgogo
);

  reg  [6:0]  cnt100;
  reg  [9:0]  cnt1000;
  reg  [3:0]  cnt_speed;
  reg  [1:0]  fsm;

  always@(posedge clk or negedge rstn) begin //100 * 10 = 1000 ns = 1us
    if(!rstn) begin
      cnt100 <= 7'd0;
    end
    else if(cnt100 == 7'd9) begin
      cnt100 <= 7'd0;
    end
    else begin
      cnt100 <= cnt100 + 1'b1;
    end
  end

  always@(posedge clk or negedge rstn) begin //1 * 1000 = 1000 us = 1ms
    if(!rstn) begin
      cnt1000 <= 10'd0;
    end
    else if(cnt1000 == 10'd999) begin
      cnt1000 <= 10'd0;
    end
    else if(cnt100 == 7'd9) begin
      cnt1000 <= cnt1000 + 1'b1;
    end
  end

  always@(posedge clk or negedge rstn) begin //1ms * 6 = 6ms
    if(!rstn) begin
      cnt_speed <= 4'd0;
      fsm <= 2'b00;
    end
    else if(cnt_speed == 4'd4) begin
      if(up) begin
        cnt_speed <= 4'd0;
        fsm <= fsm + 1'b1;
      end
      else if(down) begin
        cnt_speed <= 4'd0;
        fsm <= fsm - 1'b1;
      end
      else begin
        cnt_speed <= 4'd0;
      end
    end
    else if(cnt1000 == 10'd999) begin
      cnt_speed <= cnt_speed + 1'b1;
    end
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      INgogo <= 4'd0;
    end
    else begin
      case(fsm)
        2'b00:INgogo <= 4'b0001;
        2'b01:INgogo <= 4'b0010;
        2'b10:INgogo <= 4'b0100;
        2'b11:INgogo <= 4'b1000;
        default:;
      endcase
    end
  end

endmodule