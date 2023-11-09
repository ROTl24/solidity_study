// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
//从用户那边获取钱
//然后可以提取现金‘
//设置一个以美元为单位的最小提取
import "./PriceConverter.sol";

contract FundMe{
    
    using PriceConverter for uint;
    // uint public number;
    //改成1e18是因为后面18位是小数
    uint public minimumUsd = 50 * 1e18;

    //创建一个地址的数组，用来存放所有发送资金的用户
    address[] public funders;

    //将address映射到unit。为了将msg.sender与msg.value绑定
    mapping (address => uint) public addressToAmountFunded;


    address public owner;
    //构造函数在创建合约的那笔交易中被立刻调用了一次
    constructor(){
        //发起交易的钱包地址，在这里就是部署合约的地址人
        owner = msg.sender;

    }

    function fund()public payable {
        //1.如何将交易转向ETH
        // number = 5;
        //msg.value返回的是用户转账的ETH额度，单位是wei (18位的整数)。
        // require(getConversionRate(msg.value) >= minimumUsd,"did't send zero");
        //()里面不需要填值，因为msg.value会自动传入。
        require(msg.value.getConversionRate() >= minimumUsd,"did't send zero");
        // number = 6;

        //msg.sender表示发送人的地址
        funders.push(msg.sender);
        
        addressToAmountFunded[msg.sender] = msg.value;
        
    }

    function withdraw() public onlyOwner{

       
        for (uint256 funderIndex = 0;funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);//完全重置整个funders数组,后面的（0）表示没有对象


        // //这里的this指的使合约本身
        // payable (msg.sender).transfer(address(this).balance);
        // //如果运行失败，会直接报错并回滚交易


        // bool sendSuccess = payable (msg.sender).send(address(this).balance);
        // //运行失败不会直接报错，会返回一个是否成功的布尔值,send想要回滚必须添加回滚语句
        // require(sendSuccess,"Send faild");


        (bool callSuccess, ) = payable (msg.sender).call{value: address(this).balance}("");
        //memory->可以修改的临时变量
        require(callSuccess,"Call faild");
    }

    //modifier 一个可以直接在函数声明当中添加的关键词

    modifier onlyOwner{
        require(msg.sender == owner,"Sender is not owner!");
        _;
    }

   
}