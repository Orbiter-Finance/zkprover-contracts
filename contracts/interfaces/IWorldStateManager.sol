// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.12;
import "./UserOperation.sol";

interface IWorldStateManager {
    function transferStateRoot(
        bytes32 oldStateRoot,
        bytes32 newStateRoot
    ) external;

    function calculateUserOpHashesSum(
        UserOperation[] calldata ops
    ) external pure returns (uint256);
}
