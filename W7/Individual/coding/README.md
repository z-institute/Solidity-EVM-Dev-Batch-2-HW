# 個人作業


## 跟著[這個影片](https://youtu.be/Aw7yvGFtOvI)的範例做一遍，把專案推到 Github 上，再寫下詳細步驟截圖，簡述運作原理與實作心得

使用到的工具簡介：

1. Aave，是一個去中心化的借貸系統，允許使用者在不需要中間人的情況下借入、借出和賺取加密資產的利息。

2. Brownie 是一個基於 Python 的框架，用於開發和測試智能合約。 Brownie 同時支持 Solidity 和 Vyper 合約，它甚至可以通過 pytest 提供合約測試。

3. WETH (Wrapped Ether)
    * WETH 是以太坊（Ethereum）上的一種 ERC-20 代幣，與以太坊 (ETH) 的價格一致，用戶可以隨時 1：1 贖回原始資產。
    * ETH 本身不符合 ERC-20，所以需要經過打包成 WETH 以符合 ERC-20 標準。


--

閃電貸交易圖解：

閃電貸的技術實現原理其實非常簡單，在 Aave 部署的智能合約中有一個閃電貸的函數，當該函數被調用時，用戶可從 Aave 協議中進行借款。
但這個函數的只需必須滿足一個條件，必須在同一個以太坊區塊內完成還款並附加一定的費用，要不然這筆交易就會被復原。

![](https://i.imgur.com/I3VQN8F.png)


clone 專案

```
git clone https://github.com/PatrickAlphaC/aave-flashloan-mix.git
```


下載 python

![](https://i.imgur.com/NWyuZt9.png)


這邊遇到很多問題，路徑錯誤 / 讀不到 pip 或是 pipx，最後試了很多網路上的方法才終於裝好 brownie

```
pip install eth-brownie
```

![](https://i.imgur.com/5hGkDWQ.png)


換 .env 內的環境變數

> If using metamask, you'll have to add a 0x to the start of your private key)

![](https://i.imgur.com/8fk3Ltl.jpg)

執行環境變數
```
source .env
```

因為 clone 過了，這一步省略

```
brownie bake aave-flashloan
```
kovan 已被棄用，建議用 Goerli 來測試部署
https://docs.aave.com/developers/v/2.0/deployed-contracts/deployed-contracts

```
goerli:
    aave_lending_pool_v2: "0x5E52dEc931FFb32f609681B8438A51c675cc232d"
    weth: "0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6"
```

將 goerliETH 換成 WETH

```
brownie run scripts/get_weth.py --network goerli
```

![](https://i.imgur.com/vHooQSD.png)

這裡因為 goerliEth 不夠，所以到 [Goerli PoW Faucet](https://goerli-faucet.pk910.de/) mint

![](https://i.imgur.com/ball15b.png)

執行 get_weth.py 之外，也可以使用 [uniswap](https://app.uniswap.org/#/swap?chain=mainnet) 將 goerliETH swap 成 WETH

![](https://i.imgur.com/SdcNuNL.png)

```
brownie run scripts/deployment_v2.py --network goerli  
```

一直失敗，猜想是測試幣不夠的問題，gas 相關參數設定可以參考[這頁](https://eth-brownie.readthedocs.io/en/stable/config.html#gas_price)

![](https://i.imgur.com/XnvqQnS.png)
 
 
 --

先改成用 development environment 執行

```
brownie console
>>> aave_lending_pool_v2 = "0xB53C1a33016B2DC2fF3653530bfF1848a515c8c5"
>>> flashloan = FlashloanV2.deploy(aave_lending_pool_v2, {"from": accounts[0]})
>>> WETH = Contract("0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2")
>>> accounts[0].transfer(WETH, "1 ether")
>>> WETH.transfer(flashloan, "1 ether", {"from": accounts[0]})
>>> tx = flashloan.flashloan(WETH, {"from": accounts[0]})
```

![](https://i.imgur.com/zyf9qWb.png)


--


## [rainbowkit](https://www.rainbowkit.com/docs/installation)
```
npm init @rainbow-me/rainbowkit@latest
```

進到資料夾
```
npm install @rainbow-me/rainbowkit wagmi ethers@^5
```

run 起來
```
npm run dev
```
![](https://i.imgur.com/cl5Nvhs.png)

瞬間擁有美美的串接錢包介面

![](https://i.imgur.com/UZQwEam.png)

開始改成我們要的 UI

![](https://i.imgur.com/0zRmwlj.png)
