//==============================================================================
// Module name: fsm
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.7.8
// Description: 
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module fsm
#(
  parameter STATE = 4,
  parameter SIDLE = 4'd0,
  parameter S1    = 4'd1,
  parameter S2    = 4'd2,
  parameter S3    = 4'd3,
  parameter S4    = 4'd4,
  parameter S5    = 4'd5,
  parameter S6    = 4'd6,
  parameter S7    = 4'd7,
  parameter S8    = 4'd8,
  parameter S9    = 4'd9,
  parameter S10   = 4'd10,
  parameter S11   = 4'd11,
  parameter S12   = 4'd12,
  parameter S13   = 4'd13
)
(
  input                 clk,
  input                 rstn,

  //位置接收信号
  input                 red1_up,
  input                 red2_up,
  input                 red3_up,

  input                 red1_down,
  input                 red2_down,
  input                 red3_down,

  output reg            down,
  output reg            up,

  //外呼�????
  input                 LED0_in,
  input                 LED1_in,
  input                 LED2_in,
  input                 LED3_in,
  
  //内呼�????
  input                 LED6_in,
  input                 LED7_in,
  input                 LED8_in,

  //楼层�????
  output reg            LED4_R,
  output reg            LED4_G,
  output reg            LED4_B,
  
  //状�?�灯
  output reg            LED5_G,
  output reg            LED5_B,

  input                 close,
  output reg            open,

  output reg  [STATE:0] out_state
);

  reg  [STATE:0] current_state;
  reg  [STATE:0] next_state;

  always @(posedge clk or negedge rstn) begin
    if(!rstn) 
      current_state <= SIDLE;
    else  begin
      current_state <= next_state;
    end
  end

  always @(posedge clk) begin
    case(next_state)
      SIDLE:begin
        if(!rstn) 
          next_state = SIDLE;
        else 
          next_state = S1;
      end

      S1:begin
        if(!rstn)
          next_state = SIDLE;
        else if(red1_down)
          next_state = S2;
        else
          next_state = S1;
      end

      S2:begin
        if(!rstn)
          next_state = SIDLE;
        else begin
          if(LED0_in | (!LED6_in))
            next_state = S5;
          else if(LED1_in | LED2_in | LED3_in | (!LED7_in) | (!LED8_in))
            next_state = S7;
          else
            next_state = S2;
        end
      end

      S3:begin
        if(!rstn)
          next_state = SIDLE;
        else begin
          if(LED1_in | LED2_in | (!LED7_in))
            next_state = S5;
          else if(LED3_in | (!LED6_in))
            next_state = S7;
          else if(LED0_in | (!LED8_in))
            next_state = S8;
          else
            next_state = S3;
        end
      end

      S4:begin
        if(!rstn)
          next_state = SIDLE;
        else begin
          if(LED3_in | (!LED8_in))
            next_state = S5;
          else if(LED0_in | LED1_in | LED2_in | (!LED6_in) | (!LED7_in))
            next_state = S8;
          else
            next_state = S4;
        end
      end

      S5:begin
        if(!rstn)
          next_state = SIDLE;
        else if(close)
          next_state = S6;
        else
          next_state = S5;
      end

      S6:begin
        if(!rstn)
          next_state = SIDLE;
        else if((LED4_R & (LED0_in | (!LED6_in))) | (LED4_G & (LED1_in | LED2_in | (!LED7_in))) | (LED4_B & (LED3_in|| (!LED8_in))))
          next_state = S5;
        else if((LED4_R & (LED1_in | LED2_in | LED3_in | (!LED7_in) | (!LED8_in))) | (LED4_G & (LED3_in | (!LED8_in))))
          next_state = S7;
        else if((LED4_B & (LED0_in | LED1_in | LED2_in | (!LED6_in) | (!LED7_in))) | (LED4_G & (LED0_in | (!LED6_in))))
          next_state = S8;
        else
          next_state = S6;
      end

      S7: begin
        if(LED4_R) begin
          if((LED1_in | LED2_in | (!LED7_in)) & red2_up) 
            next_state = S9;
          else if(LED1_in | LED2_in | (!LED7_in))
            next_state = S7;
          else if((LED3_in | (!LED8_in)) & red3_up)
            next_state = S10;
          else if(LED3_in | (!LED8_in))
            next_state = S7;
          else
            next_state = S2;
        end 
        else if(LED4_G) begin
          if((LED3_in | (!LED8_in)) & red3_up) 
            next_state = S10;
          else if(LED3_in | (!LED8_in))
            next_state = S7;
          else if(LED1_in)
            next_state = S9;
          else if(LED0_in | (!LED6_in)) 
            next_state = S8;
          else
            next_state = S3;
        end
        else if(LED4_B) begin
          if(LED0_in | LED1_in | LED2_in | (!LED6_in) | (!LED7_in))
            next_state = S8;
          else
            next_state = S4;
        end
      end
      
      S8: begin
        if(LED4_B) begin
          if((LED1_in | (!LED7_in)) & red2_down)
            next_state = S11;
          else if(LED1_in | (!LED7_in))
            next_state = S8;
          else if((LED0_in | (!LED6_in)) & red1_down)
            next_state = S12;
          else if(LED0_in | (!LED6_in))
            next_state = S8;
          else
            next_state = SIDLE;
        end
        else if(LED4_G) begin
          if((LED0_in | (!LED6_in)) & red1_down)
            next_state = S12;
          else if(LED0_in | (!LED6_in))
            next_state = S8;
          else if(LED2_in)
            next_state = S11;
          else if(LED3_in | (!LED8_in))
            next_state = S7;
          else 
            next_state = S3;
        end
        else if(LED4_R) begin
          if(LED1_in | LED2_in | LED3_in | (!LED7_in) | (!LED8_in))
            next_state = S7;
          else
            next_state = S2;
        end
      end

      S9: begin
        if(!rstn)
          next_state = SIDLE;
        else if(close)
          next_state = S7;
        else
          next_state = S9;
      end

      S10: begin
        if(!rstn)
          next_state = SIDLE;
        else if(close)
          next_state = S7;
        else
          next_state = S10;
      end

      S11: begin
        if(!rstn)
          next_state = SIDLE;
        else if(close)
          next_state = S8;
        else
          next_state = S11;
      end

      S12: begin
        if(!rstn)
          next_state = SIDLE;
        else if(close)
          next_state = S8;
        else
          next_state = S12;
      end

      S13:begin
        if(!rstn)
          next_state = SIDLE;
        else if(red1_up)
          next_state = S2;
        else
          next_state = S13;
      end

      default:next_state = SIDLE;
    endcase
  end

  always @(posedge clk) begin
    case(current_state)
      SIDLE:begin
        up      <= 1'b0;
        down    <= 1'b0;
        open    <= 1'b0;
        LED4_R  <= 1'b0;
        LED4_G  <= 1'b0;
        LED4_B  <= 1'b0;
        LED5_G  <= 1'b0;
        LED5_B  <= 1'b0;
      end

      S1:begin
        down <= 1'b1;
      end

      S2:begin
        up     <= 1'b0;
        down   <= 1'b0;
        LED4_R <= 1'b1;
        LED4_G <= 1'b0;
        LED4_B <= 1'b0;
        LED5_G <= 1'b0;
        LED5_B <= 1'b0;
        out_state <= 4'd2;
      end

      S3:begin
        up     <= 1'b0;
        down   <= 1'b0;
        LED4_R <= 1'b0;
        LED4_G <= 1'b1;
        LED4_B <= 1'b0;
        LED5_G <= 1'b0;
        LED5_B <= 1'b0;
        out_state <= 4'd3;
      end

      S4:begin
        up     <= 1'b0;
        down   <= 1'b0;
        LED4_R <= 1'b0;
        LED4_G <= 1'b0;
        LED4_B <= 1'b1;
        LED5_G <= 1'b0;
        LED5_B <= 1'b0;
        out_state <= 4'd4;
      end

      S5:begin
        open   <= 1'b1;
      end

      S6:begin
        open   <= 1'b0;
      end

      S7:begin
        up     <= 1'b1;
        open   <= 1'b0;
        LED5_B <= 1'b1;
        LED5_G <= 1'b0;
        out_state <= 4'd7;
        if(red2_up) begin
          LED4_R <= 1'b0;
          LED4_G <= 1'b1;
        end
      end

      S8: begin
        down   <= 1'b1;
        open   <= 1'b0;
        LED5_B <= 1'b0;
        LED5_G <= 1'b1;
        out_state <= 4'd8;
        if(red2_down) begin
          LED4_B <= 1'b0;
          LED4_G <= 1'b1;
        end
      end

      S9: begin
        open   <= 1'b1;
        up     <= 1'b0;
        LED4_R <= 1'b0;
        LED4_G <= 1'b1;
        LED4_B <= 1'b0;
        LED5_B <= 1'b0;
      end

      S10: begin
        open   <= 1'b1;
        up     <= 1'b0;
        LED4_R <= 1'b0;
        LED4_G <= 1'b0;
        LED4_B <= 1'b1;
        LED5_B <= 1'b0;
      end

      S11: begin
        open   <= 1'b1;
        down   <= 1'b0;
        LED4_R <= 1'b0;
        LED4_G <= 1'b1;
        LED4_B <= 1'b0;
        LED5_G <= 1'b0;
      end

      S12: begin
        open   <= 1'b1;
        down   <= 1'b0;
        LED4_R <= 1'b1;
        LED4_G <= 1'b0;
        LED4_B <= 1'b0;
        LED5_G <= 1'b0;
      end

      S13:begin
        up <= 1'b1;
      end

    endcase
  end

endmodule