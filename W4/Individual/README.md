# Summary
## Lesson 1 Making the Zombie Factory

![](https://i.imgur.com/8f0dDDQ.png)
### 1. Functions
* #### Private / Public Functions: 
In Solidity, functions are set to be public by default. This means that anyone, including other contracts, can call and execute the code of your contract's functions. However, it is generally considered good practice to make functions private by default to prevent potential vulnerabilities in your contract that could be exploited by attackers. You can then selectively make only the necessary functions public to expose them to the world.

Similar to function parameters, Solidity uses an underscore (_) at the beginning of the name of private functions to differentiate them from public functions.

```
function createZombie(string memory _name, uint _dna) public {
        zombies.push(Zombie(_name, _dna));
    }
```

```
function _createZombie(string _name, uint _dna) private{
        zombies.push(Zombie(_name, _dna));
    }
```
* #### Function return values:
In Solidity, the function declaration contains the type of the return value, e.g. string.
* #### View/Pure Functions::
View functions are read-only functions that do not modify the state of the contract. They are useful when you want to read the current state of the contract without changing it. View functions are executed locally and do not require a transaction to be mined on the blockchain.

`function sayHello() public view returns (string memory)`

On the other hand, pure functions,  do not read or modify the state of the contract. They are useful when you want to perform a calculation or transformation on some input parameters and return a result. Pure functions are also executed locally and do not require a transaction to be mined on the blockchain.

```
function _multiply(uint a, uint b) private pure returns (uint) {
  return a * b;
}
```
* #### Keccak256:
The keccak256 hash function essentially takes an input and transforms it into a unique 256-bit hexadecimal number. Even a minor alteration in the input data can produce a vastly different hash value.

```
//6e91ec6b618bb462a4a6ee5aa2cb0e9cf30f7a052bb467b0ba58b8748c00d2e5
keccak256(abi.encodePacked("aaaab"));
//b1f078126895a1424524de5321b339ab00408010b7cf0e6ed451514981e58aa9
keccak256(abi.encodePacked("aaaac"));
```
### 2. Events

Events in your contract can serve as a means of notifying your application's front-end that a specific action has taken place on the blockchain. This information can be detected by the front-end(JavaScript), which can then initiate appropriate responses.

```
// declare the event
event IntegersAdded(uint x, uint y, uint result);

function add(uint _x, uint _y) public returns (uint) {
  uint result = _x + _y;
  // fire an event to let the app know the function was called:
  emit IntegersAdded(_x, _y, result);
  return result;
}
```


----
## Lesson 2 Zombies Attack Their Victims 
![](https://i.imgur.com/aJ38iVy.png)

### 3. The difference between storing variables in storage and memory.
"Storage refers to variables that are permanently stored on the blockchain.

```
Sandwich storage mySandwich = sandwiches[_index];
// mySandwich` is a pointer to `sandwiches[_index]`

mySandwich.status = "Eaten!";
 // ...this will permanently change `sandwiches[_index]` on the blockchain.
```

While memory variables are temporary and only exist between external function calls. This is like the difference between a computer's hard drive and its RAM.

```
// If you just want a copy, you can use `memory`:
Sandwich memory anotherSandwich = sandwiches[_index + 1];
 // `anotherSandwich` will simply be a copy of the
// data in memory, and...
anotherSandwich.status = "Eaten!";
 // ...will just modify the temporary variable and have no effect on `sandwiches[_index + 1]`. But you can do this:
sandwiches[_index + 1] = anotherSandwich;
```

Most of the time, it's not necessary to explicitly use these keywords because Solidity handles them automatically. Variables declared outside of functions are stored in storage and written permanently to the blockchain by default, while variables declared within functions are stored in memory and are erased when the function call ends.




### 4. The difference between internal and external functions.

In Solidity, the visibility specifiers internal and external modify the accessibility of functions and state variables within a contract.

The internal specifier is the same as private, but with the additional feature that it can also be accessed by any contracts that inherit from the current contract. This can be useful when you want to expose certain functions or state variables to derived contracts, while keeping them hidden from the outside world.

On the other hand, the external specifier is similar to public, except that the functions marked as external can only be called from outside the contract. They cannot be invoked by other functions within the same contract. This can be helpful in situations where you want to limit access to certain functions to external actors only, such as other contracts or external user interfaces.
`
```
contract Sandwich {
  uint private sandwichesEaten = 0;

  function eat() internal {
    sandwichesEaten++;
  }
}

contract BLT is Sandwich {
  uint private baconSandwichesEaten = 0;

  function eatWithBacon() public returns (string memory) {
    baconSandwichesEaten++;
    // We can call this here because it's internal
    eat();
  }
}
```

### 5. Mappings
A mapping is a data structure that functions as a repository for data, organized as key-value pairs and utilized for both storage and retrieval purposes

In the example, we will utilize two mappings to maintain records of zombie ownership: one for tracking the address of the zombie's owner, and another for keeping count of the number of zombies owned by each owner.

```
mapping (uint => address) public zombieToOwner;
mapping (address => uint) ownerZombieCount;
```
    
### 6. Msg.sender
Solidity provides access to a set of global variables that are universally accessible to all functions. One such variable is msg.sender, which corresponds to the address of the entity (be it a person or smart contract) that initiated the current function call. By leveraging msg.sender, one can ensure the security of their data on the Ethereum blockchain, as any attempts to modify another user's data would require access to the private key linked to their Ethereum address.

An example of using msg.sender and updating a mapping:

```
mapping (address => uint) favoriteNumber;

function setMyNumber(uint _myNumber) public {
  // Update our `favoriteNumber` mapping to store `_myNumber` under `msg.sender`
  favoriteNumber[msg.sender] = _myNumber;
  // ^ The syntax for storing data in a mapping is just like with arrays
}

```
---
## ChainShot

![](https://i.imgur.com/0XVOBbd.png)

