// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
const hre = require("hardhat");

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  const CommonTokenFactory = await hre.ethers.getContractFactory("CommonTokenCreate");
  const commonTokenFactory = await CommonTokenFactory.deploy();

  await commonTokenFactory.deployed();

  console.log("CommonTokenFactory deployed to:", commonTokenFactory.address);
  // // 0x31e08414b0A015b7f805758f34Dfe2a66d746189

  
  const TokenFactory = await hre.ethers.getContractFactory("TokenFactory");
  const tokenFactory = await TokenFactory.deploy();

  await tokenFactory.deployed();
  await tokenFactory.setCommonTokenContract(commonTokenFactory.address);
  await tokenFactory.factoryCommonToken("HHHTOKEN","HHH",18,10000);

  console.log("CommonToken address:", tokenFactory.address);

  // await hre.run("verify:verify", {
  //   address: "0xa351b9011d1f1b51fdfa991e531ed874fc9f914c",
  //   constructorArguments: ["CCCCTOKEN","CCCC",18,10000],
  // })
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
