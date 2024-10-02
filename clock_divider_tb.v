
module clockdivider_tb;

    reg clk, en, rst;
    wire div2, div4, div8, div16;

    // Instantiate the clock divider module
    clockdividerby2n dut(
        .clk(clk), 
        .en(en), 
        .rst(rst), 
        .div2(div2), 
        .div4(div4), 
        .div8(div8), 
        .div16(div16)
    );

    // Clock generation
    initial clk = 0;
    always #10 clk = ~clk;  // 50% duty cycle, 20 time units clock period
    //The clock toggles every 10 time units, giving a total clock period of 20 time units.

    // Test sequence
    initial begin
         $dumpfile("dump.vcd");
      $dumpvars(0,dut);
        // Test 1: Reset the counter and keep the enable low
        //The counter is reset, and en is kept low to observe that the clock divider doesn't operate when en is disabled.
     
        rst = 1; en = 0;
        #30;  // Wait for 30 time units
        rst = 0;  // Deassert reset
        #40;  // Wait for some time to observe that the counter is not incrementing

        // Test 2: Enable the clock divider
        en = 1; //The en signal is asserted, and the divided clock outputs are monitored.
        #100;  // Observe clock division by 2, 4, 8, 16

        // Test 3: The en signal is toggled (disabled and re-enabled) to test how the clock divider behaves when paused and resumed.
        en = 0;
        #40;   // Disable the divider
        en = 1;
        #100;  // Enable again

        // Test 4: Apply reset during operation
        // A reset is applied while the clock divider is running to ensure it correctly resets during operation.

        rst = 1;
        #20;   // Apply reset
        rst = 0;
        #60;   // Deassert reset and observe behavior

        // End simulation after 350 time units
        #350 $finish;
    end

    // The $monitor statement continuously displays the values of the inputs and outputs, so you can track the state of the system throughout the simulation.
    initial begin
        $monitor("Time = %0t | clk = %b | rst = %b | en = %b | div2 = %b | div4 = %b | div8 = %b | div16 = %b", 
                 $time, clk, rst, en, div2, div4, div8, div16);
    end

endmodule
