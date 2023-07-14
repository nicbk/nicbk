---
title: "Rotating Torus"
date: 2020-11-27
draft: false
---

**UPDATE**: An browser based rotating torus which uses similar source code can be viewed [here!](/projects/ascii-donut)

I recently read about a [spinning
donut](https://www.a1k0n.net/2011/07/20/donut-math.html), and decided to render
one for myself. My donut is [here](https://github.com/nicbk/donut-embedded). I
commented out the source code quite a bit and used lengthy variable
names in order to make the source code easier to understand. 

This project is an application of mathematical concepts I had recently learned
in school. Specifically, I wanted to reimplement all of the necessary math
functions needed for rendering a parameterized torus without using any
libraries. Instead, I would rely on basic floating point arithmetic to derive
numerical approximations for more complicated functions.

My parameterized torus uses three parameters: one for rotation of the torus
about the X and Z axis, one for rotating the circular cross section of the torus
about its current axis of revolution, and another for rotating a point around
that circle.

The sine function is approximated using a Maclaurin series with eight terms on
the interval \\( [-\pi/2, \pi/2] \\), which is then extended to approximate the
function on the domain of all real numbers using modular arithmetic. In order
to compute this power series, I need exponentiation and the factorial function.
However, neither of these operations are primitive arithmetic operators in the
C programming language. For exponentiation of floats to non-negative integers,
I used iterated multiplication. For the purposes of the Maclaurin series, \\( 0^0 \\)
is assumed to be 1. The square root function is approximated using Newton's method,
which is executed recursively.

The motion of the entire animation is periodic, so the sine and cosine
functions are memoized such that approximately 1000 values of those functions on
the interval \\( [0, 2\pi] \\) are stored in an array. When rendering each point
on the torus, these tables are looked up, instead of recalculating the function
on each iteration.

Lighting is done through a single directional light (vector) positioned in front of the
torus. Rays of light and the normals to the surface of the torus are multiplied
as a dot product to determine luminosity. A "Z" buffer is used to prevent
clipping, as the ray will often intersect multiple surfaces on the moving torus.

{{< mathjax >}}
