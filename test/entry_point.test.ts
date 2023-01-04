import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { Verifier } from "../typechain-types/contracts/Verifier";
import { Signers } from "./types";
import { EntryPoint } from "../typechain-types";

describe("Account", function () {
  let verifier: Verifier;
  let entryPoint: EntryPoint;

  before(async function () {
    this.signers = {} as Signers;

    const signers: SignerWithAddress[] = await ethers.getSigners();
    this.signers.admin = signers[0];

    const verifierFactory = await ethers.getContractFactory("Verifier");
    verifier = <Verifier>await verifierFactory.deploy();

    const entryPointFactory = await ethers.getContractFactory("EntryPoint");
    entryPoint = <EntryPoint>await entryPointFactory.deploy(verifier.address);
  });

  it("Test", async function () {
    console.warn("verifier.address:", verifier.address);
    console.warn("entryPoint.address:", entryPoint.address);
  });
});
