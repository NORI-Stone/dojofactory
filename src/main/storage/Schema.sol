// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

library Schema {
    struct GlobalState {
        string schoolName;
        bool initialized;
        bool paused;
        mapping(address => User) users;
        mapping(uint => Branch) branches;
        mapping(uint8 => LevelInfo) levelInfo;
        mapping(uint8 => RankedRoleInfo) rankedRoleInfo;
    }

    struct User {
        address userId;
        uint8 level;
        uint8 rankedRole;
        uint mainBranchId;
    }

    struct Branch {
        uint branchId;
        string branchName;
    }

    struct LevelInfo {
        string rankTitle;
        string colorTitle;
    }

    struct RankedRoleInfo {
        string roleTitle;
    }
}
