---
slug: "svd"
title: "Singular Value Decomposition"
date: 2021-06-18T09:35:51-04:00 
publishdate: 2021-06-18
lastmod: 2021-06-18
tags: []
draft: false
autonumbering: true
output: 
  html_document:
    keep_md: true
---



To understand SVD, we need to first understand the *Eigenvalue Decomposition* of a matrix.
We can think of a matrix $A$ as a transformation that acts on a vector $X$ 
by multiplication to produce a new vector $Ax$. 

For example, the rotation matrix in a 2-$d$ space can be defined as:

$$
\mathbf{A} = 
\begin{bmatrix}
  \cos(\theta) & -\sin(\theta) \\
  \sin(\theta) & \cos(\theta) \\
\end{bmatrix}
$$ 

This matrix rotates a vector about the origin by $\theta$. 

Another example is the stretching matrix $\mathbf{B}$ in a 2-$d$ space: 

$$
\mathbf{B} = 
\begin{bmatrix}
  k & 0  \\
  0 & 1  \\
\end{bmatrix}
$$ 
This matrix stretches a vector along the $x$-axis by a constant factor $k$ 
but does not affect it in the $y$-direction. 
Similarly, we can have a stretching matrix in $y$-direction.

$$
\mathbf{C} = 
\begin{bmatrix}
  1 & 0  \\
  0 & k  \\
\end{bmatrix}
$$ 
As an example, if we have a vector

$$
\mathbf{x} = 
\begin{bmatrix}
  1 \\
  0 \\
\end{bmatrix}
$$ 

then $y = \mathbf{A}\mathbf{x}$ is the resulting vector 
after rotating $\mathbf{x}$ by $\theta$, 
and $\mathbf{B}\mathbf{x}$ is the resulting vector 
after stretching $\mathbf{x}$ in the $x$-direction by a constant factor $k$.



![vectors and transformed vectors](rotate-and-strech-1.png "A vector transformed by rotation (left) and stretching (right)")

Here the rotation matrix is calculated for $\theta = 30^{\circ}$ 
and in the stretching matrix $k = 3$. 
