# Group3 HW
## Implement a Mainnet fork with Hardhat/Ganache-cli 
Run a local Ethereum Mainnet fork with Ganache-cli and connect MetaMask, following the steps below:
### Hardhat

#### 1. Register at https://www.alchemy.com/, go to Apps and click "VIEW KEY" to get the API key.


 ![](https://i.imgur.com/w3mIehN.png)


##### 2. Open the terminal in vscode, and enter the following command.

`npx hardhat node --fork https://eth-mainnet.alchemyapi.io/v2/<key>`


#### 3. You may encounter erros and solutions were provided: 

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



