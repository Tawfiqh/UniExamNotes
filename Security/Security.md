#Security - Private communication in a public world.

* * *
Contents
-----------
+ [Protocols and Specifications](#ProSpecs)
+ [Simple Definitions](#Definitions)
+ [Access Models](#models)
+ [References Monitors](#RM)
+ [Symmetric Key Crypto](#symCryp)
+ [Perfect Security](#Shannon)
+ [Feistel networks](#Feistelnets)
+ [DES](#Des)
+ [Double encryption](#DoubleEncr)
+ [Block Ciphers](#BlockHead)
+ [Stream Ciphers](#Streams)
+ [Hashing](#420)
+ [Salting and Hash Stretching](#Salt)
+ [Key Derivation Functions](#KDF)
+ [Number theory](#NumThe)
+ [RSA](#DatOne)
+ [Diffie Hellman Key Exchange Protocol](#dhke)
+ [MACs and Digital Signatures](#mac)
+ [RSA as a Digital Signature](#RSADIG)
+ [Authentication and Encryption](#mixers)
+ [Dolev Yao Attacker](#DolevYao)
+ [Unilateral Authentication Protocols](#uniprotos)
+ [Bi-lateral Authentication Protocols](#biprots)
+ [Key Infrastructure](#keyzuz)
+ [BEAST attack](#beast)
+ [Class notes](#class)



<a id="ProSpecs"></a>
* * *
Protocols and Specifications
-------------------------------------

###DES

64 bit plaintext/ciphertext blocks.  
16 rounds  
56 bit key - 48bit round keys.

###AES
128 bit keys and plaintexts.

###TLS
1. C ===> S: Nonce_c, cipherSuites.  
2. S ===> C: nonce_s, chosenCipher, CertChain  
3. C ===> S: Epks(protocolVersion || nonce_p)  
4. S ===> C: Ekec(m1-3 || sign(m1-3))  
5. C ===> S: Ekes(m1-4 || sign(m1-4))  
6. C ===> S: Ekec(m || sign(m || counter))
7. S ===> C: Ekes(m || sign(m || counter))

###RSA
B bit primes.


###SHA-1
160 bits  
Not entirely sure of its security. But we think that exhaustive
attack is the best full attack atm.  

###SHA-2
224 bits
Variants: 256 or 512 bits.



###Needham-Schroeder-Lowe - using Public Keys.
We set up a symmetric session using assymetric keys. Just a quick handshake using
slow protocols to begin with, sets up a quicker symmetric session.  

A ---> B: Alice, Ekb(nonceA)  
B ---> A: Epka( Bob || nonceA || nonceB )  
A ---> B: Epkb( nonceB || ks )  
A ---> B: Eks(m1 || Alice || counter)


###Certificate Chain
I send < Server, PKs, Issuer1, expiry, SIGN_PKiss1 < Server, PKs, Issuer1, expiry \> \>  
Certificate = SIGN_PKiss1 < Server, PKs, Issuer1, expiry \>  





* * *
Moxie Marlinspike's talk
----------------------------------------
Man in the middle attack.  Intruder impersonates the server to the client. The intruder impersonates the client to the server.

CA's for **AUTHENTICITY**.

If i can sign a certificate. I am trusted. I can say, hey look
this is Jim's public key, and it really is his. Then you can now use Jim's
public key but really it's not Jim's, maybe it's mine. I can now MitM you.

Currently 650 different organisations can sign certificates.

VeriSign were running lawful interception for the govt. i.e they could
MitM attack for money.

Trust Agility:

   + Trust is not permanent. It can be revoked.
   + Individual users/browsers can choose who they trust.


Atm we ask websites to send us their certificates.  
What if we asked CA's for the certs. like a KDC, requires
them to always be online.

Perspectives, an early paper with a questionable implementation.  
Convergence tries to improve on this.

Notaries.  
You ask them if they see the same certificate as you.  

Notaries can be securely connected through to other notaries.  




<a id="Definitions"></a>
* * *
Definitions - Starter for 10
---------------------------------

Integrity - Changes to the message by unauthorized persons can be detected by
the authorised persons.

Authenticity of Origin - We can verify that the message comes from its purported sender.

Non-repudiation - Can't deny taking an action once it is taken.

Availability.

Authenticated Channel:

1. Every message is sent by the puported sender.
2. Every message is received in order.
3. Every message is received by the intended recipient.


<a id="models"></a>
* * *
Access Models
-----------------
Subjects, S, and objects, O.  
Different modes of access/permissions, P,  are available to different subjects.

A ⊆ S x O x P

Access Control Matrix - Rows are subjects, columns are objects, entries are permissions

Access Control List - List for each object - List of pairs < s, p \> ∈ S x P.

Mandatory -  System wide policies with a single admin.  
Discretionary - Each file has an owner who administers the permissions for it.


###Bell La Padula

Three functions:

+ fc - **c**urrent level of a subject.
+ fo - Current level of an **o**bject.
+ fs - maximal **s**ecurity level of an object.

**Discretionary** is one constraint, the ds-property:

+ < s,o,p \> ∈ A <===iff===> < s,o,p \> has been granted.  

(ds = discrete security).


**Mandatory** is two conditions:  

For s∈ S trying to read o∈ O:

+ No Read Up - SS-Property  
< s, o , Read \> and < s, o, Write \> ===> fo(o) <= fs(s)

+ No write down - * property  
< s, o , Write \> and < s, o, Append \> ===> fc(s) <= fo(o)  
AND  
∀ o' st < s , o' Write \> ,< s , o' Read \>  fo(o') <= fo(o)  



<a id="RM"></a>
* * *
References Monitors
---------------------------
Handles authorisation.

Gate through which all access is made.

Integrity of the reference monitor itself must be ensured. Make
sure a program can't just overwrite the reference monitor.

Modern processors have various "security levels", x86 has 4 levels,
two of interest are:

1. User mode = ring 3
2. Kernel mode = ring 0 (God mode as TommyG calls it).

Reference monitor is built into the processor in silicon. #hardware solutions.

Time of Check To Time of Use.  
Buffer Overuns to implement a privelege escalation.


Unix Groups for discretionary access control.




<a id="symCryp"></a>
* * *
Symmetric Key Crypto
-----------------
**Same key** for encryption and decryption.

Kerchoff's principle - assume the enemy knows the system of encryption.

Four types of attack (attacker trying to find key OR decrypt future ciphertexts into plaintexts):  
COA; KPA; CPA; CCA.

Cipher needs to **be able to withstand _CPA_**.


Cryptanalysis is analysis of the system with the aim of breaking confidentiality.




<a id="Shannon"></a>
* * *
Shannon's Perfect Security
-----------------
1.P[M=m|C=c]=P[M=m].  
2.Keys are picked uniformly at random and used only once.

Vernam Cipher with Uniform Random keys = **O**ne **T**ime **P**ad.

Confusion - Non-linearity in the system.
Diffusion - Destroy non-uniformity of the plaintext.



<a id="Feistelnets"></a>
* * *
Feistel networks.
-----------------

Lots of rounds, a mangler F.  

Input m=L0||R0  
Li+1 = Ri  
Ri+1 = Li ⊕ F(Ki+1, Ri)  
Output = Rn || Ln  

Inverse of c = L0' || R0'  
Li+1' = Ri'  
Ri+1' = F(kn-i, Ri') ⊕ Li'


<a id="Des"></a>
* * *
DES & AES
--------
###DES

56-bit key

16 round Feistel Network. Need to know the details.

F(k, r) = P(S( E(R) ⊕ K ))

E: Expansion from 32 to 48 bits.  
S: 8 S-Boxes - Each take 6-bit input and non-linear (many to one) map to 4-bit output.  (These are many to one)  
P: Fixed permutation of the 32 bits.  

###AES

128 bit keys.  
128 bit plaintexts.

4x4 matrix of bytes, 10 rounds of applying transformations to the matrix.


<a id="DoubleEncr"></a>
* * *
Double encryption.
-----------------

Can use 2 keys. **Ek(Ek'(m))=c** and **m = Dk'(Dk(c))**.

###Meet in the middle attack - KPA
1. Obtain plaintext **m** with ciphertext **c**.

1. Iterate over keyspace for each **k ∈ K**  
Calculate **Ek(m)** store **< k, Ek(m) \>** in a list.

2. Iterate over keyspace for each **k2 ∈ K**  
Calculate **x=Dk2(c)**. If ∃**k**, **< k, x \>** in the list, then store **< k, k2 \>** as a candidate pair.

3. Test all known candidate keys **< k, k2 \>** with another known
plaintext, ciphertext pair **m'** and **c'**. and accept the candidate pair
such that **Ek(Ek2(m')) = c'**

O(2^n+1) work, for keyspace of size n. So double encryption doubles the work of
the exhaustion attack (although naively we may have expected it to square the work).

###Triple Encryption  
Ek(Dk2( Ek3(m) ))

Generally doubles the security.

<a id="BlockHead"></a>
* * *
Block Ciphers
-----------------

###ECB  

###CBC  
c0 = IV  
ci+1 = Ek(mi⊕ ci)

###OFB - Output Feedback Mode
Pseudo-random stream **r**.

r1 = IV  
ri+1 = Ek(ri)

c1= IV  
ci+1 = mi ⊕  ri+1

###CTR - Counter Mode.  
rn = Ek(IV ⊕ n)

c1 = IV  
cn = mn-1 ⊕ rn


###GCAM






<a id="Streams"></a>
* * *
Stream Ciphers
-----------------
RC4.

Uses a hidden state and permutations.  
Widely used.  
Quick to compute.  
Discard first few bytes.  



<a id="420"></a>
* * *
Hashing
-----------------

Properties:

1. Length - h:D ===> {0,1}^n
   1. D= {0,1}^n
   2. D= {0,1}^n+k
   3. D= {0,1}^*

2. Easy to compute h(x) for all x.

3. Pre image resistant - For almost all y ∈ Image(h) it is **infeasible**
to find **x** st **h(x) = y**.

4. Weak collision resistant - 2nd Pre image resistant - Given **x∈Dom(h)**
it is computationally infeasible to find **x=/=x'** st **h(x)=h(x')**.

5. Collision Resistant - Strong collision resistance - It is hard to find a pair
**x=/=x'** st **h(x)=h(x')**.

We can use the simple contrapositives of the above statements to prove things.

###Cryptographic Hash Function
**1c**; **2**; **4**; **5**.
1c -Domain {1,0}*
2 - Easy to compute  
4 - 2nd preimage resistant  
5 - Strong Collision resistance

###Compression Function
**1B**; **2**; **3**; **4**; **5**.
1b- Domain {1,0}^n+k  
2 - Easy to compute  
3 - PreImage Resistantn
4 - 2nd preimage resistant  
5 - Strong Collision resistance

###Using a compression function to make a hash funtion.
h<\> = IV  
h < x1,...,xqn,...,xqn+k \> = g(h < x1,...,xqn \>, < xqn+1, ..., xqn+k \> )


###Birthday Paradox

Average time to find a collision of an n bit hash:  
sqrt(pi * 0.5 * 2^n)= pi/2 * 2^(n/2) =  O(2^n/2)  
pi/2 = 1.6  

###Lamport's Scheme
Store h^n(pwd).  
A --> S: x=h^n-1(password)  
S checks h(x) and stores x as the new password in his database.  

Requires them to store n and keep it in sync. Additionally have to change  
password after n logins.




###Integrity
Proper integrity requires a key

A ---> B: Ek(h(m))|m  
or  
A ---> B: Ek( h(m)|m ) - Bad because integrity relies on confidentiality.

**Weakness:** h(x)=h(x') ==then==> h(x||y) = h(x'||y).




###MD Compliant Padding

1. x is a prefix of pad(x)
2. |x| = |y| ==then==> |pad(x)| = |pad(y)|
3. |x| =/= |y| ==then==> the last blocks of pad(x) and pad(y) are unequal.

MD4 and MD5 are both insecure btw. Easy to find collisions.

**SHA1-160 bits**.  
**SHA2-224 to 512 bits**  

SHA2 and SHA3 considered secure.

<a id="Salt"></a>
* * *
Salting and Hash Stretching.
---------------------------------------
h(Salt||password) - Pads out the input makes hashes longer to compute.  

h(g(User)||password) - Harder to attack a database as need to work
out an additional hash for each user. However it takes the same work
if just attacking a single user.

h(randomSalt||Password) - Assuming a random salt of 8bits. Have to
try the input with 2^8 different salts. So we increase the work by
2^8 per hash. This is much more intense on an attacker who has to
create separate rainbow tables for each salt.


###Time space tradeoffs.
Less space required, slower to lookup stored hashes.  

Can use a chain of hashes or rainbow tables. Rainbow tables use a
chain or a family of hashes, so a different hash at each point
in the chain. This is to reduce clashes of chains.

Iterate a hash - Hash stretching.

There are fewer than a million dictionary words.


<a id="KDF"></a>
* * *
Key Derivation Functions
-----------------------------
Should be VERY slow with the intention of thwarting attacks, such as dictionary attacks.

Hash stretching to make it slow.

Derive a key from a shared-secret. (Still need a secure way of sharing the secret before hand).


<a id="NumThe"></a>
* * *
Number theory
-----------------------------
Trapdoors - Easy to compute, hard to invert, **unless** one is in possession of specifi information.

a^(p-1) = 0 iff (p divides a)
	= 1 otherwise.
	(mod p)

**gcd ( m , n )** = t = mx + ny (where Euclid's algorithm will give us: t, x, y.  

m and n are coprime with m|x and n|x  ===then===> mn|x.  
e.g: 3, 5 st 3|60 and 5|60 ======> 15|60.  


<a id="DatOne"></a>
* * *
RSA
-----------------------------

###Key generation

1. p and q b-bits; n = pq; Φ = (p-1)(q-1)
2. e coprime to Φ.
3. d st de = 1 mod Φ

Secret key = < n, d \>
Public key = < n, e \>

Can find d through Euclids on gcd(e, Φ).  
We would use e = 3 as it is fast for encryption.

Prime generation is O(b^3)
Euclids is O(b^3) according to the notes.  
So overall key generation is O(b^3).  

For fixed e (as we fix e = 3 generally):  
Encryption (with fixed e) is O(b^2)  
Decryption is O(b^3)  

###Encryption

1. Pad m  
2. Epk(m) = m^e (mod n) = c

###Decryption

1. m'= Dsk(c) = c^d mod n
2. m = remove padding from m'

###Repeated Squaring
O(log y)  

x^y = 1 for y=0  
x^y = (x^2)^k for y=2k  
x^y = x*(x^2)^k for y=2k+1

###RSA Problem
Given c=m^e (mod n) where we know c, e and n, can we find m?  

Fundamental tenet of cryptography: "The problem is well
studied by the academic community and so far no feasible
solution has been found for large key sizes, therefore
an attacker should also be unable to find a feasible attack.

###RSA Assumption
Assume: The RSA problem is infeasible for large n.

###Integer factorization
It is easy to break RSA encryption if the attacker can factor p and
q, then easily find d.

But we also assume that the integer factorisation problem is
infeasible for large n.


###Padding RSA

Problems we want to avoid:

+ m = 0 or 1
+ Messages < eth root of n.
+ Encrypting the same message under many keys.
+ Small set of possible messages. Dictionary Attack.
+ Homomorphic property - E(m)*E(m2) = E(m*m2).

PKCS#1:

00 02 PADDING 00 PAYLOAD

B = floor( log(n-1) / 8)  
PADDING is B-p-3 lots of randomly generated non-zero bits.



<a id="dhke"></a>
* * *
Diffie Hellman
-----------------
g is a shared secret.

A sends: g^sa  
B sends: g^sb  
Both compute g^(sa*sb)  

Use RSA to establish a secure channel; DHKE to have a secure session.
Run DHKE under RSA. Needs to be run on a secure channel otherwise
it's susceptible to a simple man in the middle attack.

###Discrete log problem
t=m^x (mod n), given t m and n can we find x?  
So we need to find the exponent, hence it's a log problem.





<a id="mac"></a>
* * *
MACs and Digital Signatures
--------------------------------

###MAC - Message Authentication Code
Basically keyed hashes where output is some possible digest.
Keyspace is secret and so the keys need to be shared by some other means.  

MAC: {0,1}^n x K ----> D (D a set of posible digests)  
Ver: {0,1}^n x K x D -----> {True, False}
Ver k'(m', Mack(m)) = True iff k'=k and m=m'  

If the message is signed with a MAC, then we know who the originator
was as it must be the person with the key.

It is good practice to use different keys for authentication and
encryption. This is authentication, obviously.

HMAC has problems but:  
HMACk(m) = h(k||h(k||m))  
or in full:  
HMACk(m) = h((c1⊕ k)||h((c2⊕ k)||m))  
With c1= 01011100 and c2 = 00110110  


###Perfectly Secure MAC:
For all k, given m and MAC(m) then  
∀ m'=/= m P[MAC(m')=d∈ D] = 1 / |D|  

###Digital Signatures
Public/private key pairs.

K - Private keyspace  
K'- Public  keyspace

SIGN: K x {0,1}^* --------> S  
VER:  K'x {0,1}^* x S ----> {True, False}

VER k ( m, SIGNk'(m')) = True iff m==m' and < k, k' \> are a valid public-private key pair.

**Anyone** can verify, but only the sender can sign.

###Attacks on Digital Signatures

KOA - Key Only Attack - The attacker only knows the public key.  
KMA - Known Message Attack - The attacker knows the public key and has some messages and their **SIGN**s.  
CMA - Chosen Message Attack- The attacker knows the public key and can choose some messages to sign.  

EF - Existential forgery  
UF - Universal forgery


*Gold standard is security against EF even under CMA*

<a id="RSADIG"></a>
* * *
RSA as a Digital Signature
--------------------------
###Basic Idea

Public-Private Key Pair - < Ks, Kp \>
Ks = < d, n \>  
Kp = < e, n \>  
SIGN(Ks, m) = m^d (mod n)  
VER(Kp, m, sign)= (sign^e (mod n) == m )  

###EF - KOA
We know e and n.  
For any x we can sign m=x^e.  

**m**=x^e ===> sign(m=x^e) = x^ed = **x**
Ver(m, sign) checks m==sign^e=m  

**m** = **x^e**; **Sign(ks,m)** = **x**  


###EF - KMA
Sign(m) = o; Sign(m') = o'  
Sign(mm') = oo'

So given two messages **m** and **m'** with their signatures. We can also sign **mm'**

###UF - CMA

m1 = m*r  
Sign(m1)  

m2 = r^-1  
Sign(m2)

m1m2 = m  
Sign(m) = Sign(m1m2) = Sign(m1)*Sign(m2)  




###Solutions:

1. **Name in "ticket":** Sign(Name||m)

2. **Simple hashing:** Sign(h(m))

3. **Hashing and padding PKCS-esque:** Sign(00 01 PADDING 00 h(m))

4. **RSA PSS - double padding:**
   1. *Double Hash with Salt:* H= h(0x00 ^8 || h(message) || SALT)
   2. *Padding, salt, concat with another hash (side of extra hash):* S = (PADDING || 0x01 || SALT)⊕ MGF(H) || H || 0xBC
      {MGF is another hash}


<a id="mixers"></a>
* * *
Authentication and Encryption
---------------------
###ATE
c = Ek(m||Sign(m))

###ETA - _Theoretical Guarantees_
Ek(m) || Sign(Ek(m))


###E&A
Ek(m) || Sign(m)  
Separation of concerns.



<a id="DolevYao"></a>
* * *
Dolev Yao Attacker
-----------------
We assume the following strengths of the attacker on the Dolve Yao attack model:

+ Can eavesdrop on all messages that pass through the network.
+ Can intercept and message by masquerading as the recipient.
+ Can send any message by impersonating the sender.
+ Is also a legitimate user of the network.




<a id="uniprotos"></a>
* * *
Unilateral Protocols
--------------------------

###Symmetric Key

1. A ----> B: Alice
2. B ----> A: Ek(nonceA)  //Challenge - The challenge for A is to decrypt and confirm this.
3. A ----> B: Ek(nonceA + 1)  //Response - Responds by incrementing it, means she must have decrypted it.

*(Authenticates Alice)*

We re-encrypt the response otherwise we have given up an oracle.  
We encrypt the original message (as opposed to just asking Alice
 to encrypt it) so that we don't open it up to a KPA.  
Could also avoid KPA/oracle-ness by adding a structure (maybe a
 certain prefix) to the nonce.

We could use timestamps, but that requires an additional
state from whoever is storing the timestamps. Additionally
we need to then keep the clocks in sync and avoid too much
*clock skew*.

Block replay attacks with a counter in the messages. Ek(m||counter).  

We use the nonce as a sort of session id: Ek( m || nonce || Alice || Counter )  
This is because we have established identity based on the nonce, so we continue
to rely on it for continued authentication of identity.


###Session Key establishment

1. A ----> B: Alice  
2. B ----> A: Ek(nonceA)  
3. A ----> B: Ek(nonceA + 1 || ks  )  
4. A ----> B: Eks(m1 || Alice || Counter)

*(Authenticates Alice)* Let's say Alice was a news site? That makes
sense from line 2 onwards. The site proves their identity and then sends
the information.

###Public Key
A ---> B: Alice
B ---> A: EpkA(Bob || nonce)  
A ---> B: nonce.

We prepend the name so that we don't give up an oracle against ourselves.

###Public key - Session Key Establishment.

A ---> B: Alice  
B ---> A: Epka(nonce)  
A ---> B: nonce  
B ---> A: Epka(nonce||ks)  
A ---> B: Eks(m1||Alice||counter)




###TLS
1. C ---> S: noncec ; Available Cipher Suite
2. S ---> C: nonceS ; Selected  Cipher Suite; Certificate = < S, pks, Issuer1, ExpiryDate, Sign_pkis1_(S, pkS, expiry) \>,
       	  < Issuer1, pkIss1, Issuer2, Expiry, Signpkis2(Issuer1, pkIss1, Expiry)  \>  
3. C ---> S: Epks(Protocol || noncep)
4. C ---> S: Ekec(steps1-3 || MACkmc(steps1-3) )
5. S ---> C: Ekec(steps1-4 || MACkms(steps1-4) )
6. C ---> S: Ekec(m1 || MACkmc(m1||counter))
7. C ---> S: Ekes(m2 || MACkms(m2||counter))


<a id="biprots"></a>
* * *
Bilateral Authentication Protocols
---------------------------------------------

###Needham-Schroeder-Lowe - using Public Keys.

A ---> B: Alice, Ekb(nonceA)  
B ---> A: Epka( Bob || nonceA || nonceB )  
A ---> B: Epkb( nonceB || ks )  
A ---> B: Eks(m1 || Alice || counter)



###TLS
1. C ---> S: noncec ; Available Cipher Suite
2. S ---> C: nonceS ; Selected  Cipher Suite; Certificate = < S, pks, Issuer1, ExpiryDate, Sign_pkis1_(S, pkS, expiry) \>,
       	  < Issuer1, pkIss1, Issuer2, Expiry, Signpkis2(Issuer1, pkIss1, Expiry)  \>  ...
3. C ---> S: < C's certificate chain. \>
4. C ---> S: Epks(Protocol || noncep)
5. C ---> S: Ekec(steps1-3 || MACkmc(steps1-3) )
6. S ---> C: Ekec(steps1-4 || MACkms(steps1-4) )
7. C ---> S: Ekec(m1 || MACkmc(m1||counter))
8. C ---> S: Ekec(m1 || MACkmc(m1||counter))





<a id="keyzuz"></a>
* * *
Key Infrastructure
--------------------

Trusted Third Parties - TTP.

###KDC - Key Distribution Centre.
Connects people - they authentice through the KDC.  
Shared keys with all users.

###Certificate Authority
Signs Certificates.


Needham Schroeder with KDC.



###Perfect Forward Secrecy
Future sessions are secure even if long-term keys are compromised. Can
ensure this by using DHKE to set up a symmetric session key over RSA or
some other form of public assymetric crypto. Then even if the assymetric
crypto is compromised, the individual session is still uncompromised.

Determine the *session* key separately to the long-term key.



<a id="beast"></a>
* * *
BEAST attack
---------------------------------------------
Push a prefix.  
XOR out the IV and guess the last message byte.  
Rinse and repeat for the next byte.
For the next block we XOR out both the IV and c1...c8.  
