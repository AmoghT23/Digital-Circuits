module ethernetParser #(parameter WIDTH = 8)
  (input logic clk, rst_n,
   input logic [(WIDTH-1):0] data_in,
   input logic data_valid,
   input logic sop, eop,
   input logic ready,
   output logic [(WIDTH*6)-1:0] dest_mac, src_mac,
   output logic [(WIDTH*2)-1:0] ethertype,
   output logic header_valid,
   output logic [(WIDTH-1):0] payload_data,
   output logic payload_valid, error);
  
  logic [4:0] byte_count;
  logic [(WIDTH*6)-1:0] shift_reg_mac;
  logic [(WIDTH*2)-1:0] shift_reg_type;
  
  typedef enum logic [1:0] {IDLE, RECEIVE_HEADER, PAYLOAD, DONE} state_t;
  state_t current_state;
  state_t next_state;
  
  always_ff @(posedge clk, negedge rst_n) begin
    if(!rst_n)
      current_state <= IDLE;
    else
      current_state <= next_state;
  end
  
  always_comb begin
    next_state = current_state;
    case(current_state)
      IDLE: 
        if(sop && data_valid && ready) begin
          next_state = RECEIVE_HEADER;
        end else 
          next_state = IDLE;
      
      RECEIVE_HEADER:
        if(eop && byte_count < 13) 
          next_state = DONE;
      
      else if(data_valid && byte_count == 13)
        next_state = PAYLOAD;
      
      else 
        next_state = RECEIVE_HEADER;
            
      PAYLOAD:
            if(eop)
                  next_state = DONE;
            else
                next_state = PAYLOAD;
            
      
      DONE:
          next_state = IDLE;
      default: next_state = IDLE;
    endcase
  end
  
endmodule 



//*** TB ***


class Packet;
parameter WIDTH = 8;

logic clk, rst_n;

rand bit [(WIDTH-1):0] data_in;
rand bit data_valid;
rand bit sop, eop;
rand bit ready;

logic header_valid;
logic [(WIDTH-1):0] payload_data;
logic payload_valid, error;

typedef struct packed{
    bit [(WIDTH*6)-1:0] dest_mac;
    bit [(WIDTH*6)-1:0] src_mac;
    bit [(WIDTH*2)-1:0] ethertype;
    bit [(WIDTH-1):0] payload_data;
} packetStruct;

rand packetStruct pStr;


constraint c1 {
    pStr.dest_mac dist {
        '0:=25,
        '1:=25,
        ['h000000000001:'hFFFFFFFFFFFE]:/50
    };
};


constraint c2 {
    pStr.src_mac dist {
        '0:=25,
        '1:=25,
        ['h000000000001:'hFFFFFFFFFFFE]:/50
    };
};


constraint c4 {
    pStr.payload_data dist {
        '0:=25,
        '1:=25,
        [8'h02:8'hFE]:/50
    };
}


constraint c5_valid_ready {
    data_valid dist {1:=50,0:=50};
    ready      dist {1:=50,0:=50};
}


constraint c6_sop_eop {
    !(sop && eop);
  eop -> data_valid;
  sop -> (data_valid && ready);
}


function void display();

$display("[%0t] Header Valid |%0b| Data |%0b|%0b| Payload |%0b|%0b| Ready=%0b, sop=%0b, eop=%0b",
$time,
header_valid,
data_valid,
data_in,
payload_valid,
payload_data,
ready,
sop,
eop);


$display("Ethernet Packet(expected): %0h, %0h, %0d, %0h",
pStr.dest_mac,
pStr.src_mac,
pStr.ethertype,
pStr.payload_data);


$display("Ethernet_Packet: %0h",pStr);

endfunction

endclass



module ethernetParser_tb;

parameter WIDTH = 8;


logic clk, rst_n;

logic [(WIDTH-1):0] data_in;
logic data_valid;

logic sop, eop;
logic ready;

logic [(WIDTH*6)-1:0] dest_mac, src_mac;
logic [(WIDTH*2)-1:0] ethertype;

logic header_valid;

logic [(WIDTH-1):0] payload_data;

logic payload_valid, error;



ethernetParser dut(.*);



initial begin
    forever #5 clk = ~clk;
end



initial begin

Packet pkt;


clk = 1'b0;
rst_n = 1'b0;


data_in    = '0;
data_valid = 1'b0;
sop        = 1'b0;
eop        = 1'b0;
ready      = 1'b0;


#10;


@(negedge clk);
rst_n = 1'b1;



repeat(10) begin

    pkt = new();


    if(pkt.randomize()) begin


        @(negedge clk);

        data_in    = pkt.data_in;
        data_valid = pkt.data_valid;
        sop        = pkt.sop;
        eop        = pkt.eop;
        ready      = pkt.ready;


        pkt.display();


        @(posedge clk);


    end

end


#20;

$finish;

end



assert property (@(posedge clk) disable iff(!rst_n)
!(sop && eop))
else
$error("SOP and EOP cannot be high in the same cycle");



assert property (@(posedge clk) disable iff(!rst_n)
eop |-> data_valid)
else
$error("EOP asserted without valid data");



assert property (@(posedge clk) disable iff(!rst_n)
sop |-> (data_valid && ready))
else
$error("SOP asserted without valid ready handshake");


endmodule
