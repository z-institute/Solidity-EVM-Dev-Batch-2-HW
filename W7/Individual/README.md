## [RainbowKit](https://www.rainbowkit.com/docs/installation)

RainbowKit is a React library that makes it easy to add wallet connection to your dapp. It's intuitive, responsive and customizable.

```
npm init @rainbow-me/rainbowkit@latest
```
![](https://i.imgur.com/ZiBXdiY.png)


Run
```
cd my-rainbowkit-app

npm run dev
```

![](https://i.imgur.com/r2jXb2x.png)

Open the link and show the successful screen.

![](https://i.imgur.com/HKuSFhM.png)

Rainbowkit-create-react-app

![](https://i.imgur.com/Dq8A26M.png)

RainbowKit is a React library that simplifies the process of integrating wallet connection into your decentralized application (dapp). With its intuitive interface and customizable options, RainbowKit streamlines the wallet management process and offers a range of features to enhance the user experience.

One of the standout features of RainbowKit is its **out-of-the-box wallet management** functionality, which allows for easy connection and disconnection of wallets. It also supports multiple wallets, swaps connection chains, resolves addresses to ENS, displays balances, and much more. This simplifies the process of managing wallets for your dapp, making it more accessible for users.

Another key advantage of RainbowKit is its high level of **customizability**. Users can easily adjust the UI to match their branding, choosing from a selection of pre-defined accent colors and border radius configurations. For more advanced use cases, a fully custom theme can be implemented, enabling users to render their own buttons and omit certain features. Additionally, RainbowKit comes with a built-in dark mode option.

Overall, RainbowKit provides a comprehensive solution for integrating wallet connection into your dapp, with its user-friendly interface and range of customizable options.

---
## How Flash Loans Work and Their Applications
### [Research Summary Attacking the Defi Ecosystem with Flash Loans for Fun and Profit](https://www.smartcontractresearch.org/t/research-summary-attacking-the-defi-ecosystem-with-flash-loans-for-fun-and-profit/260)

The article from Smart Contract Research summarizes a research paper that explores the potential for using flash loans to attack decentralized finance (DeFi) protocols. The paper outlines several attack scenarios, including market manipulation, oracle manipulation, and flash loan attacks on liquidity pools. It also discusses the impact of these attacks on DeFi protocols and potential countermeasures. The article concludes with a recommendation for DeFi protocols to strengthen their defenses against flash loan attacks by implementing measures such as circuit breakers and price feed safeguards.

The article outlines several use cases for flash loans in DeFi:

#### 1. Arbitrage: 
Exploiting price differences among exchanges for financial gain. This is done when the same asset has different prices on different exchanges. Before flash loans, a trader needed to hold a reserve of the asset on different exchanges, but now they can perform the trade risk-free with the loan. An example is converting DAI to SAI with MakerDAO’s migration contract, converting SAI to ETH with Uniswap, and converting ETH to DAI with Uniswap.

#### 2. Wash trading: 
Artificially inflating the trading volume of an asset to attract others to trade. Before flash loans, a trader needed to hold and use real assets to make a trade on a DEX, but now they can fake the volume by paying only the gas fee. An example is increasing the 24-hour volume by 50% on the ETH/DAI market of Uniswap for ~1300 USD.

#### 3. Collateral swapping: 
The user closes the original collateral by paying back asset x and immediately opens a new collateral position using asset y when there is a cost difference between using assets as collateral. Before flash loans, the user needed to hold asset x and y, and the locked collateral may lose its value due to the asset’s price fluctuation. With flash loans, the user can borrow asset x and y with the loan. An example is using 0.18 WETH as collateral for 20 DAI, then using a flash loan to borrow 20 DAI and get back WETH, converting 0.18 WETH for 178.08 BAT, and creating 20.03 DAI using BAT as collateral.

#### 4. Flash minting: 
Minting and immediately burning an asset so it only exists within a single transaction. This can be done anytime, and sample code is provided in the article.

![](https://i.imgur.com/THrHvl9.png)


--

### [Get Everything for Nothing: How to Use Flash Loans to Launch an Arbitrage](https://medium.com/@eigenphi/get-everything-for-nothing-how-to-use-flash-loans-to-launch-an-arbitrage-d8520827cbfe)

![](https://i.imgur.com/pY8QGJC.png)

The article explains how to use flash loans to launch an arbitrage trading strategy. It begins by defining flash loans and their unique characteristics, including how they enable borrowing and repayment within a single transaction. The tutorial then outlines the steps needed to launch an arbitrage strategy using flash loans, including identifying opportunities, executing trades, and returning the borrowed funds. The article concludes with a discussion on the risks and limitations of flash loans and provides resources for further learning.



--

### [Flash loan easy explain](https://chain.link/education-hub/flash-loans)
The article from Chainlink's Education Hub explains the concept of flash loans and their use in decentralized finance (DeFi). It begins by defining flash loans as a type of uncollateralized loan that allows users to borrow funds without providing collateral, as long as the funds are repaid within a single transaction. The tutorial then explains how flash loans are executed in DeFi protocols and their potential use cases, including arbitrage trading and collateral swapping. The article also discusses the risks and limitations of flash loans, such as the potential for market manipulation and the need for sufficient liquidity. It concludes with a discussion on the future of flash loans and their potential impact on DeFi.



--

### [Flash Loans Explained (Aave, dYdX)](https://finematics.com/flash-loans-explained/)


The article starts by defining flash loans and how they differ from traditional loans. Flash loans are uncollateralized loans that allow users to borrow funds without providing any collateral. The loans are executed in a single transaction, meaning that the borrowed funds must be repaid within the same transaction or the transaction will fail.


The article goes on to explain how flash loans work on the Ethereum blockchain. Ethereum smart contracts are used to create flash loan platforms that allow users to borrow funds from a pool of liquidity provided by other users. The borrowers pay a small fee for the loan, which is distributed to the liquidity providers.

Flash loans can be used in various ways, but here are the three most common use cases:

#### 1. Arbitrage: 
Flash loans can be used to take advantage of price discrepancies across different decentralized exchanges (DEXs). By borrowing a large sum of money through a flash loan, traders can buy and sell assets across different DEXs to make a profit on the price difference. However, traders must consider network fees, price slippage, and frontrunning risks when executing arbitrage trades.

#### 2. Collateral swaps: 
Flash loans can be used to switch collateral types in lending protocols. For example, if a borrower has an ETH-backed loan on Compound and wants to switch to BAT as collateral, they can take out a flash loan in DAI to pay off their ETH-backed loan, withdraw their ETH collateral, trade it for BAT on a DEX, and then use the BAT as collateral for a new loan on Compound. The borrower must pay a fee for the flash loan, but they avoid liquidation fees and can switch their collateral type quickly.

#### 3. Self-liquidation: 
If a borrower has a loan on a lending platform and their collateral is about to be liquidated due to a drop in asset value, they can use a flash loan to quickly repay their loan and withdraw their remaining collateral. This allows them to avoid the liquidation fee and keep a portion of their collateral. However, borrowers must be able to repay the flash loan plus fees, which may require selling some of their remaining collateral on a DEX.




The article also discusses the risks associated with flash loans, including the possibility of market manipulation and the potential for flash loan attacks. These attacks involve using flash loans to manipulate the price of a cryptocurrency, causing losses for other traders.

--
### Summary

Flash loans are a type of financial service that allows borrowers to quickly borrow funds without providing any collateral. Flash loans are typically implemented using smart contracts, allowing for the acquisition of large sums of money in a single transaction, which can then be used to execute various financial operations.

Flash loans can be used in a variety of scenarios, such as:

#### 1. Arbitrage: 
Flash loans can be used to identify price differences between different decentralized exchanges, enabling arbitrage opportunities.

#### 2. Speculation: 
Flash loans can be used for high-risk speculation within a short timeframe.

#### 3. Capital management: 
Flash loans can be used for capital management, such as providing or moving liquidity pools.

However, flash loans also carry risks and may be used for market manipulation, price attacks, and other illicit activities. Therefore, more robust and secure DeFi protocols are needed to minimize these risks. Risk management is also important in flash loans, such as considering price slippage and gas costs.

reference:
https://academy.binance.com/zt/articles/what-are-flash-loans-in-defi
[https://rekt.news/leaderboard/](https://rekt.news/leaderboard/)

---
## [Aave Flash Loan Tutorial - Finding Arbitrage](https://www.youtube.com/watch?v=Aw7yvGFtOvI)
The video uses Brownie, Solidity, and Aave to teach how to create a contract that utilizes flash loans. Flash loans are a type of DeFi technology that allows users to borrow and repay cryptocurrency within the same blockchain transaction without the need for collateral.

* Tools:

1. Brownie is a Python framework used for developing, testing, and deploying smart contracts.
2. Aave is a DeFi protocol that offers lending, depositing, and interest earning features.

The video shows that Arbitrage is the practice of buying and selling assets in different markets to take advantage of price discrepancies. In the DeFi space, flash loans can be used to execute arbitrage trades between different decentralized exchanges (DEXs) and other financial protocols.The speaker also provides some practical advice and best practices for maximizing the returns from flash loan arbitrage strategies.


* Made 3 token transfers in the video:

1. Our contract got the wrapped ETH from the Aave contract.
1. We got some aToken from Aave
1. We paid back the flash loan with a little extra

Overall, it is a useful resource for anyone interested in learning more about the emerging field of DeFi and the opportunities and challenges it presents.

--

另外Kovan不支援只能用Goerli，影片說要1ETH，但Goerli一天只給0.2，不先前累積根本沒法做。

#### 1. Install Brownie and python 

我在安裝python卡住，先run
```
py -m ensurepip --upgrade
setx PATH "%PATH%;%USERPROFILE%\AppData\Roaming\Python\Python39\Scripts"
py -m pip install --user pipx
```


將指令改成
```
py -m pip install --user pipx
py -m pipx ensurepath
```
![](https://i.imgur.com/S9g2GJA.png)


`pipx install eth-brownie`

![](https://i.imgur.com/ch4xqre.png)
在這步卡住，確定有設定環境變數，


```
git clone https://github.com/eth-brownie/brownie.git
cd brownie
python3 setup.py install
```

--
![](https://i.imgur.com/YriwwQ4.png)
I installed certain dependencies in advance with these commands --
```
python -m pip install yarl
python -m pip install bitarray
python -m pip install cytoolz
```


#### 2. `git clone https://github.com/PatrickAlphaC/aave-flashloan-mix `

#### 3. Set up
    WEB3_INFURA_PROJECT_ID =...
    ETHERSCAN_TOKEN= ..
    PRIVATE_KEY=...

**3-1. WEB3_INFURA_PROJECT_ID**
Sign up for Infura and generate an API key. Store it in the WEB3_INFURA_PROJECT_ID environment variable. 
![](https://i.imgur.com/HyJ5Mll.png)


**3-2. ETHERSCAN_TOKEN** is the API key we created on Etherscan. 
Step1: To register an account on etherscan.io, go to the account settings page and click on API-KEYs. 
![](https://i.imgur.com/tPLkk2N.png)
Step2:Then create a new API key.
![](https://i.imgur.com/qmLdlXn.png) 
Step3: Copy the new API key.
![](https://i.imgur.com/2YH4ii1.png)

**3-3. PRIVATE_KEY**

Copy the PRIVATE_KEY
![](https://i.imgur.com/Pi00Fy8.png)
