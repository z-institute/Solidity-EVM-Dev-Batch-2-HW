# w4 individual

### Resume
[Resume](https://drive.google.com/file/d/1R_SPj5wcQKj132tvESbMdCVqdPibsh18/view?usp=sharing)


### ChainShot
![](https://i.imgur.com/o1M1BjW.png)


### Zombie

![Lesson 1](https://i.imgur.com/GwQgWFN.jpg)

![Lesson 2](https://i.imgur.com/87ZiW79.jpg)


1. function 的種類有哪些:
    - Internal Functions
        - 只能在合約內部調用，不能被其他合約調用，內部函數可以訪問合約的所有內部成員，例如狀態變量和其他函數。
    - External Functions
        - 只能被外部調用，不能在合約內部調用，外部函數不能訪問合約的內部狀態變量，但可以接收以太幣作為調用費用。
    - Public Functions
        - 公開函數是一種特殊的外部函數，可以被任何人調用。當合約被部署時，公開函數會自動生成一個可公開查看的 ABI。
    - Private Functions
        - 只能在合約內部調用，不能被外部或其他合約調用。
2. event 的用途為何:
    - 紀錄合約發生事件的方法，某些交易發生之後，可以透過event紀錄，這樣就不用在區塊鏈上交互才可以知道此事件
3. 變數存取在 storage ＆ memory 的差別
    - storage為永久的，且存儲需要更多的gas
    - memory為暫時的，function或調用完畢之後會被永久清除，使用比較少的gas
4. payable 的用法為何:
    -  保留字，用來放在function被定義，讓調用者需傳入以太幣，寫此類型的function都要特別小心。
5. interface的用法為何:
    - 介面or接口
        - 當定義了接口之後，我們可以在其他合約傳入address，並且此address的合約也有match此function，就可以在合約中使用它
        - 若合約繼承此interface則需實作此function
6. uint, int的差別:
    - uint 整數
    - int 正整數
7. Library用法:
    - 賦予某類型某些function的用法
    - import 之後可定義類似下面的方式給予uint Prime library中的function
    ```
    import "./Prime.sol";
    using Prime for uint;
    ```
8. pure, view的差別:
    - pure 函數不會讀取或修改任何狀態，而 view 函數只會讀取狀態，不會修改狀態。
9. constructor用法
    - 用於初始化，且定義合約的狀態變量或執行其他一次性設置，而且不帶有任何顯式返回值。
10. require 用法:
    - 用於檢查，如果有錯可以填入發生不符合設置情況的文字
    ```
        # 常常檢查調用者是否為owner
        require(owner == msg.sender)
    ```
11. block.timestamp用法
    - 返回區塊上的時間Unix格式
12. selfdestruct 用法:
    - 它會將當前合約自我銷毀，釋放合約佔用的存儲空間並將剩餘的以太（如果有的話）轉移給指定的地址
