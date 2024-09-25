// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
//internals

struct Point{
    uint256 x;
    uint256 y;
}

error Unauthorized(address _caller);

function add(uint256 x, uint256 y)pure returns(uint256){
    return x+y;
}

contract Foo{
    string public name ="Yes me";
}