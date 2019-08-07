//==============================================================================
// Module name: btncontrol
// Author     : momo
// E-mail     : 1345238761@qq.com
// Create date: 2019.7.15
// Description: 电梯按键控制消抖
// -------------------------------------------------
// Modification log here:
// Author     :
// Date       : 
// Message    :
//==============================================================================
module btncontrol
(
  input       clk,
  input       rstn,

  //外呼
  input       BTN0,
  input       BTN1,
  input       BTN2,
  input       BTN3,

  output reg  BTN0_out,
  output reg  BTN1_out,
  output reg  BTN2_out,
  output reg  BTN3_out,

  //内呼
  input       BTN4,
  input       BTN5,
  input       BTN6,

  output reg  BTN4_out,
  output reg  BTN5_out,
  output reg  BTN6_out
);

  reg [1:0] BTN0_reg;
  reg [1:0] BTN1_reg;
  reg [1:0] BTN2_reg;
  reg [1:0] BTN3_reg;
  reg [1:0] BTN4_reg;
  reg [1:0] BTN5_reg;
  reg [1:0] BTN6_reg;

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      BTN0_reg <= 2'b00;
    end
    else begin
      BTN0_reg <= {BTN0_reg[0],BTN0};
    end
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      BTN0_out <= 1'b0;
    end
    else if(BTN0_reg == 2'b01 && BTN0 == 1'b1)begin
      BTN0_out <= 1'b1;
    end
    else 
      BTN0_out <= 1'b0;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      BTN1_reg <= 2'b00;
    end
    else begin
      BTN1_reg <= {BTN1_reg[0],BTN1};
    end
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      BTN1_out <= 1'b0;
    end
    else if(BTN1_reg == 2'b01 && BTN1 == 1'b1)begin
      BTN1_out <= 1'b1;
    end
    else 
      BTN1_out <= 1'b0;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      BTN2_reg <= 2'b00;
    end
    else begin
      BTN2_reg <= {BTN2_reg[0],BTN2};
    end
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      BTN2_out <= 1'b0;
    end
    else if(BTN2_reg == 2'b01 && BTN2 == 1'b1)begin
      BTN2_out <= 1'b1;
    end
    else 
      BTN2_out <= 1'b0;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      BTN3_reg <= 2'b00;
    end
    else begin
      BTN3_reg <= {BTN3_reg[0],BTN3};
    end
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      BTN3_out <= 1'b0;
    end
    else if(BTN3_reg == 2'b01 && BTN3 == 1'b1)begin
      BTN3_out <= 1'b1;
    end
    else 
      BTN3_out <= 1'b0;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      BTN4_reg <= 2'b00;
    end
    else begin
      BTN4_reg <= {BTN4_reg[0],BTN4};
    end
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      BTN4_out <= 1'b0;
    end 
    else if(BTN4_reg == 2'b01 && BTN4 == 1'b1)begin
      BTN4_out <= 1'b1;
    end
    else 
      BTN4_out <= 1'b0;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      BTN5_reg <= 2'b00;
    end
    else begin
      BTN5_reg <= {BTN5_reg[0],BTN5};
    end
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      BTN5_out <= 1'b0;
    end
    else if(BTN5_reg == 2'b01 && BTN5 == 1'b1)begin
      BTN5_out <= 1'b1;
    end
    else 
      BTN5_out <= 1'b0;
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      BTN6_reg <= 2'b00;
    end
    else begin
      BTN6_reg <= {BTN6_reg[0],BTN6};
    end
  end

  always@(posedge clk or negedge rstn) begin
    if(!rstn) begin
      BTN6_out <= 1'b0;
    end
    else if(BTN6_reg == 2'b01 && BTN6 == 1'b1)begin
      BTN6_out <= 1'b1;
    end
    else 
      BTN6_out <= 1'b0;
  end
endmodule