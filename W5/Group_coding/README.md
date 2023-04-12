## W5討論:


### 首頁 v1

![](https://i.imgur.com/LHVbCAp.png)
* 工具 : Figma 

*  標題字會使用霓虹效果，但不知道怎麼在 figma 使用出來，旁邊的 card，會有動態刮開效果，可能會使用 gif 或 animation 做。



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
1. 中獎機率低
2. 兌換真錢後保留nft
3. 中獎了，就贖回買nft的錢，然後保留原來的nft, 但如果不贖回，就可以的level up nft 
4. level up nft 變暗底
5. 嘗試去中心化的 svg 但圖就不會太複雜


---
### 實作
#### 2023.04.05 初版

<!-- * 可以花錢(可AA，使用第三方支付)買刮刮樂（刮刮樂是否有不同金額的類型）
* 刮刮樂可以對中稀有的NFT，如何對獎 / 或是刮刮樂直接是對中金額？
* NFT 可以銷毀換 ETH（有沒有可能提供不同幣種，可以使用預言機服務）
 -->
 

```
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

interface IScratchTicket {
    function scratch(uint256 tokenId) external returns (bool);
    function isScratched(uint256 tokenId) external view returns (bool);
    function burn(uint256 tokenId) external;
}

interface IScratchTicketSale {
    function buyTicket() external payable returns (uint256);
    function setPrice(uint256 price) external;
    function getPrice() external view returns (uint256);
    function withdraw() external;
    function setPayMaster(address payable payMaster) external;
}

interface IPayMaster {
    function pay(address payable recipient, uint256 amount) external;
}
```

```
NFT合約: "ScratchTicket" / 銷售合約: "ScratchTicketSale"

scratch(uint256 tokenId)：這個函數被用來刮開指定tokenId的NFT，如果這個NFT還沒有被刮過，則返回true。否則，返回false。
isScratched(uint256 tokenId)：這個函數被用來檢查指定tokenId的NFT是否已經被刮過。如果是，則返回true。否則，返回false。
--

IScratchTicketSale是ScratchTicketSale銷售合約的介面。它定義了五個函數：

buyTicket()：這個函數被用來購買一個ScratchTicket NFT。它需要支付指定的價格，並返回NFT的tokenId。
setPrice(uint256 price)：這個函數被用來設置NFT的價格。
getPrice()：這個函數被用來獲取NFT的價格。
withdraw()：這個函數被用來從銷售合約中提取資金。


--

pay(address payable recipient, uint256 amount)：這個函數被用來向指定地址支付指定的ETH金額。
```
#### 2023.04.12 update

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

   

```



