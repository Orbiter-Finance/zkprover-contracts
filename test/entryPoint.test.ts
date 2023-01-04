import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { ethers } from "hardhat";
import { EntryPoint } from "../typechain-types";
import { Verifier } from "../typechain-types/contracts/Verifier";
import { Signers } from "./types";

import type { UserOperationStruct } from "../typechain-types/contracts/EntryPoint";
import { expect } from "chai";
import { parseEther } from "ethers/lib/utils";

const AddressZero = ethers.constants.AddressZero;
const HashZero = ethers.constants.HashZero;
const ONE_ETH = parseEther("1");
const TWO_ETH = parseEther("2");
const FIVE_ETH = parseEther("5");

const DefaultsForUserOp: UserOperationStruct = {
  sender: ethers.constants.AddressZero,
  nonce: 0,
  initCode: "0x",
  callData: "0x",
  callGasLimit: 0,
  verificationGasLimit: 100000, // default verification gas. will add create2 cost (3200+200*length) if initCode exists
  preVerificationGas: 21000, // should also cover calldata cost.
  maxFeePerGas: 0,
  maxPriorityFeePerGas: 1e9,
  paymasterAndData: "0x",
  signature: "0x",
};

describe("EntryPoint", function () {
  let verifier: Verifier;
  let entryPoint: EntryPoint;

  // Accounts
  let paymaster: SignerWithAddress;

  before(async function () {
    this.signers = {} as Signers;

    const signers: SignerWithAddress[] = await ethers.getSigners();
    this.signers.admin = signers[0];
    paymaster = signers[1];

    const verifierFactory = await ethers.getContractFactory("Verifier");
    verifier = <Verifier>await verifierFactory.deploy();

    const entryPointFactory = await ethers.getContractFactory("EntryPoint");
    entryPoint = <EntryPoint>await entryPointFactory.deploy(verifier.address);
  });

  describe("Stake Management", () => {
    it("should deposit for transfer into EntryPoint", async () => {
      const signer2 = (await ethers.getSigners())[2];
      await signer2.sendTransaction({ to: entryPoint.address, value: ONE_ETH });
      expect(await entryPoint.balanceOf(signer2.address)).to.eql(ONE_ETH);

      const depositInfo = await entryPoint.getDepositInfo(signer2.address);
      expect(depositInfo.deposit).to.eql(ONE_ETH);
      expect(depositInfo.staked).to.eql(false);
      expect(depositInfo.stake.toNumber()).to.eql(0);
      expect(depositInfo.unstakeDelaySec).to.eql(0);
      expect(depositInfo.withdrawTime.toNumber()).to.eql(0);
    });
  });

  // it("should succeed to handleOps", async function () {
  //   const ops: UserOperationStruct[] = [
  //     {
  //       ...DefaultsForUserOp,
  //       paymasterAndData: paymaster.address,
  //     },
  //   ];

  //   const resp = await entryPoint.handleOps(
  //     ops,
  //     "",
  //     [],
  //     this.signers.admin.address
  //   );

  //   console.warn("resp:", resp);
  // });
});
