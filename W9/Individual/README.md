## [Creating a Smart Wallet Factory Contract](https://blog.jarrodwatts.com/i-fixed-web3-onboarding)
選擇[Simple Wallet Factory (beta)](https://thirdweb.com/thirdweb.eth/AccountFactory)，連結錢包，點擊`Deploy now`
![](https://hackmd.io/_uploads/HJYaDAONh.png)
連結 Goerli以Contract deployment
![](https://hackmd.io/_uploads/H1KBd0_E2.png)

![](https://hackmd.io/_uploads/S1Ce5COV3.png)

畫面會自動跳到Dashboard
![](https://hackmd.io/_uploads/B1zLaCOVn.png)
接著到**APIKEYS**連接錢包並簽署消息以獲取 API KEY
![](https://hackmd.io/_uploads/HklFCRO4h.png)
![](https://hackmd.io/_uploads/BkW1gJF43.png)

### Creating the Application

使用預先配置的 SDK 創建一個新項目
`npx thirdweb create app --evm --next --ts`

![](https://hackmd.io/_uploads/rJQfZktNh.png)
安裝成功
![](https://hackmd.io/_uploads/SygWIyK4n.png)

這裡有好幾個步驟要處理:

1. 回到 contract頁面且複製contract address  與剛剛拿到API KEY貼到`_app.tsx`
![](https://hackmd.io/_uploads/ry22zJK4h.png)
1.  在`_app.tsx`頁面的activeChain改為Goerli或[其他](https://portal.thirdweb.com/wallet/smart-wallet#supported-chains)當前支持的鏈。
1. `ThirdwebProvider`允許我們定義一個`supportedWallets`指定我們想要支持智能錢包。
2. 將一個數組添加personalWallets到smartWallet我們之前在頁面中設置的`_app.tsx`，同時更新import localWallet。
**本地錢包**是一種非託管解決方案，可在後台為用戶創建錢包並將錢包的私鑰存儲在設備上。這樣，作為應用程序開發人員，我們可以在用戶不知情的情況下在幕後為用戶創建錢包，並將錢包的私鑰存儲在用戶的設備上。

以下是1-4步完整code
```
import type { AppProps } from "next/app";
import { localWallet,smartWallet, ThirdwebProvider } from "@thirdweb-dev/react";
import "../styles/globals.css";

const activeChain = "mumbai";

function MyApp({ Component, pageProps }: AppProps) {
  return (
    <ThirdwebProvider
      activeChain={activeChain}
      supportedWallets={[
        smartWallet({
          factoryAddress: "xxx", // Address of your account factory smart contract
          thirdwebApiKey: "xxx", // The API key you got from the previous step
          gasless: true,
          // Local wallet as the only option for EOA
          personalWallets: [
            localWallet({
              persist: true,
            }),
          ],
        }),
      ]}
    >
      <Component {...pageProps} />
    </ThirdwebProvider>
  );
}

export default MyApp;

```
![](https://hackmd.io/_uploads/Hkv-7fFEn.png)



`index.tsx`頁面上，整個刪掉貼上下面的code，讓我們現在顯示一個連接錢包按鈕。thirdweb React SDK 包含一個ConnectWallet組件，它讀取supportedWallets我們剛剛定義的內容，並在模式中顯示所有支持的選項。
```
import { ConnectWallet } from "@thirdweb-dev/react";
import type { NextPage } from "next";

const Home: NextPage = () => {
  return <ConnectWallet />;
};

export default Home;

```
最後`npm run dev`和打開`localhost:3000`
![](https://hackmd.io/_uploads/SkLpdkKN2.png)
我們為用戶生成EOA和智能錢包，當用戶在應用程序中與我們的合約互動時，他們永遠不會看到“簽名消息”或“批准交易”提示。
以下為EIP-4337 帳戶抽象完成畫面
![](https://hackmd.io/_uploads/HJJIxxKE2.png)

---
## [Rainbowkit + WAGMI](https://www.rainbowkit.com/docs/installation)

RainbowKit is a React library that makes it easy to add wallet connection to your dapp. It's intuitive, responsive and customizable.

```
npm init @rainbow-me/rainbowkit@latest
```
![](https://i.imgur.com/ZiBXdiY.png)


Run
```
cd my-rainbowkit-app

npm run dev
```

![](https://i.imgur.com/r2jXb2x.png)

Open the link and show the successful screen.(original version)

![](https://i.imgur.com/HKuSFhM.png)

我把網站直接拿來試改，在`index.tsx` 中改成自己想要的文案與設計
![](https://hackmd.io/_uploads/B1jHq9LEn.png)
(剛好在做另一份作業，部屬另一個合約，錢包先不連結)
![](https://hackmd.io/_uploads/S1N5K5L42.png)
下一步修改

**Import**
Import RainbowKit, wagmi, and ethers.

**Configure**
Configure your desired chains and generate the required connectors. You will also need to setup a wagmi client.
![](https://hackmd.io/_uploads/S1CEs9IV2.png)
在`_app.tsx`中改成自己想要的支援的鏈
原本
![](https://hackmd.io/_uploads/rJKkuqIV3.png)
修改後
![](https://hackmd.io/_uploads/B13359L42.png)

之後畢專就可以做更多變化


--
## [Web3Modal](https://docs.walletconnect.com/2.0/web3modal/react/installation)

Here are the steps to set up a React project with Web3Modal:


1. Create **a new React project** using create-react-app:


```
npx create-react-app my-app web3modal_tutorial

```
![](https://hackmd.io/_uploads/BknlofwNn.png)

```
cd my-app
npm install ethers
npm install web3modal
npm install @coinbase/wallet-sdk
```

2. In the `App.js` file, import the Web3Modal component and use it to get a provider:

```
import logo from './logo.svg';
import { Web3Modal } from '@web3modal/react'
import { ether } from 'ethers'
import './App.css';
const { providerOptions } = {}
function App() {
  async function connectWallet() {
    try {
      let web3Modal = new Web3Modal({
        cacheProvider: false,
        providerOptions
      });
      const web3ModalInstance = await web3Modal.connect();
      const web3ModalProvider = new ethers.providers.Web3Provider(web3ModalInstance);
      console.log({web3ModalProvider});
    } catch (error) {
      console.error({error});
    }
  }

  return (
    <div className="App">
      <header className="App-header">
        <h1>Welcome to Eda Web3Modal Connection!</h1>
        <button onClick={connectWallet}>Connect Wallet</button>
      </header>
    </div>
  );
}

export default App;

```
![](https://hackmd.io/_uploads/rJUW3QDEh.png)


3. Run the app:

`npm start`

![](https://hackmd.io/_uploads/HJPdTmD42.png)




That's it! Now you should be able to connect to a Web3-enabled wallet in your React app using Web3Modal.這裡我沒有創建任何按鈕，只有建立一個React APP

Web3Modal 是一個 JavaScript 函式庫，可以幫助 Web3 DApp（分散式應用程式）與 Web3 協議（如以太坊）上的用戶進行身份驗證和交易簽名。它可以讓用戶使用不同的 Web3 提供者（如以太坊瀏覽器擴展、WalletConnect、Portis、Fortmatic 等）來連接到 Web3 DApp，而不需要在每個提供者上單獨實現身份驗證和交易簽名的邏輯。


Web3Modal 的運作原則可以簡單分為以下幾步：


創建 Web3Modal 實例：在使用 Web3Modal 前，需要創建一個 Web3Modal 實例。在創建實例時，可以指定一個或多個 Web3 提供者作為優先級列表，這些提供者將按照優先級的順序來嘗試連接。

顯示 Web3Modal 窗口：在 Web3 DApp 中，當需要讓用戶進行身份驗證或交易簽名時，可以通過調用 Web3Modal 的 connect() 方法來顯示一個選擇 Web3 提供者的窗口。

用戶選擇 Web3 提供者：當 Web3Modal 窗口顯示時，用戶可以選擇一個 Web3 提供者來連接到 Web3 DApp。

連接 Web3 提供者：當用戶選擇 Web3 提供者後，Web3Modal 將通過該提供者連接到 Web3 DApp。如果用戶已經通過選擇 Web3 提供者授權了 Web3Modal，則 Web3Modal 會直接使用該提供者來連接。否則，Web3Modal 將會提示用戶進行授權。

返回 Web3Provider 對象：當 Web3 提供者連接成功後，Web3Modal 將返回一個 Web3Provider 對象，這個對象包含了與 Web3 協議的通信接口，可以用於身份驗證和交易簽名。


總體來說，Web3Modal 可以幫助 Web3 DApp 與 Web3 提供者之間建立一個統一的身份驗證和交易簽名界面，從而提高了 Web3 DApp 的易用性和可靠性。



--
## [manifoldxyz-creator-core-solidity](https://github.com/manifoldxyz/creator-core-solidity)
Installation
`npm install @manifoldxyz/creator-core-solidity`
Once installed, you can use the contracts in the library by importing them:

```
pragma solidity ^0.8.0;

import "@manifoldxyz/creator-core-solidity/contracts/ERC721Creator.sol";

contract MyContract is ERC721Creator  {
    constructor() ERC721Creator ("MyContract", "MC") {
    }
}
```

![](https://hackmd.io/_uploads/BkXnMBUEh.png)

The Manifold Creator Core contracts provide creators with the ability to deploy an ERC721/ERC1155 NFT smart contract with basic minting functionality, on-chain royalties and permissioning. Additionally, they provide a framework for extending the functionality of the smart contract by installing extension applications.


---
## [Manifold](https://manifold.xyz/)
Login from "Launch Studio".
![](https://hackmd.io/_uploads/rJ29XCQNn.png)
Complete your profile and connect your wallet
![](https://hackmd.io/_uploads/r1wkerH42.png)
Click "**New cotract**" on [Overview page](https://studio.manifold.xyz/home)
![](https://hackmd.io/_uploads/HyaG4SH4h.png)
Create your NFT: Once you have installed Manifold Studio, you can start creating your NFT. To do this, you need to create a new project and define the properties of your NFT, such as its name, description, and image or video file.
![](https://hackmd.io/_uploads/H11ZSHSEn.png)
Create ASCII
Please click twice on the block of ASCII MARK.
![](https://hackmd.io/_uploads/HycMqrrVh.png)
Please click [plenty of tools](https://patorjk.com/software/taag/#p=display&f=Graffiti&t=CuoocatC) to create ASCII and paste back it to the block of ASCII MARK.
The ASCII art is a signature detail of the Manifold Creator contract. ASCII art is used to visually identify your contract and represents your work, identity, and creativity.
![](https://hackmd.io/_uploads/r101cBHEn.png)


Upload your NFT to a blockchain: After you have created your NFT, you need to upload it to a blockchain, such as Goerli, using the Manifold Studio platform by clicking "**Deploy on the Goerli**". 
![](https://hackmd.io/_uploads/Sk2lN7I4h.png)
![](https://hackmd.io/_uploads/ryWcE7I43.png)

Check your NFT is minted and available on the blockchain.

一直塞車(已經塞了幾天...)，過段時間就會自動部屬好，

Click "**Go to Dashboard**"

![](https://hackmd.io/_uploads/r1Wa1_u43.png)

Go to the tokens page and create it.
![](https://hackmd.io/_uploads/SkcMe__N3.png)
Choose the **Single Token**.
![](https://hackmd.io/_uploads/BkLF1ud42.png)
Type the information again and click "**Mint to Goerli**".
![](https://hackmd.io/_uploads/SyQO8t_V3.png)

If you choose '**Myself**', the NFT will be minted and transferred to your wallet.
![](https://hackmd.io/_uploads/B18s8Y_Vn.png)

![](https://hackmd.io/_uploads/rJplwKO4h.png)

Click the **OpenSea** and it will show on the successful screen.
![](https://hackmd.io/_uploads/BykRKY_En.png)

![](https://hackmd.io/_uploads/SkO5FYdV2.png)

