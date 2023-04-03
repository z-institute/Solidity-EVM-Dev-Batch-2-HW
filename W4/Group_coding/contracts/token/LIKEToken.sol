// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./ERC20/ERC20.sol";

contract LIKE is ERC20 {
    constructor() ERC20("LikeCoin", "LIKE") {
        _mint(msg.sender, 100_000_000 * 1 ether);
    }
}