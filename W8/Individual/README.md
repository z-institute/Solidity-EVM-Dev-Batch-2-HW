## [Hardhat 前端專案](https://github.com/NomicFoundation/hardhat-boilerplate)
Step 1:
```
git clone https://github.com/NomicFoundation/hardhat-boilerplate.git
cd hardhat-boilerplate
npm install
```
Step 2: 安裝後，讓我們運行 Hardhat 的測試網絡：

`npx hardhat node`

Step 3: 然後，在一個新終端上運行它來部署你的合約：

`npx hardhat run scripts/deploy.js --network localhost`

Step 4: 最後，我們可以運行前端：

```
cd frontend
npm install
npm start
```
打開[http://localhost:3000/](http://localhost:3000/)，連接Metamask錢包並選 localhost 8545網.


![](https://i.imgur.com/IWt3red.png)


## 前端呼叫智能合約方式

前端是通過 Web3.js 與智能合約進行交互的。在 Hardhat Boilerplate 的前端代碼中，我們可以找到以下主要的程式碼：

#### 1. 定義智能合約地址和 ABI
這是用來告訴 Web3.js 前端與哪個智能合約進行交互，以及如何使用智能合約的方法和變量。
```
import {ethers} from 'ethers';
import {useEffect, useState} from 'react';
import {Contract} from '@ethersproject/contracts';
import {useUserAddress, useContractFunction} from '@usedapp/core';

import {abi} from './abi';

...

const contractAddress = '0x...'; // 智能合約地址
```


#### 2. 創建 Web3Provider 和 Contract 實例
用於與以太坊網路進行通信，同時創建了一個 Contract 實例，用於與智能合約進行交互。
```
const provider = new ethers.providers.Web3Provider(window.ethereum);
const contract = new Contract(contractAddress, abi, provider);
```
#### 3. 呼叫智能合約方法
呼叫了智能合約的 myFunction 方法，並將結果輸出到控制台中。這是通過調用 Contract來實現的。
```
async function callContractFunction() {
  const result = await contract.myFunction(); // 呼叫智能合約的 myFunction 方法
  console.log(result);
}
```


#### 4. 在前端應用中呼叫智能合約方法
在程式碼中，使用了 @usedapp/core 中提供的 useContractFunction hook，該 hook 提供了方便的方法來在前端應用中呼叫智能合約方法。在這個例子中可以看到在 App 函數中使用了 useContractFunction，並通過它來呼叫智能合約的 myFunction 方法。
```
function App() {
  const userAddress = useUserAddress();

  const {state, send} = useContractFunction(contract, 'myFunction', {transactionName: 'My Function'});

  return (
    <div>
      <h1>Welcome {userAddress}</h1>
      <button onClick={() => send()}>Call myFunction</button>
    </div>
  );
}
```

### 總結
在 Hardhat Boilerplate 中，前端通過 Web3.js 與智能合約進行交互，並通過使用 @usedapp/core 中提供的 useContractFunction hook 方便地在前端應用中呼叫智能合約方法。這樣的方式能夠更容易地與區塊鏈交互串接，並實現更多應用場景。



---
[Quiz2 的合約](https://github.com/z-institute/Quiz/blob/main/contracts/Quiz_02.sol)

1.Install

`npm install --save-dev solidity-coverage`

2.新增 hardhat.config.ts 檔案

`import "solidity-coverage";`

3.開始寫Quiz_02.test.js

4.最後，輸入下面指令，跑出測試結果

`npx hardhat coverage`  

### Quiz_02.test.js

```
const { expect } = require("chai");

describe("Quiz 2 test", function () {
  
  let token;
   
  const [owner, acc1] = await ethers.getSigners(); // get signers
  before(async () => { // runs before all tests
    const Token = await ethers.getContractFactory("MyToken") // get contract compiled file
    // get signers
    token = await Token.deploy(); // deploy contract
  });
  // describe: context / category
  // it: test case
 
  it("Should mint and send it to the account", async function () {
    await token.mint(owner.address, 0, {
      value: ethers.utils.parseEther("0.1"),
    });
    expect(await token.ownerOf(0)).to.equal(owner.address);

    await token.batchMint(acc1.address, 1, {
      value: ethers.utils.parseEther("0.2"),
    });

    expect(await token.ownerOf(1)).to.equal(acc1.address);
    
  });

});
```
### test邏輯
1. 測試檔案使用Mocha框架，並且第一行程式碼引入了Chai庫，以便在測試中使用expect斷言方法。
1. describe()是Mocha中的一個全局函數，用於測試"Quiz 2 test"。 
1. let token和const [owner, acc1] = await ethers.getSigners()定義了一些測試中會使用到的變數。
1. before()是一個Mocha中的hook，在每個測試案例之前執行，在這裡使用了它來創建一個新的合約實例。
1. it()是一個Mocha中的全局函數，用於創建test case，測試了mint()函數是否正常運作。
1. 首先使用mint()函數向owner發行一個代幣，然後使用expect()方法檢查該代幣的所有權是否已經成功地轉移到了owner的帳戶。ethers.utils.parseEther("0.1")的值是一個以 Wei 為單位的big number，可以用於在智能合約中進行計算或向某個帳戶轉移一定數量的 ETH。使用了以太坊（Ethereum）中的一個工具函數 `parseEther`，它是以太幣（Ether）的數量轉換器。它把以太幣的數量表示為一個字符串，然後轉換為以太幣的最小單位—Wei。[這個函數](https://docs.ethers.org/v5/api/utils/bignumber/#utils-parseether.)是由以太坊開發工具庫 `ethers` 提供的。
1. 最後，我們使用batchMint()函數向acc1發行一個代幣，然後再次使用expect()方法檢查該代幣的所有權是否已經成功地轉移到了acc1的帳戶。

## 檢討:
對照答案後，我發現很容易因為邊看著合約邊打測試code，漏寫了**revert** 和 **support interface** ，新手應避免這錯誤
```
  it("Should revert when not enough funds", async function () {
    expect(token.mint(owner.address, 0)).to.be.revertedWith(
      "Not enough funds to mint."
    );

    expect(token.batchMint(acc2.address, [0, 1])).to.be.revertedWith(
      "Not enough funds to mint."
    );
  });

  it("Should support interface", async function () {
    expect(await token.supportsInterface("0x00000001"), false);
  });
```

![](https://i.imgur.com/RAC36gd.png)








