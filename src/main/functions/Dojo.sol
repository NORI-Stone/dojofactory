// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "../storage/Schema.sol";
import "../storage/Storage.sol";
import "../interfaces/IFactionProxy.sol";

contract Dojo {
    using Schema for Schema.GlobalState;

    // 初期化状態を記録するフラグ
    bool public initialized = false;

    // Initialize関数で初期化
    function initialize(string memory _schoolName, address admin) external {
        require(!initialized, "Already initialized");

        Schema.GlobalState storage s = Storage.state();
        s.schoolName = _schoolName;
        s.users[admin] = Schema.User({
            userId: admin,
            level: 0, // 初期状態はレベル0
            rankedRole: 255, // 館長の役職
            mainBranchId: 1
        });

        initialized = true;
    }

    function getLevel(address user) public view returns (uint8 currentLevel) {
        Schema.GlobalState storage s = Storage.state();
        return s.users[user].level;
    }

    function getRankedRole(address user) public view returns (uint8 rankedRole) {
        Schema.GlobalState storage s = Storage.state();
        return s.users[user].rankedRole;
    }

    function applyForMembership(address applicant, uint mainBranchId) external {
        Schema.GlobalState storage s = Storage.state();

        require(s.users[msg.sender].rankedRole >= 196, "Only head or branch heads can admit new members");

        if (s.users[msg.sender].rankedRole == 196) {
            require(s.users[msg.sender].mainBranchId == mainBranchId, "Branch head can only admit members to their own branch");
        }

        s.users[applicant] = Schema.User({
            userId: applicant,
            level: 0,
            rankedRole: 0, // 入門時点では役職なし
            mainBranchId: mainBranchId
        });
    }

    function getLevelsFromAllFactions(address[] memory factionAddresses, address user) public view returns (uint8[] memory levels, uint8[] memory rankedRoles) {
        uint proxyCount = factionAddresses.length;
        levels = new uint8[](proxyCount);
        rankedRoles = new uint8[](proxyCount);

        for (uint i = 0; i < proxyCount; i++) {
            address factionProxy = factionAddresses[i];
            levels[i] = IFactionProxy(factionProxy).getLevel(user);
            rankedRoles[i] = IFactionProxy(factionProxy).getRankedRole(user);
        }

        return (levels, rankedRoles);
    }

    function promote(address[] memory userIds, uint8[] memory increaseLevels) external {
        Schema.GlobalState storage s = Storage.state();

        require(s.users[msg.sender].rankedRole >= 128, "Only instructors and higher can promote");

        for (uint i = 0; i < userIds.length; i++) {
            uint8 currentLevel = s.users[userIds[i]].level;
            uint8 newLevel = currentLevel + increaseLevels[i];

            if (currentLevel < 10 && newLevel >= 11) {
                newLevel = 10;
            }

            require(newLevel <= 13, unicode"Invalid level, cannot promote beyond 3段");

            s.users[userIds[i]].level = newLevel;
        }
    }

    function assignRole(address user, uint8 newRole) external {
        Schema.GlobalState storage s = Storage.state();

        require(s.users[msg.sender].rankedRole == 255, "Only the head can assign roles");
        s.users[user].rankedRole = newRole;
    }
}
