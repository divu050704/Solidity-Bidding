// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Contract 4: User Management
contract UserManagement {
    struct User {
        bool isRegistered;
        uint256 reputation;
        uint256[] participatedAuctions;
        uint256[] wonAuctions;
    }
    
    mapping(address => User) public users;
    
    event UserRegistered(address user);
    event ReputationUpdated(address user, uint256 newReputation);
    
    function registerUser() external {
        require(!users[msg.sender].isRegistered, "User already registered");
        
        users[msg.sender] = User({
            isRegistered: true,
            reputation: 100,
            participatedAuctions: new uint256[](0),
            wonAuctions: new uint256[](0)
        });
        
        emit UserRegistered(msg.sender);
    }
    
    function updateReputation(address _user, uint256 _newReputation) external {
        require(users[_user].isRegistered, "User not registered");
        users[_user].reputation = _newReputation;
        emit ReputationUpdated(_user, _newReputation);
    }
    
    function addParticipatedAuction(address _user, uint256 _auctionId) external {
        require(users[_user].isRegistered, "User not registered");
        users[_user].participatedAuctions.push(_auctionId);
    }
    
    function addWonAuction(address _user, uint256 _auctionId) external {
        require(users[_user].isRegistered, "User not registered");
        users[_user].wonAuctions.push(_auctionId);
    }
}