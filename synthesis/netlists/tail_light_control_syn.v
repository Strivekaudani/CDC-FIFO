/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : O-2018.06-SP1
// Date      : Thu Oct  5 21:03:08 2023
/////////////////////////////////////////////////////////////


module tail_light_control ( clk, rst_n, brake, turn_right, turn_left, 
        right_tail_light_control, left_tail_light_control );
  output [2:0] right_tail_light_control;
  output [2:0] left_tail_light_control;
  input clk, rst_n, brake, turn_right, turn_left;
  wire   n118, n1, n2, n3, n5, n7, n8, n11, n12, n14, n15, n16, n17, n19, n20,
         n21, n22, n23, n26, n27, n28, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51,
         n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65,
         n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79,
         n80, n81, n82, n83, n84, n85, n86, n87, n89, n90, n91, n93, n94, n95,
         n96, n98, n99, n100, n101, n103, n104, n105, n106, n108, n109, n110,
         n111, n113, n114, n115, n116, n117;
  wire   [2:0] count;
  wire   [2:0] count_next;
  wire   [2:0] right_tail_light_control_next;
  wire   [2:0] left_tail_light_control_next;

  NAND2_D U3 ( .A(n65), .B(n41), .Z(right_tail_light_control_next[2]) );
  NAND2_D U6 ( .A(n64), .B(n16), .Z(right_tail_light_control_next[1]) );
  NAND2_D U19 ( .A(n66), .B(n40), .Z(left_tail_light_control_next[2]) );
  NAND2_D U22 ( .A(n57), .B(n30), .Z(left_tail_light_control_next[1]) );
  XNOR2_C U38 ( .A(n3), .B(n81), .Z(count_next[1]) );
  DFFR_E \count_reg[1]  ( .D(count_next[1]), .CLK(clk), .RN(n50), .QBAR(n39)
         );
  DFFR_E \left_tail_light_control_reg[0]  ( .D(left_tail_light_control_next[0]), .CLK(clk), .RN(n50), .QBAR(n114) );
  DFFR_E \left_tail_light_control_reg[1]  ( .D(left_tail_light_control_next[1]), .CLK(clk), .RN(n50), .QBAR(n109) );
  DFFR_E \right_tail_light_control_reg[1]  ( .D(
        right_tail_light_control_next[1]), .CLK(clk), .RN(n50), .QBAR(n104) );
  DFFR_E \left_tail_light_control_reg[2]  ( .D(left_tail_light_control_next[2]), .CLK(clk), .RN(n50), .QBAR(n99) );
  DFFR_E \right_tail_light_control_reg[2]  ( .D(
        right_tail_light_control_next[2]), .CLK(clk), .RN(n50), .QBAR(n94) );
  DFFR_E \right_tail_light_control_reg[0]  ( .D(n55), .CLK(clk), .RN(n50), .Q(
        n118), .QBAR(n116) );
  DFFR_E \count_reg[0]  ( .D(n42), .CLK(clk), .RN(n50), .Q(count[0]), .QBAR(
        n42) );
  DFFR_E \count_reg[2]  ( .D(count_next[2]), .CLK(clk), .RN(n50), .Q(count[2])
         );
  INVERT_K U46 ( .A(n82), .Z(n83) );
  INVERT_H U47 ( .A(n67), .Z(n68) );
  INVERT_H U48 ( .A(n14), .Z(n67) );
  INVERT_E U49 ( .A(n79), .Z(n77) );
  INVERT_H U50 ( .A(n21), .Z(n51) );
  AND2_I U51 ( .A(n83), .B(n48), .Z(n36) );
  NAND3_D U52 ( .A(n17), .B(n5), .C(n89), .Z(n37) );
  NAND3_D U53 ( .A(n31), .B(n5), .C(n113), .Z(n38) );
  AOI21_B U54 ( .A1(n54), .A2(n108), .B(n69), .Z(n40) );
  AOI21_B U55 ( .A1(n53), .A2(n103), .B(n70), .Z(n41) );
  AO21_F U56 ( .A1(n116), .A2(n117), .B(n19), .Z(n14) );
  INVERT_H U57 ( .A(turn_right), .Z(n43) );
  INVERT_J U58 ( .A(n43), .Z(n44) );
  INVERT_H U59 ( .A(turn_left), .Z(n45) );
  INVERT_K U60 ( .A(n45), .Z(n46) );
  INVERT_H U61 ( .A(brake), .Z(n47) );
  INVERT_K U62 ( .A(n47), .Z(n48) );
  INVERT_I U63 ( .A(rst_n), .Z(n49) );
  INVERT_N U64 ( .A(n49), .Z(n50) );
  INVERT_L U65 ( .A(n105), .Z(n101) );
  NOR2_D U66 ( .A(n103), .B(n93), .Z(n117) );
  OR2_I U67 ( .A(n103), .B(n89), .Z(n21) );
  INVERT_K U68 ( .A(n101), .Z(n103) );
  NAND2_F U69 ( .A(n44), .B(n7), .Z(n19) );
  AND2_H U70 ( .A(n56), .B(n81), .Z(n35) );
  INVERT_D U71 ( .A(n35), .Z(n52) );
  INVERT_L U72 ( .A(n110), .Z(n106) );
  INVERT_L U73 ( .A(n115), .Z(n111) );
  AO21_E U74 ( .A1(n2), .A2(n5), .B(n78), .Z(n33) );
  OR2_J U75 ( .A(n108), .B(n98), .Z(n32) );
  AOI21_B U76 ( .A1(n69), .A2(n113), .B(n54), .Z(n30) );
  AOI21_B U77 ( .A1(n70), .A2(n89), .B(n53), .Z(n16) );
  INVERT_H U78 ( .A(n37), .Z(n53) );
  INVERT_H U79 ( .A(n38), .Z(n54) );
  INVERT_H U80 ( .A(n84), .Z(n82) );
  INVERT_E U81 ( .A(n22), .Z(n84) );
  AO21_F U82 ( .A1(n1), .A2(n5), .B(n12), .Z(n20) );
  NAND2_H U83 ( .A(n83), .B(n44), .Z(n12) );
  AOI222_H U84 ( .A1(n89), .A2(n20), .B1(n17), .B2(n51), .C1(n86), .C2(n19), 
        .Z(right_tail_light_control_next[0]) );
  INVERT_C U85 ( .A(right_tail_light_control_next[0]), .Z(n55) );
  INVERT_H U86 ( .A(n39), .Z(n56) );
  INVERT_D U87 ( .A(n78), .Z(n58) );
  INVERT_E U88 ( .A(n108), .Z(n59) );
  INVERT_F U89 ( .A(n27), .Z(n60) );
  INVERT_H U90 ( .A(n86), .Z(n61) );
  NOR2_C U91 ( .A(n58), .B(n59), .Z(n62) );
  NOR2_C U92 ( .A(n60), .B(n61), .Z(n63) );
  NOR2_C U93 ( .A(n62), .B(n63), .Z(n57) );
  OAI21_D U94 ( .A1(n113), .A2(n32), .B(n46), .Z(n27) );
  INVERT_K U95 ( .A(n106), .Z(n108) );
  BUFFER_F U96 ( .A(n15), .Z(n64) );
  AOI22_B U97 ( .A1(n103), .A2(n12), .B1(n86), .B2(n68), .Z(n15) );
  BUFFER_F U98 ( .A(n8), .Z(n65) );
  AOI22_B U99 ( .A1(n93), .A2(n12), .B1(n86), .B2(n68), .Z(n8) );
  BUFFER_F U100 ( .A(n23), .Z(n66) );
  AOI22_B U101 ( .A1(n86), .A2(n27), .B1(n98), .B2(n78), .Z(n23) );
  AO222_F U102 ( .A1(n113), .A2(n33), .B1(n34), .B2(n31), .C1(n86), .C2(n7), 
        .Z(left_tail_light_control_next[0]) );
  NOR2_C U103 ( .A(n108), .B(n113), .Z(n34) );
  INVERT_K U104 ( .A(n111), .Z(n113) );
  NAND3_C U105 ( .A(n81), .B(n3), .C(count[2]), .Z(n22) );
  INVERT_F U106 ( .A(n56), .Z(n3) );
  NAND3_D U107 ( .A(n108), .B(n48), .C(n98), .Z(n26) );
  INVERT_F U108 ( .A(n26), .Z(n69) );
  INVERT_J U109 ( .A(n96), .Z(n98) );
  NAND3_D U110 ( .A(n103), .B(n48), .C(n93), .Z(n11) );
  INVERT_F U111 ( .A(n11), .Z(n70) );
  INVERT_J U112 ( .A(n91), .Z(n93) );
  INVERT_H U113 ( .A(n46), .Z(n7) );
  INVERT_F U114 ( .A(n71), .Z(n31) );
  NAND2BAL_E U115 ( .A(n46), .B(n72), .Z(n71) );
  NAND2BAL_E U116 ( .A(n83), .B(n2), .Z(n73) );
  INVERT_F U117 ( .A(n73), .Z(n72) );
  INVERT_H U118 ( .A(n98), .Z(n2) );
  INVERT_F U119 ( .A(n74), .Z(n17) );
  NAND2BAL_E U120 ( .A(n44), .B(n75), .Z(n74) );
  NAND2BAL_E U121 ( .A(n83), .B(n1), .Z(n76) );
  INVERT_F U122 ( .A(n76), .Z(n75) );
  INVERT_H U123 ( .A(n93), .Z(n1) );
  CLKI_O U124 ( .A(n77), .Z(n78) );
  AND2_H U125 ( .A(n46), .B(n83), .Z(n28) );
  INVERT_D U126 ( .A(n28), .Z(n79) );
  INVERT_H U127 ( .A(count[0]), .Z(n80) );
  INVERT_I U128 ( .A(n80), .Z(n81) );
  INVERT_J U129 ( .A(n48), .Z(n5) );
  INVERT_H U130 ( .A(n36), .Z(n85) );
  INVERT_K U131 ( .A(n85), .Z(n86) );
  INVERT_K U132 ( .A(n90), .Z(n87) );
  INVERT_O U133 ( .A(n87), .Z(right_tail_light_control[0]) );
  INVERT_I U134 ( .A(n87), .Z(n89) );
  BUFFER_J U135 ( .A(n118), .Z(n90) );
  INVERT_K U136 ( .A(n95), .Z(n91) );
  INVERT_O U137 ( .A(n91), .Z(right_tail_light_control[2]) );
  INVERT_H U138 ( .A(n94), .Z(n95) );
  INVERT_K U139 ( .A(n100), .Z(n96) );
  INVERT_O U140 ( .A(n96), .Z(left_tail_light_control[2]) );
  INVERT_H U141 ( .A(n99), .Z(n100) );
  INVERT_O U142 ( .A(n101), .Z(right_tail_light_control[1]) );
  INVERT_H U143 ( .A(n104), .Z(n105) );
  INVERT_O U144 ( .A(n106), .Z(left_tail_light_control[1]) );
  INVERT_H U145 ( .A(n109), .Z(n110) );
  INVERT_O U146 ( .A(n111), .Z(left_tail_light_control[0]) );
  INVERT_H U147 ( .A(n114), .Z(n115) );
  XNOR2_B U148 ( .A(count[2]), .B(n52), .Z(count_next[2]) );
endmodule

