# 個人作業

## 嘗試完整跟著這兩個教學照做並提供相關截圖，再簡述 VRF 運作原理，與兩種作法的差異：

--

兩種模式差異在於支付費用的方法和時機不同。

--

Chainlink VRF 的工作原理：

在 Chainlink VRF 中，隨機數是由預言機網絡生成。用戶傳入一個種子給 VRF 合約，預言機 VRF 節點會使用節點私鑰和種子生成一個隨機數和 Proof ( 證明 ) 返回給 VRF 合約，VRF 合約 Proof 驗證隨機數的合法性，如果通過驗證，就會把隨機數返回給用戶。跟單純鏈下生成隨機數不同的是，Chainlink VRF 生成的隨機數可以通過 Proof 證明它是根據特定橢圓曲線算法算出來的，具有可驗證性、獨特性。

--

### [Direct Funding Method](https://docs.chain.link/vrf/v2/direct-funding/examples/get-a-random-number)：
The direct funding method does not require you to create subscriptions and pre-fund them. Instead, you must directly fund consuming contracts with LINK tokens before they request randomness. Because the consuming contract directly pays the LINK for the request, the cost is calculated during the request and not during the callback when the randomness is fulfilled. Learn how to estimate costs.

--

使用 Injected Web3 Environment，連結錢包，發布！

![](https://i.imgur.com/DNT3qih.png)

![](https://i.imgur.com/Nt7gPc4.png)


產生[測試幣LINK](https://docs.chain.link/resources/acquire-link/)，並import


![](https://i.imgur.com/hkT8s01.png)

![](https://i.imgur.com/nOhiqF4.png)

![](https://i.imgur.com/NNXNJsn.png)


獲取隨機數（這裡一開始失敗，原因是因為合約內沒有足夠的 LINK 幣）


所以[先轉入 LINK 幣](https://docs.chain.link/resources/fund-your-contract/)

![](https://i.imgur.com/dXEdZmz.png)


重新再按一次果然沒有收到錯誤訊息通知

![](https://i.imgur.com/R43jvY8.png)

交易成功

![](https://i.imgur.com/8EPZOLA.png)

![](https://i.imgur.com/GN2y8XU.png)

從 logs 可以看到 requestId 和隨機數

![](https://i.imgur.com/lt78tBL.png)

--

### [Subscription Method](https://docs.chain.link/vrf/v2/subscription/examples/get-a-random-number)：
The Subscription Manager lets you create an account and pre-pay for VRF v2, so you don’t provide funding each time your application requests randomness. This reduces the total gas cost to use VRF v2.

--

create subscription manager

![](https://i.imgur.com/muzvMjf.png)


subscription 的 id 可以在[這頁](https://vrf.chain.link/)看到

![](https://i.imgur.com/JDDCqJB.png)

fund subscription 至少 12 LINKs

![](https://i.imgur.com/uO7E2W3.png)

![](https://i.imgur.com/Zkx1rf6.png)

在 VRFv2Consumer.sol 裡頭更新 subscription id

![](https://i.imgur.com/rLpd3zu.png)

deploy 前也需要輸入 id，部署合約

![](https://i.imgur.com/e0NxA5m.png)

將合約地址加到 consumers 名單內

![](https://i.imgur.com/EyJzZkM.png)

發現合約還是需要使用 Injected Web3 Environment，所以重做一次流程

![](https://i.imgur.com/kKAYJuG.png)

按 requestRandomWords 回傳

![](https://i.imgur.com/w94SR68.png)

試用其他 function

![](https://i.imgur.com/ovwQtAi.png)

--


資料來源：

```
https://blog.chain.link/verifiable-random-function-vrf-zh/
https://www.rickjiang.dev/blog/using-chainlink-vrf-for-randomness-generation
https://0xzx.com/zh-tw/2022091416482629111.html
https://badgameshow.com/wade/2022/11/22/%E3%80%90chainlink%E3%80%91%E4%BD%BF%E7%94%A8-chainlink-vrf-subscription-%E8%A8%82%E9%96%B1%E6%A8%A1%E5%BC%8F-%E7%94%A2%E7%94%9F%E5%AE%89%E5%85%A8%E7%9A%84%E9%9A%A8%E6%A9%9F%E6%95%B8/
```


---

## 試跑[此專案](https://github.com/z-institute/bsc-eth-bridge)提供成功跑起的相關截圖，再簡述跨鏈橋運作原理


--

在兩條鏈之間做一個監聽器，當接收到一方的呼叫，就一邊進行 _mint，一邊進行 _burn。

![](https://i.imgur.com/nbcMiEG.jpg)


private key 視為簽名 

![](https://i.imgur.com/hfMm22n.png)

--

step1:

```
git clone https://github.com/z-institute/bsc-eth-bridge.git
```
![](https://i.imgur.com/8FskmTi.png)

--

step2: 
run the project

```
npm install
npm i -g truffle
truffle compile
```

--

step3:
deploy contract

```
truffle migrate --reset --network sepolia
truffle migrate --reset --network bscTestnet
```

![](https://i.imgur.com/n4lFbh7.png)

![](https://i.imgur.com/Vo8eUtb.png)

> 幣安幣的[RPC](
https://docs.bscscan.com/misc-tools-and-utilities/public-rpc-nodes)

> 本來一直失敗，後來參考 [這篇](4465030https://docs.infura.io/infura/tutorials/ethereum/deploy-a-contract-using-truffle) 將 gas 設定為 gas: 4465030

```
  sepolia: {
      provider: () => new HDWalletProvider(MNEMONIC, INFURA_API_KEY),
      network_id: '11155111',
      gas: 4465030, 
    },
```

<!-- https://sepolia.etherscan.io/tx/0xb44d6419ea783b35f2c0a98a58a9902d69af251f9bc4fc39ea9d859966ebe290 -->


![](https://i.imgur.com/CcuSocz.png)

--

step4:
```
truffle exec scripts/eth-token-balance.js --network sepolia   
truffle exec scripts/bsc-token-balance.js --network bscTestnet 
```

![](https://i.imgur.com/fKKiNdt.png)

--

step5:

Run the bridge script (keep the script opened in a separate terminal)

```
 node scripts/eth-bsc-bridge.js
```


![](https://i.imgur.com/jKQN3S7.jpg)

--

step6:

Transfer token (the bridge will listen to the event and do the bridging after transfer)

step4 因為我的金額只有 1，所以這邊的 amount 最多只能設定 1，不然會失敗

![](https://i.imgur.com/HPkiRAY.png)

```
truffle exec scripts/eth-bsc-transfer.js --network sepolia  
```


![](https://i.imgur.com/kABLXhm.jpg)

--


step7:

成功轉移！

```
truffle exec scripts/eth-token-balance.js --network sepolia   
truffle exec scripts/bsc-token-balance.js --network bscTestnet 
```

![](https://i.imgur.com/5Lammk7.png)

---

## 閱讀 [Solidity by example]( https://solidity-by-example.org)

constants

```
Constants are variables that cannot be modified.
＊ 定義後就無法被更改

// coding convention to uppercase constant variables
address public constant MY_ADDRESS = 0x777788889999AaAAbBbbCcccddDdeeeEfFFfCcCc;
uint public constant MY_UINT = 123;
```

immutable variables

```
Values of immutable variables can be set inside the constructor but cannot be modified afterwards.
＊ 只能在 constructor 被賦值

contract Immutable {
    // coding convention to uppercase constant variables
    address public immutable MY_ADDRESS;
    uint public immutable MY_UINT;

    constructor(uint _myUint) {
        MY_ADDRESS = msg.sender;
        MY_UINT = _myUint;
    }
}
```


state variable

```
To write or update a state variable you need to send a transaction.
On the other hand, you can read state variables, for free, without any transaction fee.
＊ 讀取不用錢，更新要錢

contract SimpleStorage {
    // State variable to store a number
    uint public num;

    // You need to send a transaction to write to a state variable.
    function set(uint _num) public {
        num = _num;
    }

    // You can read from a state variable without sending a transaction.
    function get() public view returns (uint) {
        return num;
    }
}
```

mapping

```
 mapping(keyType => valueType)
```


array

```
// This will increase the array length by 1.
arr.push(i);
 
// This will decrease the array length by 1
arr.pop();

// Delete does not change the array length.
// It resets the value at index to it's default value,
// in this case 0
delete arr[index];
(*) 這裡有個重點，當你 delete 時，arr 的長度並不會變，被刪除的地方會變成預設值0

-

這裡提供兩種可以更新 arr 長度的方法

function remove(uint _index) public {
    require(_index < arr.length, "index out of bound");

    for (uint i = _index; i < arr.length - 1; i++) {
        arr[i] = arr[i + 1];
    }
    arr.pop();
}

function remove(uint index) public {
    // Move the last element into the place to delete
    arr[index] = arr[arr.length - 1];
    // Remove the last element
    arr.pop();
}
```


calling parent contracts

```
Parent contracts can be called directly, or by using the keyword super.
```

gas saving techniques

```
* Replacing memory with calldata
* Loading state variable to memory
* Replace for loop i++ with ++i 
-> i不論是「i++」或「++i」，其執行後的結果都是讓「i 值加 1」；所以其差異並不在於結果，而是過程。
->「i++」代表著後綴運算，所以「i」會先執行「當前動作」，然後再將「i」值進行加 1 的動作，執行結果理所當然是「01」；反觀「++i」，它則是先將「i」值加 1 後再進行「當前動作」。)
* Caching array elements
* Short circuit
```

sending ether

```
call (forward all gas or set gas, returns bool)

function sendViaCall(address payable _to) public payable {
    // Call returns a boolean value indicating success or failure.
    // This is the current recommended method to use.
    (bool sent, bytes memory data) = _to.call{value: msg.value}("");
    require(sent, "Failed to send Ether");
}
```

.
.
.

---

## [Follow此教學](https://soliditydeveloper.com/uniswap3)並提供完成截圖，用自己的話寫下對 Uniswap V3 的運作模式理解

run "Fully working example for Remix" 的 code

![](https://i.imgur.com/gVOSxUs.png)

* 恆定乘積原理 x * y = k
* Uniswap 的三種角色
    1. 成交者：用一種資產交換另一種資產；
    2. 流動性提供者（LP） ：願意將自己的資產組合貢獻出來，幫助他人進行兌換，獲得一定費用；
    3. 套利者：發現價值凹地，比如從 UNISWAP 中低價買入到市場上去賣出，以賺取一定利潤。
*  K 不變的情況下，需要改變的是兌換費和流動性。

---


## 課外好文

[追求真理：++i为何比i++执行效率高？](https://blog.csdn.net/DP29syM41zyGndVF/article/details/100012591)

[Uniswap V3 原理解析](https://mirror.xyz/0xCf19c7444b775f4fede9b7B53b4d708338004aa4/vC-wd8t-Z2cXdpV3jKQsagoGHrRNMRAp-LDPISQ71CA)