# 個人開發實作 
任選上課時提到的五個（或以上）開發工具，並照著 Readme 試用看看，寫下簡易用法，實際上上課時提到的工具都屬於常用範圍，建議可全部自己試跑一次過。部分工具需搭配智能合約，可等上完智能合約課程後再使用。

--- 

### 1. VS code

<-- start -->

在 vscode 中安裝相關 Extension

1. Solidity

![](https://i.imgur.com/SSOpHYt.png)

<!-- ![](https://i.imgur.com/IkG6JBd.png) -->

1. Solidity Debugger

![](https://i.imgur.com/v1ckR5R.png)

3. Solidity Metrics

![](https://i.imgur.com/Q2M2hKj.png)

4. Solidity Visual Developer

![](https://i.imgur.com/8jCNgnU.png)

<-- end -->

---


### [2. solidity coverage](https://github.com/sc-forks/solidity-coverage/blob/master/HARDHAT_README.md)

hardhat提供了一個查看當前我们編寫的測試代碼的功能覆蓋率的插件，叫做solidity-coverage，專門用於可靠性測試的代碼覆蓋率。

<--- start --->

Install
```
npm install --save-dev solidity-coverage
```
新增 hardhat.config.ts 檔案
```
import "solidity-coverage"
```
![](https://i.imgur.com/49SUxQn.png)

到 [etherscan](https://etherscan.io/address/0x4f3083bf6bBA8B0482406B47d19cC26e8a23319d#code) 抓一個合約來做測試代碼覆蓋率

![](https://i.imgur.com/eRy1Dm2.png)

輸入下面指令，獲得測試結果

```
npx hardhat coverage  
```
![](https://i.imgur.com/Xu9KE6B.png)

<--- end --->

---


### [3. chainlink oracle](https://chain.link/)

在區塊鏈中，數據的公正性與獨立性至關重要，而ChainLink正是解決了中心化問題的去中心化預言機。

所以可以把ChainLink想成提供數據服務的平台，只不過是更加及時的資訊，如各類加密貨幣價格，亦提供各項數據服務。

<--- start --->

打開官網

![](https://i.imgur.com/NbOl3Q3.png)

從[這一頁](https://docs.chain.link/getting-started/consuming-data-feeds)來觀察如何透過 chainlink 獲取 price 

![](https://i.imgur.com/ELZsU2r.png)


```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceConsumerV3 {
    AggregatorV3Interface internal priceFeed;

    /**
     * Network: Sepolia
     * Aggregator: BTC/USD
     * Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
     */
    constructor() {
        priceFeed = AggregatorV3Interface(
            0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        );
    }

    /**
     * Returns the latest price.
     */
    function getLatestPrice() public view returns (int) {
        // prettier-ignore
        (
            /* uint80 roundID */,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }
}
```

發現 function 中的這一段，能透過換[地址](https://docs.chain.link/data-feeds/price-feeds/addresses)，獲取不同幣種之間的匯率

```
constructor() {
    priceFeed = AggregatorV3Interface(
        ...addresses...
    );
}
```
![](https://i.imgur.com/WUBYgVX.png)


---

### [4. Hardhat + React template](https://github.com/NomicFoundation/hardhat-boilerplate)

<--- start --->

輸入以下指令

```
git clone https://github.com/NomicFoundation/hardhat-boilerplate.git
cd hardhat-boilerplate
npm install
```

跑完後再輸入以下指令
```
<-- 因為我這裡有出錯誤，多跑了一個指令 -->
npm install --save-dev "@types/mocha@^9.1.0" "@typechain/ethers-v5@^10.1.0" "@typechain/hardhat@^6.1.2" "ts-node@>=8.0.0" "typechain@^8.1.0" "typescript@>=4.5.0"

npx hardhat node
```
![](https://i.imgur.com/3aB3mqs.png)

在 vscode 上面另開 terminal，輸入以下指令
```
cd frontend
npm install
npm start
```

因為有出錯，所以把外層的 contracts 資料夾先移到 frontend 的 src 裡面
並在 contracts 資料夾裡面新增 contract-address.json / Token.json 檔案

![](https://i.imgur.com/9i3KWJz.png)

錯誤消失，畫面出來了

![](https://i.imgur.com/0HL7P6h.png)

可以連結錢包

![](https://i.imgur.com/ujuAQBH.png)

<--- end ---->

---

### [5. Pancakeswap UI Kit](https://github.com/pancakeswap/pancake-frontend)


<--- start --->

輸入以下指令
```
git clone git@github.com:pancakeswap/pancake-frontend.git  
yarn install  
yarn dev
```

打開 http://localhost:3000/ 

![](https://i.imgur.com/Tw8QLhL.jpg)

更改 Hero.tsx 檔案的標題，成功！
接下來就可以繼續去 try 其他的元件

![](https://i.imgur.com/P4T3xNZ.png)

![](https://i.imgur.com/4rEcxWR.jpg)

<--- end --->

---
### [6. Remix 部署](https://remix.ethereum.org/#lang=en&optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.18+commit.87f61d96.js)


<-- start -->

打開 Remix IDE ( 這裡使用 chainlink 裡面的範本 )

![](https://i.imgur.com/ubIZxB2.png)

click "Solidity Compiler"，更改 compiler 環境

```
在 Compiler 環境中，有三個地方需要注意: 
- 第一個是 Compiler 版本，選擇跟你合約內的版本符合即可；
- 第二個是勾選 Auto Compile ，就不用每次更改 code 需要再去按 Compile；
- 第三個是 Enable Optimization，這個設定會跟費用有關，當你勾選並輸入1時，會讓部署 (Deploy) 費用較低，但是呼叫 (Call) 費用會較高。
  如果勾選並輸入 200 或更高時，會讓部署 (Deploy) 費用較高，但是呼叫 (Call) 費用會較低。如果你知道這個合約不會頻繁呼叫，你就可以輸入1讓部署費用降低；
  如果這個合約會頻繁呼叫，那就輸入200 或更高；如果你不確定，就不用勾選。
  Enable Optimization 後面的數字，最大值限制是(2^64-1)。
```

![](https://i.imgur.com/gbOgnbm.png)


click the "Compile HelloWorld.sol"

![](https://i.imgur.com/GHk4DHX.png)

compile 完，click "Deploy & run transactions"，選擇你要的 deploy 環境，click "Deploy"

![](https://i.imgur.com/vp4yy4o.png)

在 MetaMask 中選擇 Confirm 支付交易費用

交易完成之後會在 Remix 的 Deployed Contracts 中看到已部署的合約



---

### [7. ERC Standards](https://ethereum.org/en/developers/docs/standards/tokens/)

代幣標準是一套準則，用來管理加密代幣的運作方式。
定義了區塊鏈代幣的關鍵功能和屬性。

使用不同代幣標準開發的代幣可能不會出現在同一平台上，或是沒辦法彼此溝通或交易。如果你擁有多種加密貨幣，應該已經體會到不能在以太坊上使用 BTC 的挫折感。為了解決這個問題，我們產業想出了一個新型的代幣，稱為打包代幣。

--


<!-- ![](https://i.imgur.com/jWD6Ivt.png) -->

- [ERC-20](https://ethereum.org/en/developers/docs/standards/tokens/erc-20/) - A standard interface for fungible (interchangeable) tokens, like voting tokens, staking tokens or virtual currencies.
```
為什麼 Token 需要有 ERC20 ?
Token 只是以太坊智能合約的一種應用，可以想像這種代幣只是存在於某個智能合約中的紀錄，
這個合約上記載著每個以太坊地址擁有的 Token 數量多寡，
而每次的轉移都是呼叫原本創建 Token 合約裡面的 Function 去做改動，
亦即人們可以在創建 Token 時，可以自由訂定規則，像是我可以制定一種完全無法轉移的 Token，
但這樣的設計，Token 就變得沒有價值傳遞的意義存在，因此為了要讓代幣能擁有合理的貨幣機制，才會有 ERC20 被設立。
往後我們只要知道，若是一個 Token 符合 ERC20，即代表他是一種具有完整貨幣交易功能的代幣。
```
- [ERC-721](https://ethereum.org/en/developers/docs/standards/tokens/erc-721/) - A standard interface for non-fungible tokens, like a deed for artwork or a song.
- [ERC-777](https://ethereum.org/en/developers/docs/standards/tokens/erc-777/) - ERC-777 allows people to build extra functionality on top of tokens such as a mixer contract for improved transaction privacy or an emergency recover function to bail you out if you lose your private keys.
- [ERC-1155](https://ethereum.org/en/developers/docs/standards/tokens/erc-1155/) - ERC-1155 allows for more efficient trades and bundling of transactions - thus saving costs. This token standard allows for creating both utility tokens (such as $BNB or $BAT) and Non-Fungible Tokens like CryptoPunks.
- [ERC-4626](https://ethereum.org/en/developers/docs/standards/tokens/erc-4626/) - A tokenized vault standard designed to optimize and unify the technical parameters of yield-bearing vaults.

```
資料來源：

https://medium.com/hackoin-taiwan/ethereum-erc20-token-standard-%E4%BB%A5%E5%A4%AA%E5%9D%8A%E4%BB%A3%E5%B9%A3%E6%A8%99%E6%BA%96%E4%BB%8B%E7%B4%B9-b7bc58171021
https://academy.binance.com/zt/articles/what-are-token-standards
```