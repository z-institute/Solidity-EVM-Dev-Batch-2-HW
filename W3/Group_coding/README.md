# Implement a Mainnet fork with Hardhat/Ganache-cli

Run a local Ethereum Mainnet fork with Ganache-cli and connect MetaMask, following the steps below:


## 團體開發實作

### hardhat
Register at https://www.alchemy.com/, go to Apps and click "VIEW KEY" to get the API key.

 ![](https://i.imgur.com/jWdHsM4.jpg)

Open the terminal in vscode, and enter the following command.

```
npx hardhat node --fork https://eth-mainnet.alchemyapi.io/v2/<key>
 ```
![](https://i.imgur.com/iHIBCMI.jpg)

After installing the environment, enter the command again.

```
npx hardhat node --fork https://eth-mainnet.alchemyapi.io/v2/<key>
 ```
You will be able to see a success screen.

![](https://i.imgur.com/wGNTu2j.jpg)

Next, open MetaMask and select "localhost 8545".
If you didn't show localhost 8545, go to advanced and open the test network.

Choose "import account", paste in a private key, and the import will be successful.

 ![](https://i.imgur.com/T4gQcJU.png)
 

 ![](https://i.imgur.com/Ujv3EPu.png)

 ### Ganache-cli 

 Open the terminal in vscode and enter the following command

```
npm install ganache --global
ganache-cli -d -f https://eth-mainnet.g.alchemy.com/v2/<key> -p 8545  
```

You will be able to see a success screen.

![](https://i.imgur.com/YVcY8aJ.jpg)

Next, connect MetaMask and choose "import account", paste in a private key, and the import will be successful.

![](https://i.imgur.com/KbWj5MN.png)

![](https://i.imgur.com/MCYTbg3.png)


---

## 加分題


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
Click the button to mint NFTs without paying gas.

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

- **NFT Subscription**: Click "Subscribe" to subscribe to a NFT collection, then click "Release" to receive an NFT. Note that the "Release" is sent by the NFT creator, showing that your user can passively pay and receive NFTs.
  
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

In the end, we can enter the following command to clone the ERC-4337 examples:

`git clone https://github.com/stackup-wallet/erc-4337-examples.git`
 

![](https://i.imgur.com/ycFpysQ.png)


