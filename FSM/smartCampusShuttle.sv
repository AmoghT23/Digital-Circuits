/*
Design a Smart Campus Shuttle FSM that tracks IDLE, BOARDING, RUNNING,
STOPPING, EMERGENCY, MAINTENANCE, and LOWBATTERY states using start,
passenger, door, stop, emergency, battery, and maintenance inputs.
Transition to BOARDING/RUNNING/STOPPING/MAINTENANCE based on the corresponding
conditions, with EMERGENCY having the highest priority and remaining latched
until reset. Remain in LOWBATTERY until the battery is restored. Reset
asynchronously to IDLE.
*/

module campusShuttle( 
  input logic clk, rst, 
  input logic startCmd, 
  input logic passengerReq,
  input logic doorsClosed,
  input logic atStop, 
  input logic emergency, 
  input logic batteryLow, 
  input logic maintenanceReq, 
  input logic maintenanceDone, 
  input logic stopCmd,
  input logic timeOut, 
  
  output logic idle, 
  output logic boarding, 
  output logic running, 
  output logic stopping, 
  output logic emergency_o, 
  output logic maintenance,
  output logic lowBattery); 
  
  typedef enum logic [2:0] {IDLE, BOARDING, RUNNING, STOPPING, EMERGENCY, MAINTENANCE, LOWBATTERY} state_t; 
  state_t state, next; 
  
  always_ff @(posedge clk, posedge rst) 
    begin if(rst) state <= IDLE; 
      else state <= next; 
    end 
  
  always_comb 
    begin next = state; 
      case(state) 
        IDLE: begin 
          if(emergency) next = EMERGENCY;
          else if(batteryLow) next = LOWBATTERY; 
          else if(startCmd && passengerReq) next = BOARDING; 
          else next = IDLE; 
        end 
        
        BOARDING: begin 
          if(emergency) next = EMERGENCY;
          else if(batteryLow) next = LOWBATTERY; 
          else if(doorsClosed || timeOut) next = RUNNING; 
          else next = BOARDING; 
        end 
        
        RUNNING: begin 
          if(emergency) next = EMERGENCY;
          else if(batteryLow) next = LOWBATTERY; 
          else if(atStop || stopCmd) next = STOPPING; 
          else next = RUNNING; 
        end 
        
        STOPPING: begin 
          if(emergency) next = EMERGENCY;
          else if(batteryLow) next = LOWBATTERY; 
          else if(maintenanceReq) next = MAINTENANCE;
          else if(passengerReq) next = BOARDING; 
          else next = IDLE; 
        end 
        
        EMERGENCY: begin 
          next = EMERGENCY; 
        end 
        
        MAINTENANCE: begin 
          if(emergency) next = EMERGENCY;
          else if(batteryLow) next = LOWBATTERY; 
          else if(maintenanceDone) next= IDLE; 
          else next = MAINTENANCE;
        end 
        
        LOWBATTERY: begin 
          if(!batteryLow) next = IDLE; 
          else next = LOWBATTERY; 
        end 
        
        default: next = IDLE; 
      endcase 
    end 
  
  assign idle = (state == IDLE);
  assign boarding = (state == BOARDING); 
  assign running = (state == RUNNING); 
  assign stopping = (state == STOPPING); 
  assign emergency_o = (state == EMERGENCY); 
  assign maintenance = (state == MAINTENANCE); 
  assign lowBattery = (state == LOWBATTERY); 
endmodule
