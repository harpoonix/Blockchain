from brownie import Bank, accounts

def main():
    return Bank.deploy({'from':accounts[0]})
