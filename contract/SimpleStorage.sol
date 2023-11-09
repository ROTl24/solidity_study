//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
//表示当前合约的版本，0.8.18是当前合约的版本号，^表示向上兼容，0.8.18表示0.8.18及以上的版本都可以使用


//合约的定义
contract SimpleStorage{
     struct People{
        uint fNumble;
        string name;
    }
    //映射也叫做字典
    mapping (string => uint)public nameToFNumber;
    People[] public people;
    // bool hasFavoriteNumber = true;
    uint public favoriteNumber = 1;
    // string name = "test";
    // int x = -5;
    // address myaddress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
    // bytes favoriteBytes = "cat";
    // People public person = People({
    //     fNumble:80,
    //     name:"xiaowang"
    // });
    
    function store(uint x)public virtual {
        favoriteNumber = x;
    }

    function retivice() public view returns(uint){
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint _favoriteNumber)public {
        people.push(People(_favoriteNumber,_name));
        nameToFNumber[_name] = _favoriteNumber;
    }

}
//0xd9145CCE52D386f254917e481eB44e9943F39138合约地址
