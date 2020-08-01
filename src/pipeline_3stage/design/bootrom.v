//
// bootrom
//


`include "define.vh"

module bootrom (
    input wire clk,
    input wire [31:0] addr,
    output wire [31:0] rd_data
);

    reg [31:0] mem [0:16383];  // 64KiB(16bitアドレス空間)
    reg [13:0] addr_sync;  // 64KiBを表現するための14bitアドレス(下位2bitはここでは考慮しない)

    initial $readmemh({`BOOTROM_DATA_PATH, "boot.hex"}, mem);
     
    always @(posedge clk) begin
        addr_sync <= addr[15:2];  // 読み出しアドレス更新をクロックと同期することでBRAM化
    end
    
    assign rd_data = mem[addr_sync];

endmodule
