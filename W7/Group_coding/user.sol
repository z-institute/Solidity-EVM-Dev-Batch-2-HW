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