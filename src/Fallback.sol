// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

//executed when a function that does not exists is called or
//Ether is sent direcly to a contract but receive does not exists or msg.data is empty

contract Fallback{
    event Log(string func,uint256 gas);
    fallback() external payable { 
        emit Log("fallback",gasleft());
    }

    //receive is a variant of fallback that is trigged when msg.data is empty
    receive() external payable {
        emit Log("reciver", gasleft());
     }
     //helper fucntion to check the balance of this contract
     function getBalance()public view returns(uint256){
        return address(this).balance;
     }
}

contract SendToFallback{
    function transferToFallBack(address payable _recepient)public payable {
        _recepient.transfer(msg.value);
    }
    function callFallback(address payable _recepient)public payable {
        (bool success,) = _recepient.call{value:msg.value}("getit");
        require(success,"failed to transfer");
    }
}