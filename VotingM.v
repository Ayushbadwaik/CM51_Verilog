`timescale 1ns/1ns

module voting_machine(
    input clk,
    input rst,
    input [2:0] candidate, // Input to select the candidate being voted for (3 candidates)
    output reg [2:0] winner // Output indicating the winner (candidate with highest votes)
);

    reg [7:0] votes [2:0]; // Array to hold vote counts for 3 candidates
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset votes for all candidates
            for (i = 0; i < 3; i = i + 1) begin
                votes[i] <= 8'b0;
            end
            winner <= 3'b0;
        end else begin
            // Increment vote for the selected candidate
            case (candidate)
                3'b001: votes[0] <= votes[0] + 1; // Candidate 1
                3'b010: votes[1] <= votes[1] + 1; // Candidate 2
                3'b011: votes[2] <= votes[2] + 1; // Candidate 3
                default: ; // Do nothing if invalid candidate
            endcase

            // Find the candidate with the maximum votes
            if (votes[0] >= votes[1] && votes[0] >= votes[2])
                winner <= 3'b001; // Candidate 1 is winning
            else if (votes[1] >= votes[0] && votes[1] >= votes[2])
                winner <= 3'b010; // Candidate 2 is winning
            else
                winner <= 3'b011; // Candidate 3 is winning
        end
    end

endmodule
