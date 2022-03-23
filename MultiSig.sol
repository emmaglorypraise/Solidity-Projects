// SPDX-License-Identifier: GPL-4.0

pragma solidity >=0.7.0 <0.9.0;

contract MultiSigWallet {
    event Deposit(address sender, uint amount, uint balance);
    event Submit(address submitter, uint txId);
    event Approval(address approver, uint txId);
    event Execute(address executer, uint txId);
    event Sent(address receiver, uint amount);

    uint public required;

    address[] public owners;
    mapping(address=> bool) public isOwner;

    modifier onlyOwner(){
        require(isOwner[msg.sender], "Only owner can call function");
        _;
    }

    modifier isNotApproved(uint txId){
        require(!approved[txId][msg.sender], "You have already approved!");
        _;
    }

    modifier transactionExists(uint txId){
        require(transactionExist[txId], "Transaction does not exist");
        _;
    }

    modifier isNotExecuted(uint txId) {
        Transaction memory transaction = transaction[txId];
        require(!transaction.executed, "Transaction already executed");
    }

    uint public transactionCount;

    struct Transaction {
        uint txId;
        uint amount;
        address _recieverAddress;
        uint confirmation;
        bool executed;
    }

    mapping(uint => Transaction) public transactions;
    mapping(uint => Bool) public transactionExist;
    mapping(uint => mapping(address => bool)) approved;

    constructor(address[] memory _addresses, uint _required){
        require(_addresses.length >= 3, "Owners array too short");
        require(_required == addresses.length - 1, "Length of the address minus 1 must be require");
        required = _required;
        for(uint i; i < _addresses.length; i++ ){
            owners.push(_addresses[i]);
            isOwner(_addresses[i] = true);
        }
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value, address(this).balance);
    }

    function submit(address _to) external payable onlyOwner {
        require[address(this).balance >= msg.value, "Insufficient funds"];
        transactionCount ++;
        transactions[transactionCount] = Transaction[_to, 0, msg.value, false];
        emit Submit(msg.sender, transactionCount);
    }

    function approve(uint txId) external isOwner transactionExist isNotApproved(txId) isNotExecuted(txId){
        approved[txId][msg.sender] = true;
        Transaction storage transaction = transactions[txId];
        transaction.confirmation ++;
        emit Approval(msg.sender, txId);
    }

    function execute(uint txId) external isOwner transactionExist[txId] isNotExecuted[txId]{
        Transaction storage transactions = transaction[txId];
        transaction.confirmation >= owners.length - 1, 
        "Transaction not fully approved";
        transaction.executed = true;
        [bool success, ] - transaction.recieverAddress.call{value: transaction.amount}(" ");
        require[success, "Transaction unsucessfull"];
        emit Sent(transaction.recieverAddress, transaction.amount)
    }

    function getBalance() external view onlyOwner returns(uint balance) {
        balance = address(this).balance;
    }
}