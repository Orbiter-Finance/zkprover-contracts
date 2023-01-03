// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.12;

import "./interfaces/IVerifier.sol";

// Todo
contract Verifier is IVerifier {
    function verifyProof(
        bytes memory proof,
        uint[] memory pubSignals
    ) external view returns (bool) {
        (proof, pubSignals);
        return true;
    }
}
