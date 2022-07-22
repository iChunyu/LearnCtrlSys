# 控制器设计：反步法（Backstepping）

本文是 DR_CAN 介绍的 [Nonlinear Backstepping Control](https://www.bilibili.com/video/BV1BW411M7v4) 的学习笔记。简要罗列基本公式以便仿真建模时进行对照。作为练习，本文使用了开环不稳定的非线性被控对象。

需要注意的是，本文所定义的误差与 DR_CAN 视频中的误差相反，这样做的好处是当参考信号为零时误差为信号本身而非其相反数。


## 基本思路

反步法的基本思路是根据误差动态凑李雅普诺夫函数，从而获得控制律的具体表达。稍微具体来讲，状态误差的平方是正定的，可以作为李雅普诺夫函数；然后将李雅普诺夫函数的倒数凑成负定形式。


## 公式推导

假设现有非线性负刚度弹簧系统，其状态空间方程表述为

$$
\left\{
\begin{aligned}
    \dot{x} &= v \\
    \dot{v} &= a x^2 + u
\end{aligned}
\right.
$$

其中 $u$ 为控制命令。设控制的目标是使位移 $x$ 跟随参考位移 $x_r$，不失一般性地，控制指令应当是状态和参考的函数，即 $u=f(x,v,x_r)$。反步法的目标就是设计非线性控制律 $f(\cdot)$ 来实现参考信号的跟随。

> 提示：参考信号可以通过多种手段给出，因此 $x_r$ 及其导数均可以认为是已知的，可用于构成控制律。


控制器设计以误差收敛为目标，首先定义位移跟踪误差，并构造第一级李雅普诺夫函数

$$
\left\{
\begin{aligned}
e_1 &= x - x_r \\
V_1 &= \frac{1}{2} e_1^2 > 0, \quad (e_1 \ne 0)
\end{aligned}
\right.
$$

$V_1$ 在 $e_1\ne 0$ 时均为正值，即为正定的。$e_1$ 渐进稳定的条件是 $\dot{V}_1$ 是负定，考虑

$$
\dot{V}_1 = e_1 \dot{e}_1 = e_1 \left( v - \dot{x}_r \right)
$$

为了将上式凑成负定函数，可以让 $v-\dot{x}_r = -K_1 e_1$，将该需求进一步分解为使速度的跟踪误差收敛：

$$
v - \dot{x}_r = -K_1 e_1 \rightarrow
\left\{
\begin{aligned}
    v_r &= \dot{x}_r - K_1 e_1 \\
    e_2 &= v-v_r = 0
\end{aligned}
\right.
$$

此时将需求从一个误差收敛扩展到了两个误差收敛，相应的李雅普诺夫函数可选取为

$$
V = \frac{1}{2} e_1^2 + \frac{1}{2}e_2^2
$$

显然它是正定的。再次考虑其导数

$$
\begin{aligned}
    \dot{V} &= e_1 \dot{e}_1 + e_2 \left( ax^2 + u - \left( \ddot{x}_r - K_1 \dot{e}_1 \right) \right) \\
    &= e_1 \left( v - \dot{x}_r \right) + e_2 \left( ax^2 + u -\ddot{x}_r + K_1 \left( v-\dot{x}r \right) \right) \\
    &= e_1 \left(-K_1 e_1 + e_2 \right) + e_2 \left( ax^2 + u -\ddot{x}_r + K_1 \left( v-\dot{x}_r \right) \right) \\
    &= -K_1 e_1^2 + e_2 \left( e_1 + ax^2 + u -\ddot{x}_r + K_1 \left( v-\dot{x}_r \right) \right)
\end{aligned}
$$

注意，在第三行我们只将第一项的 $\dot{e}_1$ 进行了替换： $\dot{e}_1 = v-\dot{x}_r = v_r + e_2 - \dot{x}_r = -K_1e_1 + e_2$ ，这是第一次凑李雅普诺夫函数的期望；而第二项没有作此替换，是为了凑 $\dot{V}$。显然，如果希望 $\dot{V}$ 是负定的，可以使

$$
 e_1 + ax^2 + u -\ddot{x}_r + K_1 \left( v-\dot{x}_r \right) = -K_2 e_2
$$

由此可以解得控制律为

$$
\begin{aligned}
    u &= -ax^2 + \ddot{x}_r - e_1 -K_1 \left( v - \dot{x}_r \right) - K_2 e_2 \\
    &= -ax^2 + \ddot{x}_r - \left( x-x_r \right) -K_1 \left( v - \dot{x}_r \right) - K_2 \left( v - \dot{x}_r + K_1 \left( x - x_r \right) \right) \\
    &= -ax^2 + \ddot{x}_r - G_1 \left( x-x_r \right) - G_2 \left( v-\dot{x}_r \right)
\end{aligned}
$$

其中 $G_1 = 1 + K_1K_2,\, G_2 = K_1 + K_2$ 将控制律写成了一般形式的状态（误差）反馈。最后，将误差的动态重新整理，可得

$$
\left\{
\begin{aligned}
    \dot{e}_1 & = -K_1e_1 + e_2 \\
    \dot{e}_2 & = -e_1 - K_2e_2
\end{aligned}
\right.
$$



该非线性控制律由三部分构成：

- 非线性动态：利用 $-ax^2$ 将模型中的非线性偶和扣除，从而达到将模型线性化的目的，是反馈显性化的重要组成；
- 参考指令：$\ddot{x}_r$ 实际上是“开环控制”的指令，作为先验知识驱动被控对象跟随参考信号；
- 误差反馈：将状态与参考信号的误差进行反馈，是误差环路稳定的基本要素，可以通过调整控制参数调节误差的收敛动态。
