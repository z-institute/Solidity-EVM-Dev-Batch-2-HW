// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LIKE is ERC20, Ownable {
    // address public owner; 在使用自己的錢包地址部署合約時就會是owner了
    address public rewardsAddr; //獎金合約地址
    uint256 public cap; // max supply

    // 假設當reward合約有變動時，發出event，log記錄下來
    event RewardsChanged(address indexed newRewards);

    // initialSupply: total amount of tokens ，代幣總量上限在部署前就須設好，若無限制上限幣價會容易沒有價值
    constructor(uint256 initialSupply, uint256 _cap) ERC20("LikeCoin", "LIKE") {
        cap = _cap; // 部署合約初始化時，就設定最大供給量給變數cap
        _mint(_msgSender(), initialSupply); // msg.sender也就是部署合約的owner才可以鑄造代幣，引用了context.sol合約
    }

    // check cap when minting new tokens
    function _mint(address account, uint256 amount) internal virtual override onlyOwner {
        require(totalSupply() + amount <= cap, "Cap exceeded"); // 總量加上要鑄造的量，不可超過cap
        super._mint(account, amount); // super 與意是為了蓋過ERC20.sol的mint函數
    }

    // set relvent contracts to mint tokens
    function setRewardsContract(address _newRewardsAddr) external onlyOwner {
        require(_newRewardsAddr != address(0), "Invalid address"); // 合約地址不可為0
        rewardsAddr = _newRewardsAddr;
        emit RewardsChanged(_newRewardsAddr);
    }

}