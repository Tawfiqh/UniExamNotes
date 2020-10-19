Advanced Data Structures & Algorithms
====================

* * *

##Contents
+ [Matchings](#rishta)
+ [Flows 1](#Flows)
+ [Linear Programming](#LPs)
+ [Approximation Algorithms](#approx)
+ [Amortized Analysis](#amortizedAnalysis)
+ [Disjoint Sets](#DisjointSets)
+ [Binary Search Trees](#BSTs)
+ [Red Black Trees](#RedBlackTrees)
+ [Splay Trees](#SplayTrees)
+ [Fast fourier transforms](#FFT)
+ [Number Theoretic Algorithms](#RSA)




<a id="rishta"></a>
* * *
Matchings
-------------------------------------------------------------------

Gale Shapley Marriage algorithm. I think you know this one 😉  

Valid Partner - A potential partner in **some** stable matching.



<a id="Flows"></a>
* * *
Flows 1
-------------------------------------------------------------------

Cut = Partition of vertices into A and B with s in A, t in B.  
Capacity of a cut (A,B): Sum of capacities e from A **to** B.

Value of a flow = Sum of flow on all edges leaving s.

Residual graph:  
Edge, e, in Gf is st:  
    f'(e) = c(e) - f(e)  for e in E  
    f'(e) = f(e)         for e not in E

Augmenting Path - Simple path s-->t **in** the residual graph.  
Bottleneck Capacity - Min capacity on an augmenting path.


###Ford Fulkerson.

    Initialise flow to zero.  
    While(an existing path in Gf){  
      Find augmenting path P.  
      Increase flow along P by bottleneck capacity.  
      Update residual graph.  
    Return f.

Running time: O(V+2E) = O(E) according to one source.

###Flow & Cut Theorems
Flow value lemma: Net flow across a cut (Net from A to B) equals value of the whole flow. (This includes back flow from B into A)

Therefore: value(f) = Net flow out of A <= Cap(A,B)

Max-flow = Min-cut  
(The problems are dual and their optimal solutions intersect).  

###Capacity-Scaling
We define the X-Residual-graph as the residual graph but only with edge capacities larger than X.

    X = largest power of 2 <= Max Capacity
    While(X >= 1)
        Update X-Residual-graph.
        While (Exists augPath P in X-Residual-graph)
            Augment flow on P.
            Update X-Residual-graph
        X = X/2
    Return f


###Bipartite graphs
A matching X ⊆ E(G) is a set st each node of the graph appears in at most one edge of X.  
We naturally want to find the maximal matching.


Bipartite Max matching: network flow formulation, unary edges. Max flow.  
O(mn)

**Perfect** matching is when each node appears in **EXACTLY** one edge of the matching.


Hall's Theorem: G has a perfect matching *iff* Number of nodes adjacent to S = |S| for all subsets S of **L**

**K-regular bipartite graph** - Has a perfect matching.  
|R| = |L| = n  
Each node is connected to **k** other nodes.  

Max-Flow of value n:
f(s,x) = 1  
f(x,t) = 1  
f(u,v) = 1/k  


###Disjoint paths

Edge distjoint

Max number of edge disjoint s->t paths = max flow.

**Disconnects** -  A set X is a disconnect if all s->t paths need to use an
edge in X.

Mengers theorem. zzzz

**Max** number of edge disjoint paths in undirected graps:  
Replace each edge with two antiparallell edges; Run Max flow.



###Circulation with demands.
Max-flow formulation.  
Add a node s that feeds all the nodes with negative demands(supply).  
Add a node t that is fed by all the nodes with positive demands.

**Integer theorem** If all capacaites and demands are integers ==> An integer
valued max-flow exists.

Circulation with lower bounds: model lower bounds as demands.

**Survey Design** - Bipartite graph - max flow formulation.


<a id="LPs"></a>
* * *
Linear Programming
-------------------------------------------------------------------

Standard min form (primal):

Min:  cTx  
Ax >= b  
x >= 0  

Min Slack form (Slack form requires equality of the constraint):  

Min cTx  
Ax = b  
x >= 0

**Can convert** from standard to slack form with tricks of inequalities. E.g:  
a=b ==> a<=b && b<=a

Dual (Min):  
Max bTy  
ATy <= c  
y >= 0


Weak Duality: x is feasible for primal, y is feasible for dual ==> cTx >= bTy

Duality (Strong): If the primal or the dual has a feasible and bounded solution, so does the other. And their optimal solution intersects.

###Shortest path LP

Minimise:  
  ⎲  w(e) * x(e)  
  ⎳  
edges

St.  
sum of edges leaving a node - sum of edges into a node =  
1 for s
-1 for t
0 for all other nodes



###Extreme Point Solutions
Sometimes called vertices.

A solution is an extreme point solution if it is NOT a convex solution of two other solutions.

A convex solution (not extreme): x = **t** y - (1 - t) z



###Simplex
1. Start with a node in the polytope that is known to be feasible.
2. Move from the node to a neighbouring feasible node.
3. Stop at a local optimum.

Note:Due to convexity a local optimum is also a global optimum.

###Ellipsoid
Slow and numerically unstable in practice...


###Interior Point Methods
1. Start inside the polytope
2. Move around inside the polytope
3. Find the optimum.


<a id="approx"></a>
* * *
Approximation Algorithms
-------------------------------------------------------------------
###A fistful of definitions

Approximation ratio p - A solution to x will be within factor p away from the
optimal solution for x.

For Minimisation problems:

p = supremum A(X) / OPT(x)

(supremum is least upper bound)

For Maximisation problems:  Opt(X) / A(x)

so minimum p is always 1. 👌


###PTAS
Arbitrary approximation ratio.  
Takes ε as an input.  
Returns a solution of size: 1 + ε  
Takes time polynomial in input size to problem. (May even be exponential in size 1/ε).  
E.g: O(n^ 1/ε)  

###FPTAS
Polynomial in size of input (n) **AND** in 1/ε.


###Vertex Cover - NP Complete
A vertex cover is a set of vertices. Such that every edge touches at least one of the vertices in C.

Approx Ratio 2.
Select an EDGE, add it's endpoints to the Cover, remove it's endpoints and all adjacent edges.

Can also use a LP based formulation and rounding of the relaxation.  
This is extensible to use with costs.



###Set cover problem

Set F of subsets Si ⊆ U.

```
Q = Φ  
Select Si ∈ F with Largest cardinality  
Q = Q U Si  
F = F \ Si  
Remove all elements of Si from F
```

Approximation ratio = Ln(|U|)


Counterexample of size 2^n elements:  

Two rows of n elements  
Subset1 = first row  
Subset2 = second row  
and then a subset that takes 2^i-1 elements from each row.

(i.e each set is of size power of 2, but half it's elems are from the top row, half from the bottom 😉 & then two sets that partition it in two.)

This is a counterexample because you should pick the two rows and then you cover the set with only two subsets. However the algorithm could equally pick the subset of size 2^n-1 that is the same size as a row but in this case spans both rows 😟



**Pseudo-Tree:** Like a tree but with one additional edge ≡ At most |V| edges.

**Pseudo-forest:**  a graph is a pseudo-forest if it is composed of connected components that are each pseudo-trees.

###Max 3-SAT.
Trivial-Random algorithm has approx-ratio = **8/7**  
Algorithm `Select a random truth assignment`  
Is a 1/7 approximation algorithm.  
Expected number of clauses is n*(7/8), where n is the number of clauses.


###Derandomisation
Uses the *linearity of expectation*.

X = (x1 + x2), (x2+ ¬x4), (x2+ x5), (¬x2+ x4), (x3+ ¬x5)

N(X) = N(x1 + x2) + N(x2+ ¬x4) + N(x2+ x5) + N(¬x2+ x4) + N(x3+ ¬x5)

Compare N(X(x1,x2,x3,x4,0)) vs N(X(x1,x2,x3,x4,1))
Select the assignment for x5 that is higher. (Still based on random probability of other variables).

N(X(x1,x2,x3,x4,0)) = N(x1 + x2) + N(x2+ ¬x4) + N(x2) + N(¬x2+ x4) + (1)

###Derandomised TSP
There is a PTAS for Euclidean(TSP in Euclidean space) TSP.

Approximation algorithm with 3/2.

    1. Compute a MST.

    2. Traverse the tree to find a tour that may  
    visit nodes more than once.

    3. Take other routes to avoid visiting
    nodes more than once.

    4. The resulting tour has length <= 2 . MST



<a id="amortizedAnalysis"></a>
* * *
Amortized Analysis
-------------------------------------------------------------------

###Aggregate analysis.
Compute a tight bound on the worst case of n operations.

###Credit Method
Pay for some operations.
These prepay for other operations.  
Credit is stored on the system.  
Must be in credit at all times.  

Amortised cost = amount we charge.

###Potential Method
Credit method - Stores credit with objects  
whereas  
The potential method stores credit with the structure as a whole.

Potential can be released to pay for later operations.

One unit of potential pays for any constant-time operation.

ɸ: Configurations --> R

ĉ = Amortized cost = real cost + change in potential  
Denoted with a c-hat. c with a circumflex.

Potential always need to be positive. Initial potential can be 0.

Table example:  

ɸ(T) = 2 * num[T] - size(T)  
      1/2*size(T) - num[T]


<a id="DisjointSets"></a>
* * *
Disjoint Sets – Union-Find Problem
-------------------------------------------------------------------
Operations:

+ Union
+ Make-set
+ Find

A set of DISJOINT sets. (Obviously).

### MST implementation with Disjoint Forests - Disjoint Forests. I totally get you now.

    For each edge (u,v) of G,
    taken in increasing weight:
        if Find-set(u) =/= Find-set(v):
            A.add(u,v)
            Union(u,v)
    Return A

###Array
Elements in range 1..n - just use an array with n elements.  
Union is O(n) though.

###Linked List.
    Node:
        Value
        *Next

        *Head
        *Tail

**Weighted Union:** Store list length(can just store this in head/representative), append shorter list.

m+n operations takes O(m + n lg(n) )

###Forests - Disjoint set forests

Each set is a tree  
Each elem points to its parent.

###Link By Size
Subtree count for each node.  
Make set needs to increment this.

###Link by rank
Maintain a **rank** for each node. Initially 0.
Link on node with smaller rank.  
If ranks are equal, pick arbitrarily and then increase rank.

    Nodes:
        Value
        Rank
        *Parent

Properties:

+   **Lemma** Root of rank k has >= 2^k nodes in its tree.

+   **Lemma** Highest rank of a node is <= log n.

+   For any integer r there are n / 2^r nodes with that rank.

###Path compression
From searching for x, Find the root of tree.  
Move all nodes encountered along the way so that they are children of root.

    Find(x)
        if x.parent =/= x
            x.parent = Find(x.parent)
        return x.parent

###Log Star

2 ↑ n+1 = 2^ (2↑n)
2↑0 = 1

lg* n = max{k | 2↑k <= n }


<a id="BSTs"></a>
* * *
Binary Search Trees
-------------------------------------------------------------------

    @implementation BST
        Node Root
        - (void) insert:(int) x
        - (void) delete:(Node) x

        - (Node) search:(Int) x

        - (Node) min
        - (Node) max

        - (Node) succ:(int) x
        - (Node) pred:(int) x

BST property - strict inequality, so no duplicates, it stores a *set*.

Search - returns where the elemnt is **OR** should be.




<a id="RedBlackTrees"></a>
* * *
Red Black Trees
-------------------------------------------------------------------

Properties:

1. Either red or Black.
2. Each red node has two black children.
3. Root is black
4. For all nodes n, there exists x, all paths from n to a leaf contain exactly x black nodes.
5. Leaves are nil and black.


###Insert (x):
Place x in the tree where it goes in the BST.  
Colour it *RED*


**Case (*RED* uncle):**  
Recolour parent, uncle, grandparent.  
Recursively fix grandparent  

\{Following cases assume **_Black_** Uncle\}  

**Case (zig-zag / zag-zig):**  
Rotate node with parent.
(Rotate to zig-zig (or zag-zag)).



**Case (zig-zig / zag-zag):**  
Right-Rotate grandparent.  
Recolour old grandparent and recolour new grandparent black. (just make sure the rules hold)

At the end, recolour the root black.

###Theories

n items means height <= 2 log(n+1).




<a id="SplayTrees"></a>
* * *
Splay Trees
-------------------------------------------------------------------

CAN BE UNBALANCED!!!

Amortised cost of O(log n).

Splay(x):  
Find x  
"Splay" x to root with rotations.

###Left Rotate
![To the left one time](leftRotate.png)

###Right Rotate
![Slide to the right](rightRotate.png)

Zig basically means left child.

**Zig-zig operation:**  
\{Left Child;Left Child\} (from GP to child).  
Right-rotate grandparent.  
Right-rotate parent.  


**Zig-Zag:**  
\{Left Child;Right Child\}.  
Left-rotate parent  
Right-rotate grandparent.  

There is also the simple case of just a zig...  
Too simple to be highlighted here 👊

**Rank(x)=** Log(size(x))  
With size(x) = Number of nodes in subtree of x.  
\{Technically size is defined in terms of weight, but the notes just give
  all nodes a weight of 1.\}

###Search
After search we find either the root or its succ or its pred.  
We move whatever we find to the root.  
return root.  

###Insert
Insert is BST insert(x) and then splay (x).

###Delete
A bit more interesting.  

Splay x to the root.  
Delete the root.  
Pick succ x or pred x. Splay it to the root of its subtree S1  
Add the other subtree as a child of S1.

###Analysis

Weight of each node is 1.

Size(x) = weight of its subtree.

**Tree Potential** = Sum of ranks of tree nodes. \{Yes, all nodes\}  

ɸ(T) =  
⎲  r(x)  
⎳  
x in T  

Rank(x) = log(size x)

Perfectly balanced tree has potential θ(n).




**Access Lemma:**  
The amortized cost of splaying a node x is at most:  
1 + 3*( r'(x) - r(x) )  
\{r is rank before splaying.  
   r' is rank after splaying. \}




**Balance Theorem**  
In a tree with at most n items. The amortized cost of Search, Insert and Delete
is *O(log n)*.

**Colollary:** In a tree with n items, m search/insert/delete operations costs
at most O(m logn + n logn).



Optimal Static Search Trees.  
Leaves frequently accessed stuff near the root.
Splay trees are within a constant of the optimal dynamic search tree.  
Splay trees are also within a constant of the optimal static search tree.  


<a id="FFT"></a>
* * *
Fast fourier transforms
------------------------------------------------------------------
Degree bound n - means degree strictly less than x^n. (So x^ n-1).

Horner's rule - **Evaluation in O(n)** aritmethic operations  
A(x0) = a0 + x0(a1 + x0(a2 +... + x0(an-2 + x0*an-1) ... )).

Multiplication is O(n^2)

Aim is to multiply faster than θ(n^2).




###Point-value representation

Represent as n pairs of values, (xi, yi) on the curve. The Vandermonde matrix is
non-singular when the x values are distinct therefore it uniquely determines a polynomial.

Addition and **multiplication** over the same basis takes **O(n)** arithmetic
operations.

Better way to do it in O(n Log(n)).

Interpolation is the conversion back into coefficient form.

###Converting coefficient to point-value form:

**Evaluation:** O(n^2) using Horner's rule.  
Best done in point-value form, so we translate.
Just evaluate the coefficient form for x at x0, x1 ,..., xn.  

**Interpolation:**
Use the Vandermonde matrix. Basically we know the point-values  
Vandermonde matrix has each line as a geometric progression  
detV(x0, x1,..., xn-1) = Product (xk-xj) all j < k < n.

So we solve Ax=b (for x, naturally).  
Gaussian elimination, do this in O(n^3) arithmetic.

Lagrange's formula to directly compute A(x) with only **O(n^2)**:

A(x) =  
n-1  
⎲        Product x - xj  (j=/=k)  
⎳ yk *  -------------------------  
           Product(xk-xj) (j=/=k)  
k=0

There are n nth-roots of unity. 👌

###DTF 🍆 - Discrete Fourier transforms
Transformation from coefficient ==> point-value where we use roots of unity as
our xi values.

ω is one root of unity.

Define ω = ωn = exp(2πi/n)  
DFTn(A) = (A(1), A(ω), ..., A(ω^ n-1) )
So we're evaluating at the unity points.  
§
FFT is an Algorithm to compute the DFT.



###Divide and conquer:
A(X) = B(x^2) + x.C(x^2)
B and C degree n/2 bound.

So to compute DFTn(A) we can just calculate DFTn/2(B) and DFTn/2(C).

Takes O(n log(n)) work.


Algorithm in pseduo code

    FFT(a[0.. n-1])
        If n=1
           then return a
      	wn:= e^2pi*i/n
	x := 1
    	Array B := FFT(a[0, 2, ... , n-2])
	Array C := FFT(a[1, 3, ... , n-1])

	Array y
	for(k=0; k<n/2; k++)
	   y[k]    := B[k] +x *C[k]
	   y[k+n/2]:= B[k] -x *C[k]
	   x := x* wn
	return y

This is recursive and does evaluation in O(n log(n)).



###Evaluation equivalent to interpolation ???

DFTn(a) = (Y0, ..., Yn-1)
Yk = A(wk) = Sum (j=0,n-1) aj w^kj

The DFT is *JUST* a matrix-vector product.  
Writing a and y = DFTn(a) as column vectors, we have:  
y=Va, V is the vandermonde matrix found by th DFT.  

a = y V^-1

V-prime is obtained by replacing each entry w^k with w^-k in V.

V*V-prime = n*I.

V is non-singular and V^-1 = 1/n * V-prime.




<a id="RSA"></a>
* * *
Number Theoretic Algorithms
-------------------------------------------------------------------
m, n are B bit numbers.

m + n: O(B)  
m * n: O(B^2)  
m mod n: O(B^2)



###Euclids algorithm  
n = qm + r  
p|n and p|m iff p|m and p|r  
{n, m}, {n, r} have same set of common divisors.  


    Euclid(a,b)
        if b=0
	   then return a
	else return Euclid(b, a mod b)

Euclid(a,b) = gcd ( a , b )

Runs in O(B^3) where A,B are of size B bits.



###Extended euclid
returns d, x, y  
st gcd(a,b) = d =ax + by.

ExEuclid(a,b)
   if b=0
      then return (a, 1, 0)
   else
      (d', x', y') = ExEuclid(a,b)
      (d, x, y)    = (d', y' , x' - (a div b)y' )
      return (d, x, y)


###Euclid inverses



###Lemma gcd
For a,b Natural numbers or 0.  
there exist *integers* x,y st

gcd(a,b) = ax + by

###Chinese Remainder Theorem  
if n=n1*n2...nt where all ni are pairwise independent  
All equations: x = ai (mod n)  (i in 1..t) have a unique solution.

###Fast exponentation

We get a fast algorithm for exponentiation.


     d=1
     while(k>0)
	  if k.odd
	      d = d.a mod n
	      k--
	  if k>0
	      a = a*a mod n
	      k = k / 2
     return d

O(B^3) for a,k,n B bit numbers.



###Quick Groups
Group = <G,.> - a set and an operation.

1. For all a,b in G a.b in G.
2. Associativity of (a.b).c...  
3. e in G, st a.e=a for all a.
4. for all a we have -a, st a.-a = e

To check <G',.> is a group {for a subset G' of G}.

Just check G' is closed under .


###Groups - Zn
Zn = <{0,..., n-1}, + } can have operator + or *.

Zn* = { a in Zn | gcd(a,n) = 1}  |Zn*|= Phi n  
Multiplicative group mod n.

**Lagranges theorem:** S a subset of Zn* then it is non-empty and closed. under multiplication |S| divides |Zn*|.
