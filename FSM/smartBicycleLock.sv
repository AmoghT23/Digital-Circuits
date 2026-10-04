/*
Design a Smart Bicycle Lock FSM that controls LOCKED, AUTHENTICATING, UNLOCKED,
LOCKING, and ALARM states based on authentication, lock commands, motion,
timeouts, and lock completion. Motion while locked has priority over unlock
requests, ALARM remains latched until reset, and all normal transitions must
return the bicycle to a safe LOCKED state when required.
*/

module cycleLock(
  input logic clk, rst,
  input logic unlockRequest, 
  input logic passwordOk,
  input logic lockCmd,
  input logic motionDetected,
  input logic timeout,
  input logic lockDone,
  output logic locked, 
  output logic authenticating,
  output logic unlocked,
  output logic alarm,
  output logic locking);
  
  typedef enum logic [2:0] {LOCKED, AUTHENTICATING, UNLOCKED, ALARM, LOCKING} state_t;
  state_t state, next;
  
  always_ff @(posedge clk, posedge rst) begin
    if(rst) state <= LOCKED;
    else state <= next;
  end
  
  always_comb begin
    next = state;
    case(state)
      LOCKED: begin
        if(motionDetected) next = ALARM;
        else if(unlockRequest) next = AUTHENTICATING;
      	else next = LOCKED;
      end
      
      AUTHENTICATING: begin
        if(passwordOk) next = UNLOCKED;
      	else if (timeout) next = LOCKED;
      	else next = AUTHENTICATING;
      end
      
      UNLOCKED: begin
        if(lockCmd) next = LOCKING;
        else next = UNLOCKED;
      end
      
      ALARM: begin
        next = ALARM;
      end
      
      LOCKING: begin
        if(lockDone) next = LOCKED;
        else next = LOCKING;
      end
      
      default: next = LOCKED;
    endcase
  end
  
  assign locked = (state == LOCKED);
  assign authenticating = (state == AUTHENTICATING);
  assign unlocked = (state == UNLOCKED);
  assign alarm = (state == ALARM);
  assign locking = (state == LOCKING);
  
endmodule 
