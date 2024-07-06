// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import {ERC20Generator} from "./TokenSale.sol";
contract LookUpContract {
    struct ERC20Token {
        uint256 tokenID;
        address owner;
        uint256 tokenSupply;
        string tokenName;
        string tokenSymbol;
        string tokenAddress;
        string tokenTxHash;
        string tokenCreateDate;
    }

    address payable contractOwner =
        payable(0x401f5a824A7FB97C97EFA151D525A55CD65fB7f3);
    uint256 public listingPrice = 0.025 ether;

    mapping(uint256 => ERC20Token) private erc20Tokens;
    uint256 public _tokenIndex;

    event ERC20TokenListed(
        uint256 indexed id,
        address indexed owner,
        string indexed token
    );

    modifier onlyOwner() {
        require(
            msg.sender == contractOwner,
            "only owner can can change the listing price"
        );
        _;
    }

    function createERC20Token(
        address _owner,
        uint256 _tokenSupply,
        string memory _tokneName,
        string memory _tokenSymbol,
        string memory _tokenAddress,
        string memory _tokenTxHash,
        string memory _tokenCreatedDate
    ) external payable returns (ERC20Generator) {
        _tokenIndex++;
        uint256 _tokenId = _tokenIndex;
        ERC20Token storage erc20Token = erc20Tokens[_tokenId];
        erc20Token.tokenID = _tokenId;
        erc20Token.owner = _owner;
        erc20Token.tokenSupply = _tokenSupply;
        erc20Token.tokenName = _tokneName;
        erc20Token.tokenSymbol = _tokenSymbol;
        erc20Token.tokenAddress = _tokenAddress;
        erc20Token.tokenTxHash = _tokenTxHash;
        erc20Token.tokenCreateDate = _tokenCreatedDate;
        ERC20Generator test = new ERC20Generator(
            _tokenSupply,
            _tokneName,
            _tokenSymbol
        );
        emit ERC20TokenListed(_tokenId, _owner, _tokenAddress);
        return (test);
    }
    function getAllERC20Tokens() public view returns (ERC20Token[] memory) {
        ERC20Token[] memory tokens = new ERC20Token[](_tokenIndex);
        for (uint256 i = 1; i <= _tokenIndex; i++) {
            tokens[i - 1] = erc20Tokens[i];
        }
        return tokens;
    }
    function getERC20Token(
        uint256 _tokenId
    ) public view returns (ERC20Token memory) {
        return erc20Tokens[_tokenId];
    }

    function getUserERC20Tokens(
        address _owner
    ) public view returns (ERC20Token[] memory) {
        ERC20Token[] memory tokens = new ERC20Token[](_tokenIndex);
        uint256 j = 0;
        for (uint256 i = 1; i <= _tokenIndex; i++) {
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

    function updateListingPrice(
        uint256 _price,
        address owner
    ) public payable onlyOwner {
        require(
            contractOwner == owner,
            "only owner can change the listing price"
        );
        listingPrice = _price;
    }
    function withdraw() public payable onlyOwner {
        require(address(this).balance > 0, "Contract has no balance");
        require(payable(msg.sender).send(address(this).balance));
    }
    function getContractBalance() external view onlyOwner returns (uint256) {
        return address(this).balance;
    }
}
