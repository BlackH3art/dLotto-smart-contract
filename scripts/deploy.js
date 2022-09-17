
const main = async () => {

  const Lottery = await hre.ethers.getContractFactory("Lottery");

  const lottery = await Lottery.deploy(
    180, // subscription id
  );

  await lottery.deployed();

  console.log("**** DEPLOYED ****");

  console.log("CrookedSnouts deployed to:", lottery.address);
  console.log(`Verify with: \n npx hardhat verify --constructor-args scripts/deployArguments.js --network mumbai ${lottery.address}`);

}



const deployCrookedSnouts = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.error(error);
    process.exit(1);
  }
}


deployCrookedSnouts();