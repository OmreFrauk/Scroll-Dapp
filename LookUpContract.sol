// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract LookUpContract {
    struct ERC20Token {
        uint256 tokenID;
        address owner;
        string tokenSupply;
        string tokenName;
        string tokenSymbol;
        string tokenAddress;
        string tokenTxHash;
        string tokenCreateDate;
    }

    address payable public contractOwner =
        payable(0x401f5a824A7FB97C97EFA151D525A55CD65fB7f3);
    uint256 public listingPrice = 0.025 ether;

    ERC20Token[] private erc20Tokens;

    event ERC20TokenListed(
        uint256 indexed id,
        address indexed owner,
        string indexed tokenAddress
    );

    modifier onlyOwner() {
        require(
            msg.sender == contractOwner,
            "Only owner can call this function"
        );
        _;
    }

    function createERC20Token(
        address _owner,
        string memory _tokenSupply,
        string memory _tokenName,
        string memory _tokenSymbol,
        string memory _tokenAddress,
        string memory _tokenTxHash,
        string memory _tokenCreateDate
    )
        external
        payable
        returns (
            uint256,
            address,
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
        require(msg.value >= listingPrice, "Insufficient listing price");

        uint256 _tokenId = erc20Tokens.length + 1;
        erc20Tokens.push(
            ERC20Token({
                tokenID: _tokenId,
                owner: _owner,
                tokenSupply: _tokenSupply,
                tokenName: _tokenName,
                tokenSymbol: _tokenSymbol,
                tokenAddress: _tokenAddress,
                tokenTxHash: _tokenTxHash,
                tokenCreateDate: _tokenCreateDate
            })
        );

        emit ERC20TokenListed(_tokenId, _owner, _tokenAddress);
        return (
            _tokenId,
            _owner,
            _tokenSupply,
            _tokenName,
            _tokenSymbol,
            _tokenAddress
        );
    }

    function getAllERC20Tokens() public view returns (ERC20Token[] memory) {
        return erc20Tokens;
    }

    function getERC20Token(
        uint256 _tokenId
    ) public view returns (ERC20Token memory) {
        return erc20Tokens[_tokenId - 1];
    }

    function getUserERC20Tokens(
        address _owner
    ) public view returns (ERC20Token[] memory) {
        uint256 count = 0;
        for (uint256 i = 1; i <= erc20Tokens.length; i++) {
            if (erc20Tokens[i].owner == _owner) {
                count++;
            }
        }

        ERC20Token[] memory tokens = new ERC20Token[](count);
        uint256 j = 0;
        for (uint256 i = 1; i <= erc20Tokens.length; i++) {
            if (erc20Tokens[i].owner == _owner) {
                tokens[j] = erc20Tokens[i];
                j++;
            }
        }
        return tokens;
    }

    function getListingPrice() public view returns (uint256) {
        return listingPrice;
    }

    function updateListingPrice(uint256 _price) public onlyOwner {
        listingPrice = _price;
    }

    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "Contract has no balance");
        (bool success, ) = contractOwner.call{value: balance}("");
        require(success, "Transfer failed");
    }

    function getContractBalance() external view onlyOwner returns (uint256) {
        return address(this).balance;
    }
}
