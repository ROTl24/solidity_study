// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FallbackExample{
    uint256 public result;

    //只有合约外可以调用 ，关于交易的
    receive() external payable { 
        result = 1;
    }

    fallback() external payable { 
        result = 2;
    }
}