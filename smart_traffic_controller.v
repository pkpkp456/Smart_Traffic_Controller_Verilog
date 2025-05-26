`timescale 1ns / 1ps
module traffic_light_controller_with_display(
    input clk,
    input rst,
    input [1:0] TA, TB, TC, TD,    // Traffic densities for roads A-D
    input VA, VB, VC, VD,          // Vehicle presence for roads A-D
    input emg_mode,                // Emergency mode enable
    input [1:0] ER,                // Emergency priority road (00:A, 01:B, 10:C, 11:D)
    output reg GA, GB, GC, GD,     // Green lights for A-D
    output reg YA, YB, YC, YD,     // Yellow lights for A-D
    output reg RA, RB, RC, RD,     // Red lights for A-D
    output reg [6:0] seg,          // 7-seg display output (common anode assumed)
    output reg [7:0] timer_out     // Timer counter output for testbench monitoring
);

// State encoding
localparam IDLE      = 4'd0;
localparam A_GREEN   = 4'd1;
localparam A_YELLOW  = 4'd2;
localparam B_GREEN   = 4'd3;
localparam B_YELLOW  = 4'd4;
localparam C_GREEN   = 4'd5;
localparam C_YELLOW  = 4'd6;
localparam D_GREEN   = 4'd7;
localparam D_YELLOW  = 4'd8;
localparam EMERGENCY = 4'd9;

localparam MAX_GREEN   = 8'd100;
localparam BASE_GREEN  = 8'd20;
localparam YELLOW_TIME = 8'd10;

reg [3:0] current_state, next_state;
reg [7:0] timer_counter;
reg [7:0] next_timer_value;
reg load_timer;

// Priority traffic calculation registers
wire [7:0] TA_ext = {6'b0, TA};
wire [7:0] TB_ext = {6'b0, TB};
wire [7:0] TC_ext = {6'b0, TC};
wire [7:0] TD_ext = {6'b0, TD};

// === Central Timer Update Block ===
always @(posedge clk or posedge rst) begin
    if (rst) begin
        timer_counter <= 0;
        timer_out <= 0;
    end else begin
        if (load_timer)
            timer_counter <= next_timer_value;
        else if (timer_counter > 0)
            timer_counter <= timer_counter - 1;

        timer_out <= timer_counter;
    end
end

// === State Transition Block ===
always @(posedge clk or posedge rst) begin
    if (rst)
        current_state <= IDLE;
    else
        current_state <= next_state;
end

// === Next State Logic ===
always @(*) begin
    next_state = current_state;
    case (current_state)
        IDLE: begin
            if (emg_mode) next_state = EMERGENCY;
            else if (VA) next_state = A_GREEN;
            else if (VB) next_state = B_GREEN;
            else if (VC) next_state = C_GREEN;
            else if (VD) next_state = D_GREEN;
        end

        A_GREEN: if (emg_mode) next_state = EMERGENCY;
                 else if (timer_counter == 0) next_state = A_YELLOW;
        A_YELLOW: if (timer_counter == 0) next_state = B_GREEN;

        B_GREEN: if (emg_mode) next_state = EMERGENCY;
                 else if (timer_counter == 0) next_state = B_YELLOW;
        B_YELLOW: if (timer_counter == 0) next_state = C_GREEN;

        C_GREEN: if (emg_mode) next_state = EMERGENCY;
                 else if (timer_counter == 0) next_state = C_YELLOW;
        C_YELLOW: if (timer_counter == 0) next_state = D_GREEN;

        D_GREEN: if (emg_mode) next_state = EMERGENCY;
                 else if (timer_counter == 0) next_state = D_YELLOW;
        D_YELLOW: if (timer_counter == 0) next_state = A_GREEN;

        EMERGENCY: if (!emg_mode) next_state = IDLE;

        default: next_state = IDLE;
    endcase
end

// === Output + Timer Load Control Logic ===
always @(posedge clk or posedge rst) begin
    if (rst) begin
        {GA, GB, GC, GD} <= 4'b0000;
        {YA, YB, YC, YD} <= 4'b0000;
        {RA, RB, RC, RD} <= 4'b1111;
        seg <= 7'b1111111;
        load_timer <= 0;
        next_timer_value <= 0;
    end else begin
        // Default: all red, no load
        {GA, GB, GC, GD} <= 4'b0000;
        {YA, YB, YC, YD} <= 4'b0000;
        {RA, RB, RC, RD} <= 4'b1111;
        load_timer <= 0;

        case (current_state)
            A_GREEN: begin
                GA <= 1; RA <= 0;
                if (timer_counter == 0) begin
                    load_timer <= 1;
                    next_timer_value <= (BASE_GREEN + TA_ext > MAX_GREEN) ? MAX_GREEN : BASE_GREEN + TA_ext;
                end
            end
            A_YELLOW: begin
                YA <= 1;
                if (timer_counter == 0) begin
                    load_timer <= 1;
                    next_timer_value <= YELLOW_TIME;
                end
            end

            B_GREEN: begin
                GB <= 1; RB <= 0;
                if (timer_counter == 0) begin
                    load_timer <= 1;
                    next_timer_value <= (BASE_GREEN + TB_ext > MAX_GREEN) ? MAX_GREEN : BASE_GREEN + TB_ext;
                end
            end
            B_YELLOW: begin
                YB <= 1;
                if (timer_counter == 0) begin
                    load_timer <= 1;
                    next_timer_value <= YELLOW_TIME;
                end
            end

            C_GREEN: begin
                GC <= 1; RC <= 0;
                if (timer_counter == 0) begin
                    load_timer <= 1;
                    next_timer_value <= (BASE_GREEN + TC_ext > MAX_GREEN) ? MAX_GREEN : BASE_GREEN + TC_ext;
                end
            end
            C_YELLOW: begin
                YC <= 1;
                if (timer_counter == 0) begin
                    load_timer <= 1;
                    next_timer_value <= YELLOW_TIME;
                end
            end

            D_GREEN: begin
                GD <= 1; RD <= 0;
                if (timer_counter == 0) begin
                    load_timer <= 1;
                    next_timer_value <= (BASE_GREEN + TD_ext > MAX_GREEN) ? MAX_GREEN : BASE_GREEN + TD_ext;
                end
            end
            D_YELLOW: begin
                YD <= 1;
                if (timer_counter == 0) begin
                    load_timer <= 1;
                    next_timer_value <= YELLOW_TIME;
                end
            end

            EMERGENCY: begin
                case (ER)
                    2'b00: begin GA <= 1; RA <= 0; end
                    2'b01: begin GB <= 1; RB <= 0; end
                    2'b10: begin GC <= 1; RC <= 0; end
                    2'b11: begin GD <= 1; RD <= 0; end
                endcase
                load_timer <= 0;  // Freeze timer
            end
        endcase

        // 7-seg display logic
        seg <= seven_segment_display(timer_counter);
    end
end

// === 7-segment display ===
function [6:0] seven_segment_display;
    input [7:0] num;
    reg [3:0] digit;
    begin
        digit = (num > 9) ? 9 : num[3:0];
        case (digit)
            0: seven_segment_display = 7'b1000000;
            1: seven_segment_display = 7'b1111001;
            2: seven_segment_display = 7'b0100100;
            3: seven_segment_display = 7'b0110000;
            4: seven_segment_display = 7'b0011001;
            5: seven_segment_display = 7'b0010010;
            6: seven_segment_display = 7'b0000010;
            7: seven_segment_display = 7'b1111000;
            8: seven_segment_display = 7'b0000000;
            9: seven_segment_display = 7'b0010000;
            default: seven_segment_display = 7'b1111111;
        endcase
    end
endfunction

endmodule
