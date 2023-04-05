// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

interface IScratchTicket {
    function scratch(uint256 tokenId) external returns (bool);
    function isScratched(uint256 tokenId) external view returns (bool);
    function burn(uint256 tokenId) external;
}

interface IScratchTicketSale {
    function buyTicket() external payable returns (uint256);
    function setPrice(uint256 price) external;
    function getPrice() external view returns (uint256);
    function withdraw() external;
    function setPayMaster(address payable payMaster) external;
}

interface IPayMaster {
    function pay(address payable recipient, uint256 amount) external;
}