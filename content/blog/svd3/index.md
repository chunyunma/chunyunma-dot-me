---
slug: "svd3"
title: "Singular Value Decomposition - Transpose and Dot Product"
date: 2021-11-07T12:22:57-05:00 
publishdate: 2021-11-07
lastmod: 2021-11-07
tags: ["matrix"]
draft: false
autonumbering: true
output:
  html_document:
    keep_md: true
---



In this third post of the [series]({{< relref "../svd/index.md" >}}),
we will introduce two additional building blocks.

## Transpose

The transpose of a column vector $\mathbf{u}$, $\mathbf{u}^\top$, 
is the row vector of $\mathbf{u}$. 
The transpose of an $m \times n$ matrix $\mathbf{A}$ is an $n \times m$ matrix 
whose columns are formed from the corresponding rows of $\mathbf{A}$. 
For example, if we have 

$$
\mathbf{C} = 
\begin{bmatrix}
  5 & 4 & 2 \\\\
  7 & 1 & 9 \\\\
\end{bmatrix}
$$ 

then the transpose of $\mathbf{C}$ is:

$$
{\mathbf{C}} = 
\begin{bmatrix}
  5 & 7 \\\\
  4 & 1 \\\\
  2 & 9 \\\\
\end{bmatrix}
$$ 

The transpose of a row vector becomes a column vector with the same elements 
and vice versa. 
The element in the $i^\text{th}$ row and $j^\text{th}$, $x_\text{ij}$, is equal
to the element in the $j^\text{th}$ row and $i^\text{th}$ column, $x_\text{ji}$, 
of the original matrix. Therefore, 

$$
\mathbf{A}^\top_\text{ij} = \mathbf{A}_\text{ji}
$$ 

The transpose has some important properties. 
First, the transpose of a transpose is itself.

$$
\mathbf{A}^\top_\text{ij} = \mathbf{A}_\text{ji}
$$ 

In addition, the transpose of a product is the product of transpose in the reverse order.

$$
(\mathbf{A}\mathbf{B})^\top = \mathbf{B}^\top\mathbf{A}^\top
$$

## Dot product

If we have two vectors $\mathbf{u}$ and $\mathbf{v}$:

$$
\mathbf{u} = 
\begin{bmatrix}
  u_1 \\\\
  u_2 \\\\
  \vdots \\\\
  u_n \\\\
\end{bmatrix}
$$ 

$$ 
\mathbf{v} = 
\begin{bmatrix}
  v_1 \\\\
  v_2 \\\\
  \vdots \\\\
  v_n \\\\
\end{bmatrix}
$$ 

The dot product (aka inner product) of these vectors is defined as the transpose 
of $\mathbf{u}$ multipled by $\mathbf{v}$ :

$$
\mathbf{u}\cdot\mathbf{v} = \mathbf{u}^T\mathbf{v} = 
\begin{bmatrix}
  u_1 & u_2 & \cdots & u_n \\\\
\end{bmatrix}
\begin{bmatrix}
  v_1 \\\\
  v_2 \\\\
  \vdots \\\\
  v_n \\\\
\end{bmatrix} = 
u_1v_1 + u_2v_2 + \cdots + u_nv_n
$$ 

Based on this definition, the dot product is commutative: 

$\mathbf{u}\cdot\mathbf{v} = \mathbf{v}\cdot\mathbf{u}$

In the [next post]({{< relref "../svd4/index.md" >}}),
we will return to the topic of eigenvalues and eigenvectors.

