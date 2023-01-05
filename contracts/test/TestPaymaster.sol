// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.12;

import "../BasePaymaster.sol";

/**
 * test paymaster, that pays for everything, without any check.
 */
contract TestPaymaster is BasePaymaster {
    constructor(IEntryPoint _entryPoint) BasePaymaster(_entryPoint) {
        // to support "deterministic address" factory
        // solhint-disable avoid-tx-origin
        if (tx.origin != msg.sender) {
            _transferOwnership(tx.origin);
        }
    }

    function validatePaymasterUserOp(
        UserOperation calldata userOp,
        bytes32 userOpHash,
        uint maxCost
    )
        external
        view
        virtual
        override
        returns (bytes memory context, uint256 sigTimeRange)
    {
        (userOp, userOpHash, maxCost);
        return ("", 0);
    }
}
