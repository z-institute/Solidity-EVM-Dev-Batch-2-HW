# week2 作業
- 
1. Account public key 就 是 account address (Y/N)

    N.
    公鑰是驗證加密交易的公鑰部分，需要hash 才能得到account address，account address 則是發送加密貨幣的目的地。

3. Transaction 的順序是依據時間順序來決定的 (Y/N)

    通常Y.但有可能因為gas fee 付得比別人高，超車被礦工優先處理


5. Transaction 不是成功就是失敗，不會有執⾏到⼀半就中斷的情況發⽣ (Y/N)
    
    N.交易執行可能因以下原因而中斷:
    1.加密貨幣短時間內暴漲或暴跌，導致gas fee limit 設得太低，無法到達
    2.交易簽名錯誤
    3.網路不穩定


7. 簡短說明 EOA 和 contract account 的差別

    EOA由私鑰控制，並且沒有torage hash、code hash；contract account
    由 EVM code控制，有torage hash、code hash，如果沒有寫轉出功能，token將永遠沒辦法轉出。
    
    
9. 簡短說明甚麼是 Transaction pool

    當有交易產生，會傳送至分散式資料中，Transaction pool是區塊鏈節點網路中的一個暫時存放區，用於儲存已經被創建但尚未被打包進區塊的交易，等待被礦工挖掘和打包至新的區塊中。
    
11. Gas price 是如何計算出來的 ?

    Ether 支付，而合約中以Gwei 作為單位 Gwei=0.000000001Eth，所以 Gas Price 設定為 10 Gwei，等於 Gas Price=0.00000001Eth。

13. 是甚麼促使 State 發⽣改變 ?

    狀態的改變是會隨著每一筆交易進行更改。
    

15. Full node 和 Light node 有甚麼區別 ?

    Full node可以儲存完整的區塊鏈數據與參與區塊的驗證，因此更安全但需要更多資源，因為要需要大量存儲空間和計算能力；
    Light node是區塊鏈網路中的兩種節點Block Header，佔用更少的資有效率但依賴其他節點進行驗證，對設備的要求相對
    來說比較低
    
    ---

    ![以太坊白皮書](https://ethereum.org/en/whitepaper/)
    Firstly, Ethereum is an open blockchain platform that allows for the creation of decentralized applications. It uses smart contracts to define and execute application logic, with Ether being the platform's cryptocurrency used to pay transaction fees.
    Secondly, Transactions on Ethereum are based on account, and the platform enables interaction between smart contracts. Users can create custom tokens and trade them on Ethereum. Developers can use Ethereum's JSON-RPC API to create applications in various programming languages. 
    Finally, Ethereum is a powerful ecosystem including a developer community(OpenZeppelin, Truffle Suite, Gitcoin, Ethereum Magicians, Ethereum Community Forum, Ethereum Stack Exchange), open-source projects, and decentralized applications.