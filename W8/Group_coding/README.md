# 團體作業 - 第三組

MVP：
* 目標做出 “一個合約＆一個測試”
* 先 for 一個活動

待辦清單：
* 把 struct 加進去 code
* 測試再新增一些

--


### Ticket.sol
```
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Ticket is Ownable, ERC1155("https://donexttime.com/{id}.json") {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds; // 建立一個 _tokenIds 的計數器
    
    uint256 public constant MAX_SUPPLY = 1000;
    address[MAX_SUPPLY] private _owners;
    uint256 public constant MAX_PER_MINT = 2;
    uint256 public constant PRICE = 0.01 ether;
    
    mapping(address => Ticket[]) private _ticketsOwned;

    struct Ticket {
        uint256 expireTime;
        string name;
    }

    event TicketUsed(address indexed owner, string name);

    constructor(string memory uri) ERC1155(uri) {}

    function mintNfts(uint256 count) external payable {
        uint256 nextId = _tokenIds.current(); // get the next token id

        require(nextId + count < MAX_SUPPLY, "Supply limit exceeded");
        require(count > 0 && count <= MAX_PER_MINT, "Can only mint one NFT per address");
        require(msg.value >= PRICE * count, "Insufficient ether sent to purchase tickets");

        for (uint256 i = 0; i < count; i++) {
            string memory metadata = uri(nextId + i);
            _mintSingleNft(msg.sender, metadata);
            _ticketsOwned[msg.sender].push(Ticket(block.timestamp + 1 days, "1 day ticket"));
        }
    }

    function useTicket(string memory name) external {
        for (uint256 i = 0; i < _ticketsOwned[msg.sender].length; i++) {
            if (keccak256(bytes(_ticketsOwned[msg.sender][i].name)) == keccak256(bytes(name))) {
                delete _ticketsOwned[msg.sender][i];
                emit TicketUsed(msg.sender, name);
                return;
            }
        }
        revert("No ticket found");
    }

    function withdraw() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No ether left to withdraw");

        (bool success, ) = payable(msg.sender).call{value: balance}("");
        require(success, "Transfer failed");
    }

    function _burn(address account, uint256 id, uint256 amount) internal virtual override {
        super._burn(account, id, amount);
    }

    function uri(uint256 tokenId) public pure override returns (string memory) {
        return string(abi.encodePacked("https://donexttime.com/", Strings.toString(tokenId), ".json"));
    }

    function _mintSingleNft(address owner, string memory tokenURI) private {
        require(totalSupply() == _tokenIds.current, "Indexing has broken down!");
        uint newTokenID = _tokenIds.current(); 
        _setTokenURI(newTokenID, _tokenURI); 
        _tokenIds.increment(); 
    }
    function supportsInterface(bytes4 interfaceId)public view
        override(ERC1155)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
```



### test.js

```
const { expect } = require("chai");

describe("MyTicket", async function () {
  const [owner,] = await ethers.getSigners();
  let nft;
  let nftContractAddress;
   
  beforeEach('Setup Contract', async () => {
        const Ticket = await ethers.getContractFactory('Ticket')
        nft = await Ticket.deploy()
        await nft.deployed()
        nftContractAddress = await nft.address
  })
    
it("Should mint NFTs", async function () {
  const count = 1;
  const price = ethers.utils.parseEther("0.01");
  const tokenId = await nft.tokenIds();
  await expect(nft.mintNfts(count, {value: price}))
    .to.emit(nft, "TransferSingle")
    .withArgs(owner.address, ethers.constants.AddressZero, owner.address, tokenId, count);
  expect(await nft.balanceOf(owner.address, tokenId)).to.equal(count);
});

  it("Should support interface", async function () {
    expect(await nft.supportsInterface("0x00000001"), false);
  });
});

```

測試案例中，使用了Mocha的beforeEach函數在每個測試執行之前設置智能合約。它使用ethers.js的getContractFactory和deploy函數創建新的Ticket合約實例，然後獲取其地址並存儲到變數nftContractAddress中。此外，它還獲取簽署者帳戶的地址並存儲到變數owner中。另外還驗證兩個功能:
1. mintNfts：
用於創建和發行新的NFT代幣，並將它們分配給指定的帳戶。此測試案例使用ethers.js的parseEther將0.01 ETH轉換為相應的wei數量，並在呼叫mintNfts時將其作為value參數傳遞。接著，使用Chai的expect語法檢查呼叫mintNfts是否觸發了一個名為TransferSingle的事件，並且檢查事件觸發時的引數是否符合預期。withArgs語法用於確保事件引數與指定的值匹配。
1. supportsInterface：
用於檢查合約是否實現了指定的介面。此測試案例使用Chai的expect語法檢查合約是否未實現ERC165介面（介面ID為0x00000001）。



--

參考資料:
https://docs.openzeppelin.com/test-helpers/0.5/api#expectEvent
https://github.com/z-institute/SBF-BONK/blob/main/contracts/CyberBonk.sol
https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol
https://zhuanlan.zhihu.com/p/561647445