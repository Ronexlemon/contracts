// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

library Id{
    function generateId(address _sender,uint256 _time)internal pure returns(bytes32){
        return keccak256(abi.encode(_sender,_time));
    }
}