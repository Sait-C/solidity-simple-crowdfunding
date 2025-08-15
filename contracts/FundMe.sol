// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

// Get funds from users
// Withdraw funds
// Set a minimum funding value in USD

import { PriceConverter } from "./PriceConverter.sol";

error NotOwner();

// what happens if someone sends this contract ETH without calling the fund function
// receive()
// fallback()


contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFounded) addressToAmountFunded;

    address public immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        // Allow users to send $
        // Have a minimum $ sent
        require(msg.value.getConversationRate() >= MINIMUM_USD, "did not send anough eth"); // 1e18 = 1 ETH = 1 * 10 ** 18
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // reset array
        funders = new address[](0);
        // withdraw the funds

        // transfer
        // payable(msg.sender).transfer(address(this).balance);
        // send
        /* bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send failed"); */
        // call (recommended in most case) (returns (bool callSuccess, bytes memory dataReturned))
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner() {
        if(msg.sender != i_owner) { revert NotOwner(); }
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}