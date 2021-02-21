---
title: "On communication in multi-agent systems (MAS)"
date: 2021-02-12T11:07:31Z
tags: ["communication"]
---

Communication is as an emergent behaviour in multi-agent systems. An agent
under this behaviour exhibits signals with the _intention_ of informing peers
about an internal or external state. An agent's peers are other agents in the
environment whose _goals are aligned_ with goals of the agent. All agents
pursuing common goal in an environment form a collective.

Why should we care about communication? If an agent decodes useful information
from a signal, the agent can act on the information to optimize its
performance. As more agents are deployed into complex environments, they need
to communicate with their peers using signals which the engineers cannot
anticipate. Agents which collaborate gain competitive advantage.

Under what conditions does communication emerge? Can we design schemes which
increase the odds? How can we evaluate those schemes? Which are the key
properties and which can be sacrifices in trade-offs? What is the least complex
agent which can learn to communicate? These are some of the questions I am
interested in.

Natural collectives self-organize into control hierarchies by distributing
responsibilities into a chain of command. For these collectives it cannot be
any other way as individuals have independent nervous systems. Machines don't
necessarily have to be restricted in a similar fashion. It's plausible that a
single supercomputer controls all nodes on the network. Intuitively there are
problems with this approach related to scale and command latency. It's self
evident that MAS theory is valuable.

Communication in a collective serves two purposes:
1. to convey an agent's intention;
2. to share compressed information about agent's perceived environment.

A precondition for conveying intentions is the capability of planning ahead. A
hierarchy of control can only emerge if agents plan. However, reasoning behind
a message encoding sensory stimulus processed by agent's internal state can be
just as complex. The agent may want to consider whether the receiving peer know
about a fact already or whether a fact is valuable to peers at all. 

