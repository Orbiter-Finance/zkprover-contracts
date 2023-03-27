import { Contract } from "ethers";
import { ethers } from "hardhat";
import {
  AccountFactory__factory,
  EntryPoint__factory,
  TestPaymaster__factory,
  ZkProverZkpVerifierWrapper__factory,
} from "../typechain-types";
import { compile_yul, halo2zkpVerifierAbi } from "./utils";

async function waitDeployed(contract: Contract, name: string) {
  console.log(`${name} depolying: ${contract.deployTransaction.hash}`);
  await contract.deployed();
  console.log(`${name}.address: ${contract.address} \r\n`);

  return contract;
}

async function main() {
  const signers = await ethers.getSigners();

  const gasPrice = (await signers[0].getGasPrice()).mul(3).div(2);

  let verifyCode = await compile_yul("contracts/zkp/zkpVerifier.yul");
  // console.log(`verifiyCode ${verifyCode}`)
  const factory = new ethers.ContractFactory(
    halo2zkpVerifierAbi,
    verifyCode,
    signers[0]
  );

  const verify = await factory.deploy({ gasPrice });
  await waitDeployed(verify, "verify");

  const verifierWrapper = await new ZkProverZkpVerifierWrapper__factory(
    signers[0]
  ).deploy(verify.address, { gasPrice });
  await waitDeployed(verifierWrapper, "verifierWrapper");

  const entryPoint = await new EntryPoint__factory(signers[0]).deploy(
    verifierWrapper.address,
    { gasPrice }
  );
  await waitDeployed(entryPoint, "entryPoint");

  const paymaster = await new TestPaymaster__factory(signers[0]).deploy(
    entryPoint.address,
    { gasPrice }
  );
  await waitDeployed(paymaster, "paymaster");

  const accountFactory = await new AccountFactory__factory(signers[0]).deploy(
    entryPoint.address,
    { gasPrice }
  );
  await waitDeployed(accountFactory, "accountFactory");
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
