 
## What aspects we should be considered when we are developing a secure smart contract?

### ConsenSys
There are several suggestions are made for developers who need to pay attention to the following aspects to avoid these issues:

1. Try to avoid external calls to malicious code.
2. Carefully the use of "send()", "transfer()", and "**call.value()**".
3. Prefer to use a pull approach rather than a push approach for external contracts.
4. Mark untrusted contracts.
5. Use **assert()** to trigger assertion protection when the assertion condition is not satisfied, but be aware that it often needs to be combined with other techniques, and use **assert()** and **require()** correctly.
6. Be careful with rounding in integer division.
7. Ether can be forced to be sent to an account, and an attacker can create a contract with just 1 wei and then call selfdestruct(victimAddress).
8. Lock the program to a specific compiler version.
9. Differentiate between functions and events.
10. Keep the "**Fallback function**" as simple as possible.
11. Avoid prematurely releasing user information to protect privacy.
12. Do not assume that the contract balance is zero when it is created.
13. In the design and writing phase of the smart contract, we can browse [**known attacks**](https://consensys.github.io/smart-contract-best-practices/attacks/) to familiar attack.
14. Consider Circuit Breakers, Speed Bumps and Rate Limiting to prepare for failure of predictable failures.
16. Make good use of [**tools**](https://consensys.github.io/smart-contract-best-practices/security-tools/) to test and improve code quality.
17. Developers should prepare for failure, such as they set up " [**Bug Bounty Program**](https://consensys.github.io/smart-contract-best-practices/bug-bounty-programs/) to attract others to review the code.

---
###     Flash loan-funded price oracle attack.

Recently, several security risks that may arise in DeFi, including flash loan attacks, centralized price oracles, and other risks that may lead to fund loss and market fluctuations.

To improve the security of the DeFi ecosystem, here are some key solutions:

1.  Strengthen the security of smart contracts
2.  Increase decentralization
3.  Improve the security of transactions
4.  Use more reliable price oracles. For example, using multiple price oracles to determine the average price, or using decentralized oracles.

---

### Blockchain oracles

Oracles are third-party services that provide data to smart contracts on a blockchain. Smart contracts are self-executing programs that run on a blockchain, and they require reliable and accurate data to function properly.

Blockchain oracles provide this data by connecting off-chain data sources, such as websites or APIs, to the blockchain. They retrieve data from these sources and deliver it to the smart contract in a secure and trustless pattern.

Chainlink network, which is a decentralized network of oracles that can be used to connect smart contracts to external real-world data sources. It can use on insurance, enterprise, sustainability, dynamic NFTs and gaming,

 


---
### Summary

According to three articles, I conclude several suggesttions for avoiding attack problems.

Developers code focus on readability, simple and clear. When developer use clear variable and function names, and use an easily understandable code structure so that the contract ca to n be more easily maintained and upgraded. In the other word, they ensure that the code can be easily extended and upgraded to meet future needs and security issues.

To prevent more and more Flash loan-funded price oracle attack, developers can use blockchain oracle services like Chainlink to obtain reliable, decentralized price data to reduce problems caused by the failure of centralized price oracles.

In summary, developers must follow the best practices of secure design and coding, the article also provide a lot of examples of good and bad code patterns to understand easily.
Developer includes use automated testing tools and manual testing techniques, invite others to review the code, and regularly update and maintain the contract to ensure the security and reliability of smart contracts.


----

##### Scource:
https://github.com/ConsenSys/smart-contract-best-practices/blob/master/README-zh.md
https://insights.glassnode.com/defi-attacks-flash-loans-centralized-price-oracles/
https://chain.link/education/blockchain-oracles



