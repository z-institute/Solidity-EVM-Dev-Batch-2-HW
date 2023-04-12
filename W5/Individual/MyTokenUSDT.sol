// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract MyTokenUSDT is ERC20 {
    constructor () ERC20 ("MyToken", "TTT"){}


    // use USDT to mint
    function mint() external {
        // need to do approve first (via script or UI), approve(0xcontract, 1000000)
        IERC20(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266).transferFrom(msg.sender, address(this), 1000000);
        // IERC721(0x1234)
        _mint(msg.sender, 1 ether);
    }


        // get USDT balance of the contract
    function getUSDTBalance() external view returns(uint256) {
        return IERC20(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266).balanceOf(address(this));
    }
   
    // withdraw USDT from the contract
    function withdrawUSDT(uint256 amount) external {
        IERC20(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266).transfer(msg.sender, amount);
    }
}