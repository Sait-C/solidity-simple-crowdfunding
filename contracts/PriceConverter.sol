// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getConversationRate(uint256 ethAmount) internal returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    event Log(string message);

    function getPrice() internal returns(uint256) {
        // To get the price from data feed of chainlink we need
        // Address & ABI
        // Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // For the ABI you can copy and past interface of aggregator from github repo of chainlink and use it as abi interface
        // like this AggregatorV3Interface(address)
        // ABI ✔ (we imported directly from github)
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        // Price of ETH in terms of USD
        // 2000.00000000
        require(answer > 0, "bad price");
        emit Log("got lastest ETH/USD price");
        return uint256(answer) * 1e10;
    }

    function getVersion() internal view returns (uint256) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}