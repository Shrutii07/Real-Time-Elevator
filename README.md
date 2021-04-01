# Real-Time-Elevator

## Problem Statement
Design a 4-storey elevator control system. The system receives real-time inputs from multiple users at multiple floors simultaneously. Real-time requests can be made from the outside (for calling the lift on the floor) or from inside (indicating which floor you want to go). The machine initially takes the actual floor/state of the elevator, the requests at hand, and how the lift is now going (upwards/downwards) or the lift's previous motion(upwards/downwards) as inputs.

## Approach
The basic algorithm of our model is as follows.
- The elevator first check if its current direction of motion is up or down and whether there is a request at the current floor.
- If there is a call on the current floor, the elevator door opens.
-  Otherwise, if the present motion is upwards and there are demands at floors higher than the current floor, it would continue in the same direction, that is upwards. Similarly, if the elevator's last motion was downward and there are demands at floors below the present level, the elevator would begin to move in the same direction (downwards).
- Multiple requests from outside and within are managed using a request array, which specifies which floor each request is from. We don't need to be clear about whether the request is originating from outside or inside the lift since our lift would eventually end at that floor regardless of whether the request means a lift call or a person's destination.

## Code
### Behavioral Model
The inputs are as follos:
- clock
- Reset: Lift moves to ground/1st floor
- initial_up_down: initial motion of lift.
- initial_floor: initial/current floor of lift
- initial_request: initial request array of lift or calls for lift.

The outputs for controller are:
- op_led: Indicates door of lift (1 = open, 0 = close)
- output_floor: Real-time floor movement.
- output_request: Real-time request updates.

In the architecture we have defined signals for keeping track of the requests and the floor as it changes.The process sensitivity list includes the clk and the reset , which means that whenever either of them is changed the process block will get executed. We have used a signal named flag so that we can update the request vector every time someone makes a request. In the process it checks the current state of the lift and accordingly it decides its next motion according to the above algorithm.

### Testbench
Testbenches are used for simulation purpose. We generated the simulation waveforms using ModelSim, without changing the input signal values manually with the help of testbench. A testbench with name ‘elevator_tb’ is defined. Note that, entity of testbench is always empty i.e. no ports are defined in the entity. Input and output signals are defined inside the architecture body, these signals are then connected to actual elevator design using behavioral modeling using port map function.  Also note that, process statement is written without the sensitivity list. Lastly, different values are assigned to input signals.

## Output

### Using Testbench
<img src="https://github.com/Shrutii07/Real-Time-Elevator/blob/main/Results/elevator_tb.png" height="200" width="720">

### Transcript window
<img src="https://github.com/Shrutii07/Real-Time-Elevator/blob/main/Results/elevator_transcript.png" height="400" width="320">

### RTL View
<img src="https://github.com/Shrutii07/Real-Time-Elevator/blob/main/Results/RTL_elevator.png"   height="250" width = "720">

