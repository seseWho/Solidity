// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.6; 

contract HelloWorld {
    uint private value;

    function setValue(uint newValue) public {
        value = newValue;
    }

    function remove() public {
        selfdestruct(payable(address(0x0)));
    }
}