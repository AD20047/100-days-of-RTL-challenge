//day 1 of #100daysofrtl
//To design clock divider(clk/2^n)

module clockdividerby2n(
    input rst,clk,en, //rst= reset, en = enable
    output div2,div4, div8,div16
);

reg [3:0] count; // 4-bit counter 

//Synchronous process with reset and enable
always @(posedge clk or posedge rst)begin
    if(rst)
    count <=0; //Reset the counter to 0000
    else if(en) begin
    if(count == 4'd15)
    count<=0 ;// reset the counter when it reaches the count reaches 15(in decimal, so d) 
    else
    count <= count + 1; // In general case, increment counter
    end
end

//Assign to divide clock inputs
assign div2 = count[0];
assign div4 = count[1];
assign div8 = count[2];
assign div16 = count[3];
//This is done because each flip flop divides the clock input by 2
// If you cascade n flip-flops, the output will be a clock signal that is divided by 2^n

endmodule