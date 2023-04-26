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
