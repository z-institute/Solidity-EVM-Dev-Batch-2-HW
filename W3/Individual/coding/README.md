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