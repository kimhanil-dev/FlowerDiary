const { expect } = require("chai");

describe("GardenNFT contract", function () {
  it("Deployment should assign the total supply of tokens to the owner", async function () {
    const [owner, addr1, addr2] = await ethers.getSigners();

    const whitelistContract = await ethers.deployContract("Whitelist");
    await whitelistContract.addAddressToWhitelist(addr1);

    const gardenNFTContract = await ethers.deployContract("GardenNFT", [whitelistContract.target]);

    var testFlowers = [];
    for (let index = 0; index < 31; index++) {
      testFlowers.push(index);
    }

    expect(await gardenNFTContract.mint(addr1, testFlowers));
    const [flowers, month] = await gardenNFTContract.getGardenData(0);
    console.log("getGardenData : (month) = ", month, "(flowers) = ", flowers);
  });
});