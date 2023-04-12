// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ScratchCardNFT is Ownable, ERC1155, ERC721Enumerable {
    using Strings for uint256;

    uint256 public tokenId = 1;
    uint256 public winningPrice;
    address public erc20TokenAddress;
    address public erc1155ContractAddress;
    address public nftContractAddress;

    event NFTGenerated(uint256 tokenId, address owner);

    constructor(
        address _erc20TokenAddress,
        address _erc1155ContractAddress,
        address _nftContractAddress,
        uint256 _winningPrice
    ) ERC1155("") ERC721("ScratchCardNFT", "SCNFT") {
        erc20TokenAddress = _erc20TokenAddress;
        erc1155ContractAddress = _erc1155ContractAddress;
        nftContractAddress = _nftContractAddress;
        winningPrice = _winningPrice;
    }

    // 刮刮樂功能
    function scratchCard() external {
        // 每10人生成一個新NFT
        if (tokenId % 10 == 0) {
            require(
                IERC20(erc20TokenAddress).balanceOf(address(this)) >= winningPrice,
                "Not enough winning prize"
            );
            IERC20(erc20TokenAddress).transfer(msg.sender, winningPrice);
        }
        // 否則可以將刮刮樂的參與次數換成升級NFT
        else {
            // 取得ERC1155合約的授權
            ERC1155(erc1155ContractAddress).burn(msg.sender, tokenId, 1);
            // 取得ERC721合約的授權
            ERC721(erc721ContractAddress).transferFrom(msg.sender, address(this), tokenId);
            tokenId++;
            // 生成新NFT
            ERC721(erc721ContractAddress).mint(msg.sender, tokenId);
            emit NFTGenerated(tokenId, msg.sender);
        }
    }

    // 設定中獎NFT的價格
    function setWinningPrice(uint256 _winningPrice) external onlyOwner {
        winningPrice = _winningPrice;
    }

    // 從合約中提領ERC20代幣
    function withdrawERC20(address _to) external onlyOwner {
        uint256 balance = IERC20(erc20TokenAddress).balanceOf(address(this));
        IERC20(erc20TokenAddress).transfer(_to, balance);
    }
