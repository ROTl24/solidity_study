// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract StorageFactory{
    SimpleStorage[] public simplearry;//声明了一个公共的动态数组，用于存储 SimpleStorage 合约的实例

    function creatSimple()public {
       SimpleStorage simple = new SimpleStorage();
       //创建了一个新的 SimpleStorage 对象并将其赋值给 simple 变量。
       //这使得你可以使用 simple 变量来访问和操作这个新创建的对象的属性和方法
       simplearry.push(simple);
    }

    function sfStore(uint index,uint number)public {
        SimpleStorage scontract0 = simplearry[index];
        scontract0.store(number);
    }

    function sfGet(uint index)public view returns(uint){
        SimpleStorage simpleStorage = simplearry[index];
        return simpleStorage.retivice();
    }
}