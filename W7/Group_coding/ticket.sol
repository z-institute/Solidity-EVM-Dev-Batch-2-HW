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
