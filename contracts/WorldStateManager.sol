// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.12;

import "./interfaces/IWorldStateManager.sol";
import "./interfaces/UserOperation.sol";

abstract contract WorldStateManager is IWorldStateManager {
    using UserOperationLib for UserOperation;

    bytes32 public _oldStateRoot;
    bytes32 public _curStateRoot;

    function transferStateRoot(
        bytes32 oldStateRoot,
        bytes32 newStateRoot
    ) public {
        require(_curStateRoot == oldStateRoot, "check");
        _oldStateRoot = _curStateRoot;
        _curStateRoot = newStateRoot;
    }

    function calculateUserOpHashesSum(
        UserOperation[] calldata ops
    ) public pure returns (uint256) {
        uint256 hashSum = 0;
        uint256 opsLen = ops.length;
        for (uint256 i = 0; i < opsLen; i++) {
            hashSum += uint256(ops[i].hash()) >> 10;
        }
        return hashSum;
    }
}
