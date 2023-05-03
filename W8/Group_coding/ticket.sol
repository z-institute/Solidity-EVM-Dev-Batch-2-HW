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

    constructor(string memory uri) ERC1155(uri) {
        // Mint a ticket and add it to the user's list
        _mintSingleNft(msg.sender, "1 day ticket");
        _ticketsOwned[msg.sender].push(Ticket(block.timestamp + 1 days, "1 day ticket"));
    }

    function mintNfts(uint256 count) external payable {
        uint256 nextId = _tokenIds.current(); // get the next token id

        require(nextId + count < MAX_SUPPLY, "Supply limit exceeded");
        require(count > 0 && count <= MAX_PER_MINT, "Can only mint one NFT per address");
        require(msg.value >= PRICE * count, "Insufficient ether sent to purchase tickets");

        for (uint256 i = 0; i < count; i++) {
            string memory metadata = uri(nextId + i);
            _mintSingleNft(msg.sender, metadata);
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