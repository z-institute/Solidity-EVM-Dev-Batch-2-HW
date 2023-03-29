# Week3-Individual 

Individual development project: Choose five or more development tools mentioned in class and write down their basic usage

--- 
## Hardhat + React 

#### 1. Open the terminal in vscode, and enter the following command.

```
git clone https://github.com/NomicFoundation/hardhat-boilerplate.git
cd hardhat-boilerplate
npm install
```
 You will be able to see the success screen.
![](https://i.imgur.com/DcY9jlV.png)

#### 2. Run Hardhat's testing network
Enter the following command.

```
npx hardhat node
```
You will be able to see the success screen.
![](https://i.imgur.com/R3MomQ4.png)

#### 3.Open a new terminal, go to the repository's root folder and run this to deploy your contract.

Enter the following command.
```
npx hardhat run scripts/deploy.js --network localhost
```

You can get private key and will be able to see the success screen.
![](https://i.imgur.com/yRwoyZq.png)

Finally, we can run the frontend by the following command.

> cd frontend
> npm install
> npm start


----

## Infura

Infura saves you time on building and managing your own Ethereum client.For example, you don't have to run your own node, use Infura and web3.js to call contracts.
#### 1. Register at https://www.infura.io/zh and confirm    your email address

![](https://i.imgur.com/f8GyGsc.png)

#### 2.Create your project
Click 'CREATE NEW API KEY', choose network and input project name.

![](https://i.imgur.com/VxofWy5.png)
![](https://i.imgur.com/G0vCs3o.png)

#### 3.Obtain the API key, API secret, and endpoint
Endpoint serves as the entry point to the JSON-RPC API
![](https://i.imgur.com/cPrUD1e.png)

![](https://i.imgur.com/5AW7ShI.png)


Use Infura to initialize web3.js and retrieve account balance information.

---
## OpenZeppelin
OpenZeppelin is an open-source smart contract development tool built on top of EVM, enabling developers to securely develop and manage smart contracts and Dapps."

#### 1.Install openzeppelin   
Make sure you have the latest version of [NodeJS](https://nodejs.org/en/download) installed, and run the following command:

` npm install @openzeppelin/contracts`

![](https://i.imgur.com/oZiA5a2.png)

Once installed, you can use the contracts in the library by importing them.

#### 2. Open remix
https://remix.ethereum.org/

Open new file  and build up file name+.sol

![](https://i.imgur.com/zKIdc42.png)
#### 3. Quickly build a smart contract.

There are two ways to search smart contract we want:
1.Use https://docs.openzeppelin.com/contracts/4.x/erc20 to find examples.
2.Search from https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts, it provides all kind of strong types smart contracts.

Then, copy code you want and change it.
![](https://i.imgur.com/PIm5TBS.png)



![](https://i.imgur.com/u3bKi7v.png)


We can research update contracts anytime on github!


##### Source:
https://blog.csdn.net/weixin_43411585/article/details/105338333
https://github.com/OpenZeppelin/openzeppelin-contracts

----

### Remix IDE

Click into plugin
![](https://i.imgur.com/jCAH8un.png)

By using Remix IDE with vscode-Local during development, real-time compilation is possible, which makes it convenient to fix errors.

![](https://i.imgur.com/dNAIZwE.png)



**Solidity Metrics** and **Solidity Visual Developer** are both utilities that can help generate reports related to the creation of smart contracts

**Solidity Contract Flattener** is a tool that combines multiple contract files into one, making it easier to imports many sources at once.

----
### Tenderly

#### 1. Register at https://tenderly.co/ and create a fork
![](https://i.imgur.com/733ygPv.png)

Click 'Fork a network'
![](https://i.imgur.com/UGiFK5A.png)

Input a name and click Create. Please open the **Use the Latest Block** to get **the most recent** block. 
 
![](https://i.imgur.com/jkCfOpR.png)


If you want to fork at a specific past time block, move the circle to the left and enter the desired block number.

![](https://i.imgur.com/9g33N48.png)

#### 2.Copy the RPC URL for the forked node

![](https://i.imgur.com/k4TJ66o.png)

#### 3. Connect Metamask
Add Network and paste the RPC URL

You can search Chain ID by link
https://chainlist.org/
ps: Don't paste the same Chain ID ,or you can't click "save". 
For example, Ethereum Mainnet ->Ethereum Fork

![](https://i.imgur.com/siIOGeo.png)
![](https://i.imgur.com/Ky2G2Zf.png)


Now, you can simulate operations using the fork.
## What aspects we should be considered when we are developing a secure smart contract?

### ConsenSys
There are several suggestions are made for developers who need to pay attention to the following aspects to avoid these issues:

1. Try to avoid external calls to malicious code.
2. Carefully the use of "send()", "transfer()", and "**call.value()**".
3. Prefer to use a pull approach rather than a push approach for external contracts.
4. Mark untrusted contracts.
5. Use **assert()** to trigger assertion protection when the assertion condition is not satisfied, but be aware that it often needs to be combined with other techniques, and use **assert()** and **require()** correctly.
6. Be careful with rounding in integer division.
7. Ether can be forced to be sent to an account, and an attacker can create a contract with just 1 wei and then call selfdestruct(victimAddress).
8. Lock the program to a specific compiler version.
9. Differentiate between functions and events.
10. Keep the "**Fallback function**" as simple as possible.
11. Avoid prematurely releasing user information to protect privacy.
12. Do not assume that the contract balance is zero when it is created.
13. In the design and writing phase of the smart contract, we can browse [**known attacks**](https://consensys.github.io/smart-contract-best-practices/attacks/) to familiar attack.
14. Consider Circuit Breakers, Speed Bumps and Rate Limiting to prepare for failure of predictable failures.
16. Make good use of [**tools**](https://consensys.github.io/smart-contract-best-practices/security-tools/) to test and improve code quality.
17. Developers should prepare for failure, such as they set up " [**Bug Bounty Program**](https://consensys.github.io/smart-contract-best-practices/bug-bounty-programs/) to attract others to review the code.

---
###     Flash loan-funded price oracle attack.

Recently, several security risks that may arise in DeFi, including flash loan attacks, centralized price oracles, and other risks that may lead to fund loss and market fluctuations.

To improve the security of the DeFi ecosystem, here are some key solutions:

1.  Strengthen the security of smart contracts
2.  Increase decentralization
3.  Improve the security of transactions
4.  Use more reliable price oracles. For example, using multiple price oracles to determine the average price, or using decentralized oracles.

---

### Blockchain oracles

Oracles are third-party services that provide data to smart contracts on a blockchain. Smart contracts are self-executing programs that run on a blockchain, and they require reliable and accurate data to function properly.

Blockchain oracles provide this data by connecting off-chain data sources, such as websites or APIs, to the blockchain. They retrieve data from these sources and deliver it to the smart contract in a secure and trustless pattern.

Chainlink network, which is a decentralized network of oracles that can be used to connect smart contracts to external real-world data sources. It can use on insurance, enterprise, sustainability, dynamic NFTs and gaming,

 


---
### Summary

According to three articles, I conclude several suggestions for avoiding attack problems.

Developers code focus on readability, simple and clear. When developer use clear variable and function names, and use an easily understandable code structure so that the contract ca to n be more easily maintained and upgraded. In the other word, they ensure that the code can be easily extended and upgraded to meet future needs and security issues.

To prevent more and more Flash loan-funded price oracle attack, developers can use blockchain oracle services like Chainlink to obtain reliable, decentralized price data to reduce problems caused by the failure of centralized price oracles.

In summary, developers must follow the best practices of secure design and coding, the article also provide a lot of examples of good and bad code patterns to understand easily.
Developer includes use automated testing tools and manual testing techniques, invite others to review the code, and regularly update and maintain the contract to ensure the security and reliability of smart contracts.


----

##### Source:
https://github.com/ConsenSys/smart-contract-best-practices/blob/master/README-zh.md
https://insights.glassnode.com/defi-attacks-flash-loans-centralized-price-oracles/
https://chain.link/education/blockchain-oracles





---

# Group3 HW
## Implement a Mainnet fork with Hardhat/Ganache-cli 
Run a local Ethereum Mainnet fork with Ganache-cli and connect MetaMask, following the steps below:
### Hardhat

#### 1. Register at https://www.alchemy.com/, go to Apps and click "VIEW KEY" to get the API key.


 ![](https://i.imgur.com/w3mIehN.png)


##### 2. Open the terminal in vscode, and enter the following command.

`npx hardhat node --fork https://eth-mainnet.alchemyapi.io/v2/<key>`


#### 3. You may encounter errors and solutions were provided: 

![](https://i.imgur.com/A9Yq1wi.png)


Enter the following command:

`npm install --save-dev @nomicfoundation/hardhat-toolbox` 
`
When you see the following screen:
    
  ![](https://i.imgur.com/OBKw6Hw.png)
    
Enter the the following command again: 
    
`npx hardhat node --fork https://eth-mainnet.alchemyapi.io/v2/<key>`
    
    
   
 The success screen.
 
![](https://i.imgur.com/Q7efQxa.png)

Congratulations on solving the error!!! 

 ####  4. Open MetaMask and select 'localhost 8545'.
  
If you didn't show localhost 8545, go to advanced and open the test network.
  
 ![](https://i.imgur.com/Zo9ObJc.png)![](https://i.imgur.com/hurkM2l.png)


   #### 6. Connect MetaMask 
Choose **import account** and paste in a private key


   ![](https://i.imgur.com/SycrFhk.png)
    
The import will be successful!

   ![](https://i.imgur.com/iegeTIT.png)


### Ganache-cli
#### 1. Open the terminal in VSCode and enter the following command:

`npm install ganache --global`    


 Next   


`ganache-cli -d -f https://eth-mainnet.g.alchemy.com/v2/<key> -p 8545`
 
    
#### 2. You may encounter errors and solutions were provided:

![](https://i.imgur.com/WFeuTJS.png)
    
    
Enter the following command:
    
    Get-ExecutionPolicy
  
    Set-ExecutionPolicy Unrestricted
    
 
 Enter the the following command again:
     
     ganache-cli -d -f https://eth-mainnet.g.alchemy.com/v2/<key> -p 8545
    
  
  You will be able to see the success screen.
     ![](https://i.imgur.com/uWvqyDr.png)

#### 3. Connect MetaMask 
Choose **import account** and paste in a private key

The import will be successful.

  ![](https://i.imgur.com/Lb9VJT3.png)

---
    ### [zerodev](https://demo.zerodev.app/)

![](https://i.imgur.com/3b9HbEb.png)

ZeroDev offers smart wallets as a service, powered by account abstraction (AA). This is accomplished through five product pillars:

- A set of smart wallet factories for creating smart wallets from any authentication methods, including private keys, RPC providers, OAuth/JWT, biometrics, etc.
- A smart contract wallet kernel for building custom AA wallets on top, along with a set of wallet plugins for common smart wallet features such as session keys, subscriptions, etc.
- Ethers and Wagmi SDKs for interacting with smart wallets.
- A gas sponsoring policy engine for setting up fine-grained gas sponsoring policies, such as "only sponsor up to 0.01 ETH worth of gas for each user for interacting with contract X."
- A meta bundler network that spreads AA transactions across multiple bundler providers to ensure high uptime.

If we design function to manage private keys for users, we can use ZeroDev to create AA wallets.

```
import { getZeroDevSigner, getPrivateKeyOwner } from '@zerodevapp/sdk'

const signer = await getZeroDevSigner({
  projectId: "<project id>",
  owner: getPrivateKeyOwner("<private key>"),
})
```
--

According to [demo](https://demo.zerodev.app/), there are three ways to use ZeroDev:


- **Pay Gas for Users**: With ZeroDev, you can pay gas for your users, so they don't have to buy ETH before using your app.
```
Note how our account is identified as a "contract" by the block explorer. 
This is because in account abstraction, all accounts are smart contract accounts.
```
Click the button to gas-free.
![](https://i.imgur.com/a0yAXdH.png)

- **Bundle Transactions**: With ZeroDev, you can execute multiple transactions as a single transaction, so you get to save on confirmation time and gas cost. It's also safer because these transactions either all execute or all revert, no in-between, which is a property known as "atomicity".You can see the demo screen and code.


![](https://i.imgur.com/Fp3RBT5.png)

```
// signer is a ZeroDevSigner
// This will mint two NFTs at a time
await signer.execBatch([
  {
    to: nftAddress,
    data: nftContract.interface.encodeFunctionData("mint", [address]),
  },
  {
    to: nftAddress,
    data: nftContract.interface.encodeFunctionData("mint", [address]),
  },
])
```

- **NFT Subscription**:Click "Subscribe" to subscribe to an NFT collection, then click "Release" to receive an NFT. Note that the "Release" is sent by the NFT creator, showing that your user can passively pay and receive NFTs.
![](https://i.imgur.com/8H0sD28.png)

These transactions record in Polygonscan Mumbai.
![](https://i.imgur.com/Ubb8yAc.png)


--


### [stackup](https://www.stackup.sh/)

![](https://i.imgur.com/9UFU1pa.jpg)

Stackup makes it easy to build custom web3 transactions flows and wallets using ERC-4337


Stackup provides a fully managed paymaster service. We charge you the gas at the end of the month, so you only need to worry about the user experience.


Stackup's account abstraction infrastructure makes it easy to bundle transactions together, turning complex sequences of transactions into simple one-click experiences for your users.


![](https://i.imgur.com/3uIbfzi.png)

![](https://i.imgur.com/sTN87cc.jpg)

In the end, we can download the following command to get ERC-4337 Examples repository :


`git clone https://github.com/stackup-wallet/erc-4337-examples.git`
 

![](https://i.imgur.com/ycFpysQ.png)
