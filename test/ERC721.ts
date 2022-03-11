import { expect } from "chai";
import { Contract, Signer } from "ethers";
import { ethers } from "hardhat";


describe("ERC721", function () {;
  let token: Contract;
  let signers: Signer[];

  beforeEach(async function () {
    signers = await ethers.getSigners();

    const Token = await ethers.getContractFactory("GenshinHeroes");
    token = await Token.deploy();
    await token.deployed();
  });

  it("mint func and tokenURI", async () => {
    let addr = await signers[0].getAddress();

    await expect(
      token.tokenURI(0),
    ).to.be.revertedWith("Invalid tokenId");
    
    await token.mint(addr, "fake.json");

    expect(
      await token.balanceOf(addr)
    ).to.be.eq(1);

    expect(
      await token.tokenURI(0)
    ).to.be.eq("fake.json");
  })
})
