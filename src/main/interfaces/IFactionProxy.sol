// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

interface IFactionProxy {
    function getLevel(address user) external view returns (uint8);
    function getRankedRole(address user) external view returns (uint8);
}
