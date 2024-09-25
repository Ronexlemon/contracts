// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


contract BITWISE{
    //x 1110 = 8+4+2+0
    //y 1011 = 8+0+2+1
//......   101 0
    //x &y  =1010 => 8+0+2+0

    function and (uint256 x, uint256 y)external  pure returns (uint256) {
        return x & y;
    }

     function or (uint256 x, uint256 y)external  pure returns (uint256) {
        return x | y;
    }

    function xor (uint256 x, uint256 y)external  pure returns (uint256) {
        return x ^ y; //either a or b not both
    }
    function not (uint256 x)external  pure returns (uint256) {
        return ~x;
    }
}