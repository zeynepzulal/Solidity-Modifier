// SPDX-License-Identifier:MIT

pragma solidity ^0.8.17;

contract FunctionModifier{

    address public owner;
    uint public tokenPerSecond; //1 saniyede dagitilacak token miktari

    constructor(){
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "You're not owner");
        _; //function body placeholder 
    }

    modifier positiveTokenPerSecond(){
        require(tokenPerSecond > 0, "Number must be positive");
        _;
    }
  
 

    function changeTokenPerSecond(uint _i) public onlyOwner positiveTokenPerSecond {
        //require(owner == msg.sender, "You're not owner");
        tokenPerSecond = _i;
    }

    function example() public onlyOwner positiveTokenPerSecond {
        //require(owner == msg.sender, "You're not owner");
    }
    function example2() public onlyOwner positiveTokenPerSecond {
        //require(owner == msg.sender, "You're not owner");
    }

    function changeOwner(address _addr) public onlyOwner{
        //require(owner == msg.sender, "You're not owner");
        owner = _addr;
    }

   



    //Hack lenebilecek olan bir örnek  
    //önleyecek yöntem --> no Re entrancy

    bool public isLocked;

    modifier noReentrancy(){
        require(!isLocked,"No Reentrancy");
        isLocked = true;
        _; // deposit / withdrax placeholder
        isLocked = false;
    }

    mapping(address => uint256) public balances;

    function deposit() public noReentrancy {
       // balance arttiriyor
       // 100 ether deposit ediyor
    }

    function withdraw(uint amount) public noReentrancy {
        require(amount <= balances[msg.sender],"Insufficient Balance");
        (bool success, ) = msg.sender.call{value: amount}(""); //transfer
        require(success,"Transfer failed");
        balances[msg.sender] -= amount;
    }
 
}