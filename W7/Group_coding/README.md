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
user.sol
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract User {

    // 使用者 
    struct userData {
        uint userId; // 使用者 ID
        uint timestamp; // 使用者創建時間
        address userAddress; // 使用者地址
        uint identity; //使用者身份 1.平台商（我們）/2.售票活動商/3.消費者
    }

    uint userId; // userId 需要寫入 userData 嗎
    mapping (address => userData) public users;

    constructor() {}

    // ::todo 
    // 需要判斷使用者身份為何

    // create user
    function createUser(){}
    // delete user
    function deleteUser(){}
}
```

order.sol
```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Order {
    // 訂單
    struct orderData {
        uint orderId; // 訂單 ID
        uint timestamp; // 訂單時間
        address buyer; // 買家地址
        uint price; // 訂單價格
        uint amount; // 訂單數量
        bool canceled; // 訂單是否取消
    }

    uint orderId; 
    mapping (address => orderData) public orders;

    constructor() {}


    // ::todo 
    // orderList 
}

```


ticket.sol

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Ticket {

    // 票
    struct ticketData {
        uint ticketId; // 票 ID
        uint timestamp; // 購票時間
        address buyer; // 買家地址
        uint price; // 票價格
        uint amount; // 票數量
        bool use; // 票是否使用
    }

    uint ticketId;
    mapping (address => ticketData) public tickets;

    constructor() {}

    // :: todo 
    // 加價購 NFT

    // :: question
    // 1. 如何存取一個人擁有不同活動場次的票（mapping可以嗎）
    // 2. 主辦提款是放在這裡嗎

    // 預期要做的function
    // 買票
    function () external payable{
        buyTikcet();
    }
    function buyTikcet() private{}
    // 退票
    function cancelTicket(address event, uint price, uint amount) external {}
    // 使用票/驗票
    function verify(bytes32 _ticket) external view returns(bool){}
    //平台方提款 
    function withdraw() external{}
}

```

event.sol

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Event {

    // 活動
    struct eventData {
        uint eventId; // 活動 ID
        uint timestamp; // 活動時間
        address seller; // 第三方賣家地址
        uint price; // 活動價格
        uint amount; // 活動數量
        bool online; // 活動是否上線
    }

    uint eventId;
    mapping (address => eventData) public events;

    constructor() {}

    // ::todo 
    // 創建活動
    // 撤下活動
}
```


參考資料:https://creately.com/guides/flowchart-guide-flowchart-tutorial/
