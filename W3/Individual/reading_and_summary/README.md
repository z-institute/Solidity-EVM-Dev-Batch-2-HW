# 補充閱讀


閱讀完後用自己的話寫下 summary，和以開發者角度該如何避免類似問題 / 寫一個安全的智能合約需要注意哪些方面？

---
[DeFi Attacks: Flash Loans and Centralized Price Oracles](https://insights.glassnode.com/defi-attacks-flash-loans-centralized-price-oracles/ )


summary：
```
1. The most common variant of this attack is the flash loan-funded price oracle attack. 
   These attacks use flash loans to exploit vulnerabilities in centralized price oracles, manipulate assets prices, and siphon funds from contracts.
   In such events,attackers essentially create artificial arbitrage opportunities by instantaneously borrowing, swapping, depositing, and again borrowing large numbers of tokens. This action exploits a vulnerability in certain price oracles, which leads to a target token's price being artificially moved on a single exchange; a disparity which can then be arbitraged.
2. How do Flash Loans Work? a user can borrow a large amount of funds without putting up collateral, allowing them to leverage themselves without risking their own funds.
  （閃電貸：用戶無需提供抵押品即可借出大量資金，使他們能夠在不冒自己資金風險的情況下利用自己的槓桿作用 borrow->use->repay ）
3. This means that users of flash loans, including attackers, assume very little risk; if the transaction does not "break even" and the loan cannot be paid back, the whole thing reverts, meaning the user loses nothing more than the cost of gas. In contrast, the potential returns are considerable.
   (承擔的風險很小，如果交易沒有"收支平衡"，無法償還貸款，則整個事情都會恢復，用戶只損失 gas fee)
4. Flash loans do make attacks more viable for several reasons:
  * Zero Upfront Capital 
  * Less Capital at Risk 
5. The real culprit is not flash loans, but vulnerabilities in smart contracts.
6. Many DeFi protocols have opted use centralized price oracles. These feeds draw prices directly from asset pairs on a single decentralized exchange (DEX). 
   If an attacker can manipulate the price of an asset on that single DEX, this leads to inaccurate price data being fed to all protocols which rely on that DEX as a price oracle, making them vulnerable to exploitation. Flash loans make it easy to manipulate price data on a single DEX.
7. Other Flash Loan Attacks example: This attack did not rely on a centralized price oracle, but rather a vulnerability in Origin's rebasing mechanism.
8. Attack on Cheese Bank（https://etherscan.io/address/02b7165d0916e373f0235056a7e6fccdb82d2255）
9. Conclusions: This kind of attack could have been executed by anyone with sufficient capital, but was made easier through the availability of flash loans. This string of attacks highlights the importance of DeFi protocols using decentralized price oracles.
```
note：
```
1. stop using single source price oracles.
2. 避免使用中心化的 price oracles.
```
---

[Ethereum Smart Contract Security Best Practices](https://consensys.github.io/smart-contract-best-practices/ )

[git repo](https://github.com/ConsenSys/smart-contract-best-practices)

summary：

```
- Development Recommendations contains examples of good code patterns

# General
  + External Calls
    => Every external call should be treated as a potential security risk. 
    => When interacting with external contracts, name your variables, methods, and contract interfaces in a way that makes it clear that interacting with them is potentially unsafe. This applies to your own functions that call external contracts.

    ```
    // bad
    Bank.withdraw(100); // Unclear whether trusted or untrusted

    function makeWithdrawal(uint amount) { // Isn't clear that this function is potentially unsafe
        Bank.withdraw(amount);
    }

    // good
    UntrustedBank.withdraw(100); // untrusted external call
    TrustedBank.withdraw(100); // external but trusted bank contract maintained by XYZ Corp

    function makeUntrustedWithdrawal(uint amount) {
        UntrustedBank.withdraw(amount);
    }
    ```

    => Avoid state changes after external calls - If you are making a call to an untrusted external contract, avoid state changes after the call. This pattern is also sometimes known as the checks-effects-interactions pattern.
    => Don't use transfer() or send(). - It's recommended to stop using .transfer() and .send() and instead use .call(). To prevent reentrancy attacks, it is recommended that you use the checks-effects-interactions pattern.

    ```
    // bad
    contract Vulnerable {
       function withdraw(uint256 amount) external {
         // This forwards 2300 gas, which may not be enough if the recipient
         // is a contract and gas costs change.
         msg.sender.transfer(amount);
      }
    }

    // good
    contract Fixed {
      function withdraw(uint256 amount) external {
         // This forwards all available gas. Be sure to check the return value!
         (bool success, ) = msg.sender.call.value(amount)("");
         require(success, "Transfer failed.");
      }
    }
    ```

    => Handle errors in external calls - Solidity offers low-level call methods that work on raw addresses: address.call(), address.callcode(), address.delegatecall(), and address.send(). If you choose to use the low-level call methods, make sure to handle the possibility that the call will fail, by checking the return value.

    ```
    // bad
    someAddress.send(55);
    someAddress.call.value(55)(""); // this is doubly dangerous, as it will forward all remaining gas and doesn't check for result
    someAddress.call.value(100)(bytes4(sha3("deposit()"))); // if deposit throws an exception, the raw call() will only return false and transaction will NOT be reverted

    // good
    (bool success, ) = someAddress.call.value(55)("");
    if(!success) {
      // handle failure code
    }

    ExternalContract(someAddress).deposit.value(100)();
    ```

    => Favor pull over push for external calls - better to isolate each external call into its own transaction that can be initiated by the recipient of the call. This is especially relevant for payments, where it is better to let users withdraw funds rather than push funds to them automatically.

    ```
    // bad
    contract auction {
      address highestBidder;
      uint highestBid;

      function bid() payable {
         require(msg.value >= highestBid);

         if (highestBidder != address(0)) {
               (bool success, ) = highestBidder.call.value(highestBid)("");
               require(success); // if this call consistently fails, no one else can bid
         }

         highestBidder = msg.sender;
         highestBid = msg.value;
      }
    }

    // good
    contract auction {
      address highestBidder;
      uint highestBid;
      mapping(address => uint) refunds;

      function bid() payable external {
         require(msg.value >= highestBid);

         if (highestBidder != address(0)) {
               refunds[highestBidder] += highestBid; // record the refund that this user can claim
         }

         highestBidder = msg.sender;
         highestBid = msg.value;
      }

      function withdrawRefund() external {
         uint refund = refunds[msg.sender];
         refunds[msg.sender] = 0;
         (bool success, ) = msg.sender.call.value(refund)("");
         require(success);
      }
    }
    ```

    => Don't delegatecall to untrusted code

  + Public on-chain Data
    => make sure you avoid requiring users to publish information too early. The best strategy is to use commitment schemes with separate phases: first commit using the hash of the values and in a later phase revealing the values. 
    => A safer implementation would be to hash not just the name of the move, but also, say, a user chosen salt. That would make the resulting salt non-recognisable.
  + Negation of Signed Integers
    => In Solidity a signed integer with N bits can represent values from -2^(N-1) to 2^(N-1)-1. This means that there is no positive equivalent for the MIN_INT.Negation is implemented as finding the two's complement of a number, so the negation of the most negative number will result in the same number.

# Precautions
  + Deployment: 
    => Have a full test suite with 100% test coverage (or close to it)
    => Deploy on your own testnet
    => Deploy on the public testnet with substantial testing and bug bounties
    => Exhaustive testing should allow various players to interact with the contract at volume
    => Deploy on the mainnet in beta, with limits to the amount at risk

# Solidity-specific (*)
  ... 

# Token-specific: smart contracts of tokens should follow an accepted and stable standard.

- Known Attacks describes the different classes of vulnerabilities to avoid
  => You must treat any function which calls an untrusted contract as itself untrusted.
  => We have recommended finishing all internal work (ie. state changes) first, and only then calling the external function. 
  => Under no circumstances should a decentralized exchange's spot price be used directly for price discovery.
  => Transaction Order Dependence is equivalent to race condition in smart contracts. An example, if one function sets the reward percentage, and the withdraw function uses that percentage; then withdraw transaction can be front-run by a change reward function call, which impacts the amount that will be withdrawn eventually.
  => The best remediation is to remove the benefit of front-running in your application, mainly by removing the importance of transaction ordering or time. 
  => Timestamp Dependence: Be aware that the timestamp of the block can be manipulated by the miner, and all direct and indirect uses of the timestamp should be considered.
  => Denial of Service: Each block has an upper bound on the amount of gas that can be spent, and thus the amount computation that can be done. This is the Block Gas Limit. If the gas spent exceeds this limit, the transaction will fail.
  => Griefing: This attack may be possible on a contract which accepts generic data and uses it to make a call another contract (a 'sub-call') via the low level address.call() function, as is often the case with multisignature and transaction relayer contracts.
     - One way to address this is to implement logic requiring forwarders to provide enough gas to finish the subcall. 
       If the miner tried to conduct the attack in this scenario, the require statement would fail and the inner call would revert. A user can specify a minimum gasLimit along with the other data (in this example, typically the _gasLimit value would be verified by a signature, but that is omitted for simplicity in this case).
     - Another solution is to permit only trusted accounts to relay the transaction.
  => Force Feeding: Forcing a smart contract to hold an Ether balance can influence its internal accounting and security assumptions.
     The above effects illustrate that relying on exact comparisons to the contract's Ether balance is unreliable. The smart contract's business logic must consider that the actual balance associated with it can be higher than the internal accounting's value.
     In general, we strongly advise against using the contract's balance as a guard.
  => The Smart Contract Weakness Classification Registry offers a complete and up-to-date catalogue of known smart contract vulnerabilities and anti-patterns along with real-world examples. Browsing the registry is a good way of keeping up-to-date with the latest attacks. 

- Security Tools lists tools for improving code quality, and detecting vulnerabilities

- Bug Bounties List of bug bounties in the ecosystem.
```

note：
```
1. When interacting with external contracts, name your variables, methods, and contract interfaces in a way that makes it clear that interacting with them is potentially unsafe.
2. If you are making a call to an untrusted external contract, avoid state changes after the call.
3. Stop using .transfer() and .send() and instead use .call().
4. Isolate each external call into its own transaction that can be initiated by the recipient of the call. This is especially relevant for payments, where it is better to let users withdraw funds rather than push funds to them automatically.
5. Don't delegatecall to untrusted code.
6. Browsing the registry is a good way of keeping up-to-date with the latest attacks.
```

---
[What Is a Blockchain Oracle?](https://chain.link/education/blockchain-oracles )

summary：
```
1. Definition: Blockchain oracles are entities that connect blockchains to external systems, thereby enabling smart contracts to execute based upon inputs and outputs from the real world. 
2. The blockchain oracle problem outlines a fundamental limitation of smart contracts—they cannot inherently interact with data and systems existing outside their native blockchain environment. Securely interoperating with off-chain systems from a blockchain requires an additional piece of infrastructure known as an "oracle" to bridge the two environments.
3. Truly overcoming the oracle problem necessitates decentralized oracles to prevent data manipulation, inaccuracy, and downtime. A Decentralized Oracle Network, or DON for short, combines multiple independent oracle node operators and multiple reliable data sources to establish end-to-end decentralization.
4. Types of Blockchain Oracles:
   - Input Oracles
   - Output Oracles
   - Cross-Chain Oracles
   - Compute-Enabled Oracles
5. Reputation in blockchain oracle systems gives users and developers the ability to monitor and filter between oracles based on parameters they deem important. The broad range of oracle services means reputation is key to choosing between oracle service providers. Reputation in blockchain oracle systems gives users and developers the ability to monitor and filter between oracles based on parameters they deem important. Oracle reputation is aided by the fact that oracles sign and deliver their data onto an immutable public blockchain ledger, and so their historical performance history can be analyzed and presented to users through interactive dashboards such as market.link and reputation.link. 
   Reputation frameworks provide transparency into the accuracy and reliability of each oracle network and individual oracle node operator. Users can then make informed decisions about which oracles they want to service their smart contracts. Oracle service providers can also leverage their off-chain business reputation to provide users additional guarantees of their reliability. 
6. Blockchain Oracle Use Cases:
   - Decentralized Finance (DeFi)
   - Dynamic NFTs and Gaming
   - Insurance
   - Enterprise
   - Sustainability
```

note：
```
1. Centralized oracles are a non-starter for smart contract applications. 
2. 使用聲譽良好的 DON 服務
```


---

### 學到的英文

1.
- non-maliciously 無惡意的
- arbitrage 套利
- capital 資本
- upfront 前期
- whales - 這些擁有巨額加密貨幣的持有者或組織，大多被稱為「加密巨鯨」（crypto whales）
- culprit 罪魁禍首
- vulnerabilities 弱點
- viable 可行的
- exploit 開發
- swapping 交換
- disparity 差距
- uninitiated (n.)外行，門外漢/(adj.)無專門知識的
- delve 鑽研
- corresponding 相應的
- liquidity 流動性
- mint 鑄造
- inflate 膨脹
- manipulated 操縱的
- equates 等同於


2. 

- non-trivial 非平凡的
- pitfalls 陷阱
- tradeoffs 權衡
- optimal 最佳的
- malleability 延展性
- malicious 惡意的
- reentrancy vulnerabilities 
重入漏洞


3.

- hybrid 混合
- interoperate 交互作用
  

團體作業：
- mainnet 主網路
- testnet 測試網路

---

## 課外好文

- [淺談預言機 Oracle：區塊鏈與現實世界的橋樑。<9> 文組也該知道的區塊鏈技術知識](https://medium.com/pelith/oracle-a2016c17a56f)

- [Ethereum ERC20 Token Standard 以太坊代幣標準介紹](https://medium.com/hackoin-taiwan/ethereum-erc20-token-standard-%E4%BB%A5%E5%A4%AA%E5%9D%8A%E4%BB%A3%E5%B9%A3%E6%A8%99%E6%BA%96%E4%BB%8B%E7%B4%B9-b7bc58171021)