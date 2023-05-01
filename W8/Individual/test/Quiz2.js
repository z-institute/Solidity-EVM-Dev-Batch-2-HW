const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

describe("Quiz2", function () {
  let Token;
  let token;

  beforeEach(async () => {
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

  describe("Mint", function () {});

  describe("Batch Mint", function () {});
});
