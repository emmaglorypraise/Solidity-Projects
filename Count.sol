// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

contract Counter {
// declares a variable called count
   uint public count; 

   function getCount() public view returns (uint) {
       return count;
       //this function gets the count variable
   }

   function increase() public {
       count += 1;
    //    this function increase the value of count by 1
   }

   function decrease() public {
       count -= 1;
    //    this functiondecreas the value of count by 1
   }


   
}