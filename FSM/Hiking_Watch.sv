/*
Design a Mount Hood hiking smartwatch FSM that tracks INACTIVE, ASCEND, SUMMIT,
REST, DESCEND, EMERGENCY, GPSFAIL, and POWERSAVING states using altitude,
walking, heart-rate, GPS, and battery inputs. Enter REST/EMERGENCY/GPSFAIL/
POWERSAVING after 10 consecutive cycles of the corresponding condition, with
fault priority: EMERGENCY > GPSFAIL > POWERSAVING. Reset asynchronously to INACTIVE.
*/

module gpsTracker #(parameter DATA = 16)
  (
  input logic clk, rst,
  input logic [DATA-1:0] altitudeNow, altitudeBefore,
  input logic [DATA-1:0] peak, 
  input logic walking, 
  input logic heartRate, 
  input logic gpsFail, 
  input logic batteryLow, 
  output logic inactive,
  output logic ascend,
  output logic summit,
  output logic descend,
  output logic emergency,
  output logic gpsfail,
  output logic powersaving);
  
  typedef enum logic [3:0] {INACTIVE, ASCEND, SUMMIT, REST, DESCEND, EMERGENCY, GPSFAIL, POWERSAVING} state_t;
  state_t state, next;
  
  logic [3:0] restCounter;
  logic [3:0] heartCounter;
  logic [3:0] gpsCounter;
  logic [3:0] batteryCounter;
  
  always_ff @(posedge clk, posedge rst) begin
    if(rst) restCounter <= 0;
    else if(!walking) begin
      if(restCounter < 10)
        restCounter <= restCounter + 1;
    end
    else restCounter <= 0;
  end
  
  always_ff @(posedge clk, posedge rst) begin
    if(rst) gpsCounter <= 0;
    else if(gpsFail) begin
      if(gpsCounter < 10)
        gpsCounter <= gpsCounter + 1;
    end
    else gpsCounter <= 0;
  end
  
  always_ff @(posedge clk, posedge rst) begin
    if(rst) heartCounter <= 0;
    else if(!heartRate) begin
      if(heartCounter < 10)
        heartCounter <= heartCounter + 1;
    end
    else heartCounter <= 0;
  end
  
  always_ff @(posedge clk, posedge rst) begin
    if(rst) batteryCounter <= 0;
    else if(batteryLow) begin
      if(batteryCounter < 10)
        batteryCounter <= batteryCounter + 1;
    end
    else batteryCounter <= 0;
  end
  
  always_ff @(posedge clk, posedge rst) begin
    if(rst) state <= INACTIVE;
    else state <= next;
  end
  
  
  always_comb begin
    next = state;
    case(state)
      INACTIVE: begin
        if(heartCounter >= 10) next = EMERGENCY;
        else if(gpsCounter >= 10) next = GPSFAIL;
        else if(batteryCounter >= 10) next = POWERSAVING;
        
        else if(walking) begin
          if(altitudeNow == peak) next = SUMMIT;
          else if(altitudeNow > altitudeBefore) next = ASCEND;
          else if(altitudeNow < altitudeBefore) next = DESCEND;
        end
        else next = INACTIVE;
      end
      
      ASCEND: begin
        if(heartCounter >= 10) next = EMERGENCY;
        else if(gpsCounter >= 10) next = GPSFAIL;
        else if(batteryCounter >= 10) next = POWERSAVING;
        
        else if(walking && altitudeNow == peak) next = SUMMIT;
        else if(restCounter >= 10) next = REST;
        else if (walking && altitudeNow < altitudeBefore) next = DESCEND;
        else next = ASCEND;
          end
      
      SUMMIT: begin
        if(heartCounter >= 10) next = EMERGENCY;
        else if(gpsCounter >= 10) next = GPSFAIL;
        else if(batteryCounter >= 10) next = POWERSAVING;
        
        else if(walking && altitudeNow < peak) next = DESCEND;
        else if(restCounter >= 10) next = REST;
        else next = SUMMIT;
        end
      
      REST: begin
        if(heartCounter >= 10) next = EMERGENCY;
        else if(gpsCounter >= 10) next = GPSFAIL;
        else if(batteryCounter >= 10) next = POWERSAVING;
        
        else if(walking && altitudeNow == peak) next = SUMMIT;
        else if(walking && altitudeNow > altitudeBefore) next = ASCEND;
        else if (walking && altitudeNow < altitudeBefore) next = DESCEND;
        else next = REST;
        end 
      
      DESCEND: begin
        if(heartCounter >= 10) next = EMERGENCY;
        else if(gpsCounter >= 10) next = GPSFAIL;
        else if(batteryCounter >= 10) next = POWERSAVING;
        
        else if(restCounter >= 10) next = REST;
        else if(walking && altitudeNow > altitudeBefore) next = ASCEND;
        else next = DESCEND;
      end
      
      EMERGENCY: begin
        end
      
      GPSFAIL: begin
        if (heartCounter >= 10) next = EMERGENCY;
        else if (batteryCounter >= 10) next = POWERSAVING;
        else if (gpsCounter < 10) next = INACTIVE;
    	else next = GPSFAIL;
        end
      
      POWERSAVING: begin
        if (heartCounter >= 10) next = EMERGENCY;
        else if (gpsCounter >= 10) next = GPSFAIL;
        else if (batteryCounter < 10) next = INACTIVE;
    	else next = POWERSAVING;
        
      end
      
      default: next = INACTIVE;
    endcase
  end
  
  assign inactive = (state == INACTIVE);
  assign ascend = (state == ASCEND);
  assign summit = (state == SUMMIT);
  assign descend = (state == DESCEND);
  assign emergency = (state == EMERGENCY);
  assign gpsfail = (state == GPSFAIL);
  assign powersaving = (state == POWERSAVING);
  
endmodule 
