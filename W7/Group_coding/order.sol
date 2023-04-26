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
