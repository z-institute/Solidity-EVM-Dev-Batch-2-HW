# 隨堂小測驗（投影片第 24 頁）
- 列出題目與你的回答和說明
1. Account public key 就 是 account address (Y/N)
   No, Account address 是經由public key 推導出 private key 後再經由 hash 算出 地址。
2. Transaction 的順序是依據時間順序來決定的 (Y/N)   
   No, 在一定時間內的 transaction 會集中到 transaction pool 中，並由礦工來排序順序。
3. Transaction 不是成功就是失敗，不會有執⾏到⼀半就中斷的情況發⽣ (Y/N)
   Yes, 不會有執行到一半發生錯誤之後被記錄下來。交易若中間有誤會直接被返回，所以不是成功就是失敗。
4. 簡短說明 EOA 和 contract account 的差別？
   Contract Account 比 EOA 多了兩個欄位 Storage hash 和 Code hash 的欄位，而 Contract 可以控制交易及紀錄交易的往來，，EOA 則是交易的發起者。
5. 簡短說明甚麼是 Transaction pool
   交易送出後會被丟到 Transaction pool等待被礦工打包，此時的交易狀態是未確認的pending狀態。
6. Gas price 是如何被計算出來的？
   就每單位 Gas 願意付出多少 ETH，一般使用Gwei作為單位 1 Gwei=0.000000001Eth，所以 Gas Price 設定為 20 Gwei，等於 Gas Price=0.00000002Eth。
7. 是甚麼促使 State 發⽣改變 ?
   由transaction交易來改變State，並記錄下來。
8. Full node 和 Light node 有甚麼區別
   全節點儲存了所有區塊的 Block Header 與 Body（交易列表），而輕節點只儲存最小量的狀態：即「區塊標頭 Block Header」

# [閱讀 ethereum white paper](https://ethereum.org/en/whitepaper/)
- 寫下簡易筆記／心得
