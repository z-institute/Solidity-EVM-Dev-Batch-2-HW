# 個人作業


## [studying-solidity](https://www.chainshot.com/md/studying-solidity)

![](https://i.imgur.com/bbQe7ym.png)

```
/* Here we specify the solidity versions
 * Any version greater than or equal to 0.6.2
 * or less than 0.7.0 will compile this contract */
pragma solidity ^0.6.2;

contract OnOffSwitch {
    // the switch is on if true
    bool private isOn;

    constructor() public {
        // we'll default to being on
        isOn = true;
    }

    // a publicly accessible function to "flip" the switch
    function toggle() public returns(bool) {
        // flip isOn from true->false or false->true
        isOn = !isOn;
        // return the new value
        return isOn;
    }
}
```

First let's look at the familiar! Things that are similar to JavaScript:

1. Comments appear to be the same! Both syntaxes: // comment and /* comment */
2. The casing used is the same as JavaScript, it is lowerCamelCase
3. Curly Braces {} seem to serve a similar purpose, marking scope
4. Boolean values true/false which can be modified with boolean operators: !
1. The contract keyword seems a bit like JavaScript class, especially the constructor
1. The function syntax looks a bit similar to JavaScript
2. The return keyword is still used for passing a value back from a function


Now let's look at the dissimilarities:

1. There seems to be some kind of version control statement at the top: pragma
1. There are public/private keywords for variables and functions
1. The isOn variable is prefaced with its type bool
1. The code refers to the isOn member variable without using this
1. The function toggle defines what it will return, a bool


---


### The Contract 

```
contract OnOffSwitch {
    // the switch is on if true
    bool private isOn; isOn -> state variables

    constructor() public { -> run only once when it is deployed.
        // we'll default to being on
        isOn = true;
    }
}
```

Since state variables are referred to by name, you may often see constructor arguments using underscores to disambiguate:

```
constructor(bool _isOn) public {
    // in this case we'll accept a boolean argument
    // that will set the initial value of isOn
    isOn = _isOn;
}
```

permanent storage on the blockchain is stored in Patricia Merkle Tries on every Ethereum Full Node

Local variables defined inside of a code block {} or passed in as arguments live in memory only for the length of their particular scope.



--

note
```
- constructor: run only once when it is deployed.
- isOn -> state variables
- The "this" keyword is still used in Solidity as a reference to the contract account.
```


---


### Control Structures


multiple values can be returned from a Solidity function

```
function getValues() public pure returns (int, bool) {
    return (49, true);
}
```

destructure assignments 

```
(bool x, bool y) = (true, false);
```


---


### Visibility

```
public / private / internal / external
```

public 與 external 都會讓 function 公開；相反的 internal 與 private 的 functions 只能被合約內部叫用。

限制多寡的順序是︰ public < external < internal < private

公開 use cases︰

> 比如說，如果你確定不對內公開，最好宣告為 external。external 有個好處是 call 的參數是從 CALLDATA 獲得，不需要 copy 到 memory 才能執行該 function call。所以比較省 gas，尤其是處理參數是 array 時更凸顯其效果。
但用 external，自己合約如果要調用，反而要寫 this.f() 編譯器才能接受，通常是多此一舉。而且會呼叫 CALL 指令，跟 JUMP 指令比，花更多 gas。

不公開 use cases︰

> 當合約自己內部的 functions 不想被外部合約或程式調用，最好是用 internal 或甚至用 private 來做限制。internal 還可以被繼承的合約來調用，而 private 就只能自己合約內使用。
它們會被用 JUMP 指令來呼叫，比較省 gas。

---

### Static Typing


all variables must declare their type

```
// It must always be true or false.
bool isOn = true; 
```


--

note

```
- By default, boolean values are false.
- type can't change
```

---


### Basic Solidity Data Types

```
contract Contract {
    bool public value = true;
    int public a = 10;
    string public msg = "Hello World";
}
```

It's important to do things efficiently since all storage and computation on the blockchain will cost money.


---


State Variables are stored in the contract's **persistent memory**. Modifying a state variable in one transaction will change its value for anyone who tries to read the variable afterwards.

---


### Integers

```
uint8: Ranges from 0 to 255
int8: Ranges from -128 to 127
```

---

### Bytes

```
fixed-size / dynamically-sized
```


```
bytes1 a = 0x1f; // 0001 1111
=> 0x1f => 1在16進位制中為0001，f在16進位制中為1111 (2^0+2^1+2^2+2^3 = 1+2+4+8 = 15)

bytes2 b = 0xbeef; // 1011 1110 1110 1111
bytes3 c = 0xabcdef; // 1010 1011 1100 1101 1110 1111

byte b = 0xa3; // <-- byte is an alias for bytes1
```

--

```
bytes2 a = 0x1337;
=> a = [13,37]

console.log( a[1] ); // 37
```

--

```
bytes2 public a = 0x1023; // 0001 0000 0010 0011
bytes2 public b = 0x0314; // 0000 0011 0001 0100
bytes2 public leet = a | b;  // 0001 0011 0011 0111
```

note 

```
 You can see that each time we go up 1 byte we can store two new hexadecimal characters. Each hexadecimal character can be represented in 4 bits.
```

---

### String Literals

If the string is shorter than 32 bytes, it is more efficient to store it in a fixed-size byte array like bytes32

Many characters in UTF-8 encoding can be represented with 1 byte while others are represented with several bytes. For instance c is encoded by 0x63, while ć is encoded by 0xc487.

```
bytes32 msg1 = "cccccccccccccccccccccccccccccccc"; 
bytes32 msg2 = "ćććććććććććććććć"; 
```

---


### Enum Type

```
// bad
if(player.movement == 0) {
    // player is moving up
}
else if(player.movement == 1) {
    // player is moving left
}
.
.
.
// good
enum Directions = { Up, Left, Down, Right }
if(player.movement == Directions.Up) {

}
else if(player.movement == Directions.Left) {
    
}
```

---

### Solidity Arguments


#### constructor


The constructor function is invoked only once during the contract's deployment and never again. It is generally used for setting up initial contract values.


```
bool public isOpen;

constructor(bool _isOpen) {
    isOpen = _isOpen;
}
```

Notice how the parameter name (_isOpen) has an underscore in front of it? This prevents the variable from having the same name as the state variable. When the names collide it is referred to as variable shadowing. 

--

Create a constructor which will take a uint as an argument.

Store this uint value inside a public state variable called x.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


contract Contract {
    uint public x;
    constructor(uint _x) {
        x = _x;
    }
}
```

External is better than public if you know that you are only calling the function externally (outside the EVM). Public visibility requires more gas because it can be called externally and internally.

--

note

```
Many of the shorthand operators we've become accustomed to in languages like JavaScript will also available in Solidity: 
-=, *=, /=, %=, |=, &=, ^=, ++ and --.
```

---

### Returning Values

```
// SPDX-License-Identifier: MIT
pragma solidity 0.7.5;

contract Contract {
	bool _isRunning = true;

	function isRunning() external view returns(bool) {
		// return the state variable
		return _isRunning;
	}
}
```

Adding the view keyword to the isRunning function signature guarantees it will not modify state variables. You can think of view functions as read-only; they can read the state of the contract but they cannot modify it.

--

Create an external view function add which takes a uint parameter and returns the sum of the parameter plus the state variable x.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


contract Contract {
    uint public x;
    constructor(uint _x) {
        x = _x;
    }
    function increment() external{
        x += 1;
    }
    function add(uint a) external view returns(uint){
        return x + a;
    }
}
```

---


### Pure Functions

當函式不讀取，不異動狀態就會用 pure


```
function double(uint x, uint y) external pure returns(uint) {
    return x + y;
}
```
 
  If we tried attempted to modify state in a pure function the compiler would throw an error along the lines of "Function declared as pure, but this expression (potentially) modifies the state".
  
  
--
 
note

```
This function is just performing simple arithmetic without reading/writing state so we can label it pure.
 ```
 
---

### Overloading Functions
 
In Solidity it is perfectly valid to declare two functions with the same name if they have different parameters:
 
```
function add(uint x, uint y) external pure returns(uint) {
    return x + y;
}
function add(uint x, uint y, uint z) external pure returns(uint) {
    return x + y + z;
}
```
Solidity will **call the function signatures that matches the arguments provided**. For example, add(2,4) will invoke the first funciton while add(2,3,4) will invoke the second function.

Also, Solidity can return multiple values from functions:

```
function addTwo(uint x, uint y) external pure returns(uint, uint) {
    return (x + 2, y + 2);
}

(uint x, uint y) = addTwo(4, 8);
console.log(x); // 6
console.log(y); // 10
```

---

### Libraries

Using libraries can:

* Reduce new code, limiting the opportunity for bugs 
* Save development time by not re-inventing the wheel 
* Secure your contracts with audited code and best practices 
* Save gas on deployments by making use of already deployed code 

[可參考：openzeppelin-contracts](
https://github.com/OpenZeppelin/openzeppelin-contracts)

--

note 

```
- One major difference between libraries and contracts is that libraries do not have state. Trying to declare a state variable on a library will not compile.
- Libraries also cannot recieve ether, inherit (or be inherited from), or be destroyed. 
- The purpose of libraries is to share code.
```

--


### Using the Library

```
import "./UIntFunctions.sol";
contract Example {
    using UIntFunctions for uint;
    function isEven(uint x) public pure returns(bool) {
        return x.isEven();
    }
}
```
--

We have a contract called Game, you can find it on the new Game.sol tab! 

This contract has two state parameters: participants and allowTeams.

Your goal is to create a constructor which takes a uint parameter for the number of participants in the game. Store this uint in the participants state variable.

This game can be played free-for-all or team-against-team. To make sure the teams have the same number, ensure that the boolean allowTeams is only true if the number of participants is even.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./UIntFunctions.sol";

contract Game {
    uint public participants;
    bool public allowTeams;

    constructor(uint x){
        participants =  x;
        allowTeams = UIntFunctions.isEven(x);
    }
}
```
---

### Console Log

```
import "hardhat/console.sol";

console.log(x);
```

---
 
### Block Global
 
Among many global properties we can access inside Solidity is the block.
 
 
* block.coinbase - The miner of this block's address 
* block.difficulty - The difficulty of the current block
* block.gaslimt - The total gaslimit of the block
* block.number - The current block number
* block.timestamp - The current timestamp of the block (in seconds since unix epoch)


---

### Accounts

Every account on the EVM has a public address and a balance. Contract accounts will also store their bytecode as well as their internal storage data.

When making a call from an EOA to a Contract Account it's important to know things like who is making the call, how much ether they are sending and the function they are intending to invoke with which arguments.

Access to the transaction parameters through globals like msg.sender and msg.value.

--

an address on the EVM is a 160 bits long, or a 40 character, hexadecimal string:

```
address a = 0xc783df8a850f42e7f7e57013759c285caa701eb6;
```

We can also find the sender of the current message:

```
import "hardhat/console.sol";
contract Example {
    constructor() {
        console.log( msg.sender ); // 0xc783df8a850f42e7f7e57013759c285caa701eb6
    }
}
```

(*) The only difference between address and address payable types is that **address payable has the methods transfer and send**.

--

The first assignment stores an address payable in a address payable state variable. No conversion needed!

(*) The next two assignments show data type conversion. Notice how an address payable can be implicitly converted to address (b = _b). Meanwhile the type address must be explicitly converted to address payable via payable() (c = payable(_c)).

```
contract Example {
    address payable a;
    address b;
    address payable c;

    constructor(
        address payable _a, 
        address payable _b, 
        address _c
    ) {
        a = _a; // store payable in payable
        b = _b; // implicit conversion to nonpayable
        c = payable(_c); // explicit conversion to payable
    } 
}
```

--

Let's make the owner state variable address payable!
This way in future stages we'll be able to transfer ether to the owner.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Contract {
    address payable public owner;
    constructor(){
        owner = payable(msg.sender);
    }
}
```

--

note
```
msg.value： how much wei the sender sent
msg.sender：sender's address
```

---

### Receive Function

In the latest versions of Solidity, contracts cannot receive ether by default.

In order to receive ether, a contract must specify a payable function. This is another keyword which affects the function's mutability similar to view and pure.

```
view / pure / payable / nonpayable
```
--

Here the msg.value is the amount of ether sent to this function pay measured in Wei.

```
import "hardhat/console.sol";
contract Contract {
    function pay() public payable {
        console.log( msg.value ); // 100000
    }
}
```

--

It is the function that runs when a contract is sent ether without any calldata.

The receive function **must be external, payable, it cannot receive arguments and it cannot return anything.**

```
import "hardhat/console.sol";
contract Contract {
    receive() external payable {
        console.log(msg.value); // 100000
    }
}
```

---

### Transferring Funds

```
contract Contract {
    address payable public a;
    address payable public b;
    constructor(address _a, address _b) {
        a = _a;
        b = _b;
    }
    function payA() public payable {
        a.transfer(msg.value);
    }
    function payB() public payable {
        b.transfer(msg.value);
    }
}
```

---

### Contract Account

Within contracts, the this keyword can explicitly converted to an address:

```
import "hardhat/console.sol";
contract Contract {
	constructor() {
		console.log( address(this) ); // 0x7c2c195cd6d34b8f845992d380aadb2730bb9c6f
		console.log( address(this).balance ); // 0
	}
}
```

--


Let's take all funds that were passed to the receive function and donate them to charity. We'll do this in two steps.

First, modify the constructor to accept a new argument: the charity address.

Next, add a new function called donate. When this function is called transfer all remaining funds in the contract to the charity address.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Contract {
	address payable public owner;
	address payable public charity;

	constructor(address payable _charity) {
		owner = payable(msg.sender);
		charity = _charity;
	}

	receive() external payable { }

	function donate() public {
		charity.transfer(address(this).balance);
	}

	function tip() public payable {
		owner.transfer(msg.value);
	}
}
```

---

### (*) Self Destruct

After 10 calls to the tick function the Contract will selfdestruct! 

The address provided to the selfdestruct function gets all of the ether remaining in the contract! **Ether sent to the payable constructor will be refunded to the final caller of the tick function**.

```
contract Contract {
    uint _countdown = 10;

    constructor() payable {}

    function tick() public {
        _countdown--;
        if(_countdown == 0) {
            selfdestruct(msg.sender);
        }
    }
}
```

---

### Importing Enums

enum讓使用者可以自定義變數而不需要指定型態。
```
enum myMove{ Up, Left, Down, Right}
```
enum裡面的值依照宣告的順序從零開始遞增，可以轉換成正整數(uint)

```
uint(myMove.Up);      //0
uint(myMove.Left);    //1
```

可以利用enum來模擬合約狀態轉換：

```
enum State { Created, Locked, Inactive }
State public state;                 //default is 0 which is Created
modifier inState(State _state) {
        if (state != _state) throw;
        _;
}
```

--

(*) 

![](https://i.imgur.com/tTrJvXm.png)

```
// Game.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Game {
	int public team1Score;
	int public team2Score;

	enum Teams { Team1, Team2 }

	function addScore(Teams teamNumber) external {
		// TODO: add score to the specified team
		if(teamNumber == Teams.Team1){
			team1Score++;
		}else{
			team2Score++;
		}
	}
}
```

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./Game.sol";

contract Bet {
    <!-- 不懂 -->
        // 可以直接呼叫game這個function來查看目前狀態
	Game public game;
	constructor(address _game) {
		game = Game(_game);
	}
    <!-- 不懂 -->
	
	// calculates the payout of a bet based on the score difference between the two teams
	function calculatePayout(uint amount, int scoreDifference) private pure returns(uint) {
		uint abs = uint(scoreDifference > 0 ? scoreDifference : scoreDifference * -1);	
		uint odds = 2 ** abs;
		if(scoreDifference < 0) {
			return amount + amount / odds;
		}
		return amount + amount * odds;
	}

    <!-- 不懂 -->
	function getScoreDifference(Game.Teams teamNumber) public view returns(int256){
		if(teamNumber == Game.Teams.Team1){
			return game.team1Score() - game.team2Score();
		}
		return game.team2Score() - game.team1Score();
	}
    <!-- 不懂 -->
}
```

---

### Private Functions 

私有函式，只能被自己合約所調用，也不會被繼承合約調用。

A good rule of thumb for function visibility is to start by making a function private. **If it needs to be called by EOAs, make it external. If it needs to be called by both EOAs and other contracts, make it public.**


---

### Interfaces

* cannot have any functions implemented
* can inherit from other interfaces
* all declared functions must be external
* cannot declare a constructor
* cannot declare state variables

```
interface Token {
	function transfer(address recipient, uint256 amount) external returns (bool);
}
```

```
import "./Token.sol";
import "hardhat/console.sol";
contract Example {
	function makeTransfer(address tokenAddress) public {
		Token token = Token(tokenAddress);
		// transfer 100 of the token 
		// from this contract to the msg.sender
		bool success = token.transfer(msg.sender, 100);
		// was the transfer successful?
		console.log(success);
	}
}
```

---


### Emitting an Event

Events are typically UpperCamelCase whereas function names are lowerCamelCase.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Collectible {
    event Deployed(address);
    constructor(){
        emit Deployed(msg.sender);
    }
}
```

---

### indexed

We can make it easy to filter on event arguments by adding an indexed keyword:

```
event HighScore(address indexed player);
```
---


## [cryptozombies](https://cryptozombies.io/en/course)

### Chapter 1: Lesson 1 

![](https://i.imgur.com/hZM3gqW.jpg)

--

### Structs

For more complex data type, Solidity provides structs:

```
struct Person {
  uint age;
  string name;
}
```

--

### Function Declarations

- By value, which means that the Solidity compiler creates a new copy of the parameter's value and passes it to your function. This allows your function to modify the value without worrying that the value of the initial parameter gets changed.
- By reference, which means that your function is called with a... reference to the original variable. Thus, if your function changes the value of the variable it receives, the value of the original variable gets changed.

note

```
It's convention (but not required) to start function parameter variable names with an underscore (_) in order to differentiate them from global variables. We'll use that convention throughout our tutorial.
```


---


### Chapter 1: Lesson 2

![](https://i.imgur.com/lgHQsv8.jpg)

### Mappings

Mappings are another way of storing organized data in Solidity.

```
// For a financial app, storing a uint that holds the user's account balance:
mapping (address => uint) public accountBalance;
// Or could be used to store / lookup usernames based on userId
mapping (uint => string) userIdToName;
```

--

### msg.sender

msg.sender, which refers to the address of the person (or smart contract) who called the current function.


function execution always needs to **start with an external caller**. A contract will just sit on the blockchain doing nothing until someone calls one of its functions. So there will always be a msg.sender.

--

###  Require

錯誤的檢查和處理很重要，Solidity裡雖然沒有ErrorMessage，但有Require()、Revert()、Assert()這三個函數。

require是最常用的錯誤檢查函數，常出現在function的一開始，做為檢查參數是否有錯誤用，由於require為false時會退回剩下的gas，所以才會放在function的一開始，這樣就能節省gas fee。

```
require(判斷式, 返回字串)
```

```
資料來源：
https://medium.com/taipei-ethereum-meetup/%E6%AF%94%E8%BC%83-require-assert-%E5%92%8C-revert-%E5%8F%8A%E5%85%B6%E9%81%8B%E4%BD%9C%E6%96%B9%E5%BC%8F-30c24d534ce4
https://vocus.cc/article/62012998fd8978000141dd23
```

--

###  Storage vs Memory (Data location)

- Storage refers to variables stored permanently on the blockchain. 
- Memory variables are temporary, and are erased between external function calls to your contract.

--

### Internal and External

- Internal is the same as private, except that it's also accessible to contracts that inherit from this contract. (Hey, that sounds like what we want here!).
- External is similar to public, except that these functions can ONLY be called outside the contract — they can't be called by other functions inside that contract. We'll talk about why you might want to use external vs public later.

