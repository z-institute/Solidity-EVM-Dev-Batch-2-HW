### IScratchTicket是ScratchTicket NFT合約的介面。它定義了三個函數：

1. scratch(uint256 tokenId)：這個函數被用來刮開指定tokenId的NFT，如果這個NFT還沒有被刮過，則返回true。否則，返回false。
2. isScratched(uint256 tokenId)：這個函數被用來檢查指定tokenId的NFT是否已經被刮過。如果是，則返回true。否則，返回false。
3. burn(uint256 tokenId)：這個函數被用來燒毀指定tokenId的NFT。當NFT被燒毀時，合約會向設置的pay master地址支付一定的ETH。

### IScratchTicketSale是ScratchTicketSale銷售合約的介面。它定義了五個函數：

1. buyTicket()：這個函數被用來購買一個ScratchTicket NFT。它需要支付指定的價格，並返回NFT的tokenId。
2. setPrice(uint256 price)：這個函數被用來設置NFT的價格。
3. getPrice()：這個函數被用來獲取NFT的價格。
4. withdraw()：這個函數被用來從銷售合約中提取資金。
5. setPayMaster(address payable payMaster)：這個函數被用來設置pay master地址。

### IPayMaster是pay master概念的介面。它定義了一個函數：

* pay(address payable recipient, uint256 amount)：這個函數被用來向指定地址支付指定的ETH金額。

