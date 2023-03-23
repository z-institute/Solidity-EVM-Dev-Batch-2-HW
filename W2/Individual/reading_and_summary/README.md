# 隨堂小測驗（投影片第 24 頁）
- 列出題目與你的回答和說明
# [閱讀 ethereum white paper](https://ethereum.org/en/whitepaper/)
- 寫下簡易筆記／心得
# Solidity 智能合約時站開發班
# w02-H.W.
1. Account public key 就是 account address (Y/N)
    Ans： NO.
    在EOA中，Public key 需要透過 hash 才能得到account address；以 Contract account ， Account Address 是由 Nonce 與 Sender Address 一起計算的結果，故不同。
    
2. Transaction 的順序是依據時間來決定的 (Y/N)
    Ans： NO. 是依據 nonce 而決定順序。
    

3. Transaction 不是成功就是失敗，不會有執行到一半就中斷的情況 (Y/N)
    Ans： NO.
    執行到一半就中斷原因是gasLimit值設定太小，以至於到達目的前就先消耗完畢，而中斷。
    
4. 簡短說明 EOA 和 contract account 的差別
    Ans：
    EOA沒有storage hash、code hash，而contract account 有。

6. 簡短說明 Trasaction pool
    Ans：
    每個人發送交易後，會先發送到Trasaction pool。

7. Gas price是如何計算出來的?
    Ans：
    每單位Gas 願意付出多少ETH。一般來說以Gwei為單位，所以設定Gas Price為30 Gwei，Gas Price = 0.00000003Eth。
    
8. 是什麼促使 State 發生改變?
    Ans：
    1.     對Account來說，Account State包含nonce、balance、storage hash、code hash，狀態中發生改變時，會促使 State 改變。
    2.     在Ethersan 中，詳細點出不同帳號的狀態，且預設顯示 nonce、balance。
    3.     以帳本而言，State間的改變得關鍵是Transaction。

9. Full node 和 Light note 有什麼區別?
    Ans：
    FULL NODE:擁有完整區塊鏈帳本資料的節點，具備獨立驗證的能力來確認交易之有效性。
    1.     儲存所有歷史交易資訊，資料公開透明
    2.     **監測礦工挖出來的新區塊，驗證其合法性後同步該區塊**
    3.     **監測區塊鏈網路中的新交易資訊，驗證每個交易的合法性**
    4.     將驗證過的「交易／區塊資訊」廣播給全網路節點
    
    LIGHT NODE:
    具體定義是不儲存或維護完整的區塊鏈副本，只儲存最小量的狀態來作為發送或傳遞交易訊息的節點。
    由於割捨掉區塊的 Body，即所有歷史的交易列表，因此當輕節點需要驗證某個交易的合法性時，具體做法為：
    1.     向鄰近的全節點發起確認請求
    2.     全節點收到請求後提供所需相關資訊供驗證
    3.     只儲存每個區塊的區塊標頭 Block Header
    4.     不一定保持隨時在線（獲取最新的 Block Header 資訊）
    5.     根據需求可以只保存與自己相關的交易內容
    6.     **無法驗證大多數交易的合法性，只能驗證與自己相關交易的合法性**
    7.     **無法驗證新區塊的正確性**
    8.     只能檢測到當前的最長鏈，但無法知道哪條是最長合法鏈
    參考文獻：https://ithelp.ithome.com.tw/articles/10292197?sc=rss.iron