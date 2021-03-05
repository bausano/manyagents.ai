---
title: "On communication in multi-agent systems (MAS)"
date: 2021-02-12T11:07:31Z
tags: ["communication"]
---

Communication is as an emergent behaviour in multi-agent systems. An agent
under this behaviour transmits signals with the _intention_ of informing peers
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
agent which can learn to communicate? These are some of the questions I will
explore in a [series of articles][tag-communication].

Natural collectives self-organize into control hierarchies by distributing
responsibilities into a chain of command. For these collectives it cannot be
any other way as individuals have independent nervous systems. Machines don't
necessarily have to be restricted in a similar fashion. It's plausible that a
single supercomputer controls all nodes on the network. Intuitively there are
problems with this approach related to scale and command latency. It's self
evident that MAS theory is valuable.

Communication in a collective serves two purposes:
1. to convey an agent's intention;
2. to share compressed information about 
    - agent's perceived environment or
    - other agents.

A precondition for conveying intentions is the capability of planning ahead. A
hierarchy of control can only emerge if agents plan. However, reasoning behind
a message encoding sensory stimulus processed by agent's internal state can be
just as complex. The agent may want to consider whether the receiving peer
knows about a fact already or whether a fact is valuable to peers at all. 

# Experiments
Although the primary outcome of my endeavour is a scheme which improves the
odds of communication, I am motivated by observing and analysing MAS. Here I
present some experiments which I use as training grounds for my intuition. 

If possible, all experiments should be implemented within the same framework. I
picked MineCraft for a few reasons:

1. _It's hackable._ There are many existing mods, it's straightforward to add
   missing functionality and it has existing APIs for controlling bots.
   Environments can be automated and the game is easily dockerized, hence an
   experiment can be quickly set up on any machine.
2. _It's open-world._ Any experiment can be built and customized using existing
   structures.
3. _It's visual._ Should I need some help to cover training costs, I can engage
   with other enthusiasts and present eventual results in an approachable way. 

Each of the following experiments, once implemented and executed, deserves an
article on its own. The experiments are of two kinds: environments (focus on
achieving some goal) and variations (focus on different way environments can be
configured). 

## Predator-prey pursuit 
A classic MAS problem is that of predators hunting some
prey[^1][^2][^3][^4][^5]. The predators must close the distance between them
and an entity whose movement is typically given by an escape algorithm. If they
get sufficiently close, they are rewarded.

The advantages of this experiment are: it's simple to set up and there are only
actions for movement in a plane. The disadvantages are: it's not clear that
communication enables more efficient strategies and it doesn't scale to more
than a handful of agents.

There are three stages to this experiment.

The first stage is control. I train agents which don't communicate besides
observing each other's movement. The performance of agents in this stage the
base performance. 

The second stage introduces an unsupervised channel. The messages are somehow
sampled from the outputs of the agents and transmitted to all other agents. I
expect to see no signalling in the second stage and I expect the agents to
consider the messages a noise. I expect the performance of the agents to be
same as in the first stage, perhaps offset in time.

The third stage introduces supervision to the channel. In upcoming articles I
develop a scheme which the agents adhere to. I expect to see performance gains
as the agents learn to use signals to follow simple hunting strategies based on
co-ordination.

## Territory capture
To patch issues with the predator-prey pursuit, I propose an experiment in
which two collectives (red squad and green squad) capture territory in a
zero-sum game.

The grid is made of fields (A1, B1, ...) and each field is made of some blocks.
An example below is made of 16 fields, each containing 2 blocks. An agent is
rewarded when its squad captures a field (such as red squad did with A1). The
grid size can be scaled with the number of agents.

```
  A  B  C  D
+--+--+--+--+
|rr|  |  |  |  1
+--+--+--+--+
|  |rg|  |  |  2
+--+--+--+--+
|  |  |gg|  |  3
+--+--+--+--+
|  |  |  |  |  4
+--+--+--+--+
```

There are two kinds of agents:
1. _Attackers_ which lay blocks and remove opposing squad's block. On top of
   the collective reward, they are individually rewarded when they remove an
   opposing squad's block. Their actions are: movement along a plane, lay
   block, remove block. The last two actions apply to the block closest to
   them. 
2. _Supports_ which periodically generate new blocks and distribute them among
   allied attackers. Their actions are: movement along a plane, distribute
   blocks. The last action applies to the nearest attacker within some radius.

I imagine the ratio of attackers to supports about 5:1. However, similarly to
other parameters, the ratio will be adjusted and its implications discussed
when the experiment is implemented.

Depending on the number of agents, the communication can be a "chat room" where
everyone reads every message, or proximity based.

This experiment consists of the same three stages as the predator-prey pursuit:
no communication, unsupervised communication and supervised communication.

## Liquid population
This variant of the previous experiments assumes at least some primitive
communication emerged in the third stage. Henceforth I shall refer to it as a
jargon.

An important property of a jargon is opaqueness - or lack thereof. If a new
individual is introduced into a group (a slice of a collective which shares a
jargon), all individuals should converge on a similar or identical jargon. As
an example, if a group of [predators](#predator-prey-pursuit) is extended with
an untrained agent, the agent must eventually acquire the group's jargon. 

To select for the efficacy of acquiring a jargon, agents [of both
squads](#territory-capture) are periodically on random replaced with untrained
agents. In another words, simulate mortality and natality.

## Chain of command


<!-- References -->
[^1]: [Mohit Sharma, Arjun Sharma: Coordinated Multi-Agent Learning][ref-1]
[^2]: [Kam-Chuen Jim, C. Lee Giles: Talking Helps: Evolving Communicating
  Agents for the Predator-Prey Pursuit Problem][ref-2]
[^3]: [T. Haynes, S. Sen, D. Schoenefeld, R. Wainwright: Evolving a
  team][ref-3]
[^4]: [T. Haynes, S. Sen: Cooperation of the Fittest][ref-4]
[^5]: [J. Denzinger, M. Fuchs: Experiments in Learning Prototypical Situations
  for Variants of the Pursuit Game][ref-5]

[tag-communication]: /tags/communication/
[ref-1]: https://mohitsharma0690.github.io/files/multi-agent-communication/report.pdf
[ref-2]: https://clgiles.ist.psu.edu/papers/Artificial-Life-2000-talking-helps.pdf
[ref-3]: https://www.aaai.org/Papers/Symposia/Fall/1995/FS-95-01/FS95-01-004.pdf
[ref-4]: https://www.researchgate.net/profile/Thomas-Haynes/publication/2264683_Cooperation_of_the_Fittest/links/573b72fe08aea45ee84063fa/Cooperation-of-the-Fittest.pdf
[ref-5]: https://www.aaai.org/Papers/ICMAS/1996/ICMAS96-006.pdf
