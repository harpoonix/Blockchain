# Blockchain and Web3

## Introduction to Blockchain

### [Working and Cryptography](./Blockchain.md)

Describes how the blockchain is implemented, the problems and solutions discussed in the original [whitepaper](https://bitcoin.org/bitcoin.pdf), the cryptographic methods associated and their working.

### [Ethereum](./Ethereum.md)

A brief indroduction to the Ethereum blockchain - quite different from the bitcoin one. The bitcoin blockchain can only be used for cryptocurrency transfers, while the Ethereum blockchain can be programmed to host cryptocurrency, as well as host the backend of entire apps (decentralised apps), deploy and execute tamper-proof, permanant and secure (smart) contracts, and much more.

### [Solidity](./Solidity.md)
The language used to program on the Ethereum blockchain. Used to write smart contracts, which can be tested in the local environments using `ganache-cli`, `brownie` and `pytest`.

## Contracts

Some smart contracts written to   
- Implement a deposit and interest system for a [Bank](./contracts/Bank.sol)
- Implement a secure [voting](./contracts/Voting.sol) system 

## Ganache Deployments

### [Testing our Bank](./Ganache%20Deployments/bank/)

Testing the banking smart contract using brownie to build the project, ganache to deploy it locally, testing based on `pytest` framework.

### [NFT Minting](./Ganache%20Deployments/NFT/)

Designing a custom mintable and enumerable NFT.

