# Blockchain Notes

## 3B1B Video on Bitcoin

[Video link](https://www.youtube.com/watch?v=bBC-nXj3Ng4)  
A **ledger** is a book or a collection of accounts in which account transactions are recorded.  
Say you and your friends make a communal _ledger_ to keep track of payments when you hang out together.
Because this ledger is _public_, _anyone can add a line_.  
How are we supposed to trust which lines are genuine?  
Here is where **digital signatures** come in.  
The solution is to have the other party verify the transaction with a digital signature of theirs.
How are we sure digital signatures cannot be forged?
Every person on the ledger generates a `public key` and a `private/secret key`.  
A digital signature on a message is a combination of the `message` itself and the `secret key`.  
This means _only_ you can make it, and it is _unique for every message_, so no one can take one signature of yours and apply it to some other line in the ledger.

```py
Sign(Message, sk) = Signature
Verify(Message, Signature, pk) = True or False
# Verify checks if this is the signature made by the private key associated with the public key
# The signature is of 256 bits, and e can be sure it can't be just guessed feasibly.
```

**So, only signed transactions are valid. This removes the element of trust from the ledger.**  
The next problem is that, what if someone racks up a lot of money in deb on this ledgerm, and never shows up to pay?  
We devise a mechanism to ensure no one can spend more on this ledger than what they have.  
We add a line to the ledger everytime a new user gets added, say `User X` gets $100. This means that `User X` now can only spend wha his account on this ledger has, and this eliminates the need for paying up and settling on this ledger in cash.  

Till now, our ledger was public, so anyon could add lines. But his would require us to trust the hosting place of the ledger, how do we get rid of this trust requirement? How can we trust that THE MAIN LEDGER has not been compromised?  
To work around this, we let everyone have a copy of the ledger. And every transaction is broadcast to everyone for them to record it on their ledger.  
But how can we be sure that the transaction we received as a broadcast is the same one everyone else has received?  
The solution offered by bitcoin is that we trust which ever ledger has the most computational work put into it.  
The idea is that fraudulent trasactions would rewuire an infeasible amount of computation to bring about.  

## Hash Function

SHA256(message) = some string of bits, say 256 length  
This is a _cryptographic_ hash function, so the output when you change the input even slightly is completely different from the previous one. It changes quite unpredictably for change in inputs, and thius it is `infeasible` to compute it in the reverse order, ie., given an output (string of 1s and 0s) we cannot find a message whose SHA256() gives this output. Our best bet in this case is to guess 2^256 messages, which is reliably too much work to break this system.  

How are cryptographic hash functions associated with proof of work?  
Say someone tells you they found a number such that when you add that number to a ledger, and apply SHA256() to it, the first 30 digits of the output are all zeros.  
How hard was it for them to find this number?  
The probability that a hash output just happens to start with 30 is 1/2^30, close to 1 in a billion. This means that this person had to go through a lot of computational work to find this number. We can verify this numbr quickly, without having to go through this work ourselves (just take SHA256() of this ledger + number combo, recall that SHA256 is easy one way, gruesome the other way.)  
This is `Proof of Work`.  
So now we trust the ledger which has the most computational work put into it.  

## The Process

We divide the ledger into blocks, with each block having transactions followed by a number, the _proof of work_, such that when we take the SHA256 of this block, the output starts with, say 60 zeros.  
In the same way as transactions are only valid if they have a digital signature, _blocks are only valid_ if they have a `proof of work.`  
To make sure there is an `order` to these blocks, we make it so that each block has the `hash` of the _previous block at its header._  
Now if we go back and change one of these blocks, it will change its hash, which change the hash of the block after it, and so on. So we need to redo the entire chain form that point.  

**Since we have blocks chained in this way, we call it a blockchain, instead of simply a ledger.**

## Mining

So we allow anyone to be a block creator. This means they listen to the transactions, find these special numbers that satisfy the hash constraint, and send it out to everyone to update their ledgers.  
As a reward to block creator, the block they verified gets to add a special new line at the top, that pays the miner some ledger dollars. This is called mining, since we created new currency and introduced it into the economy.  
What a miner is really doing is trying to find a special number that validates the block, quickly and before anyone else.  
So now everyoe who is not a creator, they just listen to these validated blocks broadacast by miners instead of listening to each transaction.  
What happens if you get 2 conflicting blocks? Who to trust now?  

**The solution is that we trust the block which has most computational work put into it.**  
We trust the longer blockchain, which naturally has more work put into it.  
_How can we trust that more computaional work will strengthen the credibility of a blockchain?_  
Say Alice sends Bob a fraudulent block, in which she pays him a $100, but does not broadacst it to other miners. This makes Bob believe Alice paid him, without this transaction ending up on the blockchain, so Alice didn't actually pay him. How does Bob figure out that Alice's block is fake?  
Bob is still listening to broadcasts by other miners, and to keep up her lie, Alice will have to single-handedly keep adding to her fake block.  
She might do this for a while, but in due time, with all other miners working on the correct blockchain, her blockchain will be way shorter than theirs, and Bob will reject her version as the incorrect one.  

### Mining Rewards and Fees

Miner reward for verifying a block gets cut in half periodically as more and more transactions are verified. Also, as number of miners increase, the target number of zeros for a hash increase so that each verification takes on avg 10 minutes.  
A block on the blockchain can only include about about 2400 transactions, so to incentivise the miner to include your transaction on the blockchain, you add a small fee, which goes to the verifier, so they choose to include your transaction in the blockchain.  
_____________________________________________________________

## Asymmetric Encryption

[Video](https://www.youtube.com/watch?v=AQDCe585Lnc)  
Let us first understand **symmetric encryption** and its problems before jumping on to how aysmmetric enryption solves it.  
Say Alice has to send a sensitive document to Bob. She can encrypt it using a _password_, but how is she supposed to _send_ the password to bob? Sending it via mail is `risky`, because attackers can steal the password.  
The solution is to use _asymmetric_ encryption, where for each person, the RSA algo generates a _public_ and a _private_ key, such that they both are mathematically _linked_ to each other, but one `cannot be derived` from the other.  
You can share your public key with the world, it is sort of an _address_ to your mailbox, where people can send messages. But only your `private key` can _unlock_ the mailbox, no one else.  
Say Alice and Bob have to communicate securely, then they exchange their public keys, and Alice `encrypts` a mesaage using `Bob's public` key.  
This message can now be _decrypted_ only using `Bob's private` key, not even by Alice.  
____________________________________________________________________

## Public Key Cryptography

[ComputerPhile Video](https://www.youtube.com/watch?v=GSIDS_lvRv4)  
Basic cryptography, you have a secret key, and you encode some information using it and convert it to random noise. The person at the other end can decrypt it using the secret key, and they acn get the message. Anyone trying to snoop in can't understand anything. Basic, Simple, Old.  

So a symmetric system works like this : 
You have a message, and you encrypt it by doing some process to it using a key (secret piece of info), nd the other person reverses your process and gets the message. The problem is in communicating the secret key to the other person.  

If we were to send this key via the internet, we might run into attackers that could take advantage of the unencrypted communication channel. Got it. We need a secure encrypted connection to share the key.  

But we need the key to establish a secure encrypted connection.  

We solve this problem using asymmetric enryption.  

We generate 2 keys - say `KeyA` and `KeyB`. These are _mathematically linked_ to each other in a certain way, such that _only KeyB can decrypt a message encrypted with KeyA_, and vice versa. The cool part is that you _can't infer one key from the other_.
Now you've got an asymmetric pair of keys, just pick one of them, say `KeyA.`  
You can call KeyA your `public key` - share it with the world! Share it with everyone you wish to communicate to!  
The _other person_ just needs to encrypt the message using your _public key_, knowing that you, and **only you**, using your `private key` will be able to decrypt it.  

Another cool thing you can do is, encrypt something with your private key.  
Why, you may wonder? If everyone ahs my public key, they can all decrypt this message. Why bother encrypting it in the first place?
Well since this message can be decrypted using YOUR PUBLIC KEY, it means that it was encrypted using YOUR PRIVATE KEY. (Recall this is how the pair of keys work, only A can open B, and only B can open A)  

So the best way to communicate is this :  

1. I encrypt something with my private key. This ensures that the message is genuine.
2. I then encrypt it using your public key. This ensures that only you can read the message.

This simple 2 key encryption ensures 2 things,

1. It is me who sent the message, not an impostor, since only I could have made this message encrypted with my private key.
2. We both know no one else can read the message, only your private key can decrypt it.

We have a great way of communication set up! Hooray!
________________________________________________________________

## Digital Signature

[ComputerPhile Video](https://www.youtube.com/watch?v=s22eJ1eVLTU)  
Recall public key cryptography, whre we have a pair of keys - a public and a private one, they can dectypt each other's messages. But encryption using RSA is slow, and these keys are used or a very long time, while people prefer to rotate keys more often.  
A better solution is to verify the identity of one of the people in the conversatino and just use AES or symmetric encryption.  
So here is the sitch - a have a document I want to send you, and I want to prove it is me who has sent it. So I use my private key to sign the document, and you on your end verify it using my public key.  
Thi can be a problem, since the document could be very long, or very short. Any encryption algorithm applied to the number 1 is just 1, so these don't work very well if the input is very short.  

So what we do is, we encrypt the document using a hash function, eg sha256, and this will take any document, whatever the length be, into an output of exactly 256 bits.
We will probably add some padding to increase the size of the encrypted signature.  

We now encrypt this using our private key, and send it to the verifier. The verifier runs hashing on the document, adds padding and compares it with what they received after decrypting it with our public key.  

### Certificates

One of the primary roles of digital signatures is at the end of certificates.  
Say we have the certificate on a server, that holds their public key, and it carries along with it a digital signature signed by some certification authority.  
So the server sends you a certificate, you take the contents of the certifivate, hash them, pad them, and compare it with what you get after decrypting the signature on it using their public key.  
____________________________________________________________________________

## Hashing Algorithms

[Tom Scott and ComputerPhile](https://www.youtube.com/watch?v=b4b8ktEV4Bg)  
The hash of a file is analogous to a summary of that file, kind of what the file boils down to at the end, typically a code in 16/32/64 bits of hexadecimal. It basically crushes down the whole file into this small code. It doesn't work backwords, you can't get the file from the hash.  

This is like the last digit on a barcode, which is determined by/is a function of all the previous digits in the barcode. This makes it easy for us to spot any errors in one of the digits, since it results a completely different last digit (alpha character).

1. Speed. It has to be reasonably fast, it should be able to churn through a big file quickly. But it shouldnt' be _too quick_, that make sit easy to break.
2. If you change even one bit, anywhere in the file, the resulting hash should be completely and unpredictably different from the original one. (avalanche effect)
3. We've got to avoid hash collisions, where 2 documents have the same hash. Now there's the pigeonhole principle, and since the number of hashes are limited (2^ no.of bits), there will be files out there with the same hash. Our jobs is to ensure the odds against it are so high that manifesting hash collisons is unfeasible.

A hash algorithm is said to be broken if you can manipulate the file in certain way, and have it return the same hash as the original file. Thus if the hashing is too fast, you can find documents with the same hash fairly quickly.  
___________________________________________________________________

## SHA (Secure Hashing Algorithm)

[Computerphile](https://www.youtube.com/watch?v=DMtFhACPnTY&list=PL0LZxT9Dgnxfu1ILW0XnLnq3mb0L5mUPr&index=2)  

```py
Sidenote on Hashing Passwords
Password hashing is used to verify the integrity of your password, sent during login, against the stored hash so that your password never gets stored. This is a secure way to verify passwords without keeping track of them and better than encryption, since there is no way to 'decrypt' a hash.
Such hashing algos need to be slow since we need them to be secure.
```

```py
Side-Sidenote on How to store passwords
1. The stupidest way to store is plain text. Anyone could hack into it, anyone can see it, its as good as announcing them publicly, because at some point, they will be.
2. Another naive approach is to store encrypted passwords. Well first, the key could simply get stolen. The encrypted passwords could still get leaked, hackers can figure out what people have the same password. Loads of different people having one thing in common - could easily be exploited.
3. Even hashing isn't completely safe. You could take in the password, run it through a hashing algorithm and get a hash which you store. Now if you use MD5 or SHA1 for hashing, you're pretty much done, because these are broken. MD5 is completely broken in the sense even googling the hash will get you the input. For SHA1, hackers have run the SHA on billions of common passwords and created rainbow tables, a lsit of passwords and their hashes, and your hash could end up on them.

So what do we do? The best way is to use salting and hashing both.
You generate a long random string of characters for every user, called the salt, and combine it with their password, and then run the hashing. Thhus the hash that is produced is truly irreversible, since it is different for each user, and also the rainbow table method does not work because now you have to combine common passwords with garbage and guess hashes for that, truly impossible.
```


