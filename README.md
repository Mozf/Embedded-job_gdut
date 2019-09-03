This is my homework.

# 设计思路

1. 三层电梯按键：

| 按键 | 灯 |意义|
|:-:|:-:|:-:|
|BTN3|LED3|三楼下|
|BTN2|LED2|二楼上|
|BTN1|LED1|二楼下|
|BTN0|LED0|一楼上|

在按键按下之后，所需要的灯就会亮起来，直到电梯到达。

2. 模型总开关：SW0

关闭后，LED0~LED3全亮。

既SW0为复位。

3. 电梯所在层数LED4：

|灯色|层数|
|:-:|:-:|
|B|3|
|G|2|
|R|1|
在到达下一楼之前，亮上一楼。两个红外接收到信号则到达本层。

4. 电梯上下状态LED5：

|灯色|意义|
|:-:|:-:|
|B|上|
|G|下|
|R|开门|
|不亮|静止|

5.电梯移动速度：

步进电机速度设置为6ms进一步。

6. 红外信号名：

一楼：red1；

二楼：red2;

三楼：red3。

红外有东西就0，没有就1

7. 电机控制信号{up,down,stop}。

8. 外加三个按键，是里面人要去哪里的按键，内呼，1为关，0为开

9. 电梯动作分为：上，下，静止，开门。

10. 电机接线：

|ULN2003|Arty接口|
|:-:|:-:|
|IN1|IO13|
|IN2|IO12|
|IN3|IO11|
|IN4|IO10|

# 模型参数

1. 模型外观，即电梯井为长方体，底面为10cm * 10cm，高为3 * 4cm + 4 * 2cm。厚5mm。
2. 电梯为4cm * 4cm * 4cm的正方体。
3. 电梯井顶上做一个圆盘为电机控制来卷动绳子。
4. 电梯上面留一个孔，拉出绳子 让电机吊着电梯移动。
5. 红外螺丝孔直径3mm，电机螺丝孔直径4mm。
6. 电梯井前后板有一条通道保证电梯悬吊的时候不会乱动，左右板方红外，左三低，右三高。

# 一些计算
1 ms = 1000 us = 1000 000 ns

|次数|得数|
|:-:|:-:|
|0|1|
|1|2|
|2|4|
|3|8|
|4|16|
|5|32|
|6|64|
|7|128|
|8|256|
|9|512|
|10|1024|

# 程序思路

1. 复位，重开s0，电梯是否在一楼，否，去一楼；是，转s1。
2. 判断动作，判断层数，判断按键，做动作。

|状态|描述|
|:-:|:-:|
|s_idle|无|
|s1|判断电梯位置，并移动电梯到一楼|
|s2|判断一楼|
|s3|判断二楼|
|s4|判断三楼|
|s5|开门(静止开门)|
|s6|静止等待（开门后）|
|s7|上行|
|s8|下行|
|s9|上行2开门|
|s10|上行3开门|
|s11|下行2开门|
|s12|下行1开门|
|s13|判断电梯位置，并移动电梯到一楼|


一定有层数，一定有动作状态，无按键则静止，开门的时候有专门状态，之后转为静止

有两个reg，一个是上一步的，一个是下一步的

内部按键和外部按键是上一步的动作，判断动作也是判断上一步的，但是判断层数是判断此时此刻的，内部按键和外部按键会在动作中被跟新。

```
always@(posedge clk or negedge rstn) begin 
    if(!rstn) begin

    end
    else begin

    end
  end
```

# IO设置

|name|IO|Pin|
|:-:|:-:|:-:|
|IN4|IO13|N17|
|IN3|IO12|P18|
|IN2|IO11|R17|
|IN1|IO10|T16|
|BTN0||D19|
|BTN1||D20|
|BTN2||L20|
|BTN3||L19|
|BTN4|IO4|V15|
|BTN5|IO5|T15|
|BTN6|IO6|R16|
|clk||H16|
|LED0||R14|
|LED1||P14|
|LED2||N16|
|LED3||M14|
|LED4_R||N15|
|LED4_G||G17|
|LED4_B||L15|
|LED5_R||M15|
|LED5_G||L14|
|LED5_B||G14|
|LED6|IO7|U17|
|LED7|IO8|V17|
|LED8|IO9|V18|
|red1|IO1|U12|
|red2|IO32|V8|
|red3|IO38|W8|
|SW0||M20|

```
set_property IOSTANDARD LVCMOS33 [get_ports {INgogo[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {INgogo[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {INgogo[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {INgogo[0]}]
set_property PACKAGE_PIN N17 [get_ports {INgogo[0]}]
set_property PACKAGE_PIN P18 [get_ports {INgogo[1]}]
set_property PACKAGE_PIN R17 [get_ports {INgogo[2]}]
set_property PACKAGE_PIN T16 [get_ports {INgogo[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports BTN0]
set_property PACKAGE_PIN D19 [get_ports BTN0]
set_property IOSTANDARD LVCMOS33 [get_ports BTN1]
set_property PACKAGE_PIN D20 [get_ports BTN1]
set_property IOSTANDARD LVCMOS33 [get_ports BTN2]
set_property PACKAGE_PIN L20 [get_ports BTN2]
set_property IOSTANDARD LVCMOS33 [get_ports BTN3]
set_property PACKAGE_PIN L19 [get_ports BTN3]
set_property IOSTANDARD LVCMOS33 [get_ports BTN4]
set_property PACKAGE_PIN V15 [get_ports BTN4]
set_property IOSTANDARD LVCMOS33 [get_ports BTN5]
set_property PACKAGE_PIN T15 [get_ports BTN5]
set_property IOSTANDARD LVCMOS33 [get_ports BTN6]
set_property PACKAGE_PIN R16 [get_ports BTN6]
creare_clock -name clk -period 8.000 -waveform {0.000 4.000} [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
set_property PACKAGE_PIN H16 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports LED0]
set_property PACKAGE_PIN R14 [get_ports LED0]
set_property IOSTANDARD LVCMOS33 [get_ports LED1]
set_property PACKAGE_PIN P14 [get_ports LED1]
set_property IOSTANDARD LVCMOS33 [get_ports LED2]
set_property PACKAGE_PIN N16 [get_ports LED2]
set_property IOSTANDARD LVCMOS33 [get_ports LED3]
set_property PACKAGE_PIN M14 [get_ports LED3]
set_property IOSTANDARD LVCMOS33 [get_ports LED4_R]
set_property PACKAGE_PIN N15 [get_ports LED4_R]
set_property IOSTANDARD LVCMOS33 [get_ports LED4_G]
set_property PACKAGE_PIN G17 [get_ports LED4_G]
set_property IOSTANDARD LVCMOS33 [get_ports LED4_B]
set_property PACKAGE_PIN L15 [get_ports LED4_B]
set_property IOSTANDARD LVCMOS33 [get_ports LED5_R]
set_property PACKAGE_PIN M15 [get_ports LED5_R]
set_property IOSTANDARD LVCMOS33 [get_ports LED5_G]
set_property PACKAGE_PIN L14 [get_ports LED5_G]
set_property IOSTANDARD LVCMOS33 [get_ports LED5_B]
set_property PACKAGE_PIN G14 [get_ports LED5_B]
set_property DRIVE 12 [get_ports {INgogo[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports LED6]
set_property PACKAGE_PIN U17 [get_ports LED6]
set_property IOSTANDARD LVCMOS33 [get_ports LED7]
set_property PACKAGE_PIN V17 [get_ports LED7]
set_property IOSTANDARD LVCMOS33 [get_ports LED8]
set_property PACKAGE_PIN V18 [get_ports LED8]
set_property IOSTANDARD LVCMOS33 [get_ports red1]
set_property PACKAGE_PIN U12 [get_ports red1]
set_property IOSTANDARD LVCMOS33 [get_ports red2]
set_property PACKAGE_PIN U13 [get_ports red2]
set_property IOSTANDARD LVCMOS33 [get_ports red3]
set_property PACKAGE_PIN V13 [get_ports red3]
set_property IOSTANDARD LVCMOS33 [get_ports SW0]
set_property PACKAGE_PIN M20 [get_ports SW0]

```
