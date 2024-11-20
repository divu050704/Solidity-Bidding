// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Contract 1: Main Auction Manager
contract AuctionManager {
    address public owner;
    mapping(uint256 => Auction) public auctions;
    uint256 public auctionCount;
    
    struct Auction {
        uint256 id;
        address seller;
        string itemDescription;
        uint256 startingPrice;
        uint256 endTime;
        bool isActive;
    }
    
    event AuctionCreated(uint256 auctionId, address seller, string itemDescription);
    event AuctionEnded(uint256 auctionId);
    
    constructor() {
        owner = msg.sender;
        auctionCount = 0;
    }
    
    function createAuction(
        string memory _itemDescription,
        uint256 _startingPrice,
        uint256 _duration
    ) external {
        require(_startingPrice > 0, "Starting price must be greater than 0");
        require(_duration > 0, "Duration must be greater than 0");
        
        uint256 newAuctionId = auctionCount++;
        auctions[newAuctionId] = Auction({
            id: newAuctionId,
            seller: msg.sender,
            itemDescription: _itemDescription,
            startingPrice: _startingPrice,
            endTime: block.timestamp + _duration,
            isActive: true
        });
        
        emit AuctionCreated(newAuctionId, msg.sender, _itemDescription);
    }
    
    function endAuction(uint256 _auctionId) external {
        require(msg.sender == owner || msg.sender == auctions[_auctionId].seller, "Unauthorized");
        require(auctions[_auctionId].isActive, "Auction already ended");
        
        auctions[_auctionId].isActive = false;
        emit AuctionEnded(_auctionId);
    }
}
