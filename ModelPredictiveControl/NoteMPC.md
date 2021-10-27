# 模型预测控制基本公式推导

本文展示的公式由 DR_CAN 在他的视频 [【MPC模型预测控制器】2_最优化数学建模推导](https://www.bilibili.com/video/BV1SQ4y1Y7FG/?spm_id_from=333.788.recommend_more_video.0) 中给出，在此编辑以方便建模参考。模型预测控制（MPC, Model Predictive Control）的基本原理可以参考 [【MPC模型预测控制器】1_最优化控制和基本概念](https://www.bilibili.com/video/BV1cL411n7KV)。




## 符号定义


| 符号            | 维度              | 说明                             |
| --------------- | ----------------- | -------------------------------- |
| $A$             | $n \times n$      | 状态矩阵                         |
| $B$             | $n \times p$      | 输入矩阵                         |
| $x(k)$          | $n \times 1$      | $k$ 时刻状态                     |
| $x(n\|k)$       | $n \times 1$      | $k$ 时刻对 $n$ 时刻预测的状态    |
| $u(n\|k)$       | $p \times 1$      | $k$ 时刻对 $n$ 时刻预测的输入    |
| $N$             | $1 \times 1$      | 预测区间长度                     |
| $\mathbf{X}(k)$ | $n(N+1) \times 1$ | $k$ 时刻预测的状态按序张成的向量 |
| $\mathbf{U}(k)$ | $p(N+1) \times 1$ | $k$ 时刻预测的输入按序张成的向量 |
| $Q$             | $n \times n$      | 误差的加权矩阵                   |
| $R$             | $p \times p$      | 输入的加权举证                   |
| $F$             | $n \times n$      | 端值误差的加权矩阵               |




## 已知条件与目标

已知条件与假设有

- 系统的离散状态空间方程：$x(k+1) = A x(k) + B u(k)$
- 假设系统输出所有状态，即 $y = x$
- 假设参考信号恒为零，即 $r=0$ ，则误差 $e = y-r = x$

代价函数可写作

$$
J = \sum_{i=0}^{N-1} \left( 
        x^\mathrm{T}(k+i|k) Q x(k+i|k) 
        + u^\mathrm{T}(k+i|k) R u(k+i|k) 
        \right) 
    + x^\mathrm{T}(k+N|k) F x(k+N|k)
$$

设计的目标是寻找控制序列 $\mathbf{U}(k)$ 使得 $J$ 最小，可以使用二次规划的方法。为此，需要将代价函数写成下面的二次规划的标准形式

$$
\min_x \left( \frac{1}{2} x^\mathrm{T}Hx + f^\mathrm{T}x \right)
$$


## 推导

根据系统的状态空间方程可以在 $k$ 时刻对系统的状态进行预测，为

$$
\begin{aligned}
    x(k|k) &= x(k) \\
    x(k+1|k) &= A x(k|k) + B u(k|k) = A x(k) + B u(k|k) \\
    x(k+2|k) &= A x(k+1|k) + B u(k+1|k) = A^2 x(k) + AB u(k|k) + B u(k+1|k)\\
    &\vdots \\
    x(k+N|k) &= A^N x(k) + \sum_{i=0}^{N-1} A^{N-1-i}B u(k+i|k)
\end{aligned}
$$

用矩阵可以表示为

$$
\underbrace{\begin{bmatrix}
    x(k|k) \\  x(k+1|k)  \\ \vdots \\ x(k+N|k)
\end{bmatrix}}_{\mathbf{X}(k)} 
=   \underbrace{\begin{bmatrix}
        I \\ A \\ A^2 \\ \vdots \\ A^N
    \end{bmatrix}}_{M} x(k)
+   \underbrace{\begin{bmatrix}
        0 & 0 & 0 & \cdots & 0 \\
        B & 0 & 0 & \cdots & 0 \\
        AB & B & 0 & \cdots & 0 \\
        \vdots & \vdots & \vdots & \ddots & 0 \\
        A^{N-1}B & A^{N-2}B & A^{N-3}B & \cdots & B
    \end{bmatrix}}_{C}
    \underbrace{\begin{bmatrix}
        u(k|k) \\  u(k+1|k)  \\ \vdots \\ u(k+N|k)
    \end{bmatrix}}_{\mathbf{U}(k)}
$$

如此做，代价函数可以使用 $\mathbf{U}(k)$ 表示为

$$
J = 
$$