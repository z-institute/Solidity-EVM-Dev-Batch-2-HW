// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract WeekFive is ERC20 {

    address private _mockUSDT = 0xd9145CCE52D386f254917e481eB44e9943F39138;

    constructor() ERC20("WeekFive", "WF") {}

    // use USDT to mint
    function mint() external {
        // need to do approve first (via script or UI), approve(0xcontract, 1000000)
        IERC20(_mockUSDT).transferFrom(
            msg.sender,
            address(this),
            1 ether
        );
        // IERC721(0x1234)
        _mint(msg.sender, 1 ether);
    }

    function mintByETH() external payable {
        require(msg.value == 1 ether, "Not enough");
        _mint(msg.sender, 1 ether);
    }

    function balanceOf() external view returns (uint256) {
        return
            IERC20(_mockUSDT).balanceOf(
                address(this)
            );
    }

    function withDraw(address to, uint256 amount) external {
        IERC20(_mockUSDT).transfer(
            to,
            amount * 1 ether
        );
    }
}
