---
slug: "svd6"
title: "Singular Value Decomposition - Properties of Symmetric Matrices"
date: 2021-11-12T12:31:00-05:00 
publishdate: 2021-11-13
lastmod: 2021-11-13
tags: ["matrix"]
draft: false
autonumbering: true
output:
  html_document:
    keep_md: true
---



In a previous [post]({{< relref "../svd4/index.md" >}}),
you have seen that the eigenvectors of a symmetric matrix
are perpendicular to each other.
This is not a coincidence and is an important property of symmetric matrices.

An important property of symmetric matrices is that
an $n \times n$ symmetric matrix has $n$ linearly independent
and orthogonal eigenvectors,
and it has $n$ real eigenvalues corresponding to those eigenvectors.
It is important to note that these eigenvalues are not necessarily unique;
some of them can be identical.
Another important property of symmetric matrices is that
they are orthogonally diagonalizable.
Next, let's unpack **orthogonally diagonalizable**.

## Eigendecomposition

A symmetric matrix is orthogonally diagonalizable.
It means that for an $n \times n$ symmetric matrix $\mathbf{A}$,
we can decompose it as

$$
\mathbf{A} = \mathbf{P}\mathbf{D}\mathbf{P}^\top
$$ 

in which $\mathbf{D}$ is an $n \times n$ diagonal matrix comprised of 
the $n$ eigenvalues of $\mathbf{A}$ on its diagonal.
$\mathbf{P}$ is also an $n \times n$ matrix, 
and the columns of $\mathbf{P}$ are the $n$ linearly independent eigenvectors of $\mathbf{A}$ 
that correspond to those eigenvalues in $\mathbf{D}$ respectively. 
For example, if $\mathbf{u}_1, \mathbf{u}_2, \ldots, \mathbf{u}_n$ 
are the eigenvectors of $\mathbf{A}$, and $\lambda_1, \lambda_2, \ldots, \lambda_n$ 
are their corresponding eigenvalues, 
then $\mathbf{A}$ can be written as

$$
\begin{equation*}
  \mathbf{A} = 
  \begin{bmatrix}
    \mathbf{u}_1 & \mathbf{u}_2 & \cdots & \mathbf{u}_n \\\\
  \end{bmatrix}
  \begin{bmatrix}
    \lambda_1 & 0 & \ldots & 0 \\\\
    0 & \lambda_2 & \ldots & 0 \\\\
    \vdots & \vdots & \vdots & \vdots \\\\
    0 & 0 & \ldots & \lambda_n \\\\
  \end{bmatrix}
  \begin{bmatrix}
    \mathbf{u}_1 & \mathbf{u}_2 & \ldots & \mathbf{u}_n \\\\
  \end{bmatrix}^\top
\end{equation*}
$$ 

This can also be written as

$$
\begin{equation*}
  \mathbf{A} = 
  \begin{bmatrix}
    \mathbf{u}_1 & \mathbf{u}_2 & \cdots & \mathbf{u}_n \\\\
  \end{bmatrix}
  \begin{bmatrix}
    \lambda_1 & 0 & \ldots & 0 \\\\
    0 & \lambda_2 & \ldots & 0 \\\\
    \vdots & \vdots & \vdots & \vdots \\\\
    0 & 0 & \ldots & \lambda_n \\\\
  \end{bmatrix}
  \begin{bmatrix}
    \mathbf{u}_1^\top \\\\
    \mathbf{u}_2^\top \\\\
    \ldots \\\\
    \mathbf{u}_n^\top \\\\
  \end{bmatrix}
\end{equation*}
$$ 


This factorization of $\mathbf{A}$ is called the eigendecomposition of $\mathbf{A}$. 

Let's see an example. Suppose that 

$$
\mathbf{A} = 
\begin{bmatrix}
  3 & 1 \\\\
  1 & 2 \\\\
\end{bmatrix}
$$ 

It has two eigenvectors: 



$$
\begin{equation*}
\mathbf{u}_1 = 
\begin{bmatrix}
  -0.85 \\\\
  -0.53 \\\\
\end{bmatrix}~
\mathbf{u}_2 = 
\begin{bmatrix}
  0.53 \\\\
  -0.85 \\\\
\end{bmatrix}
\end{equation*}
$$ 

and the corresponding eigenvalues are:

$$
\begin{equation*}
\lambda_1 = 3.62,~
\lambda_2 = 1.38
\end{equation*}
$$ 

Therefore, $\mathbf{D}$ can be defined as

$$
\begin{equation*}
  \mathbf{D} = 
\begin{bmatrix}
  \lambda_1 & 0 \\\\
  0 & \lambda_2 \\\\
\end{bmatrix} = 
\begin{bmatrix}
  3.62 & 0 \\\\
  0 & 1.38 \\\\
\end{bmatrix}
\end{equation*}
$$ 

Likewise, columns of $\mathbf{P}$ are the eigenvectors of $\mathbf{A}$
corresponding to those eigenvalues in $\mathbf{D}$,

$$
\begin{equation*}
  \mathbf{P} = 
\begin{bmatrix}
  \mathbf{u}_1 & \mathbf{u}_2  \\\\
\end{bmatrix} = 
\begin{bmatrix}
  -0.85 & 0.53 \\\\
  -0.53 & -0.85 \\\\
\end{bmatrix}
\end{equation*}
$$ 

The transpose of $\mathbf{P}$ is

$$
\begin{equation*}
  \mathbf{P}^\top =
\begin{bmatrix}
  \mathbf{u}_1 & \mathbf{u}_2 \\\\
\end{bmatrix}^\top = 
\begin{bmatrix}
  \mathbf{u}_1^\top \\\\
  \mathbf{u}_2^\top \\\\
\end{bmatrix} =
\begin{bmatrix}
  -0.85 & -0.53 \\\\
  0.53 & -0.85 \\\\
\end{bmatrix}
\end{equation*}
$$ 

And finally, barring some round error, $\mathbf{A}$ can be written as

$$
\begin{equation*}
  \mathbf{A} = 
\begin{bmatrix}
  3 & 1 \\\\
  1 & 2 \\\\
\end{bmatrix} =
\begin{bmatrix}
  -0.85 & 0.53 \\\\
  -0.53 & -0.85 \\\\
\end{bmatrix}
\begin{bmatrix}
  3.62 & 0 \\\\
  0 & 1.38 \\\\
\end{bmatrix}
\begin{bmatrix}
  -0.85 & -0.53 \\\\
  0.53 & -0.85 \\\\
\end{bmatrix}
\end{equation*}
$$ 

It is neat to be able to re-write a symmetric matrix
as the product of three matrices.
But to understand its implication,
we need to look at it geometrical interpretation,
which will be the topic of the next post.

