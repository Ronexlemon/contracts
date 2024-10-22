// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract EtherWallet{
    address payable  owner;

    constructor(){
        owner = payable (msg.sender);
    }


modifier onlyOwner(){
    require(owner == msg.sender,"only owner");
    _;
}
    function withdraw(uint256  _amount)external onlyOwner  {

        owner.transfer(_amount);

    }

function  getBalance()external  view returns(uint256){
    return address(this).balance;
}

//can receive ether

    receive() external payable { }
}