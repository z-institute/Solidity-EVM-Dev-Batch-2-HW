## 寫一個代幣合約，可以用 USDT 買到一個代幣、查到合約現有 USDT 餘額、與提款，提交完成程式碼，並附上成功買到代幣，查餘額跟提款在 remix 的截圖
### 1. 寫一個USDT智能合約，發布USDT

因為USDT從我的帳號轉出，用remix UI方式，設定一個假的USDT合約
![](https://i.imgur.com/AILEsqF.png)

![](https://i.imgur.com/1mzPlMq.png)
 複製地址到My Contract
 ![](https://i.imgur.com/O3atamU.png)

### 2. 寫可以用 USDT 買到一個代幣合約
##### 需先授權使用USDT，才能mint
![](https://i.imgur.com/bGsMAxv.png)
#### code
![](https://i.imgur.com/MPMtq75.png)

#### 查到合約現有 USDT 餘額
![](https://i.imgur.com/GPCaMHH.png)
![](https://i.imgur.com/qCHHKjf.png)
#### 提款
![](https://i.imgur.com/0A83Mfj.png)
![](https://i.imgur.com/XJTvMd8.png)



---

## 寫一個 NFT 合約，需要同時付以上的 ERC20 代幣加上 0.1 ETH 才能 mint 到，並且可以更新 token URI，每個地址只能 mint 5 個，提交完成程式碼，並附上截圖

### 分解需求:
NFT + 足夠的 (ERC20代幣 & ETH) + 每個最大限mint * 5 (mint counts) + 更新 token URI

### 程式碼
#### 1.NFT初始化
![](https://i.imgur.com/7q3rwV0.png)

#### 2.需要足夠的ERC20代幣 & ETH + 每個最大限mint supply 5個(含mint counts)
![](https://i.imgur.com/sFzaFwH.png)

#### 3. 更新mint counts + index + token URI

![](https://i.imgur.com/X0IJXL9.png)

* 資料來源:https://github.com/z-institute/SBF-BONK/blob/main/contracts/CyberBonk.sol


---
## [<Swap/> with Uniswap](https://azfuller20.medium.com/swap-with-uniswap-wip-f15923349b3d)
Uniswap is a popular decentralized finance (DeFi) protocol.

### The <Swap/> widget
The <Swap/> widget is a tool built on the Ethereum blockchain using the scaffold-eth framework that allows users to exchange one ERC20 token for another using the Uniswap protocol. Uniswap is a popular decentralized finance (DeFi) protocol that provides automated liquidity for token swaps.

### Estimating trades with the SDK 

To estimate trades with the Uniswap SDK, the <Swap/> widget first instantiates the required Tokens, which can be obtained from a token list following the Token List standard. The corresponding Pair data is then fetched from the local Ethereum network, which can be set up using the mainnet forking option provided by Hardhat (or Buidler). With this data, the <Swap/> widget can calculate and present to the user an estimated trade, including the expected amount of tokens to be received and the price impact of the trade.

### Summary
Once the user confirms the trade, the <Swap/> widget prepares and sends the appropriate transaction to the Ethereum network to execute the trade. It's important to note that the Uniswap SDK does not handle the transaction preparation and sending, and the developer needs to implement this functionality separately in their application.

The <Swap/> widget also supports token lists, which are curated lists of ERC20 tokens following a standard JSON schema. Token lists are hosted by different organizations and can be used to filter high-quality tokens from scams and fakes. The <Swap/> widget uses the Uniswap default token list by default, but it can also accept any token list JSON URI following the Token List standard. The token lists can also include token logo URLs, making it easy to display token logos in the frontend of the <Swap/> widget.

## [Uniswapper](https://docs.scaffoldeth.io/scaffold-eth/examples-branches/defi/uniswapper)

### 1.Open the terminal in vscode, and enter the following command.

```
git clone -b uniswapper https://github.com/scaffold-eth/scaffold-eth-examples.git uniswapper-scaffold

cd uniswapper-scaffold
```

```
yarn install
```
```
yarn start
```

![](https://i.imgur.com/cd6W5J8.png)
```
cd scaffold-eth
yarn chain
```
### 2. Start a local networK
You should see something like this:
![](https://i.imgur.com/f2jcJGR.png)


### 3. Deploy your first smart contract

We have our local network running, we can deploy smart contracts to it. Run the following command in a **new** terminal window.
```
cd scaffold-eth
yarn deploy

```
You should see something like this:
![](https://i.imgur.com/xhGbADz.png)



### 4. Register at alchemyapi.io , go to Apps and click “VIEW KEY” to get the API key for mainnet.
 ![](https://i.imgur.com/w3mIehN.png)
 
 
 
### 5. Replace the Infura URL with an Alchemy URL with your API key
![](https://i.imgur.com/02gzdmL.png)


Replace the Infura URL with an Alchemy URL with your API key into the fork script on **line 28** of /packages/hardhat/package.json


### 6. Open http://localhost:3000 to see the app

if you open that url on your browser, you should see the following:

![](https://i.imgur.com/WWdpcCT.png)



