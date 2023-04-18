// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MockUSDT is ERC20 {
    constructor() ERC20("MockUSDT", "USDT") {
        _mint(msg.sender, 1 ether);
    }
}