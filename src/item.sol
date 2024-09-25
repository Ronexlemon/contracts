// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;
//consuming the library

import "./Library.sol";

contract Items{
    using Id for address;
    struct items{
        uint256 price;
        bytes32  id;
    }
    mapping(bytes32 => items)public itemWithAmount;
    event Create(address _sender,bytes32 id);
    
    function create(uint256 _price)public payable  returns(bytes32){
        require (_price * 1 ether == msg.value,"incorrect amount");
       bytes32 _id = msg.sender.generateId(block.timestamp);
        itemWithAmount[_id] = items({price: msg.value, id: _id});
        emit Create(msg.sender,_id);
        return _id;


    }
}