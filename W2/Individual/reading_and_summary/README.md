# 隨堂小測驗（投影片第 24 頁）
- 列出題目與你的回答和說明

    1. N 通常account address比較短且比較好記
    2. N
    3. N
    4. EOA是外部錢包，且沒有儲存資料，被private key控制，反之Contract Account是記錄在鏈上，有儲存資料，被合約控制
    5. Transaction pool 是交易的池子，放著未被交易的交易，等待礦工來領取他們，若太長時間未被領取，極有可能被刪除。
    6. Gas price是由 Gas used * gas fee
    7. 交易促使State改變
    8. 全節點紀錄區塊上的所有資訊，輕節點只紀錄block header，如果要詳細內容還要發送要求到區塊上

# [閱讀 ethereum white paper](https://ethereum.org/en/whitepaper/)
- 寫下簡易筆記／心得
    - 以太坊
        - 建構在區塊上的平台，且可執行合約
        - 區塊的本質為帳本系統
        - 概念由中本聰2008比特幣白皮書提出
        - 集中式帳本可能有倒閉危機
        - 分散式發生衝突會需要共識機制來解決
    - 區塊鏈特性
        - 二進制
        - 每個交易都有簽章
        - 多個交易鏈結在一起
    - 共識機制
        - PoW工作量證明
        - PoS權益證明
        - PoA權威證明
        - PoS 委派式證明
        - 何謂三角悖論: 去中心化,可擴展性,一致性 不可能同時達成
    - 以太坊節點
        - 全節點
        - 礦工節點
        - 輕節點
        - 歸檔節點

    - 何謂EVM
        一個狀態機，負責運行合約
        - Ethereum Account
            1. nonce 是一個會持續增加的數字
            2. balance 持有的貨幣量
            3. codeHash執行code的hash
            4. storageRoot: Merkle root的hash
            - account 分為EOA, Contract Account

        - EVM如何運作
            1. 唯讀 eth_call
            2. 寫入 使用者傳送transaction, 礦工給EVM處理, 並修改transaction狀態

        - Address
            160bits
        - Transaction 由EOA建立
            - nonce 目前執行個數
            - gasPrice 每個單位多少Wei
            - gasLimit 每次限制
            - to 對方地址
            - value balance的值
            - v,r,s 簽章的值
            - data message call的值
