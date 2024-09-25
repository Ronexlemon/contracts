// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
import "./Foo.sol";

import {Point,Unauthorized,add as func} from "./Foo.sol";
contract Import{
    Foo public foo = new Foo();
    mapping(uint256=>Point)public  point;
    function getName()public view returns(string memory){
        return foo.name();

    }
    //do sum
    function addTwo(uint256 x,uint256 y)public pure  returns(uint256){
        return func(x,y);
    }

    
}