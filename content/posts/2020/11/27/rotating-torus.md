---
title: "Rotating Torus"
date: 2020-11-27
draft: false
---

I recently read about a [spinning
donut](https://www.a1k0n.net/2011/07/20/donut-math.html), and decided to render
one for myself. My donut is [here](https://gitlab.com/xrop/donut-embedded). I
commented it out quite a bit and used relatively lengthy variable names, so
hopefully it is easy to understand.

This project is an application of mathematical concepts I had recently learned
in school. Namely, I wanted to reimplement all of the necessary math functions
needed for rendering a parameterized torus without using any libraries,
instead relying on basic floating point arithmetic.

My parameterized torus uses three parameters: one for rotation of the torus
about the X and Z axis, one for rotating the circular cross section of the torus
about its current axis of revolution, and another for rotating a point around
that circle.

The sine function is approximated using a Maclaurin series with eight terms on
the interval \\( [-\pi/2, \pi/2] \\), which is then extended to approximate the
function on the domain of all real numbers through modular arithmetic. In order
to compute this power series, I need exponentiation and the factorial function.
Neither of these are primitive arithmetic operators in the C programming
language. For exponentiation of floats to non-negative integers, I used an
iterative function which performs a simple repeated multiplication. However,
this is a rudimentary exponentiation which ignores edge cases such as
indeterminate forms. For the purposes of the Maclaurin series, \\( 0^0 \\) is
assumed to be 1. The square root function is approximated using Newton's method,
which is executed recursively.

The motion of the entire animation is periodic, so the sine (and cosine)
functions are memoized such that approximately 1000 values of those functions on
the interval \\( [0, 2\pi] \\) are stored in an array. When rendering each point
on the torus, these tables are looked up, instead of recalculating the function
on each iteration.

Lighting is done through a single directional light positioned in front of the
torus. Rays of light and the normals to the surface of the torus are multiplied
as a dot product to determined luminosity. A Z buffer is used to prevent
clipping, as often the ray will encounter multiple surfaces of the
torus as it passes through.

Next up will be placing this example into the `Projects` section of this
website.

<br><br><br><br>
<br><br><br><br>
<br><br><br><br>
<br><br><br><br>
