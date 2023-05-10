# 個人作業


## Follow [此文件](https://hackmd.io/@zinstitute/frontend-lib)並寫下做法與提供完成截圖


--

## Rainbowkit + WAGMI

```
npm init @rainbow-me/rainbowkit@latest
```
進到資料夾

```
npm install @rainbow-me/rainbowkit wagmi ethers@^5
```
run 起來

```
npm run dev
```

--

#### 錢包 lightbox 大小
```
<RainbowKitProvider modalSize="compact" chains={chains}>
    <Component {...pageProps} />
</RainbowKitProvider>
```
![](./../images/1.png)

```
<RainbowKitProvider chains={chains}>
    <Component {...pageProps} />
</RainbowKitProvider>
```
![](./../images/2.png)

--

#### theme

```
import { RainbowKitProvider, darkTheme } from '@rainbow-me/rainbowkit';

export const App = () => (
  <RainbowKitProvider theme={darkTheme()} {...etc}>
    {/* Your App */}
  </RainbowKitProvider>
);
```

![](./../images/3.png)

--

#### chain

```
<RainbowKitProvider chains={chains} initialChain={1}> //chainId = 1
```

or

```
const { chains } = configureChains(
  [mainnet, polygon],
  [
    alchemyProvider({ apiKey: process.env.ALCHEMY_ID }),
    publicProvider(),
  ]
);

const App = () => {
  return (
    <RainbowKitProvider chains={chains} {...etc}>
      {/* ... */}
    </RainbowKitProvider>
  );
};
```


---

## Web3Modal


到[這裡](https://cloud.walletconnect.com/app)連結錢包

![](./../images/4.png)

開新專案，獲得 projectId

![](./../images/5.png)


參考 React dApp (with v2 UniversalProvider + Ethers.js)

替換掉 projectId 這個參數，並把檔案名稱改成 .env.local

![](./../images/27.png)

```
yarn
yarn build
yarn start
```

![](./../images/6.png)

![](./../images/7.png)


---

## Manifold


```
npm install https://github.com/manifoldxyz/creator-core-solidity.git
.
.
.
npm install -g truffle
npm install -g ganache-cli
```

創建 v.sol

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@manifoldxyz/creator-core-solidity/contracts/ERC721Creator.sol";

contract MyContract is ERC721Creator  {
    constructor() ERC721Creator ("MyContract", "MC") {
    }
    

    function test() public{
        
    }
}
```

new terminal, start development server

```
ganache-cli
```
![](./../images/8.png)

compile

```
truffle compile
```
![](./../images/9.png)

compile 完生成 ABI

![](./../images/10.png)

deploy

```
truffle migrate
```

![](./../images/11.png)

---


## 使用 [Manifold studio](https://studio.manifold.xyz/) 做任意一件事（如隨便上傳一張 NFT 圖片做成 NFT mint site），並寫下做法與提供完成截圖、網站連結

> 網站並不支援 mac m2，所以我是用舊的 mac i5 去做

```
____   _________________________    _____   
\   \ /   /\_   _____/\______   \  /  _  \  
 \   Y   /  |    __)_  |       _/ /  /_\  \ 
  \     /   |        \ |    |   \/    |    \
   \___/   /_______  / |____|_  /\____|__  /
                   \/         \/         \/
```

開新專案

![](./../images/12.png)

選擇在測試網發布

![](./../images/13.png)


![](./../images/14.png)


因為測試幣又不夠，所以先去生成測試幣，但生成速度太慢

![](./../images/15.png)

本來以為入金就能領測試幣，結果還是遇到問題

![](./../images/16.png)

他下面顯示收到，但上面沒有更新

![](./../images/28.png)

才發現是帳戶被盜，轉進來的當下就立馬被轉出去，所以實作先停在這裡。

 
---
 
## [Account Abstraction](https://blog.jarrodwatts.com/i-fixed-web3-onboarding)
 
--
 
先去[這裡](https://thirdweb.com/explore)建立我的 Smart Wallet 

![](./../images/17.png)

部署

![](./../images/18.png)

成功

![](./../images/20.png)

![](./../images/21.png)


回到頁面，替換掉參數後

```
npm run dev
```

畫面成功出現

![](./../images/22.png)

當你註冊成功，回到網站上可以看到新增一個使用者

![](./../images/23.png)

![](./../images/26.png)

可以開始和頁面互動

![](./../images/24.png)

![](./../images/25.png)