// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NumberStorage {
    uint256 private number;

    // Function to set a number
    function setNumber(uint256 _number) public {
        number = _number;
    }

    // Function to get the stored number
    function getNumber() public view returns (uint256) {
        return number;
    }
}
