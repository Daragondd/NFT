
import { ethers } from "hardhat";

async function main() {

  const GensinHeroes = await ethers.getContractFactory("GensinHeroes");
  const gensinheroes = await GensinHeroes.deploy();

  await gensinheroes.deployed();

  console.log("GensinHeroes deployed to:", gensinheroes.address);
}


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
