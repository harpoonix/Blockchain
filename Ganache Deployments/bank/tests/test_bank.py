#!/usr/bin/python3

import pytest

def test_initialise_bank(token, accounts):
    accounts[0].transfer(token, "99 ether", data=0x1234)
    assert token.balance()=="99 ether"

def test_balance(token, accounts):
    accounts[1].transfer(token, "50 ether")
    accounts[2].transfer(token, "60 ether")
    bal1 = token.showBalance({'from':accounts[1]}).return_value
    bal2 = token.showBalance({'from':accounts[2]}).return_value

    assert(bal1 == 50)
    assert(bal2 == 60)

def test_withdraw(token, accounts):
    money = token.showBalance({'from': accounts[2]}).return_value
    withdrawn = token.withdraw({'from': accounts[2]}).return_value
    assert(money==withdrawn[2])