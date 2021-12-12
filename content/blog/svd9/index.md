---
slug: "svd9"
title: "Singular Values"
date: 2021-11-21
publishdate: 2021-11-21
lastmod: 2021-11-21
tags: ["matrix"]
draft: false
autonumbering: true
output:
  html_document:
    keep_md: true
---





In [a previous post]({{< relref "../svd4/index.md" >}}),
we have seen the effect of multiplying a matrix with its eigenvectors.
The vector does not change in direction,
merely shrinks/stretches by an amount proportional to the corresponding
eigenvalue.

I reproduce the before and after plots below for three matrices
$\mathbf{A}$, $\mathbf{B}$, and $\mathbf{C}$.

<!-- Insert a 3x2 figure. -->

There is one subtle difference between
$\mathbf{B}$, $\mathbf{C}$, and $\mathbf{A}$.
Take $\mathbf{B}$ for example,
the length of $\mathbf{B}\mathbf{u}_1$ is the maximum of
$\\|\mathbf{B}\mathbf{x}\\|$ over all unit vectors $\mathbf{x}$.
And the length of $\mathbf{B}\mathbf{u}_2$ is the maximum of
$\\|\mathbf{B}\mathbf{x}\\|$ over all unit vectors $\mathbf{x}$
that are perpendicular to $\mathbf{u}_1$.
The same pattern applies to $\mathbf{C}$ as well.
However, $\mathbf{A}\mathbf{u}_1$ is certainly NOT the maximum of
$\\|\mathbf{A}\mathbf{x}\\|$ over all unit vectors $\mathbf{x}$.

As always, there is no coincidence in mathematics.
Nor is this one.
For a symmetric matrix $\mathbf{M}$,
$\mathbf{M}\mathbf{u}_i$ returns the maximum of
$\\|\mathbf{M}\mathbf{x}\\|$ over all unit vectors $\mathbf{x}$
that are perpendicular to the first $i - 1$ eigenvectors of $\mathbf{M}$.
The question remains then:
among all unit vectors $\mathbf{x}$,
which one maximizes $\\|\mathbf{A}\mathbf{x}\\|$
when $\mathbf{A}$ is not necessarily symmetric?

Let's digress here for a moment and consider, not $\mathbf{A}$,
but $\mathbf{A}^\top\mathbf{A}$.
Given that the transpose of a product is the product of the transpose
in the reverse order, we have

$$
\begin{equation*}
  (\mathbf{A}^\top\mathbf{A})^\top =
  \mathbf{A}^\top(\mathbf{A}^\top)^\top =
  \mathbf{A}^\top\mathbf{A}
\end{equation*}
$$ 

In other words, $\mathbf{A}^\top\mathbf{A}$ is equal to its transpose,
and therefore is a symmetric matrix.
From [previous posts](),
we know that a symmetric matrix such as $\mathbf{A}^\top\mathbf{A}$
has $n$ real eigenvalues 
and $n$ linearly independent and orthogonal eigenvectors.

Next, let's calculate the eigenvalues and eigenvectors of $\mathbf{A}^\top\mathbf{A}$.



Let's label these eigenvectors as
$\mathbf{v}_1$ and $\mathbf{v}_2$, 
and we can assume that they are normalized.

Before we proceed, take a guess at
what you would see if we plot $\mathbf{v}_1$, $\mathbf{v}_2$,
$\mathbf{A}\mathbf{v}_1$ and $\mathbf{A}\mathbf{v}_2$.

<!-- Insert a 3x1 figure here, with 1) unit circle, v1, v2, 2) ATAx, v1, v2 -->
<!-- and 3) Av1, Av2 -->

Recall the question we asked earlier:
Among all unit vectors $\mathbf{x}$,
which one maximizes $\\|\mathbf{A}\mathbf{x}\\|$?
It seems that we have found the answer.
It is the eigenvectors of $\mathbf{A}^\top\mathbf{A}$.

We have shown that this is true in the example of matrix $\mathbf{A}$.
In general, for an $m \times n$ matrix $\mathbf{A}$,
it can be shown that $\mathbf{A}\mathbf{v}_i$ has the greatest length
and is perpendicular to the pervious $i - 1$ eigenvectors,
where $\mathbf{v}_1, \mathbf{v}_2, \ldots, \mathbf{v}_n$
are eigenvectors of $\mathbf{A}^T\mathbf{A}$.

For each of these eigenvectors,
we can use the definition of length 
and the rule for the product of transposed matrices to have: 

$$
\begin{equation*}
  \\|\mathbf{A}\mathbf{v}_i\\|^2 =
  (\mathbf{A}\mathbf{v}_i)^T\mathbf{A}\mathbf{v}_i = 
  \mathbf{v}_i^T\mathbf{A}^T\mathbf{A}\mathbf{v}_i
\end{equation*}
$$ 

Let's assume that the corresponding eigenvalue of $\mathbf{v}_i$ is $\lambda_i$

$$
\mathbf{v}_i^T\mathbf{A}^T\mathbf{A}\mathbf{v}_i = \mathbf{v}_i^T\lambda_i\mathbf{v}_i = 
\lambda_i\mathbf{v}_i^T\mathbf{v}_i
$$ 

And because $\mathbf{v}_i$ is normalized, so 

$$
\\|\mathbf{v}_i\\|^2 = \mathbf{v}_i^T\mathbf{v}_i = 1
$$ 

and 

$$
\\|\mathbf{A}\mathbf{v}_i\\|^2 =
\lambda_i\mathbf{v}_i^T\mathbf{v}_i = \lambda_i
$$ 

This result shows that all the eigenvalues of $\mathbf{A}^\top\mathbf{A}$ 
are non-negative. 
If we label them in descending order, we have:

$$
\lambda_1 \geq \lambda_2 \geq \cdots \geq \lambda_n \geq 0
$$ 

**The singular value of $\mathbf{A}$ is defined as the square root of $\lambda_i$, 
denoted $\sigma_i$.**

$$
\sigma_i = \sqrt{\lambda_i} = \\|\mathbf{A}\mathbf{v}_i\\|,~
\sigma_1 \geq \sigma_2 \geq \cdots \geq \sigma_n \geq 0
$$ 

Therefore, the singular values of $\mathbf{A}$ are the length of vectors $\mathbf{A}\mathbf{v}_i$.
An important theory that forms the backbone of the SVD method: 
the maximum value of $\\|\mathbf{A}\mathbf{x}\\|$, subject to the constraints 

$$
\\|\mathbf{x}\\| = 1,~
\mathbf{x}^\top\mathbf{v}_1 = 0,~
\mathbf{x}^\top\mathbf{v}_2 = 0,~
\ldots,~
\mathbf{x}^\top \mathbf{v}\_{k-1} = 0
$$ 

is $\sigma_k$, and this maximum value is attained at $\mathbf{v}_k$,
the $k$-th eigenvector of $\mathbf{A}^T\mathbf{A}$.

In an [earlier post]({{< relref "../svd4/index.md" >}}),
we mentioned that
a symmetric matrix transforms a vector 
by stretching or shrinking the vector along the eigenvectors of this matrix.

With a non-symmetric matrix $\mathbf{A}$,
it transforms a vector by stretching or shrinking the vector
along the direction of $\mathbf{A}\mathbf{v}_i$,
where $\mathbf{v}_i$ is an eigenvector of $\mathbf{A}^T\mathbf{A}$,
ordered based on its corresponding eigenvalue, 
$\\|\mathbf{v}_i\\| = 1$.
The corresponding singular value $\sigma_i$ is the scalar 
that determines the length of the stretching,
$\sigma_i = \sqrt{\lambda_i}$,
where $\lambda_i$ is the corresponding eigenvalue of
$\mathbf{A}^\top\mathbf{A}$.


How can we reconcile these two seemingly different rules?
Let's take a symmetric metrix, $\mathbf{B}$.
Suppose that its $i$-th eigenvector is $\mathbf{u}_i$
and the corresponding eigenvalue is $\lambda_i$.
If we multiply $\mathbf{B}^\top\mathbf{B}$ by $\mathbf{u}_i$ we get:

$$
\begin{equation*}
  \left(\mathbf{B}^\top\mathbf{B}\right)\mathbf{u}_i =
  \mathbf{B}\left(\mathbf{B}\mathbf{u}_i\right) =
  \mathbf{B}\lambda_i\mathbf{u}_i =
  \lambda_i\mathbf{B}\mathbf{u}_i =
  \lambda_i^2\mathbf{u}_i
\end{equation*}
$$

which means that $\mathbf{u}_i$ is also an eigenvector of
$\mathbf{B}^\top\mathbf{B}$,
but its corresponding eigenvalue is $\lambda_i^2$!
Now we can see that the previous rule about a symmetric matrix
is nothing but a special case of the more general rule:

A matrix $\mathbf{A}$ transforms a vector by stretching or shrinking the vector
along the direction of $\mathbf{A}\mathbf{v}_i$,
where $\mathbf{v}_i$ is an eigenvector of $\mathbf{A}^T\mathbf{A}$,
ordered based on its corresponding singular value.
The corresponding singular value $\sigma_i$ is the scalar 
that determines the length of the stretching or shrinking,
$\sigma_i = \sqrt{\lambda_i}$,
where $\lambda_i$ is the corresponding eigenvalue of
$\mathbf{A}^\top\mathbf{A}$.

When $\mathbf{A}$ is symmetric,
the direction of $\mathbf{A}\mathbf{v}_i$ will be identical
to that of $\mathbf{A}\mathbf{u}_i$,
because $\mathbf{A}$ has the same eigenvectors as $\mathbf{A}^\top\mathbf{A}$.
Moreover, $\mathbf{A}\mathbf{u}_i = \lambda_i\mathbf{u}_i$.
Therefore, the direction of $\mathbf{A}\mathbf{v}_i$
is the direction of $\mathbf{A}\mathbf{u}_i$,
which is the direction of $\mathbf{u}_i$.
That is, a symmetric matrix transforms a vector by stretching or shrinking
the vector along the direction of $\mathbf{u}_i$,
its eigenvector!

What about the length of the stretching or shrinking?
We know that $\lambda_i = \sqrt{\lambda_i^2}$,
where $\lambda_i^2$ is the corresponding eigenvalue of
$\mathbf{A}^\top\mathbf{A}$,
and $\lambda_i$ is the corresponding eigenvalue of $\mathbf{A}$.
Therefore, a symmetric matrix transforms a vector
along its eigenvectors $\mathbf{u}_i$,
scaled by its corresponding eigenvalues $\lambda_i$.
We have come a full circle!
In the next post,
we are finally ready to present the singular value decomposition equation!
