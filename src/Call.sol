// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
contract Receiver{
    event Receiver(address sender,uint256 amount, string message);

    fallback() external payable {
        emit Receiver(msg.sender, msg.value, "fallback triggled");
     }
     function foo(string memory _message,uint256 _x)public payable returns(uint256){
        emit Receiver(msg.sender, msg.value, _message);
        return _x +1;
     }
}


contract Caller{
    event Response(bool success, bytes data);

    function testCallFoo(address payable _receiver)public payable {
        (bool success,bytes memory data) = _receiver.call{value:msg.value}(abi.encodeWithSignature("foo(string,uint256)","call foo",124));
        emit Response(success, data);
    }
    //calling a function that does not exists triggers the callback function
    function testCallNotExists(address payable  _addr)public payable {
        (bool success,bytes memory data) = _addr.call{value:msg.value}(abi.encodeWithSignature("doesNotexists()"));
        emit Response(success, data);
    }
}