# 8-bit RISC Super Simple CPU [Manuel Kelly]

### 8-bit RISC Super Simple CPU written in VHDL [INCOMPLETE TESTBENCH]
* TB does not show all operations.
* All ALU instructions were followed by this [web page](http://faculty.washington.edu/gmobus/Academics/TCSS372/Notes/crash1.html).
* All instruction are initialized in Instruction Memory.
* The CPU reads instructions from memory and executes them every clock cycle.
* The ALU has Carry, Zero and Negative flags (C, F(1) and F(0) respectively).
* Below is the following I/O you will need to know to use the CPU:
  * clk.
  * reset.

* Each instruction is separated into two 4-bit strings. 
  * The **upper 4 bits [7:4]** are used for the opcode.
  * The **lower 4 bits [3:0]** are used for the address.

### opcode(7 downto 0)
|7-  opcode  -4|3- addr -0|
| :----: | :----: |

### Below are all 16 operations (opcode[3:0])

|opcode[7:4]|op name|addr/imm[3:0]|
| :--------: | :------: | :----------: |
| 4'b0000 | NO OP | N/A |
| 4'b0001 | LOAD A | ADDR |
| 4'b0010 | LOAD B | ADDR |
| 4'b0011 | STORE A | ADDR |
| 4'b0100 | MOVE B TO A | N/A |
| 4'b0101 | TWO'S COMP | N/A |
| 4'b0110 | AND | N/A |
| 4'b0111 | OR | N/A |
| 4'b1000 | ADD | N/A |
| 4'b1001 | JMP | ADDR |
| 4'b1010 | JMPC | ADDR |
| 4'b1011 | JMPZ | ADDR |
| 4'b1100 | JMPN | ADDR |
| 4'b1101 | LOAD IMM | IMMEDIATE |
| 4'b1110 | OUT | N/A |
| 4'b1111 | HALT | N/A |


|RTL Design [ALL FOLDED]|
| :--------: |
|![RTL Design [ALL FOLDED]](https://github.com/mankelly/VHDLProjects/blob/main/8-bit%20RISC%20Super%20Simple%20CPU/images/8-bit%20Super%20Simple%20CPU%20%5BFOLDED%5D.PNG)|

|RTL Design [ALL UNFOLDED]|
| :--------: |
|![RTL Design [ALL UNFOLDED]](https://github.com/mankelly/VHDLProjects/blob/main/8-bit%20RISC%20Super%20Simple%20CPU/images/8-bit%20Super%20Simple%20CPU%20%5BUNFOLDED%5D.PNG)|

|RTL Design [DATA PATH UNFOLDED]|
| :--------: |
|![RTL Design [DATA PATH UNFOLDED]](https://github.com/mankelly/VHDLProjects/blob/main/8-bit%20RISC%20Super%20Simple%20CPU/images/8-bit%20Super%20Simple%20CPU%20Data%20Path.PNG)|

|RTL Design [CONTROL UNFOLDED]|
| :--------: |
|![RTL Design [CONTROL UNFOLDED]](https://github.com/mankelly/VHDLProjects/blob/main/8-bit%20RISC%20Super%20Simple%20CPU/images/8-bit%20Super%20Simple%20CPU%20Control.PNG)|

|[Testbench1]()|
| :--------: |
|![TB1](https://github.com/mankelly/VHDLProjects/blob/main/8-bit%20RISC%20Super%20Simple%20CPU/images/8-bit%20Super%20Simple%20CPU%20TestBench.PNG)|
