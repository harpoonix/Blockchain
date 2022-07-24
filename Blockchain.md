# Introduction to Blockchain

## Digital Signature

1. A password generator, which generates a pair of keys, one public and one private from the given password by the user.
2. A signature on the document. `sign = Signature(message, sk)` is a function of both the message and the secret key of the person signing it. This ensures that the signature cannnot be used for other messages, and that only one person could have signed it.
3. Finally a function that verifies if the signature is for this message amd made by the right person.
`valid_or_not = verify(sign, message, pk)` verifies that the `sign` is made for `message`, and that it is signed by the _private key corresponding_ to this _public key_ `pk`.

[General Introduction](https://faun.pub/what-are-digital-signatures-and-how-do-they-work-195b18c4f42c)  
[Blockchain specific](https://ravikantagrawal.medium.com/digital-signature-from-blockchain-context-cedcd563eee5)  

## Hash Functions

[This article](https://medium.com/@rauljordan/the-state-of-hashing-algorithms-the-why-the-how-and-the-future-b21d5c0440de)  
The basic idea behind hashing is to use a deterministic algorithm that takes in one input and produces a fixed length string everytime. The output is said to be pseudo-random, which means that it looks random and changes unpredictably for chang in inputs, but always gives the same random-looking output for an input.  
A problem with hashing algorithms is the inevitability of collisions. Since the number of hashes is limited and the number of possible inputs is not, some inputs will have the same hash.  
The goal of a good hashfunction is to make it extremely difficult to find ways of generating inputs that lead to the same hash value.  

### Working of SHA1

[ComputerPhile SHA](https://www.youtube.com/watch?v=DMtFhACPnTY)  
A loop that works on 512 bits of data at a time, until the file's expended. We first describe the working of SHA1 for messages of exactly the right length - one singl block of 512 bits. We only need to runt he loop once.  
SHA has an internal state that keeps taking in message, one bit at a time and keeps updating itself through this. After there's no more message left, SHA just reads the internal state. That's the hash.  

The internal state is made of 160 bits, exactly as long as the hash it produces. This is 5 32 bit words. Call these 5 words that make up the internal state H0, H1, .. H4.  
A compression function will take some data, and these set of H values, and convert it to a new set of H values.  
It copies the values of H_{i} into temporary words, say A, B, C, D, E. It will then perform the SHA function on these words, mixed with the message, 80 times. The final values of A, .. E are added to H_{i} to get the new internal state.  
We perform this process over and over for 512 bit blocks of data until we run out. If there are less than 512 bits in the last block, we do some padding to make it 512.  

Padding works like this -  
Say we have to pad a 7bit string (say 1001101) to 16/32 bits. After 7 bits, we write a 1, followed by as many zeros as required. Then we end the padding with the length of the original message in binary, in our example it will end with 111. So the padded string is  
[1001101][1000...00111], here the first part is our original message, and the next part is the padding, starting with 1. It ends with 111 in binary, which tells us that the original message was the first 7 bits of this padded string.  

## Hash Tables

[](https://www.youtube.com/watch?v=KyUTuwz_b7Q)


