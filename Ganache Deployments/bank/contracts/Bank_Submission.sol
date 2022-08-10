// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract Bank {
    mapping (address => uint) balances;
    mapping (address => uint) depositTimes;
    address payable BankAddress;
    constructor () {
        BankAddress = payable(address(this));
        // Balance of the Bank is the same as the amount of ether in the account that has 
        // called the contract
    }

    event BankMoney(string message, uint value);
    function showTotalBalance() public returns (uint){
        emit BankMoney("Total balance in the bank was queried.", BankAddress.balance);
        return BankAddress.balance/(1 ether);
    }

    function interest(address owner) internal view returns (uint){
        uint time_elapsed = block.timestamp - depositTimes[owner];
        // The interest is 7% per 10 seconds
        return time_elapsed*7*balances[owner]/(10*100);
    }

    event UserBalance(string message, uint value);
    function showBalance() public returns (uint){
        address owner = msg.sender;
        uint updated = balances[owner] + interest(owner);
        emit UserBalance("User has queried about their bank balance.", balances[owner]);
        return updated/(1 ether);
    }

    event Transaction(string nature, uint money, address customer);
    function addBalance(address owner, uint money) internal returns (bool){
        balances[owner]+=money;
        depositTimes[owner] = block.timestamp;
        emit Transaction("Deposit", money, owner);
        // BankAddress.transfer(money); no need to do this, money already in the contract, 
        // which is the bank
        return true;
    }

    function withdraw() public returns (bool, string memory, uint){
        address payable owner = payable(msg.sender);
        balances[owner]+=interest(owner);
        uint value = balances[owner];
        owner.transfer(value);
        emit Transaction("withdraw", value, owner);
        balances[owner]=0;
        return (true, "Withdrawn", value/(1 ether));
    } 

    receive() external payable {
        addBalance(msg.sender, msg.value);
    }
    event Initialise(uint money, string message);
    
    fallback() external payable {
        emit Initialise(BankAddress.balance, string(msg.data));
    }
}
