[README](..\README.md)

# 如何使用 hardhat-gas-reporter

[hardhat-gas-reporter](https://www.npmjs.com/package/hardhat-gas-reporter)

1. 完成 [Hardhat 初始化](Hardhat.md) 之後，輸入下列指令安裝套件
```
npm install hardhat-gas-reporter --save-dev
```
2. 在 `hardhat.config.js` 中添加
```
require("hardhat-gas-reporter");
```
![](2023-03-29-21-48-50.png)
3. 輸入下列指令執行 `solidity-coverage`
```
npx hardhat coverage
```
![](2023-03-29-22-15-16.png)