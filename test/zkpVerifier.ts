import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { ethers } from "hardhat";
import { Signers } from "./types";
import { BigNumber } from "@ethersproject/bignumber";
import { ZkpVerifier, ZkpVerifier__factory } from "../typechain-types";
import { TestZkpVerifier, TestZkpVerifier__factory } from "../typechain-types";
import fs from "fs";

import { halo2zkpVerifierAbi, compile_yul } from "../scripts/utils";

function bufferToUint256LE(buffer: Buffer) {
  let buffer256 = [];
  for (let i = 0; i < buffer.length / 32; i++) {
    let v = BigNumber.from(0);
    let shft = BigNumber.from(1);
    for (let j = 0; j < 32; j++) {
      v = v.add(shft.mul(buffer[i * 32 + j]));
      shft = shft.mul(256);
    }
    buffer256.push(v);
  }

  return buffer256;
}

describe("zkpVerifier", function () {
  let verifier: ZkpVerifier;
  let verifierTest: TestZkpVerifier;
  const provider = ethers.provider;

  before(async function () {
    this.signers = {} as Signers;

    const signers: SignerWithAddress[] = await ethers.getSigners();
    this.signers.admin = signers[0];

    let verifyCode = await compile_yul("contracts/zkp/zkpVerifier.yul");
    // console.log(`verifiyCode ${verifyCode}`)
    const factory = new ethers.ContractFactory(
      halo2zkpVerifierAbi,
      verifyCode,
      this.signers.admin
    );
    const verifyContract = await factory.deploy();
    console.log(`contract address ${verifyContract.address}`);
  });

  it("deploy with compiled code", async () => {
    // const factory = new ethers.ContractFactory([], bytecode, signer);
    // const contract = await factory.deploy();
  });
});
