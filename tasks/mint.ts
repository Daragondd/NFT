import { task } from "hardhat/config";


task("mint", "mint NFT(ERC721) with metadata in IPFS")
    .addParam("contract", "address of ERC721 contract")
    .addParam("json", "IPFS to json scheme")
    .addParam("owner", "address of NFT owner")
    .setAction(async (taskArgs, hre) => {
        const contract = await hre.ethers.getContractAt("GensinHeroes", taskArgs.contract);
        await contract.mint(taskArgs.owner, taskArgs.json)
    });