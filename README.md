# Ethereum Crowdfunding Smart Contract

A decentralized crowdfunding platform built on Ethereum that allows users to contribute funds and project owners to manage fundraising campaigns.

## Features

- **Minimum Contribution**: Set minimum contribution amount in USD (currently 5 USD)
- **Price Conversion**: Real-time ETH/USD price conversion using Chainlink Price Feeds
- **Fund Management**: 
  - Users can contribute ETH
  - Contract owner can withdraw funds
  - Automatic fund tracking per contributor
- **Fallback Handling**: Supports direct ETH transfers through receive() and fallback() functions

## Smart Contracts

### FundMe.sol
The main contract that handles crowdfunding functionality:
- Fund collection with minimum USD requirement
- Withdrawal mechanism for the contract owner
- Tracking of funders and their contributions
- Owner-only access control for critical functions

### PriceConverter.sol
A library that provides ETH/USD price conversion functionality:
- Uses Chainlink Price Feeds for accurate price data
- Converts ETH amounts to USD equivalent
- Implements version checking and price validation

## Technical Details

### Dependencies
- Solidity ^0.8.7
- Chainlink Contracts (for price feeds)

### Key Functions

#### FundMe Contract
- `fund()`: Accept contributions (minimum 5 USD equivalent in ETH)
- `withdraw()`: Allow owner to withdraw all funds
- `receive()` and `fallback()`: Handle direct ETH transfers

#### PriceConverter Library
- `getConversationRate()`: Convert ETH amount to USD
- `getPrice()`: Fetch current ETH/USD price from Chainlink
- `getVersion()`: Get price feed version

### Price Feed
Uses Chainlink ETH/USD Price Feed at address: `0x694AA1769357215DE4FAC081bf1f309aDC325306`

## Security Features

- Owner-only withdrawal
- Constant minimum USD requirement
- Price feed validation
- Require statements for fund validation
- Custom error handling

## Usage

1. Deploy the `FundMe` contract
2. Users can contribute by calling the `fund()` function with ETH value
3. Contract owner can withdraw funds using `withdraw()`
4. Minimum contribution is 5 USD equivalent in ETH

## Development

### Prerequisites
- Ethereum development environment
- Access to Ethereum testnet or local network
- Chainlink Price Feed contract access

### Testing
The contract includes various safety checks:
- Minimum contribution validation
- Owner-only access control
- Price feed validation
- Successful fund transfer verification

## License

MIT License

## Note

This contract uses Chainlink Price Feeds for ETH/USD conversion. Make sure you're using the correct Price Feed address for your network. 