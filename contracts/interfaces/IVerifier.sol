// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.12;

/**
 * Zk-Snark Verifier
 */
interface IVerifier {
    function verify(
        uint256[1] calldata pub_ins,
        bytes calldata proof
    ) external view;
}
