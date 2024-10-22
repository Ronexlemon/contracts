// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract MultisigWallet{
    event Deposit(address indexed  sender, uint256 amount,uint256 balance);
    event SubmitTraction(address indexed  owner, uint256 indexed  txIndex,address indexed  to,uint256 value, bytes data);
    event confrimTransaction(address indexed onwer,uint256 indexed  txIndex);
    event RevokeConfirmation(address indexed  owner, uint256 indexed  txIndex);
    event ExecuteTransaction(address indexed  owner,uint256 indexed  txIndex);
     address[] public owners;
    mapping(address => bool)public isOwner;
    mapping(uint256 tx=>mapping(address owner => bool))public isconfrimed;

    uint256 numConfrimationRequired;

    struct Transaction{
        address to;
        uint256 value;
        bytes data;
        bool executed;
        uint256 numConfrimaions;
    }
    Transaction[] public transactions;

    modifier onlyOwner(){
        require(isOwner[msg.sender],"only Owner");
        _;
    }

    modifier txExists(uint256 _txIndex){
        require(_txIndex < transactions.length,"tx does not exists");
        _;
    }

    modifier notExecuted(uint256 _txIndex){
        require(!transactions[_txIndex].executed,"tx Aready Executed");
        _;
    }

    modifier notConfrimed(uint256 _txIndex){
        require(!isconfrimed[_txIndex][msg.sender],"already Confirmed");
        _;
    }

constructor(address[] memory _owners,uint256 _numConfirmationsRequired){
        require(_owners.length >0, "owners required");
        require(_numConfirmationsRequired >0 && _numConfirmationsRequired <= _owners.length,"Invalid Number of confirmations");
        for (uint256 i=0; i< _owners.length;i++){
            address owner = _owners[i];

            require(owner !=address(0),"invalid Address");
            require(!isOwner[owner], "owner not unique");
            isOwner[owner] = true;
            owners.push(owner);
        }

        numConfrimationRequired = _numConfirmationsRequired;

    }
    receive() external payable {
        emit Deposit({sender:msg.sender, amount:msg.value, balance:address(this).balance});
     }

}