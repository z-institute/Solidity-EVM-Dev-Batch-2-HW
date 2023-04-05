// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

interface IScratchTicket {
    function scratch(uint256 tokenId) external returns (bool);
    function isScratched(uint256 tokenId) external view returns (bool);
}

interface IScratchTicketSale {
    function buyTicket() external payable returns (uint256);
    function setPrice(uint256 price) external;
    function getPrice() external view returns (uint256);
    function withdraw() external;
}