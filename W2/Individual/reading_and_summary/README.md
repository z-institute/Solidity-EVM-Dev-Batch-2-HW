# 隨堂小測驗（投影片第 24 頁）
- Account public key 就 是 account address (Y/N)
    - no, account public key 經過 hash 後才產生 account address
- Transaction 的順序是依據時間順序來決定的 (Y/N)
    - no, 在一定時間內的 transaction 會集中到 transaction pool 中，並由礦工決定 transaction 順序
- Transaction 不是成功就是失敗，不會有執⾏到⼀半就中斷的情況發⽣ (Y/N)
    - no, 如果在 transaction 過程中，gas 超過 gas limit，則 transaction 會中斷且損失 gas limit
- 簡短說明 EOA 和 contract account 的差別
    - EOA 只有 nonce (隨機數) & balance (餘額)，而 contract account 還多包含了 storage (儲存空間) & code (程式碼)
    - EOA 的 account address 是由 private & public key 產生，而 CA 沒有 private key, account address 由 sender address, nonce 產生
- 簡短說明甚麼是 Transaction pool
    - 在 Ethereum 中會不斷的產生區塊，礦工就是不斷的處理區塊中的交易以獲取報酬，而那些尚未被加入到區塊中的交易節點，就會被放入 transaction pool 中，以等待被放入下一個區塊中。
- Gas price 是如何計算出來的 ?
    - gas fee = gas used * gas price
- 是甚麼促使 State 發⽣改變 ?
    - 當有一個 transaction 發生時，就會促使 State 發生改變
- Full node 和 Light node 有甚麼區別 ?
    - Full node
        - 儲存所有歷史交易資訊，資料公開透明 (block header + block body)
        - 監測礦工挖出來的新區塊，驗證其合法性後同步該區塊
        - 監測區塊鏈網路中的新交易資訊，驗證每個交易的合法性
        - 將驗證過的 “交易/區塊資訊" 廣播給全網路節點
    - Light node
        - 只儲存了 block header
    - 全節點越多，不可被竄改性越強
    - 礦工必定是全節點，全節點者不一定是礦工
    - Light node 要驗證交易時，必須向鄰近的 full node 發起確認請求，full node 收到請求後提供所需資訊供驗證
    - Block header 中存有 Merkle Root，是透過 block body 中的交易資訊透過 hash 得到的字符，相當於 digital fingerprint，可以用來驗證資訊是否正確，以此確認交易。
# [閱讀 ethereum white paper](https://ethereum.org/en/whitepaper/)
由於 bitcoin 本身的限制，不容易基於該鏈發展應用，大大限縮了區塊鏈的發展與成長，ethereum 則是為了解決此問題，使創建去中心化應用程式變得容易。

### ethereum 應用
- 代幣
- 金融衍生產品
- 身分認證系統
- 分散式文件儲存
- 去中心化自治組織
- 儲蓄
- 保險
- 雲計算
- etc.