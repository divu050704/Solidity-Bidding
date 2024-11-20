// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Contract 3: Escrow Service
contract EscrowService {
    address public auctionManager;
    mapping(uint256 => uint256) public escrowBalances;
    
    event FundsDeposited(uint256 auctionId, uint256 amount);
    event FundsReleased(uint256 auctionId, address recipient, uint256 amount);
    
    constructor(address _auctionManager) {
        auctionManager = _auctionManager;
    }
    
    function depositFunds(uint256 _auctionId) external payable {
        require(msg.value > 0, "Deposit amount must be greater than 0");
        escrowBalances[_auctionId] += msg.value;
        emit FundsDeposited(_auctionId, msg.value);
    }
    
    function releaseFunds(uint256 _auctionId, address payable _recipient) external {
        require(msg.sender == auctionManager, "Only auction manager can release funds");
        uint256 amount = escrowBalances[_auctionId];
        require(amount > 0, "No funds to release");
        
        escrowBalances[_auctionId] = 0;
        _recipient.transfer(amount);
        emit FundsReleased(_auctionId, _recipient, amount);
    }
}