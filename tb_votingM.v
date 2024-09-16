`timescale 1ns/1ns

module voting_machine_tb;

    // Testbench signals
    reg clk;
    reg rst;
    reg [2:0] candidate; // Voting input for selecting the candidate
    wire [2:0] winner;   // Output to show the winner candidate

    // Instantiate the voting machine module
    voting_machine vm (
        .clk(clk),
        .rst(rst),
        .candidate(candidate),
        .winner(winner)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize all signals
        clk = 0;
        rst = 1;
        candidate = 3'b0;
        #10 rst = 0; // Release reset after 10ns
        
        // Simulate votes
        #10 candidate = 3'b001; // Vote for candidate 1
        #10 candidate = 3'b010; // Vote for candidate 2
        #10 candidate = 3'b001; // Another vote for candidate 1
        #10 candidate = 3'b011; // Vote for candidate 3
        #10 candidate = 3'b010; // Another vote for candidate 2
        
        #10 $finish;
    end

    // Generate VCD file for waveform analysis
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, voting_machine_tb);
    end

    // Monitor signal changes
    initial begin
        $monitor("Time = %0t ns, Candidate = %b, Winner = %b", $time, candidate, winner);
    end

endmodule
