## [DIRECT FUNDING METHOD](https://docs.chain.link/vrf/v2/direct-funding/examples/get-a-random-number/)

![](https://i.imgur.com/xcIC1ah.png)

### Requirements:
* The Remix IDE
* MetaMask
* Sepolia testnet ETH - Request testnet ETH and LINK tokens for the Sepolia testnet and test your Chainlinked smart contract

### Fund Your Contract
Retrieve the contract address
![](https://i.imgur.com/BapItNP.png)

Send funds to your contract
![](https://i.imgur.com/nR9uACt.png)

![](https://i.imgur.com/cwXP1UO.png)


### Create and deploy a VRF v2 compatible contract
Open the VRFv2DirectFundingConsumer.sol contract in Remix.
 
![](https://i.imgur.com/H49TJB1.png)

### Request random values
Click the requestRandomWords() function to send the request for random values to Chainlink VRF. MetaMask opens and asks you to confirm the transaction.

![](https://i.imgur.com/oJEtVwH.png)


To fetch the request ID of your request, call lastRequestId().

![](https://i.imgur.com/OU7V5bw.png)

After the oracle returns the random values to your contract, the mapping s_requests is updated. The received random values are stored in s_requests[_requestId].randomWords.

![](https://i.imgur.com/0r67bpY.png)


Call getRequestStatus() and specify the requestId to display the random words.

![](https://i.imgur.com/7uMwAgN.png)


### Analyzing the contract & Clean up
#### The contract includes the following functions:

* requestRandomWords(): Takes your specified parameters and submits the request to the VRF v2 Wrapper contract. 
* fulfillRandomWords(): Receives random values and stores them with your contract.
* getRequestStatus(): Retrive request details for a given _requestId.
* withdrawLink(): At any time, the owner of the contract can withdraw outstanding LINK balance from it.

![](https://i.imgur.com/OR6T0WM.png)

Call withdrawLink() function. MetaMask opens and asks you to confirm the transaction. After you approve the transaction, the remaining LINK will be transfered from your consuming contract to your wallet address.


![](https://i.imgur.com/0IAyuOv.png)


## [SUBSCRIPTION METHOD](https://docs.chain.link/vrf/v2/subscription/examples/get-a-random-number)

![](https://i.imgur.com/zA5A3Ft.png)

### Create and fund a subscription

![](https://i.imgur.com/ZQJ2l4o.png)

### Add funds
After completing the process, when you return to the Chainlink Subscription Manager page, you will notice that there is an additional subscriber in "My Subscriptions". You can click on the ID of the subscriber to access their account and transfer some LINK Tokens into their account. This will be used later when generating random numbers.

![](https://i.imgur.com/Ua3A5oS.png)
![](https://i.imgur.com/4vz8QgT.png)

### Deploye the Contract

The first step in deploying the contract is to pass the newly created subscriber ID during contract deployment. Next, within the constructor function, the ID will be stored in the s_subscriptionId variable.

![](https://i.imgur.com/fAjPkHQ.png)

### Add Chainlink VRF Consumer

Go back to the Chainlink Subscription Manager and navigate to the newly created subscriber. Click on "Add consumer" and paste the address of the just-deployed contract, then click on "Add" to add it as a consumer.

![](https://i.imgur.com/X4aJ8Oo.png)

### Test Generating Random Number
After deploying the contract and adding it as a consumer, you can call the requestRandomWords function to generate a random number. After the function is called, you can check the running tasks and their statuses in the Chainlink Subscription Manager. 

![](https://i.imgur.com/X5KBkS5.png)

If everything is running smoothly, you should see s_requestId and s_randomWords being updated.

![](https://i.imgur.com/nE0r5UF.png)


## Comparison
The comparison between **the DIRECT FUNDING METHOD** and **the SUBSCRIPTION METHOD** for getting a random number in Chainlink VRF version 2:

### 1. Fee Payment Method: 
The DIRECT FUNDING METHOD requires direct funding, where users need to specify the amount of LINK tokens to be paid when requesting a random number in their contract. On the other hand, the SUBSCRIPTION METHOD uses a subscription approach, where users need to subscribe to the VRF contract in their contract and set the appropriate payment period and amount to continuously receive random numbers.

### 2.Random Number Request Method: 
The DIRECT FUNDING METHOD requests a random number by calling the requestRandomness function in the contract, specifying the amount of LINK tokens to be paid and other parameters. Meanwhile, the SUBSCRIPTION METHOD sets up a subscription to the VRF contract in the contract and listens for the arrival of random numbers through the randomValue event.

### 3. Random Number Response Method:
In the DIRECT FUNDING METHOD, the VRF contract directly returns the random number to the user's contract without further processing. In the SUBSCRIPTION METHOD, the VRF contract sends the random number to the subscribed event, and the user needs to extract the random number in the event handling function.

### 4. Payment Authorization Method: 
In the DIRECT FUNDING METHOD, users need to authorize enough LINK tokens to the VRF contract before requesting a random number, as collateral for payment. In the SUBSCRIPTION METHOD, users need to authorize enough LINK tokens to the VRF contract when subscribing, as both payment collateral and subscription fee.

### 5. Costs and Use Cases:
The DIRECT FUNDING METHOD is suitable for scenarios where a single random number is needed, as users can directly pay LINK tokens to request a random number, offering flexibility. The SUBSCRIPTION METHOD is suitable for scenarios where multiple random numbers need to be continuously obtained, as users can set the subscription period and amount to reduce frequent requests and payments, making it suitable for long-term use.

---
## [bsc-eth-bridge](https://github.com/z-institute/bsc-eth-bridge)
![](https://i.imgur.com/J2ke5uK.png)

版本太舊了，很多參數都要改，可以參考
https://docs.infura.io/infura/tutorials/ethereum/deploy-a-contract-using-truffle
並且指令也要都修改，run一遍後才有辦法開始實作

另外，infura測試幣一直拿不到，無法在錢包上看到數字，但其他水龍頭可以，但其他的測試網又不支援了，能做的選擇很有限，
我最後卡在truffle migrate --reset --network sepolia

`git clone https://github.com/z-institute/bsc-eth-bridge.git`



### Run the project

![](https://i.imgur.com/OVLx82b.png)


You can install truffle in the terminal using the following command:

```
npm install -g truffle
```
If you have already installed truffle but are still unable to use the command, please verify if your system environment variables are set correctly.

### [Fund your Ethereum account](https://www.infura.io/faucet)
See how to work
https://www.youtube.com/watch?v=WkojkWkVdZY

### Create a project directory

```
mkdir truffleProject
cd truffleProject
```
### Install Dotenv

`npm install dotenv`

### Create a Truffle project

`truffle init`

![](https://i.imgur.com/8esyOX9.png)

### Install hdwallet-provider

`npm install @truffle/hdwallet-provider`

### Create the .env file

INFURA_API_KEY = "https://sepolia.infura.io/v3/<Your-API-Key>"
MNEMONIC = "<Your-MetaMask-Secret-Recovery-Phrase>"

### Deploy contract

```
truffle migrate --reset --network sepolia
    
```
![](https://i.imgur.com/bFuxdwU.png)



see https://github.com/z-institute/bsc-eth-bridge/blob/main/truffle-config.js and use below the code to fix your truffle-config.js. 

```
 require('dotenv').config();
const HDWalletProvider = require('@truffle/hdwallet-provider');
const { INFURA_API_KEY, MNEMONIC } = process.env;

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*"
    },
    sepolia: {
      provider: () => new HDWalletProvider(MNEMONIC, INFURA_API_KEY),
      network_id: '11155111',
      gas: 4465030
    }
  }

};   
```
![](https://i.imgur.com/OORdPgq.png)
![](https://i.imgur.com/xeKyQ2e.png)


Run
`npm install @truffle/hdwallet-provider`

    
### Run the bridge script (keep the script opened in a separate terminal)  
![](https://i.imgur.com/gSmTbsx.png)

#### Transfer token (the bridge will listen to the event and do the bridging after transfer)
    
![](https://i.imgur.com/soBXTAj.png)
    


## The principle of a cross-chain bridge 
The principle of a cross-chain bridge is a technical solution that connects different blockchain networks, allowing for the transfer of assets or information between them. The key principles involved in the operation of a cross-chain bridge include:

### 1. Cross-chain communication protocols: 
Communication between different blockchain networks requires the use of protocols, such as atomic cross-chain transaction protocols based on consensus algorithms, relay chain protocols, etc. These protocols allow for the generation of corresponding transactions or information on different chains, enabling cross-chain transfers.

### 2. Locking and unlocking mechanisms: 
Cross-chain bridges typically require locking and unlocking mechanisms for assets when they are transferred from one chain to another. For example, when a user transfers a certain amount of assets from Chain A to Chain B, the cross-chain bridge locks these assets on Chain A and generates corresponding locking proofs. On Chain B, the user can unlock the corresponding assets by providing the locking proofs, completing the cross-chain transfer.

### 3. Trust mechanisms: 
Cross-chain bridges involve multiple different blockchain networks, which requires addressing the issue of cross-chain trust. Typically, cross-chain bridges rely on trust mechanisms to ensure the security and reliability of cross-chain operations. Examples of trust mechanisms include multi-signature accounts, cross-chain validators, consensus algorithms, etc.

### 4. Event triggering and state monitoring: 
Cross-chain bridges need to trigger and monitor events on multiple chains to take appropriate actions during the asset transfer process. For example, when a user performs an asset transfer operation on Chain A, the cross-chain bridge needs to monitor events on Chain A and generate corresponding cross-chain transactions or information in a timely manner.

### 5. Cross-chain asset proxy: 
When transferring assets between different chains, cross-chain bridges often introduce asset proxies to facilitate the issuance and destruction of assets on different chains. For example, when a user transfers assets from Chain A to Chain B, the cross-chain bridge may generate corresponding asset proxies on Chain B for proxy issuance and destruction operations.

### Summary
These principles and technologies collectively form the operation mode of a cross-chain bridge, enabling the transfer of assets and information between different blockchain networks and achieving interconnectivity among blockchain networks.A bridge channel is provided between two different public blockchains, where native assets are held in custody on this bridge. Meanwhile, one chain can obtain transaction information of assets on the other chain through oracle functionality, and map the assets to the other chain in a 1:1 ratio. The result of the cross-chain bridge is that two chains can exchange the same type of asset, with the assets being mapped from native assets on one chain to another, for example, BETH is the mapped asset of ETH crossing from Ethereum to Binance Smart Chain (BSC) via the Binance Bridge.

補充文章: 
### [跨鏈橋概述：一覽六個主流跨鏈橋特性及進展](https://abmedia.io/20230315-cross-chain-bridges-review)
### [7大公链原生跨链桥](https://morioh.com/p/2b85cf749b4b)
---
    
## Solidity by example
### Basic
**Sending Ether (transfer, send, call)**
You can send Ether to other contracts by
1. transfer (2300 gas, throws error)
1. send (2300 gas, returns bool)
1. call (forward all gas or set gas, returns bool)
    
**How to receive Ether?**
A contract receiving Ether must have at least one of the functions below

1. receive() external payable
1. fallback() external payable
1. receive() is called if msg.data is empty, otherwise fallback() is called.

**Which method should you use?**
call in combination with re-entrancy guard is the recommended method to use after December 2019.
Guard against re-entrancy by making all state changes before calling other contracts using re-entrancy guard modifier    
**Variables**
There are 3 types of variables in Solidity
1. local
declared inside a function
not stored on the blockchain
1. state
declared outside a function
stored on the blockchain
1. global (provides information about the blockchain)

**Fallback**
fallback is a special function that is executed either when a function that does not exist is called or Ether is sent directly to a contract but receive() does not exist or msg.data is not empty fallback has a 2300 gas limit when called by transfer or send.
**Gas Saving Techniques**
Some gas saving techniques.
1. Replacing memory with calldataLoading state variable to memory
1. Replace for loop i++ with ++i
1. Caching array elements
1. Short circuit

**Error**
An error will undo all changes made to the state during a transaction.

You can throw an error by calling **require, revert or assert**.

* require is used to validate inputs and conditions before execution.
* revert is similar to require. See the code below for details.
* assert is used to check for code that should never be false. Failing assertion probably means that there is a bug.
Use custom error to save gas.
### Applications

**Multi-Sig Wallet**

The wallet owners can submit a transaction approve and revoke approval of pending transcations, anyone can execute a transcation after enough owners has approved it.

**Merkle Tree**

Merkle tree allows you to cryptographically prove that an element is containedin a set without revealing the entire set.

**Write to Any Slot**
Solidity storage is like an array of length 2^256. Each slot in the array can store 32 bytes.

Order of declaration and the type of state variables define which slots it will use.

However using assembly, you can write to any slot.
**English Auction**-English auction for NFT.
Seller of NFT deploys this contract.
Auction lasts for 7 days.
Participants can bid by depositing ETH greater than the current highest bidder.
All bidders can withdraw their bid if it is not the current highest bid.
After the auction
Highest bidder becomes the new owner of NFT.
The seller receives the highest bid of ETH.

**Deploy Any Contract**
Deploy any contract by calling Proxy.deploy(bytes memory _code) 
```

   function deploy(bytes memory _code) external payable returns (address addr) {
        assembly {
            // create(v, p, n)
            // v = amount of ETH to send
            // p = pointer in memory to start of code
            // n = size of code
            addr := create(callvalue(), add(_code, 0x20), mload(_code))
        }
        // return address 0 on error
        require(addr != address(0), "deploy failed");

        emit Deploy(addr);
    }

    function execute(address _target, bytes memory _data) external payable {
        (bool success, ) = _target.call{value: msg.value}(_data);
        require(success, "failed");
    }
    
```
For this example, you can get the contract bytecodes by calling Helper.getBytecode1 and Helper.getBytecode2
    
```
contract Helper {
    function getBytecode1() external pure returns (bytes memory) {
        bytes memory bytecode = type(TestContract1).creationCode;
        return bytecode;
    }

    function getBytecode2(uint _x, uint _y) external pure returns (bytes memory) {
        bytes memory bytecode = type(TestContract2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_x, _y));
    }

    function getCalldata(address _owner) external pure returns (bytes memory) {
        return abi.encodeWithSignature("setOwner(address)", _owner);
    }
```
### Hacks

**Denial of Service**
Vulnerability
There are many ways to attack a smart contract to make it unusable.
One exploit we introduce here is denial of service by making the function to send Ether fail.

```
contract KingOfEther {
    address public king;
    uint public balance;

    function claimThrone() external payable {
        require(msg.value > balance, "Need to pay more to become the king");

        (bool sent, ) = king.call{value: balance}("");
        require(sent, "Failed to send Ether");

        balance = msg.value;
        king = msg.sender;
    }
}

contract Attack {
    KingOfEther kingOfEther;

    constructor(KingOfEther _kingOfEther) {
        kingOfEther = KingOfEther(_kingOfEther);
    }

    function attack() public payable {
        kingOfEther.claimThrone{value: msg.value}();
    }
}
```
**Source of Randomness**
Vulnerability
blockhash and block.timestamp are not reliable sources for randomness.
```
/*
GuessTheRandomNumber is a game where you win 1 Ether if you can guess the
pseudo random number generated from block hash and timestamp.

At first glance, it seems impossible to guess the correct number.
But let's see how easy it is win.

1. Alice deploys GuessTheRandomNumber with 1 Ether
2. Eve deploys Attack
3. Eve calls Attack.attack() and wins 1 Ether

What happened?
Attack computed the correct answer by simply copying the code that computes the random number.
*/
```

### DeFi
**Chainlink Price Oracle**
ETH / USD Price Oracle
```
contract ChainlinkPriceOracle {
    AggregatorV3Interface internal priceFeed;

    constructor() {
        // ETH / USD
        priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
    }

    function getLatestPrice() public view returns (int) {
        (
            uint80 roundID,
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        // for ETH / USD price is scaled up by 10 ** 8
        return price / 1e8;
    }
}

interface AggregatorV3Interface {
    function latestRoundData()
        external
        view
        returns (
            uint80 roundId,
            int answer,
            uint startedAt,
            uint updatedAt,
            uint80 answeredInRound
        );
}
`
```
    
---

## [The overview of the operational mode of Uniswap v3](https://soliditydeveloper.com/uniswap3):

```
// SPDX-License-Identifier: MIT
pragma solidity =0.7.6;
pragma abicoder v2;

import "https://github.com/Uniswap/uniswap-v3-periphery/blob/main/contracts/interfaces/ISwapRouter.sol";
import "https://github.com/Uniswap/uniswap-v3-periphery/blob/main/contracts/interfaces/IQuoter.sol";

interface IUniswapRouter is ISwapRouter {
    function refundETH() external payable;
}

contract Uniswap3 {
  IUniswapRouter public constant uniswapRouter = IUniswapRouter(0xE592427A0AEce92De3Edee1F18E0157C05861564);
  IQuoter public constant quoter = IQuoter(0xb27308f9F90D607463bb33eA1BeBb41C27CE5AB6);
  address private constant multiDaiKovan = 0x4F96Fe3b7A6Cf9725f59d353F723c1bDb64CA6Aa;
  address private constant WETH9 = 0xd0A1E359811322d97991E03f863a0C30C2cF029C;

  function convertExactEthToDai() external payable {
    require(msg.value > 0, "Must pass non 0 ETH amount");

    uint256 deadline = block.timestamp + 15; // using 'now' for convenience, for mainnet pass deadline from frontend!
    address tokenIn = WETH9;
    address tokenOut = multiDaiKovan;
    uint24 fee = 3000;
    address recipient = msg.sender;
    uint256 amountIn = msg.value;
    uint256 amountOutMinimum = 1;
    uint160 sqrtPriceLimitX96 = 0;
    
    ISwapRouter.ExactInputSingleParams memory params = ISwapRouter.ExactInputSingleParams(
        tokenIn,
        tokenOut,
        fee,
        recipient,
        deadline,
        amountIn,
        amountOutMinimum,
        sqrtPriceLimitX96
    );
    
    uniswapRouter.exactInputSingle{ value: msg.value }(params);
    uniswapRouter.refundETH();
    
    // refund leftover ETH to user
    (bool success,) = msg.sender.call{ value: address(this).balance }("");
    require(success, "refund failed");
  }
  
  function convertEthToExactDai(uint256 daiAmount) external payable {
    require(daiAmount > 0, "Must pass non 0 DAI amount");
    require(msg.value > 0, "Must pass non 0 ETH amount");
      
    uint256 deadline = block.timestamp + 15; // using 'now' for convenience, for mainnet pass deadline from frontend!
    address tokenIn = WETH9;
    address tokenOut = multiDaiKovan;
    uint24 fee = 3000;
    address recipient = msg.sender;
    uint256 amountOut = daiAmount;
    uint256 amountInMaximum = msg.value;
    uint160 sqrtPriceLimitX96 = 0;

    ISwapRouter.ExactOutputSingleParams memory params = ISwapRouter.ExactOutputSingleParams(
        tokenIn,
        tokenOut,
        fee,
        recipient,
        deadline,
        amountOut,
        amountInMaximum,
        sqrtPriceLimitX96
    );

    uniswapRouter.exactOutputSingle{ value: msg.value }(params);
    uniswapRouter.refundETH();

    // refund leftover ETH to user
    (bool success,) = msg.sender.call{ value: address(this).balance }("");
    require(success, "refund failed");
  }
  
  // do not used on-chain, gas inefficient!
  function getEstimatedETHforDAI(uint daiAmount) external payable returns (uint256) {
    address tokenIn = WETH9;
    address tokenOut = multiDaiKovan;
    uint24 fee = 3000;
    uint160 sqrtPriceLimitX96 = 0;

    return quoter.quoteExactOutputSingle(
        tokenIn,
        tokenOut,
        fee,
        daiAmount,
        sqrtPriceLimitX96
    );
  }
  
  // important to receive ETH
  receive() payable external {}
}
```

    
![](https://i.imgur.com/Wvw7WSG.png)


**The difference between exactInput and exactOutput**
Once you execute the functions and look at them in Etherscan, the difference becomes immediately obvious. Here we are trading with exactOutput.
![](https://i.imgur.com/kX4bJ4a.png)
    
### Uniswap v3 introduces several new features and improvements over Uniswap v2:
### 1. Concentrated liquidity: 
Unlike Uniswap v1 and v2, Uniswap v3 introduces the concept of concentrated liquidity. In Uniswap v3, liquidity providers can choose to concentrate their funds within specific price ranges, providing liquidity in more specific price intervals.

### 2. Multiple fee tiers: 
Uniswap v3 allows liquidity providers to choose different fee tiers, enabling them to set different fees for different price ranges. This provides more flexibility and incentives for liquidity providers.

### 3. Non-fungible token (NFT) liquidity: 
Uniswap v3 introduces the concept of NFT liquidity positions, allowing liquidity providers to manage and trade their liquidity as NFTs, providing more flexibility in managing liquidity.

### 4. Trade path optimization: 
Uniswap v3 optimizes trade paths and price calculations to achieve better price execution in trades.

### 5. Smart contract interactions: 
Developers can interact with Uniswap v3's smart contracts using languages like Solidity, integrating Uniswap v3 functionalities into decentralized applications.
    
reference:
    https://mixbytes.io/blog/how-to-add-new-pool-uniswap-v3