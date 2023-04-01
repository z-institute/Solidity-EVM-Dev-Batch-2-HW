1. 請準備一份英文履歷存成 pdf 檔案上傳至 Github (學院內部建檔用，有興趣找/接新工作的人可以提供，若有合適的職缺我們會幫忙媒合)
2. 在下方連結註冊帳號，完成所有 Lesson 並提供截圖
    - 連結：[https://www.chainshot.com/learn/solidity](https://www.chainshot.com/learn/solidity)
    - Certificate
    ![](2023-04-01-20-01-03.png)
3. 在下方連結註冊帳號，完成 Lesson 1 Making the Zombie Factory &  Lesson2 Zombies Attack Their Victims ：
    - 連結：[https://cryptozombies.io/en/course](https://cryptozombies.io/en/course)
    - Summary 從 Lesson 1 & Lesson 2 學到知識點，例如：function 的種類有哪些、event 的用途為何、變數存取在 storage ＆ memory 的差別、Internal ＆ External function 的差別等
    - Summary
      - x^y 可以用 x ** y 運算子
      - 加入 memory 關鍵字的用意是類似一種保護機制，編譯器會自動將傳入的參數複製一份傳入給 function 使用，避免修改時到傳入的參數，類似於 by value and by reference 的差別
      - In Solidity, functions are **Public** by default
      - 只要是參數或是 private (global variable or function name) 都建議在最前面加入 underscore ('_') 並且 Solidity 習慣為小駝峰制命名
      - function 關鍵字 view 相當於 read-only，這在區塊鏈中特別重要，因為"只讀"代表不會有寫入，也就不會產生手續費
      - 改變 data type 的方式是
        ```
        uint8 a = 5;
        uint b = 6;
        // throws an error because a * b returns a uint, not uint8:
        uint8 c = a * b;
        // we have to typecast b as a uint8 to make it work:
        uint8 c = a * uint8(b);
        ```
      - keccak256 是一種透過 SHA3 的 HASH 轉換方法，這個函數的傳入參數是 `bytes` 型態，所以通常會用以下範例方式做 pack 來傳入：`keccak256(abi.encodePacked("aaaab"));`
      - event 主要是用來通知 front-end 發生了什麼，JavaScript 的實作範例如下：
        ```
        /*
         * Contract
         */
        // declare the event
        event IntegersAdded(uint x, uint y, uint result);

        function add(uint _x, uint _y) public returns (uint) {
        uint result = _x + _y;
        // fire an event to let the app know the function was called:
        emit IntegersAdded(_x, _y, result);
        return result;
        }
        /*
         * JavaScript
         */
        YourContract.IntegersAdded(function(error, result) {
        // do something with result
        })
        ```
      - event 的名稱通常使用大駝峰制
      - 各種型別擺上順序通常為
        - `event`
        - `variable`, `struct`, `array`, `mapping`
        - `private function`, `public function`
      - mapping 像是 C# 的 list
        ```
        // For a financial app, storing a uint that holds the user's account balance:
        mapping (address => uint) public accountBalance;
        // Or could be used to store / lookup usernames based on userId
        mapping (uint => string) userIdToName;
        ```
      - Global Variable - "msg"
        - msg.sender: 調用當前函數的地址
      - storage vs. memory
        - storage: 相當於硬碟，會永久保存於區塊鏈上
        - memory: 相當於 RAM，僅為暫存，離開了作用範圍後則消失
      - function visibility:
        - public vs. external
          - public: 可以在合約內部/外部被訪問
          - external: 僅能在合約**外部**被訪問
        - private vs. internal
          - private: 可見度最低
          - internal: 比 private 可見度高一點，可以被繼承的合約訪問
        - 在 Solidity 中沒有 string 的 compare 函數，所以必須透過 `keccak256(abi.encodePacked(str1)) == keccak256(abi.encodePacked(str2)` 的方式來做比較
    - Certificate
    ![](2023-04-01-23-06-18.png)
    ![](2023-04-02-00-40-50.png)
