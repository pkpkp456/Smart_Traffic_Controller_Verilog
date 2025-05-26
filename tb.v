`timescale 1ns / 1ps

module tb_traffic_light_controller;

    reg clk;
    reg rst;
    reg [1:0] TA, TB, TC, TD;
    reg VA, VB, VC, VD;
    reg emg_mode;
    reg [1:0] ER;

    wire GA, GB, GC, GD;
    wire YA, YB, YC, YD;
    wire RA, RB, RC, RD;
    wire [6:0] seg;
    wire [7:0] timer_out;

    // Instantiate the DUT
    traffic_light_controller_with_display dut (
        .clk(clk),
        .rst(rst),
        .TA(TA), .TB(TB), .TC(TC), .TD(TD),
        .VA(VA), .VB(VB), .VC(VC), .VD(VD),
        .emg_mode(emg_mode),
        .ER(ER),
        .GA(GA), .GB(GB), .GC(GC), .GD(GD),
        .YA(YA), .YB(YB), .YC(YC), .YD(YD),
        .RA(RA), .RB(RB), .RC(RC), .RD(RD),
        .seg(seg),
        .timer_out(timer_out)
    );

    // Clock generation: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;

    task print_status;
    begin
        $display("Time=%0t | GA=%b GB=%b GC=%b GD=%b | YA=%b YB=%b YC=%b YD=%b | RA=%b RB=%b RC=%b RD=%b | seg=%b | timer=%0d",
            $time, GA, GB, GC, GD, YA, YB, YC, YD, RA, RB, RC, RD, seg, timer_out);
    end
    endtask

    initial begin
        // Initialize inputs
        rst = 1; TA = 0; TB = 0; TC = 0; TD = 0;
        VA = 0; VB = 0; VC = 0; VD = 0;
        emg_mode = 0; ER = 2'b00;

        #20;
        rst = 0;

        // --------- Normal operation ---------
        TA = 2; TB = 3; TC = 1; TD = 2;
        VA = 1; VB = 1; VC = 1; VD = 1;
        #4000;  // Let some cycles run

        // --------- Emergency mode: ambulance on road B ---------
        emg_mode = 1;
        ER = 2'b01;  // Emergency road B
        $display("*** Emergency mode ON: Road B priority ***");
        #2000;
        emg_mode = 0; // Disable emergency
        ER = 2'b00;
        $display("*** Emergency mode OFF ***");
        #2000;

        // --------- Corner case: No vehicles ---------
        TA = 0; TB = 0; TC = 0; TD = 0;
        VA = 0; VB = 0; VC = 0; VD = 0;
        $display("*** No vehicles on any road ***");
        #3000;

        // --------- Traffic density dynamically changes ---------
        // Start with some vehicles only on A and D
        TA = 3; TB = 0; TC = 0; TD = 2;
        VA = 1; VB = 0; VC = 0; VD = 1;
        $display("*** Traffic density changes: Vehicles on A and D ***");
        #3000;

        // Now add vehicles on all roads with varying density
        TA = 1; TB = 2; TC = 3; TD = 1;
        VA = 1; VB = 1; VC = 1; VD = 1;
        $display("*** Traffic density changes: Vehicles on all roads ***");
        #3000;

        $finish;
    end

    // Monitor signals every 100 ns for easier viewing
    always #(100) print_status;

endmodule
