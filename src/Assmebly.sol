// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract Assembly{
    //add using assembly
    function add (uint a, uint b)external pure returns(uint c){
        assembly{
            c:= add(a,b)
        }
    }
    //assembly variable
    function yul_let()external  pure returns(uint256 sum){
        assembly{
            let a := 10
            let b := 20
            sum := add(a,b)
        }


    }
//conditional statement
function yul_Switch(uint256 x) public  pure returns(uint256 z){
    assembly{
        switch  x
        case 1{z:=10}
        case 2{z:=20}
        case 3 {z:=30}
        default {z:=50}
    }
}

//loop
function yul_while_loop(uint256 num)public  pure returns(uint256 total){
    assembly{
        let sum :=0
        let i:=0
        for {} lt(i,num) {i := add(i,1)}{
            sum := add(sum,i)
            
             
        }
        total :=sum
        
    }
}
//error
function yul_err(uint256 x) public pure{
    assembly{
        if  gt(x,10){revert(0,0)}
    }
}
//math
function yul_add(uint256 a, uint256 b)external pure returns(uint256 sum){
    assembly{
        sum:= add(a,b)
    }
}
function yul_mul(uint256 a, uint256 b)external  pure returns(uint256 mull){
    assembly{
        mull := mul(a,b)
    }
}

function yul_div(uint256 a, uint256 b)external  pure returns(uint256 divv){
    assembly{
        divv := div(a,b)
    }
}
//round off to the fixed nearest

}