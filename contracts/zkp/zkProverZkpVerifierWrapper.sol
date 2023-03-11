// SPDX-License-Identifier: GPL-3.0-only
pragma solidity ^0.8.12;

contract zkProverZkpVerifierWrapper {
    address verifier_address;
    uint256 cnt = 100;

    constructor(address vaddr) {
        verifier_address = vaddr;
    }

    function verify(uint256[1] calldata pub_ins, bytes calldata proof) public {
        assembly {
            // function Error(string)
            function revertWith(msg) {
                mstore(0, shl(224, 0x08c379a0))
                mstore(4, 32)
                mstore(68, msg)
                let msgLen
                for {

                } msg {

                } {
                    msg := shl(8, msg)
                    msgLen := add(msgLen, 1)
                }
                mstore(36, msgLen)
                revert(0, 100)
            }

            let addr := sload(verifier_address.slot)
            switch extcodesize(addr)
            case 0 {
                // no code at `verifier_address`
                revertWith("verifier-missing")
            }

            let calldata_sig := 0x0
            let calldata_pub_ins := add(calldata_sig, 0x4)
            let pub_ins_size := mul(0x20, 0x1)
            let calldata_pad := add(calldata_pub_ins, pub_ins_size)
            let calldata_proof_len := add(calldata_pad, 0x20)
            let calldata_proof := add(calldata_proof_len, 0x20)
            let proof_size := sub(calldatasize(), calldata_proof)
            let total_size := add(pub_ins_size, proof_size)

            // Copy the public inputs
            let pub_ins_pos := mload(0x40)
            calldatacopy(pub_ins_pos, calldata_pub_ins, pub_ins_size)

            // Copy the proof bytes
            let proof_pos := add(pub_ins_pos, pub_ins_size)
            calldatacopy(proof_pos, calldata_proof, proof_size)

            let success := staticcall(
                gas(),
                addr,
                pub_ins_pos,
                total_size,
                0,
                0
            )
            switch success
            case 0 {
                // plonk verification failed
                revertWith("verification-failed")
            }
        }

        cnt += 1;
    }
}
