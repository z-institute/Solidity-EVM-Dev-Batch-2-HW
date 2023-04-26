## Week7討論
 
### 目的: 
更換project

### 主旨:
訂票系統
 
### 原因:
傳統系統使用人數上中心化伺服器的使用人數比較佔優勢，但存在故障的風險。
區塊鏈平台處理大量交易和流量，更穩定，隨著人數增加，交易費用與時間增加，可能可以有效增加黃牛的成本。

### User flow chart
 
 ![](https://i.imgur.com/gavtaiZ.png)



```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// User 包括賬戶餘額、訂票歷史等
contract User {
    address public owner; 
    uint public balance; 
    uint[] public orderIds;
    
    // key: 訂單 ID / value: Order
    mapping(uint => Order) public orders;
    
    // 訂單
    struct Order {
        uint id; // 訂單 ID
        uint timestamp; // 下單時間
        address seller; // 第三方賣家地址
        uint price; // 訂單價格
        uint amount; // 訂單數量
        bool canceled; // 訂單是否已取消
    }


    // 專案初始化，建立 User 合約
    constructor() {
        owner = msg.sender;
    }

    // 存款
    function deposit() public payable {
        balance += msg.value;
    }

    // 提款
    function withdraw(uint amount) public {
        require(amount <= balance, "餘額不足");
        balance -= amount;
        payable(owner).transfer(amount);
    }

    // 購買門票，創建一個新的訂單
    function buyTicket(address seller, uint price, uint amount) public returns (uint) {
        require(amount > 0, "購買數量需大於 0");
        require(price > 0, "門票價格需大於 0");
        require(balance >= price * amount, "餘額不足");

        uint id = orderIds.length + 1;
        Order memory order = Order(id, block.timestamp, seller, price, amount, false);
        orders[id] = order;
        orderIds.push(id);

        balance -= price * amount;

        return id;
    }

    // 取消訂單
    function cancelOrder(uint id) public {
        require(msg.sender == owner, "您不是訂單擁有者");
        require(orders[id].id == id, "訂單不存在");
        require(!orders[id].canceled, "訂單已取消");

        orders[id].canceled = true;
        balance += orders[id].price * orders[id].amount;
    }
}
```

參考資料:https://creately.com/guides/flowchart-guide-flowchart-tutorial/
