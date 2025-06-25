`timescale 1ns/1ps

module fsm_tb();


    reg clk;
    reg reset;
    reg [1:0] ai_signal;
    reg ack;
    wire [1:0] state;
    wire sensor_enable;
    wire alert_flag;
    integer file, code;
    reg [7:0] ai_output_val;

    
    fsm uut (
        .clk(clk),
        .reset(reset),
        .ai_signal(ai_signal),
        .ack(ack),
        .state(state),
        .sensor_enable(sensor_enable),
        .alert_flag(alert_flag)
    );

    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    initial begin
        $dumpfile("fsm.vcd");
        $dumpvars(0, fsm_tb);
    end
    initial begin
        
        reset = 1;
        ai_signal = 2'b00;
        ack = 0;
        #20 reset = 0;

        file = $fopen("ai_output.txt", "r");
        if (file == 0) begin
            $display("Error: Could not open file.");
            $finish;
        end

        while (!$feof(file)) begin
            code = $fscanf(file, "%d\n", ai_output_val);

            case (ai_output_val)
                0: ai_signal = 2'b00;
                1: ai_signal = 2'b01;
                2: ai_signal = 2'b10;
                default: ai_signal = 2'b00;
            endcase

            @(posedge clk);
            if (state == 2'b10) ack = 1;
            else ack = 0;
            @(posedge clk);

        
            $display("Time %0t: AI Output = %0d, ai_signal = %b, FSM State = %b, UART Out = %s",
                $time, ai_output_val, ai_signal, state,
                (state == 2'b00) ? "0" :
                (state == 2'b01) ? "1" :
                (state == 2'b10) ? "A" : "?");
        end

        $fclose(file);
        $display("Simulation completed.");
        $finish;
    end

endmodule

