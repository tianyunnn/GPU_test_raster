`timescale 1ns/1ps

module bram_dual_mask #(
    parameter ADDR_WIDTH = 10,    // 640 words needs 10 bits (2^10=1024)
    parameter DATA_WIDTH = 48,    // Matching your original 48-bit width
    parameter MASK_WIDTH = 12     // 4 masks for 48 bits (48/4=12 bits per mask)
)(
    // Port A
    input               clka,
    input               cena,
    input [3:0]         wena,    // 4-bit write enable mask
    input               gwena,
    input [ADDR_WIDTH-1:0] addra,
    input [DATA_WIDTH-1:0] dina,
    output reg [DATA_WIDTH-1:0] douta,
    
    // Port B
    input               clkb,
    input               cenb,
    input [3:0]         wenb,    // 4-bit write enable mask
    input               gwenb,
    input [ADDR_WIDTH-1:0] addrb,
    input [DATA_WIDTH-1:0] dinb,
    output reg [DATA_WIDTH-1:0] doutb
);

    localparam DEPTH = 1 << ADDR_WIDTH;
    
    (* ram_style = "block" *) reg [DATA_WIDTH-1:0] mem[0:DEPTH-1];
    
    // Port A operation
    always @(posedge clka) begin
        if (!cena) begin
            if (gwena) begin
                // Masked write operation
                if (!wena[0]) mem[addra][11:0]   <= dina[11:0];
                if (!wena[1]) mem[addra][23:12]  <= dina[23:12];
                if (!wena[2]) mem[addra][35:24]  <= dina[35:24];
                if (!wena[3]) mem[addra][47:36] <= dina[47:36];
            end else begin
                // Read operation
                douta <= mem[addra];
            end
        end
    end
    
    // Port B operation
    always @(posedge clkb) begin
        if (!cenb) begin
            if (gwenb) begin
                // Masked write operation
                if (!wenb[0]) mem[addrb][11:0]   <= dinb[11:0];
                if (!wenb[1]) mem[addrb][23:12]  <= dinb[23:12];
                if (!wenb[2]) mem[addrb][35:24]  <= dinb[35:24];
                if (!wenb[3]) mem[addrb][47:36] <= dinb[47:36];
            end else begin
                // Read operation
                doutb <= mem[addrb];
            end
        end
    end
    
    // Initialize outputs
    initial begin
        douta = {DATA_WIDTH{1'b0}};
        doutb = {DATA_WIDTH{1'b0}};
    end

endmodule
