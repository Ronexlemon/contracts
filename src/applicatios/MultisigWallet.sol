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

    uint256 numConfrimationRequired;

    struct Transaction{
        address to;
        uint256 value;
        bytes data;
        bool executed;
        uint256 numConfrimaions;
    }

}