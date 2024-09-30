// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

/**
*Overflow and underflow in solidity 0.8 throw an error. This can be disable using unchecked


*/

contract Unchecked{
    function add (uint a, uint b)external  pure returns(uint){
        unchecked{
            return a +b;
        }
    }

//uint8 => 2^8 -> 256-1 => 255 
    function underflow(uint8 _num1,uint8 num2)external pure returns(uint8){
        return _num1 + num2; //this will throw an error error in sol v 0.8
    }
    function underflowWithUncheck(uint8 a, uint8 b)external  pure returns(uint8){
        unchecked{
            return a +b;
        }
    }

    function overflowWithUnchecked(int8  a, int8 b)external  pure returns(int8){
        unchecked{
            return a+b;
        }
    }
}