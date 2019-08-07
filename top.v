//==============================================================================
// Module name: top
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
module top
(
  input         clk,

  //reset
  input         SW0,

  //redcatch
  input         red1,
  input         red2,
  input         red3,

  //btncontrol
  input         BTN0,
  input         BTN1,
  input         BTN2,
  input         BTN3,
  input         BTN4,
  input         BTN5,
  input         BTN6,

  //ledcontrol
  output        LED0,
  output        LED1,
  output        LED2,
  output        LED3,
  output        LED4_R,
  output        LED4_G,
  output        LED4_B,
  output        LED5_R,
  output        LED5_G,
  output        LED5_B,
  output        LED6,
  output        LED7,
  output        LED8,

  output  [3:0] INgogo
);

  wire        clk;
  wire        rstn;

  //redcatch-fsm
  wire r      ed1_reg;
  wire        red2_reg;
  wire        red3_reg;
  wire        red1_up;
  wire        red2_up;
  wire        red3_up;
  wire        red1_down;
  wire        red2_down;
  wire        red3_down;
  
  //btncontrol-ledcontrol
  wire        BTN0_b_l;
  wire        BTN1_b_l;
  wire        BTN2_b_l;
  wire        BTN3_b_l;
  wire        BTN4_b_l;
  wire        BTN5_b_l;
  wire        BTN6_b_l;

  //fsm-opendoor
  wire        open;
  wire        close;
  wire [4:0]  out_state;

  //ledcontrol-opendoor
  wire        LED0_lc_od;
  wire        LED1_lc_od;
  wire        LED2_lc_od;
  wire        LED3_lc_od;
  wire        LED6_lc_od;
  wire        LED7_lc_od;
  wire        LED8_lc_od;

  //fsm-ULN2003
  wire        up;
  wire        down;


  fsm fsm_inst_0
  (
    .clk       ( clk         ),
    .rstn      ( rstn        ),

    .red1_reg  ( red1_reg    ),
    .red2_reg  ( red2_reg    ),
    .red3_reg  ( red3_reg    ),

    .red1_up   ( red1_up    ),
    .red2_up   ( red2_up    ),
    .red3_up   ( red3_up    ),

    .red1_down ( red1_down  ),
    .red2_down ( red2_down  ),
    .red3_down ( red3_down  ),

    .down      ( down        ),
    .up        ( up          ),

    .LED0_in   ( LED0        ),
    .LED1_in   ( LED1        ),
    .LED2_in   ( LED2        ),
    .LED3_in   ( LED3        ),
    .LED6_in   ( LED6        ),
    .LED7_in   ( LED7        ),
    .LED8_in   ( LED8        ),

    .LED4_R    ( LED4_R      ),
    .LED4_G    ( LED4_G      ),
    .LED4_B    ( LED4_B      ),

    .LED5_G    ( LED5_G      ),
    .LED5_B    ( LED5_B      ),

    .close     ( close       ),
    .open      ( open        ),

    .out_state ( out_state   ) 
  );

  reset reset_0
  (
    .clk    ( clk        ),
    .SW0    ( SW0        ),
    .rstn   ( rstn       )
  );

  redcatch redcatch_inst_0
  (
    .clk        ( clk        ),
    .rstn       ( rstn       ),

    .red1_in    ( red1       ),
    .red2_in    ( red2       ),
    .red3_in    ( red3       ),

    .red1_reg   ( red1_reg   ),
    .red2_reg   ( red2_reg   ),
    .red3_reg   ( red3_reg   ),

    .red1_up    ( red1_up    ),
    .red2_up    ( red2_up    ),
    .red3_up    ( red3_up    ),

    .red1_down  ( red1_down  ),
    .red2_down  ( red2_down  ),
    .red3_down  ( red3_down  )
  );

  btncontrol btncontrol_inst_0
  (
    .clk        ( clk        ),
    .rstn       ( rstn       ),

    .BTN0       ( BTN0       ),
    .BTN1       ( BTN1       ),
    .BTN2       ( BTN2       ),
    .BTN3       ( BTN3       ),
    .BTN4       ( BTN4       ),
    .BTN5       ( BTN5       ),
    .BTN6       ( BTN6       ),

    .BTN0_out   ( BTN0_b_l   ),
    .BTN1_out   ( BTN1_b_l   ),
    .BTN2_out   ( BTN2_b_l   ),
    .BTN3_out   ( BTN3_b_l   ),
    .BTN4_out   ( BTN4_b_l   ),
    .BTN5_out   ( BTN5_b_l   ),
    .BTN6_out   ( BTN6_b_l   )
  );

  ledcontrol ledcontrol_inst_0
  (
    .clk        ( clk        ),
    .rstn       ( rstn       ),

    .BTN0       ( BTN0_b_l   ),
    .BTN1       ( BTN1_b_l   ),
    .BTN2       ( BTN2_b_l   ),
    .BTN3       ( BTN3_b_l   ),
    .BTN4       ( BTN4_b_l   ),
    .BTN5       ( BTN5_b_l   ),
    .BTN6       ( BTN6_b_l   ),

    .LED0_in    ( LED0_lc_od ),
    .LED1_in    ( LED1_lc_od ),
    .LED2_in    ( LED2_lc_od ),
    .LED3_in    ( LED3_lc_od ),
    .LED6_in    ( LED6_lc_od ),
    .LED7_in    ( LED7_lc_od ),
    .LED8_in    ( LED8_lc_od ),

    .LED0       ( LED0       ),
    .LED1       ( LED1       ),
    .LED2       ( LED2       ),
    .LED3       ( LED3       ),
    .LED6       ( LED6       ),
    .LED7       ( LED7       ),
    .LED8       ( LED8       )
  );

  opendoor opendoor_inst_0
  (
    .clk        ( clk        ),
    .rstn       ( rstn       ),

    .open       ( open       ),
    
    .out_state  ( out_state  ),

    .close      ( close      ),

    .LED0       ( LED0_lc_od ),
    .LED1       ( LED1_lc_od ),
    .LED2       ( LED2_lc_od ),
    .LED3       ( LED3_lc_od ),
    .LED5       ( LED5_R     ),
    .LED6       ( LED6_lc_od ),
    .LED7       ( LED7_lc_od ),
    .LED8       ( LED8_lc_od )
  );

  ULN2003 ULN2003_inst_0
  (
    .clk        ( clk        ),
    .rstn       ( rstn       ),

    .up         ( up         ),
    .down       ( down       ),

    .INgogo     ( INgogo     )
  );

endmodule