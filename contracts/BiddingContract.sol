// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// Contract 2: Bidding Logic
contract BiddingContract {
    struct Bid {
        address bidder;
        uint256 amount;
        uint256 timestamp;
    }
    
    mapping(uint256 => Bid[]) public auctionBids;
    mapping(uint256 => Bid) public highestBids;
    
    event BidPlaced(uint256 auctionId, address bidder, uint256 amount);
    event BidWithdrawn(uint256 auctionId, address bidder, uint256 amount);
    
    function placeBid(uint256 _auctionId) external payable {
        require(msg.value > 0, "Bid amount must be greater than 0");
        require(msg.value > highestBids[_auctionId].amount, "Bid must be higher than current highest bid");
        
        if (highestBids[_auctionId].bidder != address(0)) {
            // Refund previous highest bidder
            payable(highestBids[_auctionId].bidder).transfer(highestBids[_auctionId].amount);
        }
        
        highestBids[_auctionId] = Bid({
            bidder: msg.sender,
            amount: msg.value,
            timestamp: block.timestamp
        });
        
        auctionBids[_auctionId].push(highestBids[_auctionId]);
        emit BidPlaced(_auctionId, msg.sender, msg.value);
    }
}