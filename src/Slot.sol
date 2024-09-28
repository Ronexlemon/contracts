// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.2;

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
}