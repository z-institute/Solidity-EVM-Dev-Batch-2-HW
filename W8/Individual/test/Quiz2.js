const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Quiz2", function () {
  let Token;
  let token;
  let owner;
  let acc1;

  beforeEach(async () => {
    [owner, acc1] = await ethers.getSigners();
    Token = await ethers.getContractFactory("MyToken");
    token = await Token.deploy();
  });

  describe("Deployment", function () {
    it("Should set the expected name", async function () {
      expect(await token.name()).to.equal("MyToken");
    });

    it("Should set the expected symbol", async function () {
      expect(await token.symbol()).to.equal("TTT");
    });
  });

  describe("Mint", function () {
    it("Should mint 1 NFT", async function () {
      await token.mint(owner.address, 0, {
        value: ethers.utils.parseEther("0.1"),
      });
      expect(await token.ownerOf(0)).to.equal(owner.address);
    });
  });

  describe("Batch Mint", function () {
    it("Should mint batch of NFTs", async function () {
      await token.batchMint(acc1.address, [0, 1, 2], {
        value: ethers.utils.parseEther("0.3"),
      });
      expect(await token.ownerOf(0)).to.equal(acc1.address);
      expect(await token.ownerOf(1)).to.equal(acc1.address);
      expect(await token.ownerOf(2)).to.equal(acc1.address);
    });
  });

  describe("Revert", function () {
    it("Mint should revert if not enough ether", async function () {
      await expect(token.mint(owner.address, 0)).to.be.revertedWith(
        "Not enough funds to mint."
      );
    });

    it("Batch mint should revert if not enough ether", async function () {
      await expect(token.mint(acc1.address, [0, 1, 2])).to.be.revertedWith(
        "Not enough funds to mint."
      );
    });
  });

  describe("Supports Interface", function () {
    it("Should support interface", async function () {
      expect(await token.supportsInterface("0x80ac58cd"), false);
    });
  });
});
