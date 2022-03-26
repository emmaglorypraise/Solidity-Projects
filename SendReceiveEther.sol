// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;


contract ReceiveEther {
// Function to receive Ether. msg.data must be empty
    receive() external payable {}

    // Fallback function is called when msg.data is not empty
    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}

contract SendEther {
    function sendViaTransfer(address payable _to) public payable {
        // This function is no longer recommended for sending Ether.
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable {
        // Send returns a boolean value indicating success or failure.
        // This function is not recommended for sending Ether.
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
    }

    function sendViaCall(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}

// contract Receiver {
//     event Received(uint value);
  
//     function deposit() public payable {
//         emit Received(msg.value);
//     }
    
//     function getBalance() public view returns (uint256) {
//         return address(this).balance;
//     }
    
//     fallback() external payable {
//         emit Received(msg.value);
//     }
    
//     receive() external payable {
//         emit Received(msg.value);
//     }
// }
// contract Sender {
//     constructor() payable {}
    
//     function sendEther(address payable receiver) public {
//         receiver.transfer(1 ether);
//     }
    
//     function getBalance() public view returns (uint256) {
//       return address(this).balance;
//     }
// }