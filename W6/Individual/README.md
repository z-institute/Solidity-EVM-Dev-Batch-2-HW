1. 嘗試完整跟著這兩個教學照做並提供相關截圖，再簡述 VRF 運作原理，與兩種作法的差異：
    
    a. 方法一 Subscription Method 
    
     - link: [https://docs.chain.link/vrf/v2/subscription/examples/get-a-random-number#request-random-values](https://docs.chain.link/vrf/v2/subscription/examples/get-a-random-number#request-random-values)

     - Create Subscription
        
       <img width="1503" alt="image" src="https://user-images.githubusercontent.com/50972884/233080711-e46a8ec1-d375-4243-992e-6516c28bbc1d.png">

        tx id [0x9970d685a28b16991e4c332b740f6b98ecf647cf57e2fe6ce3bc770f047605cd](https://sepolia.etherscan.io/tx/0x9970d685a28b16991e4c332b740f6b98ecf647cf57e2fe6ce3bc770f047605cd)

     - Add Funds
        
       <img width="1494" alt="image" src="https://user-images.githubusercontent.com/50972884/233083443-bb1f119f-9a02-49ed-8876-d7b3eb6a5355.png">

     - Deploy Contract

       Source code - SubscriptionMethodVRF.sol

       <img width="754" alt="image" src="https://user-images.githubusercontent.com/50972884/233128035-e67471eb-d717-4791-b69e-154b6d7c0a93.png">
     
     - Add consumer

       <img width="1467" alt="image" src="https://user-images.githubusercontent.com/50972884/233128583-5ebbf422-6705-4d48-83a5-4094e21578a7.png">

       <img width="1482" alt="image" src="https://user-images.githubusercontent.com/50972884/233128665-66be78f7-b222-4382-b650-d079b0893fbe.png">
     
     - Execute

       - requestRandomWords()
        
         <img width="1079" alt="image" src="https://user-images.githubusercontent.com/50972884/233131567-dee116b5-6fcb-4853-b454-649552a2f0c4.png">

       - fulfillRandomWords() (<- Callback by Chainlink VRF) 
       
        <img width="1413" alt="image" src="https://user-images.githubusercontent.com/50972884/233143287-b35638ee-613e-42de-9d5a-6e77aa2614ec.png">

        <img width="1494" alt="image" src="https://user-images.githubusercontent.com/50972884/233143355-77cb51d8-fb46-489d-abc7-dbfc3c8638d3.png">

        The returned two random numbers are:
        - 100483367765334522954510812727772571635354320205677136576264592449505173831133
        - 72158507902054012182107666183486671829555566516640719739116182145637510478154
        
        這邊有個問題：Chainlink call function fulfillRandomWords() 時在這個 Contract 的 transaction 上是否應該會有紀錄？
    
    b. 方法二 Direct Funding Method
    
    - link: [https://docs.chain.link/vrf/v2/direct-funding/examples/get-a-random-number/](https://docs.chain.link/vrf/v2/direct-funding/examples/get-a-random-number/)

    - Deploy Contract

        -  Need to get VRF Wrapper address

            - link: [https://docs.chain.link/vrf/v2/direct-funding/supported-networks/](https://docs.chain.link/vrf/v2/direct-funding/supported-networks/)

        -  Source code - DirectFundingMethodVRF.sol

            <img width="1488" alt="image" src="https://user-images.githubusercontent.com/50972884/233170287-abc5dfcc-7490-4d3f-bb43-4b9c7e191aec.png">

    - Execute

       - requestRandomWords()

         <img width="1092" alt="image" src="https://user-images.githubusercontent.com/50972884/233172801-24479f95-98b7-4e21-919b-ff50ca7cca67.png">

       - fulfillRandomWords() (<- Callback by Chainlink VRF) 
         
         <img width="1490" alt="image" src="https://user-images.githubusercontent.com/50972884/233174069-b866781d-a493-477f-aa90-86a732b9c57c.png">
         
         The returned two random numbers are:
         - 39306645323753105006199481687228324203214575728951470024127717370062361884749
         - 67171372413566424223042161612381560581061553659481704399349577637596742266512

    c. 簡述 VRF 運作原理
    
      VRF 的運作上有四個階段，分別是
      1. Request
      2. Generate Random Words and Proof Sending
      3. Verify it
      4. Fullfill

      Request 階段就是透過合約去呼叫 VRF Coordinator 要求要隨機數，VRF Coordinator 就會要求隨機數的事件。另一邊，Chainlink 有一個 VRF Service 會保持監聽鏈上有無 VRF Coordinator 要求隨機數，當它監聽到事件時就會進入 Generate Random Words and Proof Sending 階段。根據官方資料，VRF 的輸入會包含一組金鑰（公鑰和私鑰）與一個 seed。其中私鑰和 seed 會用來產生隨機數。接著這組隨機數上鏈之後，就可以用公鑰來驗證這組隨機數。最後一個階段，VRF Coordinator 會呼叫合約內的 fullfill function 來傳回生成的隨機數。
      
      reference link:
      - https://www.leewayhertz.com/what-is-chainlink-vrf/#:~:text=Every%20time%20a%20new%20request,utilized%20by%20other%20consuming%20applications.
      - https://chain.link/education-hub/verifiable-random-function-vrf
      - https://docs.chain.link/vrf/v2/subscription

    d. 兩種方法的差異
    
    根據 Chainlink 官方文件描述可以得知，首先 Subscription Method 是一種預付充值型的使用方式，可以透過 `fulfillRandomWords` function 內程式的長度再搭配官方的公式推算出 minimum subscription balance 是多少。這種方式蠻適合產品運作規範已經定義且不太會變化的項目，可以很清楚的規劃出產品在 Chainlink VRF 上的運作成本然後事先儲值進去。

    Direct Funding Method 則是一種執行即付費型的使用方式。根據官方文件描述，這種方式不需要 subscription 且適合一次性的隨機數產生需求。尤其是對於用戶會支付費用的項目而言，這是很適合的方式，因為在 request 時就會需要支付。
   
    由此我們也可以看出來，兩個方法在 Link Token 的花費時機上也有差異，subcription method 是在 callback function `fulfillRandomWords` 時才會花費，而 direct funding method 則是在 request function `requestRandomWords` 時就會花費。
    
    實際兩種方式都練習過後會覺得 Direct Funding Method 在真的實作的時候可能還要先多做一個把 Link 存到 Contract 裡面的行為，整體來說會比 Subscription 多一個交易。
    
2. 試跑此專案提供成功跑起的相關截圖，再簡述跨鏈橋運作原理：[https://github.com/z-institute/bsc-eth-bridge](https://github.com/z-institute/bsc-eth-bridge)

    a. 專案執行完成截圖
    
    Follow the guide on project readme
    
    - truffle compile
        
    <img width="1160" alt="image" src="https://user-images.githubusercontent.com/50972884/233265604-dabfb8ec-18b2-4fe5-af4f-886207e0223f.png">

    - Modified setting in truffle-config.js
        - Change private key or mnemonic to my personal test wallet
        - Change ethTestnet rpc endpoint and network_id to sepolia
        
        <img width="545" alt="Screenshot 2023-04-20 at 1 24 42 PM" src="https://user-images.githubusercontent.com/50972884/233266415-d0d8ceb6-64f2-4f07-8426-b4809bd4ef3f.png">
            
    - Get test ETH and test BNB in wallet
        
        ![image](https://user-images.githubusercontent.com/50972884/233267481-f0904364-a529-4cbb-9c6f-8ab2afb3ce12.png)

    - Deploy contract to Sepolia testnet
        
       <img width="1158" alt="image" src="https://user-images.githubusercontent.com/50972884/233268060-a06aea59-82b3-475e-a3de-bf8417e0f2f4.png">
       
       <img width="1153" alt="image" src="https://user-images.githubusercontent.com/50972884/233268107-e3e2cf67-6f3b-462e-b4e3-9927ff15fa5a.png">
        
    - Deploy contract to BSC testnet
    
       <img width="1148" alt="image" src="https://user-images.githubusercontent.com/50972884/233268583-742844f3-c1b4-44bf-bc7d-7631cabedb75.png">
       
       <img width="1161" alt="image" src="https://user-images.githubusercontent.com/50972884/233268627-b1119807-7a9d-4351-8126-157b9d4bb930.png">

    - Check token balance before transfer (the first one should be 1000 and the second one should be 0)
    
       <img width="812" alt="image" src="https://user-images.githubusercontent.com/50972884/233269738-9b3e00b1-90d8-4c1c-9945-0cb45b4f10cc.png">
    
    - Run the bridge script (keep the script opened in a separate terminal)
      - Change adminPrivKey to my personal test wallet
      - Change ethTestnet rpc endpoint and network_id to sepolia
    
      <img width="1436" alt="image" src="https://user-images.githubusercontent.com/50972884/233270579-0e66fa8a-843c-49e4-a25c-b00adeea564c.png">
    
    - Transfer token (the bridge will listen to the event and do the bridging after transfer)
      - Change privKey to my personal test wallet
      
      <img width="1448" alt="image" src="https://user-images.githubusercontent.com/50972884/233272299-202b8f4a-202e-414f-b2fe-ab8339d8c98e.png">

    - Check token balance after transfer
    
      <img width="715" alt="image" src="https://user-images.githubusercontent.com/50972884/233272419-3a419886-9e01-41aa-b0bf-68c86ecb4066.png">

    b. 簡述跨鏈橋運作原理
    
      跨鏈橋的概念跟借貸有一些相似，思考方向是“如何讓資產位於不同鏈上時擁有同等的**價值**”。我們可以把每條公鏈想像成獨立的金融體系，我們希望將 A 體系的資產“跨”到 B 體系，就是一個等價映射。對於 B 體系而言，因為雙方是完全獨立，來自 A 體系的資產沒有特殊原因的話是沒有價值的。而讓 A 體系資產在 B 體系上存在價值的一個方法就是抵押證明。所以常見的跨鏈橋做法是，用戶必須先在 A 公鏈上“鎖住”想跨練的 Token，然後在 B 公鏈上 Mint 出等量的 Token，而這些在 B 公鏈上出現的 Token 其價值擔保來源於用戶鎖在 A 公鏈的 Token，如果有什麼意外風險發生時，還可以從這些鎖住的 Token 得到補償。在這樣的前提下，跨鏈橋的資產意義就建立了。技術上就運用相同的概念執行，然後當 User 想要把資產跨回到 A 公鏈時，要先把 B 公鏈的 Token 送回跨鏈橋協議。跨鏈橋協議可能會燒毀或是隔離掉這些 Token，然後再將 A 公鏈上“鎖住”的 Token 解鎖還給 User。

3. 閱讀 Solidity by example: [https://solidity-by-example.org](https://solidity-by-example.org)，可能會出現在未來隨堂考 😛
4. [加分作業，難度較高] Follow 此教學並提供完成截圖，用自己的話寫下對 Uniswap V3 的運作模式理解：[https://soliditydeveloper.com/uniswap3](https://soliditydeveloper.com/uniswap3)

    a. 完成截圖

    b. 對 Uniswap V3 的運作模式理解
