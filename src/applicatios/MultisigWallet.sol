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

     function submitTransaction(address _to,uint256 _value,bytes memory _data)public onlyOwner{
        uint256 txIndex = transactions.length;

        transactions.push(Transaction({to:_to,value:_value,data:_data,executed:false,numConfrimaions:0}));
        emit SubmitTraction({owner:msg.sender, txIndex:txIndex, to:_to, value:_value, data:_data});
     }

     function confirmTransaction(uint256 _txIndex)public  onlyOwner notConfrimed(_txIndex) txExists(_txIndex) notExecuted(_txIndex){
        Transaction storage transaction = transactions[_txIndex];

        transaction.numConfrimaions +=1;
        isconfrimed[_txIndex][msg.sender] = true;
        emit confrimTransaction({onwer:msg.sender, txIndex:_txIndex});
     }

     function executeTransaction(uint256 _txIndex)public  onlyOwner txExists(_txIndex)notExecuted(_txIndex){
        Transaction storage transaction = transactions[_txIndex];

        require(transaction.numConfrimaions >= numConfrimationRequired,"cannot execute tx");

        transaction.executed = true;
        (bool success,) = transaction.to.call{value: transaction.value}(transaction.data);
        require(success, "tx failed");
        emit ExecuteTransaction({owner:msg.sender, txIndex:_txIndex});
     }
     function revokeConfirmation(uint256 _txIndex)public  onlyOwner txExists(_txIndex) notExecuted(_txIndex){
        Transaction storage transaction = transactions[_txIndex];

        require(isconfrimed[_txIndex][msg.sender],"tx not Confrimed");

        transaction.numConfrimaions -=1;
        isconfrimed[_txIndex][msg.sender] = false;

        emit RevokeConfirmation({owner:msg.sender, txIndex:_txIndex});
     }

}