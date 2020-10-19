#Databases

* * *
##Contents

+ [Overview](#DB)
+ [Safety equivalences](#safe)
+ [Relation Algebra](#RA)
+ [SQL](#SQL)
+ [Storage and Hardware](#hardware)
+ [B+ Trees](#BTree)
+ [Join implementations](#JoinI)
+ [Transactions](#xacts)

<a id="DB"></a>
* * *
Databases - DBMS
-------------------------------------------------------------------
DBMS - We use it for efficiency, handling large data,  integrity, access control, concurrent access, data independence.


Conceptual and semantic - UML

Logical Model - trees & graphs

Physical Model - indexing, clustering

Deletion of a required item:  

1. Delete dependent fields, cascade.
2. Reject deletion.
3. Change dependent field to default.

A schema describes valid instances.



<a id="safe"></a>
* * *
Safety equivalences
-------------------------------------------------------------------
Extended ADOM, also allows constants.  
ADOM RC– = ADOM RC with no constants
ADOM RC is safe.  

ADOM RC– = RA = All safe queries.

ADOM RC = RA (without consts) = Safe RC without constants.

SQL with subqueries = RA = ADOMRC = SafeDRC


AdomRC ⊆ RA ⊆ DRC



<a id="RA"></a>
* * *
Relation Algebra
-------------------------------------------------------------------


Renaming:

*P(R(col-->col2, col3-->col3'), expr);*  
Calculate expr, rename the result to R, and rename columns as specified.



<a id="SQL"></a>
* * *
SQL
-------------------------------------------------------------------

Create table table_name(

)

Foreign key target is a primary key or unique.





<a id="hardware"></a>
* * *
Storage and hardware
-------------------------------------------------------------------
Data is on pages in disk.  
We retrieve pages.


Catalogs

###Estimated Result sizes
**col = value**  Rf = 1 / NVals(col)

**col = col2**  Rf = 1 / Max(NVals(col), NVals(col2))

**col > value**  Rf = High(I) - value / High(I) - Low(I)





<a id="BTree"></a>
* * *
B+ Trees
-------------------------------------------------------------------

###Insert
Insert and push up if too full.

###Delete

Delete and steal from siblings if need be.  
If they don't have spare capacity; merge.




<a id="JoinI"></a>
* * *
Join implementations
------------------------------------------------------------------
Simple Nested Loop Join.

Page Oriented Nested Loop Join.

Block Nested Loop Join.

Index Nested Loop Join.

Sort-Merge Join.

Hash Join.





<a id="xacts"></a>
* * *
Transactions
-------------------------------------------------------------------

Serial schedule : No interleaving of transactions.

Serialisable: equivalent to a serial schedule.

Equivalence: On the same input, give the same output database for a set of xacts.
then two schedules are equivalent.

###Conflict serialisable
A **conflict** is a read/write sequence (where at least one action is a write), by
different transactions on the same object.

Schedules are conflict equivalent if they deal with the same actions, and
conflicts appear in the same order.

Conflict serialisable if conflict equivalent to a serialisable schedule.




###Strict 2PL
Shared Lock - Needed to read.  
Exclusive Lock - Needed to write.


Deadlock prevention

Conflict graph - wait for graph.
Transactions are nodes.
Precedence/waiting is an edge.
