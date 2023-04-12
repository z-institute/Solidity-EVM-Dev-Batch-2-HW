# w5 individual

### test.sol
```solidity=
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract MyToken is ERC20 {
    IERC20 public usdt;
    constructor(IERC20 _usdt) ERC20("MyToken", "MTK") {
        usdt = _usdt;
        _mint(msg.sender, 1000000000000);
    }

    function buyToken(uint256 amount) public {
        require(usdt.transferFrom(msg.sender, address(this), amount), "USDT transfer failed");
        _mint(msg.sender, amount);
    }

    function getUSDTBalanceOfContract() public view returns(uint256){
        return usdt.balanceOf(address(this));
    }

    function withdrawUSDT(uint256 amount) external payable {
        require(amount <= usdt.balanceOf(address(this)), "Insufficient contract balance");
        usdt.transfer(msg.sender, amount);
    }
}
```

### USDT.sol
```solidity=
// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyUSDT is ERC20 {
    uint256 public usdtBalance;


    constructor(uint256 initialSupply) ERC20("USDT", "USDT") {
        _mint(msg.sender, initialSupply);
    }
}

```


## MyNFT.sol
```solidity=
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";


contract MyNFT is ERC721 {
    using SafeERC20 for IERC20;
    using Counters for Counters.Counter;

    string public baseURI;
    IERC20 public payToken;
    uint256 public maxMintPerAddress;
    uint256 public paymentAmount;
    address public owner;

    Counters.Counter private _tokenIdTracker;
    mapping(address => uint256) private _addressMintCount;

    constructor(IERC20 _myERC20) ERC721("MyNFT", "MNT") {
        owner = msg.sender;
        payToken = _myERC20;
        paymentAmount = 1 ether;
        _mint(msg.sender, 1000000000000);
        maxMintPerAddress = 5;
        baseURI = "https://gateway.pinata.cloud/ipfs/QmT6tujkbPh7oWdjqLEZgstHVaJB6QEqiWBiayFxaC1PtD";
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function mint() external {
        require(_addressMintCount[msg.sender] < maxMintPerAddress, "Mint limit exceeded for address");
        payToken.safeTransferFrom(msg.sender, address(this), paymentAmount);

        uint256 tokenId = _tokenIdTracker.current();
        _safeMint(msg.sender, tokenId);
        _tokenIdTracker.increment();
        _addressMintCount[msg.sender]++;

        emit Transfer(address(0), msg.sender, tokenId);
    }

    function updateBaseURI(string memory _newBaseURI) external onlyOwner {
        baseURI = _newBaseURI;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }
}
```


![](https://i.imgur.com/UpSydev.png)

- buy token
![](https://i.imgur.com/93zgxTN.png)

- get usdt balance
![](https://i.imgur.com/2HVnZ6r.png)


- withdraw
![](https://i.imgur.com/KW4B57B.png)


## 加分題
scaffoldeth
![](https://i.imgur.com/7B9cIcg.jpg)