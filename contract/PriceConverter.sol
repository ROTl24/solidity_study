// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV2V3Interface.sol";

library PriceConverter{
    //1. 首先获得以太币等区块链通行证价格
    function getPrice()internal view returns(uint){
        //ABI
        //adress 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        //通过这种语法可以获得返回的多个数据：(uint roundId,int price,uint startAt,uint timeStamp,uint80 answeredInRound)
        //不需要的数据可以像下面这样删除，但是需要以逗号隔开
        (,int price,,,) = priceFeed.latestRoundData();
        //获取的这个价格是ETH相对于USD的价格，返回的后八位是在小数点之后的。
        //这里*10是为了与msg.value当中18位小数一致
        return uint(price * 1e10);
    }

    function getVestion()internal view returns (uint){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    //为了将msg.value的值从ETH转成USD
    function getConversionRate(uint ethAmount)internal view returns(uint){
        //来获得ETH价格
        uint ethPrice = getPrice();
        //3000_000000000000000000
        //1_000000000000000000
        uint ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        //3*1e18---->即3000    表明
        return ethAmountInUsd;
    }

    // function withdraw(){

    // }
}