# Solidity

[Documentation](https://docs.soliditylang.org/en/v0.8.15/)  
[Cheatsheet](https://docs.soliditylang.org/en/develop/cheatsheet.html)  
Solidity is a statically typed, compiled progarmming language for implementing smart contracts. It is a high level, object oriented language.  
`.sol` is the extension for code written in solidity.  
Use `pragma` keyword at the top to specify to the compiler the version of solidity to use.  
`contract` keyword is used to define the details of the smart contarct, roughly like a class for smart contracts.  

## Basic Syntax

```javascript
pragma solidity >=0.4.0 <0.6.0;
contract SimpleStorage {
   uint storedData;
   function set(uint x) public {
      storedData = x;
   }
   function get() public view returns (uint) {
      return storedData;
   }
}
```

The first line here is a pragma directive that the code is written for solidity version 0.4.0 or anything newer, and will not break functionality upto 0.6.0.  
The pragma for a file which will not compile earlier than version 0.4.0 and it will also not work on a compiler starting from version 0.5.0 can be written as `pragma solidity ^0.4.0`  
Comments can be added just like in C++, using // or between /* */  

## Data Types

- `bool` (Boolean) stores `true` or `false`
- `int/uint` (Integer) signed and unsigned integers of varying sizes. `int8` to `int256` can be used, where int256 is the same as normal int. Similarly for `uint8` to `uint256`.
- `fixed/unfixed` (Fixed point numbers)
-`fixedMxN or ufixedMxN` are signed and unsigned fixed point numbers where `M` is the no. of bits taken by the data type and `N` is the number of decimal points.  

### address

[All about address in ethereum](https://jeancvllr.medium.com/solidity-tutorial-all-about-addresses-ffcdf7efc4e7#:~:text=The%20distinction%20between%20address%20and,while%20a%20plain%20address%20cannot.)  
It holds the 20 byte value representing the size of an Ethereum address.  

```javascript
address x = 0x212;
address myAddress = this;
if (x.balance >10 && yAddress.balance>=10) x.transfer(10);
```

The balance associated with an address can be fetched using the `.balance` method and balance acn be transferred to another address using `.transfer` method.  

There are two different data types in solidity - address and address payable. You can only send Ether to a recipient via the smart contract if the data type of the recipient is address payable.  

We can cast an object of type address payable into an object of type address but not vice-versa. Also after casting to address, transfer method cannot be called on it.  

## Variables

[Variables](https://www.tutorialspoint.com/solidity/solidity_variables.htm)  

- **State Variables**  
Variables whose values are permanantly stored in the contract storage
- **Local variables**  
Variables whose values are present till function is executing.
- **Global variables**  
These exist in the global namespaceand are sued to get info about the blockchain.

### Global variables

- blockhash(uint Blocknumber) returns hash of the given block
- block.coinbase(address payable) current block miner's address
- block.gaslimit (uint)
- block.number returns current block number
- gasleft() Remaining gas
- tx.gasprice gasprice of the transaction
- msg.sender (address payable) is the address thaat has initiated the function or created the transaction
- tx.origin (address payable) sender of the transaction

### Variable Scope

State variables can have 3 types of scope

- Public : These variabe san be accessed internally as well as via messages.
- Internal : These can be accessed only internally form the current or contract deriving form it\
- Private : They can be accessed only in the contarct they are defined in

Function example

```javascript
function x() public returns (uint){
   data = 3;
   return data;
}
```

## Strings

Strings can be enclosed in double or single quotes. They can be constructed using data type string.  
String operation requires more gas consumption than bytes32. We can assign a string literal to bytes32 object and vice-versa.  

## Arrays

```javascript
//statically create an array
type arrayName [arraysize];
// Dynamically create an array
type[] arrayName;
// For example
address payable[] recipients;
```

Methods for arrays -

- length will return the length of the array
- push will append the given element to the end of the dynamic array

We have 2 functions for sending ether to someone's account in solidity - transfer and send.  
If there is an error on the recipient's end while receiving the sum, `transfer` will propagate the error to the smart contarct and the transaction will fail.  , on the other hand, will simply return a `False` boolean value.  

## Enums

Enum is a data type consisting of named values that represent integral constants. So enums can be used to restrict a variable to only some predefined values.  
An object of type enum will only take values in the list, eg

```cpp
enum Day {
   Sunday, Monday, Tuesday, Wednesday, hursday, Friday, Saturday
};
// If we don't assign values to the labels in an enum, the default values assigned are 0, 1, 2, ...
// If we change the first value to say, 10, and leave the others empty, they get automatically initialised to 11, 12, 13, ...
int main(){
   Day today;
   today = Wednesday;
   //If we tried to assign 9 to today, it would give an error since today can only take values from 0 to 6.
   cout<<today<<endl;
}
```

Elements in a cpp enum list are qualifiable by their enum name, eg Day::fri  
Things are a bit different in solidity, eg qualifier here is dot, so Day.fri is used.  

## Function Scope

In solidity, a function that does not read or modify variables of the state is called a `pure` function.  
It does not read from the state and thus does not require '`view`'. Pure functions cannot invoke other functions which are not pure.  
`view` specifier is used for functions which can read, but not modify the state of the blockchain. This is the same as declaring the function `constant`.  

## Data Locations

**Storage**  
This is permanant data, which means this can be accessed in all functions within the contract. Storage variable is stored in the state of the smart contract and is persistent b/w function calls. Any variable stored on storage is written on the blockchain, and thus is permanant with the smart contract.  

**Memory**
This location is temporary data and can only be accessed wihin the function. Once the function gets executed, its contents are discarded.  

**Calldata**  
This is a non-modifiable and non-persistant data location where all passing values to function and the parameters passed are stored.  

**Stack**  
Stack is a non-persistant data location maintained by the EVM. It is used by the EVM to laod variables during execution. Satck location has limitation upto 1024 levels.  

## Function Visibility Specifier

**public**  
public functions are visible from internal and external contracts, which means it can be called inside a contract or outside the contract.

**private**  
They can only be used internally and not even by derived contracts

**internal**  
Similar to private functions, and available for the class hierarchy. Can be called by the contract and its derived ones.

**external**  
They can be called from outside the contract only, ie by other contracts or some other external means.  
To call exernal function within contract use `this.function()`.  

## `payable` qualifier

`payable` qualifier on a function allows accepting ether from a caller. It fails if the sender has not provided ether. Other functions do not accept ether, only payable functions allow.  

### Mapping

Mapping is like a function which takes in value in one datatype (_KeyType) and returns another datatype (_ValueType).  

```javascript
mapping(_KeyType => _ValueType)
```

## Special Variables

### txn (Transaction)

tx.origin is the ethereum address that sends the transaction.  
A smart contct may make cals to multiple smart contracts, but the tx.origin remains fixed at the person who called the smart contract to make the transaction.  

### msg (Message)

Gives info about the calling environment of the function  
`msg.value` is the amount of ether sent to the contract  
`msg.sender` isthe ethereum address that called the function  
If a smart contract A calls another smart contract B, then the msg.sender for B is A.  

### block

block.timestamp is the timestamp at which the block was mined.  

## Functions

```javascript
function function-name(parameter-list) scope returns (){
   // statements
}
```

A function can return multiple values too, just write the list of return parameters inside `returns ()`, eg `returns(string name, uint age)`.  

## Modifiers

Modifiers are used to modify the behaviour of a function.  
The point where `_;` is inserted in the modifier code is where the function body is executed, or _it returns the flow of execution back to the original function code_.  

## Events

Events are generally used to inform the calling application about the state of the contract.  
Writing blocks on the lbockchain is an asynchronous process, so events provide us with a way to instantaneously listen to emitted events using a third party source (reading the logs).  

We can use the indexed keyword while defining the data members in an event. This will allow us to search for the event using indexed parameters as filters.  
This means that we can search for a particular event using the parameters which have been indexed as filters, whereas the filter does not work for parameters that were un-indexed.  

> Visibility for constructor is ignored, which means that the concept of visibility (public/external) in constructors is now obsolete. If we want to make a contract non-instantiable, we can mark it to be abstract.

## ERC20 Tokens

Two specially define devents are invoked when a user is granted rights to withdraw tokens form an account, and after the tokens are actually transferred. 

```javascript
event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
event Transfer(address indexed from , address indexed to, uint tokens);
```

## `Transfer` vs `Send` vs `Call`

These are some of the ways to transfer ether to a particular address.  
`<address payable>.transfer(uint256 amount)` sends the given amount of wei to Address, reverts on failure, forwards 2300 gas stipend.  
`<address payable>.send(uint256 amount)` sends the given amount of wei to Address, returns false on failure, forwards 2300 gas.  

[These methods](https://ethereum.stackexchange.com/questions/19341/address-send-vs-address-transfer-best-practice-usage)  
[Call StackExchange](https://ethereum.stackexchange.com/questions/19341/address-send-vs-address-transfer-best-practice-usage)  
[Call Docs](https://docs.soliditylang.org/en/v0.8.15/types.html#address)  

## Error Handling

[Docs for Error Handling](https://docs.soliditylang.org/en/v0.8.15/control-structures.html#error-handling-assert-require-revert-and-exceptions)  

## Fallback and Receive

If a contract receives ether and no data (no function is specified to handle the ether) or no function , the fallback function handles the ether received.  

`receive() external payable` - for empty calldata (and any value)  
`fallback() external payable` - when no other function matches (not even the receive function). Optioally payable  

### `receive()`

A contract can only have one receive function, declared with syntax `receive() external payable {...}`. It executes on the calls made to the contarct with no data, eg. `send()` or `transfer()` calls.  
It doesn't take arguments, doesn't return anything, and must have `external` visibility and payable state mutability.  

### `fallback()`

`fallback() external [payable] {...}` is the syntax, payable is optional.  
The fallback function always receives data, to receive ether, it can be set payable.  





