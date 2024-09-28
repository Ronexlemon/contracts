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
    //finding the most significant bits is the left most bit in a binary representation
    function mostSignificantBit(uint x) external pure returns (uint) {
 uint i = 0;
 while ((x >>= 1) > 0) {
 ++i;
 }
 return i;
}
}

contract Slot{
    uint128 public A = 2;
uint104 public D = 6;
uint16  public E = 4; //byte2 but will be in for byte3  slot 32-3 => 29
uint8   public G = 1; //1 byte
uint256 public  FF =8;

function readSlot(uint256 slot)external  view returns(bytes32 value){
    assembly{
        value := sload(slot)
    }
}

//getting variable offset for E
function getOffset()external  pure returns(uint256 _offset){
    assembly{
        //returns 29 bytes left
        _offset:= E.offset
    }
}
function getDOffset()external  pure  returns(uint256 _offset){
    assembly{
        //should return 104 +16+8 => 128 bits => 16 bytes => 32 bytes -16 bytes to the left that is =>16 bytes
        _offset := D.offset
    }
}
function getESlot()external  pure returns(uint slot){
    assembly{
        slot := E.slot
    }
}
//return the bytes of E
function shiftE()external  view  returns(bytes32 e){
    assembly{
        let slot := sload(E.slot)
        e := shr(mul(E.offset,8),slot)
    }
}
//masking 
/**
*since the to get the number of bytes it the previous bits plus the current one
*to umask mask the number of bits it contain 
*/
function shiftEForValue()external  view returns(bytes32 e, uint val){
    assembly{
        let slot := sload(E.slot) // get the slot
        e:= shr(mul(E.offset,8),slot) // shift the slot to the right by the number of bytes offset
        val:= and(e,0xffff)

    }
}
}