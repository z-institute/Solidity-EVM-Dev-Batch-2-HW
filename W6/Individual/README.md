# h6

### 方法一
![](https://i.imgur.com/KDommSi.png)

![](https://i.imgur.com/20ZVtdW.png)

- get lastRequestId
- ![](https://i.imgur.com/pRN8Zvm.png)

- getRequestStatus to produce random words
- ![](https://i.imgur.com/6D2JrZ2.png)

### 方法二

- deploy contract
- ![](https://i.imgur.com/Nug2MGk.png)

- send token to contract
- ![](https://i.imgur.com/n8T05IT.png)

- click requestRandomWords
- ![](https://i.imgur.com/NTyZLDr.png)


- get lastRequestId
- ![](https://i.imgur.com/N02mfO8.png)


- get getRequestStatus
![](https://i.imgur.com/COIOBvD.png)

## Solidity by Example 筆記
https://solidity-by-example.org/



## bridge

- compile
-![](https://i.imgur.com/BCBwOkb.png)

- failed
    - update tuffle-config
    - ![](https://i.imgur.com/ROMRLsY.png)

    - update private key
    - ![](https://i.imgur.com/oIOZhFS.png)
- deploy ethTestnet result
    - migration
    - ![](https://i.imgur.com/JIBw4X8.png)

    - token ETH
    - ![](https://i.imgur.com/ibHzIVD.png)

    - bridge ETH
    - ![](https://i.imgur.com/cRlhWbE.png)

    - summary
    - ![](https://i.imgur.com/JyIp0un.png)

- choose one of testnet RPC
- ![](https://i.imgur.com/sdatp3B.png)

- Deply bscTestnet result
- ![](https://i.imgur.com/L755Gmw.png)
- ![](https://i.imgur.com/A1CgZZg.png)
- ![](https://i.imgur.com/ajcGkPC.png)

3. exec
- truffle exec scripts/eth-token-balance.js --network ethTestnet
![](https://i.imgur.com/Np257Sm.png)

- truffle exec scripts/bsc-token-balance.js --network bscTestnet
![](https://i.imgur.com/O6N5nZb.png)


- face error
- change network key
![](https://i.imgur.com/ERv6LrX.png)

4. transfer
- truffle exec scripts/eth-bsc-transfer.js --network ethTestnet
![](https://i.imgur.com/2jZ1GSM.png)
![](https://i.imgur.com/u8Ot5Xc.png)


5. check balance
- truffle exec scripts/eth-token-balance.js --network ethTestnet

![](https://i.imgur.com/DIHIkjF.png)


- truffle exec scripts/bsc-token-balance.js --network bscTestnet
![](https://i.imgur.com/hUsdy8v.png)
![](https://i.imgur.com/GMQ7OSj.png)


