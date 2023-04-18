1. 寫一個代幣合約，可以用 USDT 買到一個代幣、查到合約現有 USDT 餘額、與提款，提交完成程式碼，並附上成功買到代幣，查餘額跟提款在 remix 的截圖

    MockUSDT code -> MockUSDT.sol
    代幣合約 code -> WeekFive.sol

    1. Deploy MockUSDT 合約，並獲得一顆 USDT
    
        ![image](https://user-images.githubusercontent.com/50972884/232860991-4e2922eb-ba21-4270-af44-20509da33149.png)
        
    2. Deploy WeekFive Token 合約
    
        ![image](https://user-images.githubusercontent.com/50972884/232862478-cc73b999-299f-4776-ac29-aabbfc060308.png)
    
    3. Approve WeekFive Token 可以使用一顆 MockUSDT
        
        ![image](https://user-images.githubusercontent.com/50972884/232862400-af1d22f2-d90d-4ee9-b97c-aa3ece326310.png)
        
    1. 用一顆 USDT 成功買到代幣 
        
        ![image](https://user-images.githubusercontent.com/50972884/232862563-8c478109-c108-4137-9d03-ecf4a49432b0.png)
        
    2. 查到合約現有 USDT 餘額
    
        ![image](https://user-images.githubusercontent.com/50972884/232862631-bcd1389e-3cd2-45e1-b506-121a069915fc.png)
    
    3. 提款
    
        這邊的 amount 不用寫到 1e18, 因為我在 code 裡已經寫好 `amount * 1 ether`
        
        ![image](https://user-images.githubusercontent.com/50972884/232862887-8a485327-5392-481f-92ed-4c5095f2cf08.png)


- 小考的程式碼片段：[https://github.com/z-institute/Quiz/blob/main/Quiz_04.sol](https://github.com/z-institute/Quiz/blob/main/Quiz_04.sol)
1. 寫一個 NFT 合約，需要同時付以上的 ERC20 代幣加上 0.1 ETH 才能 mint 到，並且可以更新 token URI，每個地址只能 mint 5 個，提交完成程式碼，並附上截圖
2. 加分題：先閱讀：[https://azfuller20.medium.com/swap-with-uniswap-wip-f15923349b3d](https://azfuller20.medium.com/swap-with-uniswap-wip-f15923349b3d) 再跟著指示跑起這個專案 [https://docs.scaffoldeth.io/scaffold-eth/examples-branches/defi/uniswapper](https://docs.scaffoldeth.io/scaffold-eth/examples-branches/defi/uniswapper) 對於 DeFi 了解會加深很多，下次上課會講到，建議可以先看比較跟得上
