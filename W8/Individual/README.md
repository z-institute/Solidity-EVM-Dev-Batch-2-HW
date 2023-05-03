# 個人作業


## 看著 Quiz2 的合約（[在此](https://github.com/z-institute/Quiz/blob/main/contracts/Quiz_02.sol)），嘗試用 Hardhat 框架寫出 Quiz2 合約的 test，並跑 npx hardhat coverage，把測試涵蓋率提高到 100%
* 遇到困難的話可以看答案，但建議先自己嘗試後，真的想不到再對照：[https://github.com/z-institute/Quiz/blob/main/test/Quiz_02.test.js](https://github.com/z-institute/Quiz/blob/main/test/Quiz_02.test.js)

--

先打開 console.log 看 token.functions 提供了幾項 api 可以使用

```
  before(async function () {
    const MyToken = await ethers.getContractFactory("MyToken");
    token = await MyToken.deploy();
    console.log(token.functions);
  });
```

--

test.js

```
const { expect } = require("chai");

describe("Quiz 2 test", async function () {
  // A Signer in ethers.js is an object that represents an Ethereum account.
  // It's used to send transactions to contracts and other accounts.
  const [owner, acc1, acc2] = await ethers.getSigners();
  let token;

  before(async function () {
    // 編譯完的大寫
    const Contract = await ethers.getContractFactory("MyToken");
    // 部署完的小寫
    contract = await Contract.deploy();
  });
  it("Name should be as expected", async function () {
    expect(await contract.name()).to.equal("MyToken");
  });

  // 第三個參數在你給他多少錢的情況下
  // 當給他的 value 是 0 的時候
  it("mint reverted when not enough funds", async function () {
    expect(contract.mint(owner.address, 0, {value: ethers.utils.parseEther("0")})).to.be.revertedWith(
      "Not enough funds to mint."
    )
  });

  it("batchMint reverted when not enough funds", async function () {
    expect(contract.batchMint(owner.address, [0,1], {value: ethers.utils.parseEther("0")})).to.be.revertedWith(
      "Not enough funds to mint."
    )
  });

  // 測試給他一定的錢，查看mint的數量
  it("Should be able to mint to specific account", async function () {
    await contract.mint(owner.address, 0, {value: ethers.utils.parseEther("0.1")})
    expect(await contract.ownerOf(0)).to.equal(owner.address);
  });

  it("Should be able to batchMint to specific account", async function () {
    await contract.batchMint(owner.address, [1,2,3], {value: ethers.utils.parseEther("0.3")})
    expect(await contract.ownerOf(1)).to.equal(owner.address);
    expect(await contract.ownerOf(2)).to.equal(owner.address);
    expect(await contract.ownerOf(3)).to.equal(owner.address);
  });

  it("Should support interface", async function () {
    // 需傳入 bytes4
    expect(await contract.supportsInterface("0x12345678"), false);
  });

});

```


--

有部分參考 https://github.com/z-institute/Quiz/blob/main/test/Quiz_02.test.js 才順利寫完

```
npx hardhat coverage
```

![](https://i.imgur.com/SgnDfHz.png)

打開 coverage / index.html

![](https://i.imgur.com/I7a9LLI.png)


參考：
```
https://hardhat.org/hardhat-runner/docs/other-guides/waffle-testing
https://medium.com/my-blockchain-development-daily-journey/%E5%AE%8C%E6%95%B4%E7%9A%84hardhat%E5%AF%A6%E8%B8%90%E6%95%99%E7%A8%8B-a9b005aa4c12
```

--


## 跑起這個 Hardhat 前端專案，並觀察他的專案架構，用自己的話寫出『前端是怎麼樣呼叫智能合約的？』
* https://github.com/NomicFoundation/hardhat-boilerplate


```
git clone https://github.com/NomicFoundation/hardhat-boilerplate.git
cd hardhat-boilerplate
npm install
```

```
npx hardhat node
```

有出現錯誤，因為套件沒有安裝完全

![](https://i.imgur.com/DTGBn6q.png)

先安裝套件

```
 npm install --save-dev "@types/mocha@^9.1.0" "@typechain/ethers-v5@^10.1.0" "@typechain/hardhat@^6.1.2" "ts-node@>=8.0.0" "typechain@^8.1.0" "typescript@>=4.5.0"
```

再下一次 npx hardhat node

```
npx hardhat node
```
![](https://i.imgur.com/Lxvt7ab.png)

--

new terminal

```
npx hardhat run scripts/deploy.js --network localhost
```
![](https://i.imgur.com/YMhosID.png)


```
cd frontend
npm install
npm start
```

![](https://i.imgur.com/ZWH9nP8.png)

連接錢包

![](https://i.imgur.com/FiryDt7.png)

在 dapp.js 裡面，發現這個專案是用 [ether.js](https://learnblockchain.cn/ethers_v5/) 來和合約互動

![](https://i.imgur.com/0GtdeSJ.png)

合約部署後會產生 ABI 文件，我們就是透過 ABI 文件知道這個智能合約提供哪些 function 以及應該要傳入什麼樣的參數，所以 init 的時候必須提供合約 address 和合約 ABI

![](https://i.imgur.com/FdFk5y7.png)

合約 ABI： contracts / Token.json

![](https://i.imgur.com/lbtEqZI.png)

合約 address： contracts / contract-address.json

> Q: 但如果要和多個合約互動，要怎麼做？

![](https://i.imgur.com/M4W8ZUf.png)


--

補充：
```
開發到部署智能合約的流程大致上是這樣的：

* 使用 Solidity 開發智能合約
* 將撰寫完畢的智能合約透過 Solidity 的編譯器進行編譯
* 編譯完畢後會產生 bytecode 與 ABI
* 將 bytecode 部署到以太坊中

-

要如何知道這個智能合約提供哪些 function 以及應該要傳入什麼樣的參數呢？
這些資訊就是記錄在智能合約的 ABI
```
![](https://i.imgur.com/qxpSNqu.png)

--

送出交易，成功時會更新餘額

![](https://i.imgur.com/YicSMKN.png)

從 code 來看，他會在交易回傳的 receipt 不為 0 時，確認交易成功，並執行 _updateBalance 來更新餘額

![](https://i.imgur.com/X3T0MNj.png)

--

## 課外好文：


[嘟嘟房NFT出包事件懶人包](https://medium.com/fuly-ai-%E6%99%BA%E8%83%BD%E6%8A%95%E8%B3%87%E7%AD%96%E7%95%A5%E6%A9%9F%E5%99%A8%E4%BA%BA-bitfinex-%E6%94%BE%E8%B2%B8%E6%A9%9F%E5%99%A8%E4%BA%BA/%E5%98%9F%E5%98%9F%E6%88%BFnft%E5%87%BA%E5%8C%85%E4%BA%8B%E4%BB%B6%E6%87%B6%E4%BA%BA%E5%8C%85-4a4acd7fe0c2)

--

結論：

比較簡單的做法就是不要用 array 去存，用一個 mapping 去存這個地址是的白名單

![](https://i.imgur.com/6hINtQt.png)

判斷的時候直接判斷，就不用一個 for loop 去跑

![](https://i.imgur.com/yVTZy4U.png)

現在主流做法都是用 merkle tree 的方式來實作白名單，好處是修改名單方便，也不用這麼高的手續費

--

[【Ethereum 智能合約開發筆記】深入智能合約 ABI](https://medium.com/taipei-ethereum-meetup/ethereum-%E6%99%BA%E8%83%BD%E5%90%88%E7%B4%84%E9%96%8B%E7%99%BC%E7%AD%86%E8%A8%98-%E6%B7%B1%E5%85%A5%E6%99%BA%E8%83%BD%E5%90%88%E7%B4%84-abi-268ececb70ae)

