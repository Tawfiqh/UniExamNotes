Computer Aided Formal Verification
===================================

* * *
##Contents

+ [Reduced Order Binary Decision Diagrams](#ROBDD)
+ [Linear Temporal Logic](#LTL)
+ [CTL*](#CTLStar)
+ [GNBA](#GNBA)
+ [Semantics of CTL](#CTL)


* * *

Bring the formalism. Formality is key 👔🔑  

It's in the name, this is **formal** verification, not computer-aided
casual-maybe-on-the-weekend verification.


<a id="TS"></a>
* * *
Transition System
---------------------------------------------------------
Transition System is a 5 tuple: < S, ==>, I, AP, L \>.  
Only consider non-blocking TS's.

Deterministic iff |I| = 1 And ∀s.|Post(s)| = 1

Initial-Path-Fragment - starts state in I.





<a id="LTL"></a>
* * *
Linear Temporal Logic
---------------------------------------------------------
Traces are in (2^AP^ω)

TS implies P means:  traces(TS) ⊆ traces(P)

TS is a refinemet of TS' if traces(TS) ⊆ traces(TS')


traces(TS) ⊆ traces(TS')  <====> TS' impies P  ===> TS impies P

###Invariants
P is an invariant if it has an invariant condition ɸ st:

P = {A0A1A2...∈ 2^AP^ω | ∀j>=0 Aj implies ɸ}

There is some invariant condition such that P can be expressed as a list of
infinite words where each state implies the invariant.

###Safety Properties
Nothing bad happens.

∀s ∈ (2^AP^ω) \\ P, ∃s'< s st

P ∩ {t ∈ (2^AP^ω) | t < s' } = ɸ

There exists a finite prefixes of bad words




<a id="CTLStar"></a>
* * *
CTL*
---------------------------------------------------------
LTL is all path formulae - All **PATHS** from the given state.  

CTL is all state formulae- For the given state we examine either:  
all it's paths,  
a single path,  
what properties hold now,  
etc etc.

Sat(∃(A U B)) = Smallest T ⊆ S:  

+ Sat(B) ⊆ T
+ s ∈ Sat(A) and Post(s) intersects T ===THEN===> s ∈ T



Sat(∀(A U B)) = Smallest T ⊆ S:  

+ Sat(B) ⊆ T
+ s ∈ Sat(A) and Post(s) ⊆ T ===THEN===> s ∈ T




<a id="GNBA"></a>
* * *
GNBA
---------------------------------------------------------

(Q, Sigma, delta, Q0, F) - 5 tuple

d: Q x Sigma ---> 2^Q  

Input to a GNBA is an infinite word.  
Accepts if all f in F come up infinitely often in the infinite word.


If F is the empty set, all states are considered accepting, so the language of G
is all words with an infinite run in G.


* * *
Witnesses and Counterexamples
-----------------------------
A witness for a "∃" is a sufficiently long prefix of a path pi st pi impies what
we are seeking to find exists... #deep.



<a id="ROBDD"></a>
* * *
Reduced Order Binary Decision Diagrams
---------------------------------------------------------
A tree

Two leaves 0 and 1.

one type of internal node: x -> t1, t0  
t1 and t0 successor nodes or one of the two leaves.

Reduced - No two distinct nodes have the same variable, high and low successors.


Ordered - There exists a variable ordering such that any path through the tree
follows this given variable order.

Canonicity lemma - For all boolean expressions t there is some ROBDD.

NP-Hard if a given variable ordering is optimal.


Encoding of jazz.  
