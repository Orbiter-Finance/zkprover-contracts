// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.12;

/**
 * Zk-Snark Verifier
 */
interface IVerifier {
    function verify(
        uint256[] calldata proof,
        uint256[] calldata target_circuit_final_pair
    ) external view;
}
