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
  input         sysclk,
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

  output  [3:0] INgogo,

  inout [14:0]  DDR_addr,
  inout [2:0]   DDR_ba,
  inout         DDR_cas_n,
  inout         DDR_ck_n,
  inout         DDR_ck_p,
  inout         DDR_cke,
  inout         DDR_cs_n,
  inout [3:0]   DDR_dm,
  inout [31:0]  DDR_dq,
  inout [3:0]   DDR_dqs_n,
  inout [3:0]   DDR_dqs_p,
  inout         DDR_odt,
  inout         DDR_ras_n,
  inout         DDR_reset_n,
  inout         DDR_we_n,
  inout         FIXED_IO_ddr_vrn,
  inout         FIXED_IO_ddr_vrp,
  inout [53:0]  FIXED_IO_mio,
  inout         FIXED_IO_ps_clk,
  inout         FIXED_IO_ps_porb,
  inout         FIXED_IO_ps_srstb
);

  wire        clk1;
  wire        rstn;

  //redcatch-fsm
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
    .clk       ( clk1        ),
    .rstn      ( rstn        ),

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
    .clk    ( clk1       ),
    .SW0    ( SW0        ),
    .rstn   ( rstn       )
  );

  redcatch redcatch_inst_0
  (
    .clk        ( clk1       ),
    .rstn       ( rstn       ),

    .red1_in    ( red1       ),
    .red2_in    ( red2       ),
    .red3_in    ( red3       ),

    .red1_up    ( red1_up    ),
    .red2_up    ( red2_up    ),
    .red3_up    ( red3_up    ),

    .red1_down  ( red1_down  ),
    .red2_down  ( red2_down  ),
    .red3_down  ( red3_down  )
  );

  btncontrol btncontrol_inst_0
  (
    .clk        ( clk1       ),
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
    .clk        ( clk1       ),
    .rstn       ( rstn       ),

    .BTN0       ( BTN0_b_l   ),
    .BTN1       ( BTN1_b_l   ),
    .BTN2       ( BTN2_b_l   ),
    .BTN3       ( BTN3_b_l   ),
    .BTN4       ( BTN4_b_l   ),
    .BTN5       ( BTN5_b_l   ),
    .BTN6       ( BTN6_b_l   ),

    .LED0       ( LED0       ),
    .LED1       ( LED1       ),
    .LED2       ( LED2       ),
    .LED3       ( LED3       ),
    .LED6       ( LED6       ),
    .LED7       ( LED7       ),
    .LED8       ( LED8       ),

    .open       ( open       ),
    .out_state  ( out_state  ),
    .LED4_R     ( LED4_R     ),
    .LED4_G     ( LED4_G     ),
    .LED4_B     ( LED4_B     )
  );

  opendoor opendoor_inst_0
  (
    .clk        ( clk1       ),
    .rstn       ( rstn       ),

    .open       ( open       ),

    .close      ( close      ),
    .LED5_R     ( LED5_R     )
  );

  ULN2003 ULN2003_inst_0
  (
    .clk        ( clk1       ),
    .rstn       ( rstn       ),

    .up         ( up         ),
    .down       ( down       ),

    .INgogo     ( INgogo     )
  );

  clk_wiz_0 clk_wiz_0_inst_0
  (
    .clk_in1    ( sysclk     ),
    .clk_out1   ( clk1       )
  );

  design_1_wrapper design_1_wrapper_0
  ( 
    .DDR_addr           ( DDR_addr          ),
    .DDR_ba             ( DDR_ba            ),
    .DDR_cas_n          ( DDR_cas_n         ),
    .DDR_ck_n           ( DDR_ck_n          ),
    .DDR_ck_p           ( DDR_ck_p          ),
    .DDR_cke            ( DDR_cke           ),
    .DDR_cs_n           ( DDR_cs_n          ),
    .DDR_dm             ( DDR_dm            ),
    .DDR_dq             ( DDR_dq            ),
    .DDR_dqs_n          ( DDR_dqs_n         ),
    .DDR_dqs_p          ( DDR_dqs_p         ),
    .DDR_odt            ( DDR_odt           ),
    .DDR_ras_n          ( DDR_ras_n         ),
    .DDR_reset_n        ( DDR_reset_n       ),
    .DDR_we_n           ( DDR_we_n          ),
    .FIXED_IO_ddr_vrn   ( FIXED_IO_ddr_vrn  ),
    .FIXED_IO_ddr_vrp   ( FIXED_IO_ddr_vrp  ),
    .FIXED_IO_mio       ( FIXED_IO_mio      ),
    .FIXED_IO_ps_clk    ( FIXED_IO_ps_clk   ),
    .FIXED_IO_ps_porb   ( FIXED_IO_ps_porb  ),
    .FIXED_IO_ps_srstb  ( FIXED_IO_ps_srstb )
  );

endmodule