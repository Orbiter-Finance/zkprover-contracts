import { ethers } from "hardhat";

async function main() {
  const signers = await ethers.getSigners();

  const tx = await signers[0].provider?.getTransaction(
    "0x4ea6760234bf615eca6665db63887d9d8da44a1d2be89b549c03abf9a2875800"
  );

  console.warn("tx:", tx);

  // const TestToken = await ethers.getContractFactory("TestToken");
  // const testToken = await TestToken.deploy();

  // console.warn("testToken.deployTransaction:", testToken.deployTransaction);

  // console.log(`TestToken deploying: ${testToken.address}`);
  // await testToken.deployed();
  // console.log(`TestToken deployed: ${testToken.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
