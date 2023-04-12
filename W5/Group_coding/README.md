# (week5) 團體作業


### 首頁 v1

![](https://i.imgur.com/LHVbCAp.png)

* 繪製工具：Figma
* 標題字會使用霓虹效果，但不知道怎麼在 figma 使用出來，旁邊的 card，會有動態刮開效果，可能會使用 gif 或 animation 做。

--


### 上禮拜修正:
* 每多10人進來刮，就生成一個NFT
* 預言機保留至最後時現階段決定
* interface修改
* 輸出固定量NFT的實現

### 新增功能修改提案:
1. 是否使用靈魂綁定的功能，level up?
2. svg?
3. 不同token URI回傳不同張的nft?
4. 同樣nft有不同的變化，兌換真錢之前/之後有不同的圖片?
5. 兌換真錢之後nft不會消失?

### 討論結果
1. 中獎機率低（20%-30%）
2. 兌換真錢後保留 nft
3. 中獎了，就贖回買 nft 的錢，然後保留原來的 nft, 但如果不贖回，就可以 level up nft 
4. 兌換真錢後，nft 變暗底
5. 嘗試去中心化的 svg 但圖就不會太複雜

```
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


// 設定中獎NFT的價格
function setWinningPrice(uint256 _winningPrice) external onlyOwner {
    winningPrice = _winningPrice;
}

// 從合約中提領ERC20代幣
function withdrawERC20(address _to) external onlyOwner {
    uint256 balance = IERC20(erc20TokenAddress).balanceOf(address(this));
    IERC20(erc20TokenAddress).transfer(_to, balance);
}
```
