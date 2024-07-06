# Token Launchpad Project

## Overview

This project is a Token Launchpad on the Scroll ecosystem, implemented using Solidity for the smart contract. The smart contract allows users to list and retrieve ERC20 tokens.

## Smart Contract

The `LookUpContract` smart contract is written in Solidity and provides the following functionalities:

- **Listing ERC20 Tokens**: Users can create a new ERC20 token by providing necessary details and paying a listing fee.
- **Retrieving Tokens**: Users can retrieve all listed tokens or tokens owned by a specific address.
- **Managing Contract**: The contract owner can update the listing price and withdraw funds from the contract.

### Contract Structure

- **ERC20Token Struct**: Defines the structure of a token with the following fields:

  - `tokenID`: The unique identifier for the token.
  - `owner`: The address of the token owner.
  - `tokenSupply`: The total supply of the token.
  - `tokenName`: The name of the token.
  - `tokenSymbol`: The symbol of the token.
  - `tokenAddress`: The contract address of the token.
  - `tokenTxHash`: The transaction hash when the token was created.
  - `tokenCreateDate`: The date when the token was created.

- **Events**:

  - `ERC20TokenListed`: Emitted when a new token is listed.

- **Functions**:
  - `createERC20Token`: Creates a new ERC20 token and lists it.
  - `getAllERC20Tokens`: Retrieves all listed ERC20 tokens.
  - `getERC20Token`: Retrieves a specific ERC20 token by its ID.
  - `getUserERC20Tokens`: Retrieves all ERC20 tokens owned by a specific address.
  - `getListingPrice`: Returns the current listing price.
  - `updateListingPrice`: Allows the contract owner to update the listing price.
  - `withdraw`: Allows the contract owner to withdraw the contract balance.
  - `getContractBalance`: Returns the contract balance.
