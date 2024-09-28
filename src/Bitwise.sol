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
    //shift left
    /**
    *1 << 0 = 0001 -->0001 =1
    *1 << 1 =0001 --> 0010 = 2
    *1 <<2 =0001 --> 0100 =4
    *1 << 3 = 0001 --> 1000 = 8
    *3 <<2 = 0011 --> 1100 =12
    *4 <<2 = 000000101 -->00010100 = (2^4)+(2^2) =16+4 =>20
    */
    function shiftLeft(uint256 x, uint256 bits)external pure returns (uint256){
        return  x << bits;
    }
    //extracting  the last n bits
    function getLastNBits(uint256 x, uint256 n)external  pure returns(uint256){
        uint mask =(1<<n)-1;
        //let x be 12 and n 3
        //mask => (1 << 3) => 00000001 -> 00001000 -> 8 -1 => 7 => 00000111
        //x & mask -> 00001100 & 00000111 ->000001100 
        return x & mask;
    }

    function getLastNBitsUsingModulo(uint256 x, uint256 n)external  pure returns(uint256){
        //let x = 12 and n 3
        //  (1 << 3) => 00000001 -> 00001000 -> 8 -1 => 7 => 00000111
        //000001100 % 00000111 =>1100
        return x % (1<<n);
    }
    //finding the most significant bi
}