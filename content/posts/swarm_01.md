---
title: "Environment sniffing with localizers"
date: 2021-02-05T12:07:31Z
tags: ["swarm-ai"]
---

In his book [A Deepness in the Sky][deepness-in-the-sky], Vernor Vinge
describes nano technology called "the localizers". This point sized object
floats in zero-gee and communicates with other localizers in its proximity. A
localizer is equipped with some processing power and sensors.

Localizers in zero-gee are handy abstraction for thinking about distributed
systems. They can model systems across scales (a point can be a dust smite or a
planet) and one can plug in any sensors and constrains they need.

A hello world setup is a confined 3-space $S$ of $V_s = 1$ in which localizers
are represented by a single point. The localizers be able to detect the number
of peers in their proximity at distance $r = 0.000001$. A million localizers
uniformly distributed in $S$ gives us ~6 detectable peers. Localizers are
pushed away by solid objects we send through the space.

For example, a ball moves across $S$ and we simulate the displacement of
localizers in its way. We control _3 static localizers_ $C = \set{c_0, c_1,
c_2}$ at the edge of $S$, . How do we leverage the network to track the
movement of the ball?

---
_Displacement (anomaly) detection algorithm_

A localizer broadcasts a message `ANOMALY` to its peer if the number of its
peers rapidly changes. `ANOMALY` message contains two parameters:
1. `ORIGIN` as an identifier of the localizer;
2. `HOPS` as a counter of hops this message has travelled, set to 0.

When a localizer receives `ANOMALY` message, it relays it with the same
`ORIGIN` parameter and the `HOPS` parameter incremented by 1.

---

Clearly the above algorithm leads to infinite cycles. To patch this defect we
store a set of recently relayed `ORIGIN`s. A localizer ignores messages with
`ORIGIN` in this set. A message which started in a single localizer now expands
like a shock wave through the network, eventually hitting $C$.  Since we know
the size of $S$, `HOPS` parameter estimates distance[^1]. We need to receive a
message from the same `ORIGIN` on all 3 of control localizers.

An interesting experiment 

Instead of displacement, localizers can broadcast sensory data. An operator of
such network might want to make queries to the network rather than passively
await an anomaly. For example, let's assume that the localizers are equipped
with thermometers and the operator wants to measure the temperature around some
point $P$. We need to solve two problems:
1. How to read temperature only from localizers around $P$ in $S$? Can we
   generalize into more complex spaces?
2. How to target the query and deliver an answer with minimal bandwidth usage?

Let's start with a simple case where we know the localizer density of $S$,
localizers are uniformly distributed and we broadcast messages from one
receiver in all directions (shock wave shape) with ~ equal speed.

[^1]: Not always accurate. Displaced localizers create areas of different
  densities, effectively skewing distances. The message might need to travel
  around an obstacle, bending the path of the "shock wave". Further
  investigation of these situations is necessary.

[^2]: If we were in a 2-space, we would need 3 localizers. This is because in
  2-space, the line that connects two localizers splits the space into two
  subspaces which are a reflection of each other. The line reflects each point
  which lies to the left of the line to the right of the line. Therefore 2
  localizers don't know whether the distances they observed are to the right or
  to the left of the line that connects them. In a 3-space, the symmetry
  between two localizers splits the space into four subspaces. A point in each
  subspace has another 3 reflections. A third localizer only resolves
  uncertainty to two points. Generally, a fourth localizer is needed to be
  certain of an origin of a message.

<!-- References -->
[deepness-in-the-sky]: https://en.wikipedia.org/wiki/A_Deepness_in_the_Sky
