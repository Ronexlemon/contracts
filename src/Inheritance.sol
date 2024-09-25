// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;


contract A{
    function foo()public pure virtual returns(string memory){
        return "A";

    }
}

//inherit A
contract B is A{
    function foo()public pure virtual  override  returns(string memory){
        return "B";

    }
}
contract C is A{
    
    function foo()public pure virtual  override  returns(string memory){
         
        return "C";
      

    }
}

/**
*Contracts can inherit from multiple parent
*When a function is called that is defined multiple times in
*different contracts, parent contracts are searched from
*right to left, and in depth-first manner
**/

contract D is B,C{
    //D.foo() returns "C"
    //since C is the right most parent contract with function foo()
    function foo()public pure override(B,C)  returns(string memory){
        return  super.foo();

    }

}

//Inheritance must be orderd from "most base-like" to "most derived"
//Swapping the order of A and B will throw a compilation error
contract F is A,B{

    function foo()public pure virtual  override(A,B)  returns(string memory){
        return super.foo();

    }
}

//SHADOWING INHERITED STATE VARIBALES

contract S{
    string public name ="Yes S";
    function getName()public virtual  view returns(string memory){
        return name;
    }
}

contract P is S{
   
    constructor(){
        name = "Yes P";
    }
    
    

}