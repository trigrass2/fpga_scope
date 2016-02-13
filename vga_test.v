`timescale 1ns / 1ps

module vga_test(clk,
                rst,
                HSYNC,
                VSYNC,
                R,
                G,
                B,
                col_change);
                
input clk; // 25 MHz
input rst;
input col_change;

output HSYNC;
output VSYNC;
output R;
output G;
output B;


wire [9:0] Pixel_x;
wire [9:0] Pixel_y;


wire [2:0] Back_ground = 3'b000;
wire [2:0] Char_color = 3'b111;

wire blank;
wire Red;
wire Green;
wire Blue;




assign Mux_Sel = Pixel_x[2:0];
assign DP_mux_sel = Pixel_y[8:7];

assign Red = ((Pixel_x > (100 + (col_change?50:0))) & (Pixel_x < 300))? Back_ground[2] : Char_color[2];
assign Green = ((Pixel_x > (100 + (col_change?50:0))) & (Pixel_y < 300))? Back_ground[1] : Char_color[1];
assign Blue = ((Pixel_y > (100 + (col_change?50:0))) & (Pixel_y < 300))? Back_ground[0] : Char_color[0];


assign R = (blank == 1'b0)? 1'b0 : Red;
assign G = (blank == 1'b0)? 1'b0 : Green;
assign B = (blank == 1'b0)? 1'b0 : Blue;


vga_sync vga_sync (
    .clk(clk),
    .rst(rst),
    .Vsync(VSYNC),
    .Hsync(HSYNC),
    .Blank(blank),
    .Pixel_x(Pixel_x),
    .Pixel_y(Pixel_y)
    );



/*
vga_interface vga_int (.clk_25M(clk),
                        .v_cnt(Pixel_x),
                        .h_cnt(Pixel_y),
                        .v_sync(VSYNC),
                        .h_sync(HSYNC),
                        .porch_flag(blank),
                        .reset(0)
                        );
*/
endmodule
