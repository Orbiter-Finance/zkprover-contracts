// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.12;

/**
 * Zk-Snark Verifier
 */
interface IVerifier {
    function verifyProof(
        bytes memory proof,
        uint[] memory pubSignals
    ) external view returns (bool);
}
