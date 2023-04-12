mport "./// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";

contract MyNFT is Ownable, ERC1155 {
    
    uint256 public constant MINT_MY_TOKEN_PRICE = 1;
    uint256 public constant MINT_ETH_PRICE = 0.1 ether;
    address private constant _tokenAddress =
        0x8ec80b506951302Cc1908289FD7F427740F9b466;
    uint256 public constant PERSONAL_MAX_LIMIT = 5;
    uint256 public constant MAX_SUPPLY = 500;
    uint256 private index = 1;

    mapping(address => uint256) private mintedCounts;

    constructor(string memory _uri) ERC1155(_uri) {}

    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function mint(uint8 amount) external payable {
        uint256 _index = index;
        require(_index < MAX_SUPPLY, "supply limit");
        require(
            MyTokenUSDT(_tokenAddress).allowance(_msgSender(), address(this)) >=
                MINT_MY_TOKEN_PRICE * amount,
            "Not enough token"
        );
        require(
            msg.value >= MINT_ETH_PRICE * amount,
            "Not enough ETH"
        );
        require(
            mintedCounts[_msgSender()] + amount <= PERSONAL_MAX_LIMIT,
            "Can only mint five NFTs per address"
        );

        MyTokenUSDT(_tokenAddress).transferFrom(
            _msgSender(),
            address(this),
            MINT_MY_TOKEN_PRICE * amount
        );

        _mint(_msgSender(), 0, amount, "");

        // Update minted counts
        mintedCounts[_msgSender()] += amount;

        // Update index
        unchecked {
            index += amount;
        }
    }

    // returns the metadata uri for a given id
    function uri(uint256 _id) public view override returns (string memory) {
        return string(abi.encodePacked(super.uri(_id), Strings.toString(_id)));
    }

    function compare(string memory str1, string memory str2)
        private
        pure
        returns (bool)
    {
        return
            keccak256(abi.encodePacked(str1)) ==
            keccak256(abi.encodePacked(str2));
    }

}
