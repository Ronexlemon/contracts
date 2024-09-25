// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

/***
*Use cases of events
*Event  filtering and monitoring or real-time update and analytics
*Event log analysis decoding for data extraction and processing
* Event-driven Architecture for decentralized applications
*Event subscriptions for real-time notifications and update
***/
contract Event{
    //Event declaration
    //Up to 3 parameters can be indexed
    //Indexed parameters helps you filter the logs by the indexed parameter

    event Log(address indexed  sender,string message);
    event AnotherLog();

    function test()public{
        emit Log(msg.sender,"Yes i'm the sender");
        emit AnotherLog();
    }
}
/***Best Practices and Recommedations
*Index the right event parameter to enable efficient filtering  and seraching. Address should typically be indexed,while amounts generally should not
*Avoid redundant events by not emmiting events that are already covered by underlying libraries or contracts
*Events can not be used in view and pure functions, as thy alter the state of the blockchain by storing logs
*Be mindful of the gas cost associated with emmiting events, especially when indexing paramaters, as it can impact the overall gas consumption of your contract
*/

contract AdvanceEvents{
    event TransferInitiated(address indexed from, address indexed  to,uint256 value);
    event TransferConfirmed(address indexed from,address indexed  to, uint256 value);
    mapping(bytes32 => bool)public  transferConfirmations;

    function initiateTransfer(address _to,uint256 _value)public{
        emit TransferInitiated({from:msg.sender,to: _to, value:_value});
    }
    function confirmTransfer(bytes32 _transferID)public{
        require(!transferConfirmations[_transferID],"Transfer Already confirmed");
        emit TransferConfirmed({from:msg.sender, to:address(this), value:0});
    }
}