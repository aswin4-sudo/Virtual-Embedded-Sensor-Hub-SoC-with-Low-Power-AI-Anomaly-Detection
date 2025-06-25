
module fsm (
    input wire clk,
    input wire reset,
    input wire [1:0] ai_signal,   
    input wire ack,
    output reg [1:0] state,
    output reg sensor_enable,
    output reg alert_flag,
    output reg [7:0] uart_out      
);

    parameter SLEEP  = 2'b00,
              ACTIVE = 2'b01,
              ALERT  = 2'b10;

    integer alert_counter;
    integer sleep_counter;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= SLEEP;
            sensor_enable <= 0;
            alert_flag <= 0;
            alert_counter <= 0;
            sleep_counter <= 0;
            uart_out <= "0";
        end else begin
            case (state)

                
                SLEEP: begin
                    sensor_enable <= 0;
                    alert_flag <= 0;
                    alert_counter <= 0;

                    if (ai_signal == 2'b01) begin
                        sleep_counter <= sleep_counter + 1;
                    end else if (ai_signal == 2'b00) begin
                        state <= ACTIVE;
                        sleep_counter <= 0;
                    end else if (ai_signal == 2'b10) begin
                        state <= SLEEP;
                        sleep_counter <= 0;
                    end

                    if (sleep_counter >= 3) begin  
                        state <= ALERT;
                        sleep_counter <= 0;
                    end
                end

                
                ACTIVE: begin
                    sensor_enable <= 1;
                    alert_flag <= 0;
                    sleep_counter <= 0;

                    if (ai_signal == 2'b01) begin
                        state <= ALERT;
                        alert_counter <= 0;
                    end else if (ai_signal == 2'b10) begin
                        state <= SLEEP;
                    end
                end

                
                ALERT: begin
                    sensor_enable <= 0;
                    alert_flag <= 1;
                    sleep_counter <= 0;
                    alert_counter <= alert_counter + 1;

                    if (ack == 1 || alert_counter >= 5) begin
                        state <= SLEEP;
                        alert_counter <= 0;
                    end
                end

                
                default: begin
                    state <= SLEEP;
                    sensor_enable <= 0;
                    alert_flag <= 0;
                    alert_counter <= 0;
                    sleep_counter <= 0;
                end

            endcase


            case (state)
                SLEEP:  uart_out <= "0"; 
                ACTIVE: uart_out <= "1"; 
                ALERT:  uart_out <= "A"; 
                default: uart_out <= "0";
            endcase
        end
    end

endmodule
