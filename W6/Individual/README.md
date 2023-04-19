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

    d. 兩種方法的差異
    
    根據 Chainlink 官方文件描述可以得知，首先 Subscription Method 是一種預付充值型的使用方式，可以透過 `fulfillRandomWords` function 內程式的長度再搭配官方的公式推算出 minimum subscription balance 是多少。這種方式蠻適合產品運作規範已經定義且不太會變化的項目，可以很清楚的規劃出產品在 Chainlink VRF 上的運作成本然後事先儲值進去。

    Direct Funding Method 則是一種執行即付費型的使用方式。根據官方文件描述，這種方式不需要 subscription 且適合一次性的隨機數產生需求。尤其是對於用戶會支付費用的項目而言，這是很適合的方式，因為在 request 時就會需要支付。
   
    由此我們也可以看出來，兩個方法在 Link Token 的花費時機上也有差異，subcription method 是在 callback function `fulfillRandomWords` 時才會花費，而 direct funding method 則是在 request function `requestRandomWords` 時就會花費。
    
    實際兩種方式都練習過後會覺得 Direct Funding Method 在真的實作的時候可能還要先多做一個把 Link 存到 Contract 裡面的行為，整體來說會比 Subscription 多一個交易。
    
2. 試跑此專案提供成功跑起的相關截圖，再簡述跨鏈橋運作原理：[https://github.com/z-institute/bsc-eth-bridge](https://github.com/z-institute/bsc-eth-bridge)

    a. 專案執行完成截圖

    b. 簡述跨鏈橋運作原理

3. 閱讀 Solidity by example: [https://solidity-by-example.org](https://solidity-by-example.org)，可能會出現在未來隨堂考 😛
4. [加分作業，難度較高] Follow 此教學並提供完成截圖，用自己的話寫下對 Uniswap V3 的運作模式理解：[https://soliditydeveloper.com/uniswap3](https://soliditydeveloper.com/uniswap3)

    a. 完成截圖

    b. 對 Uniswap V3 的運作模式理解
