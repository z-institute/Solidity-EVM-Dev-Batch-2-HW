# 隨堂小測驗（投影片第 24 頁）
- 列出題目與你的回答和說明
    - Account public key 就是 account address (Y/N)
        - Not
        - Account address 是由 public key 產生出來的
    - Transaction 的順序是依據時間順序來決定的 (Y/N)
        - Not
        - Transaction 的順序不是保證的，理論上會隨著時間排序，但在一個Block中，礦工可以決定的Block 內的 Transaction 的順序 
    - Transaction 不是成功就是失敗，不會有執⾏到⼀半就中斷的情況發⽣ (Y/N)
        - Yes
        - Transaction 是一種 atomic operation, 無法分割也不能中斷，所以只會有成功或是失敗
    - 簡短說明 EOA 和 contract account 的差別
        - EOA 就是用戶錢包，會有 Private key, 但不會有Storage Hash 跟 Code Hash
        - contract address 就是合約地址，合約地址不會有 Private Key, 但有 Storage Hash 和 Code Hash 來儲存資料跟程式碼
    - 簡短說明甚麼是 Transaction pool
        - Transaction pool 是一個暫存區，用來暫存還沒被打包進 Block 的 Transaction
    - Gas price 是如何計算出來的 ?
        - 目前的 Gas price = base fee + priority fee
        - 這是 London fork 之後的計算方式，base fee 是鏈的基礎費用，priority fee 是交易者願意多給礦工的費用
    - 是甚麼促使 State 發⽣改變 ?
        - 發送交易會促使 State 改變
    - Full node 和 Light node 有甚麼區別 ?
        - Full node 會儲存所有的 Block 資料，Light node 只會儲存最新的 Block 資料


# [閱讀 ethereum white paper](https://ethereum.org/en/whitepaper/)
- 寫下簡易筆記／心得
