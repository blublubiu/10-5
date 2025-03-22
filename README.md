valid-ready握手
----为什么需要valid-ready？
----使用valid-ready需要注意什么问题？
----valid-ready握手如何实现？

1.为什么需要valid-ready？
在上下游模块的信号传输中，如果只传一个通道的data信号，下游模块无法判断data什么时候是有效的/下游过载的时候无法反压上游。

2.使用valid-ready需要注意什么问题？
死锁。好比两个人握手如果一直没有人先伸出手，场面就会僵持，数据传输永远无法完成。
在rtl设计时要规定好先伸出手的模块，一般是下游主动拉高ready。

在使用带valid-ready的fifo作为缓冲的时候，可以利用fifo的空满进行握手申请发起。
-fifo上游ready主动拉高
-fifo下游valid当fifo非空时拉高



4.测试：
一、功能描述:
　　在我们的流水线设计中有 5 个pipe stages。这意味着在 5 个时钟周期后可以在输出端口观察到输入数据,所有阶段都必须准备好同时进行。当 out_rdy 无效时，必须保留输出 vld & data 直到 out_rdy 有效。如果out_rdy 无效并且所有pipe stage都处于busy状态，则必须使in_rdy 无效以通知前一stage保留数据。当 out_rdy 无效时，必须消除管道气泡。
附： 所有信号均由时钟的上升沿触发。 所有输出必须是触发器输出（in_rdy 除外）。
Interface description
Input:
       clk         // clock
       rst_n         // reset signal, active low
       in_data[15:0] // input data
       in_vld        // input data valid
       out_rdy        // out data ready（The next stage not full）
Output:
       out_data[15:0] // output data
       out_vld       // output data valid
       out_rdy       // in data ready （current stage not full）
Block diagram：
![image](https://github.com/user-attachments/assets/bb625705-843f-4294-a23b-d136eac94f61)

代码：pipe_stage.v

二、
