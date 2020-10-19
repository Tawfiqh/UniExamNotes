Complexity
===========

##Contents
+ [Rice's theorem](#rice)
+ [Turing Machines](#TM)
+ [The Halting Problem](#Halting)
+ [PTime](#P)
+ [Nondeterministic Polynomial Time](#NP)
+ [Reductions](#reductions)
+ [Approximation](#approx)
+ [Space](#space)
+ [Log Space](#LogSpace")


<a id="rice"> </a>
* * *
Rice's Theorem
--------------
P a subset of the set of all languages.

P is not the set of all languages.  
P is not the empty set.  

Then

P is undecidable.



<a id="TM"> </a>
* * *
Turing Machines
----------------------------
Configuration - {Q-state, (w1, ..., wn) -word on tape i, (p1, ..., pn) position of head on tape i.}.


T\_M(w) is the number of steps for the machine M to halt on input w.

Decision problem - output is in {"Yes", "No"}

Turing acceptor - F - Two sets of final states Fa and Fr.

###There exist undecidable languages.

1. Words in Sigma* are countably infinite, can just use lexicographical ordering.  
Therefore we create an enumeration, p, of words in sigma*  
Each language can now be represented as an infinite string, x, where x[i] = 1 iff p(i) is in the language.  
Therefore we represent languages as infinite strings.

2. Infinite strings over {0,1} are uncountably infinite.
We assume they are countable. such that f(i) is the ith infinite string in our ordering.
Then we construct a string c which differs from f(i) in the ith position.
Contradiction as now c does not occur anywhere in our enumeration.

3. Turing machines are countable as they can be expressed as finite strings in terms of an encoding on their state space, tape contents, language, transition funciton, initial state(just list as the first state when we encode the set of states), and their final states.

4. Languages are infinite strings, inifinite strings are uncountable. TMs are countable. Therefore we can't map all languages to TMs and there are some languages for which no Turing Machine exists, therefore these languages without TMs are undecidable.


<a id="Halting"> </a>
* * *
Halting Problem
--------------
Assume H(M, w) tells us if M halts on w.

Construct S(< M \>) = opposite of H(M, < M \>). I.e accepts iff H rejects

Run S(< S \>) this accepts iff H(S, < S \>) rejects.
i.e S halts and accepts on < S \> iff H tells us S does not halt or accept on < S \>.



<a id="P"> </a>
* * *
PTime
--------------
Ptime = U Dtime(n^d) for all d.  
Ptime = class of languages with a n^d-time-bounded k-tape Turing-acceptor. For some k>=1. We may say k=1 by the tape-reduction theorem.



PTime Algorithm that decides 2-Sat:

    Main(T):
        if (BCP(T) == Conflict) return unsat
        While(T =/= Empty)
            Choose var X from T
            SaveT := T
            Assign(T,X,1)
            if (BCP(T) == Conflict)
                T := SaveT
                Assign(T,X,0)
                if(BCP(T)==Conflict) return unsat.
        return Sat


    BCP(X):
        While(X contains a unit clause, C)
            if (C = {x}) Assign(X, x, 1)
            else Assign(X, x, 0)     //c = {-x}
        if(X contains empty clause {}) return Conflict
        return NoConflict

    Assign(T, x, i):
        if(i==1){
            Remove all clauses containing x.
            Remove x from all clauses containing -x.
        }
        else{
            Remove all clauses containing -x.
            Remove x from all clauses containing x.
        }


###2-col <= p 2-sat.
Reduction of 2-colorability to 2-sat!!!

Construct 2-sat formula X.  
For each edge (u, v) in our 2-col graph add clauses {xu, xv}, {-xu, -xv} to X.

Pseudo Ptime - PTime in the maximum of input length and *value* of numbers input.

<a id="NP"> </a>
* * *
NP - NonDet PTime
------------------------------

Transition function is non-det.

Has a polynomial Time verifier. Certificates for a problem are polynomially bounded in the length of the input problem.




<a id="reductions"> </a>
* * *
The Reductions
--------------

###SAT
Cook levin.


###Clique (Use SAT)

Take clauses Cj and each literal Li within that clause. Add a node V_jL_.  
Connect  V_jL_ and V_j'L'_ iff j =/= j' and the literals, L and L' are not incompatible.
(Incompatible if L=X and L'=NOT X )

Extra notes:
X in Sat with k clauses. Clique of size k.  


###Independent Set (Use Clique)

Take a graph, invert the edges.


###Vertex Cover (Use Clique)
G has a clique X of size k.  
Y = V \ X is a VC in G complement..  

===>  
e= (u,v) at most one of u,v can be in X, as if they were both in the clique,
their edge would no longer be in G complement.

Hence at least one of u,v in Y.

<====  
V \ X is a VC. u,v in X.  
Assume an edge (u, v), but then not covered in Y. Contra.  
Therefore, no edge (u,v) in G complemet.  
Therefore an edge in G. And so X is a clique.



###3-SAT (use SAT).
Reduction from SAT.

C = (L1, ..., Lk) in Sat with more than 3 clauses.  
Add variables Yi. Replace C' with 3CNF clauses:
C' = (L1, Y1), (-Y1, L2, Y2 ), ..., (-Yk-1, Lk)

###Directed Hamiltonian Path is NP-Complete.
Reduction from 3-SAT
X = C1 in 3CNF.


###SubsetSum is NP-Complete
Reduction from SAT.  

X in CNF = C1 and C2 and C3... Ck.


###Knapsack (use SubsetSum)

###Reachability
Reachability is in PTime, can use Floyd-Washall to do it in O(|V|^3)
Also NLogSpace complete.


<a id="space"> </a>
* * *
Space - The final frontier
----------------------------
TM with a read-only input tape.


DTime(f) subset< of DSpace(f)

Sat is in linear space - just try every assignment in turn.  
NP subset of PSpace.

QBF- NPSpace hard  
Also in PSpaceTherefore PSpace=NPSpace.


Savitchs' Theorem: For all S >= log(n)  
NSpace(S(n)) <= DSpace(S(n)^2).  





PSpace = NPSpace.





<a id="LogSpace"> </a>
* * *
Log Space
---------------

Logspace = U (dlog(n)) {for all integers d.}





Logspace transducer - A TM.

1. With a read-only input tape
2. Read/write tape
3. A write-only write-once output tape.

Computes a function f, using less than or equal to log(|w|) space on its working tape.  
When it terminates the result f(w) is on the output tape.



<a id="approx"> </a>
* * *
Approximation
---------------
###Optimisation problems - 4 points

1. Inst - set of problem instances
2. Sol(x):  Inst --> Sol - a mapping of a given instance to a set of
*feasible* solutions
3. Cost:Inst(x) x Sol(x) ---> R  -  gives the cost of a given solution.
4. Opt ∈ {min, max}


###NPO
1. Inst is decidable in PTime.
2. Given x ∈ Inst, y ∈ Σ\* **y ∈ Sol(x)** is decidable in PTime.
3. Cost is in PTime.
4. For all x, Sol(x) is bounded in length polynomial wrt to x.

###APX
Set of problems in NPO with fixed-constant approximation algorithms.
(Can be approximated in constant factor)

###PO
Problems that can be solved in **P**Time, **O**ptimally.

###Min Vertex Cover.
    Repeat until no edges left
        Pick an edge (u,v)
        Add u and v to R.
        Remove all edges incident on u and v.

    return R.

An optimal solution must contain at least one of the endpoints for all the edges we selected. We selected both endpoints. Therefore our solution is at most twice as big as the optimum.


###TSP **NOT** in APX 

Hamiltonian circuit is NP-complete.
Hamiltonian circuit takes <G,k> is a closed loop through a graph that visits each node exactly once.


TSP is finding a Hamiltonian cycle of least weight. Where the input graph is complete.

If TSP was in APX then for any input graph G we could work out the minimum hamiltonian path with ratio r.


For any input we create G' where we assign unitary weights for vertices connected by an edge and apply weight (1+r)|V| for edges that were not in V(G)

G has a Hamiltonian circuit ===> T has a tour of length |V|.

Otherwise minimal tour is at least (1+r)|V| as it has to use a non-graph edge.

So we run our APX algorithm on G', if it gives <=r|V| then has a Hamiltonian cycle.
