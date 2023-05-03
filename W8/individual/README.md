
###  test case

```js
const { expect } = require("chai");

describe("Quiz 2 test", () => {
  let owner;
  let acc1;
  let acc2;
  let token;

  beforeEach(async () => {
    [owner, acc1, acc2] = await ethers.getSigners();
    const MyToken = await ethers.getContractFactory("MyToken");
    token = await MyToken.deploy();
    // console.log(token.functions);
  });

  it("Expect token symbol", async () => {
    // const ownerBalance = await token.balanceOf(owner.address);
    expect(await token.symbol()).to.equal("TTT");
  });

  it("Name should be as expected", async function () {
    // const ownerBalance = await token.balanceOf(owner.address);
    expect(await token.name()).to.equal("MyToken");
  });

  it("Expect mint", async function () {
    await token.mint(acc1.address, 1, {
      value: ethers.utils.parseEther("0.1"),
    });
    expect(await token.ownerOf(1)).to.equal(acc1.address);
  });

  it("Expect failed single mint", async function () {
    expect(token.mint(acc1.address, 1, {
      value: ethers.utils.parseEther("0"),
    })).to.be.revertedWith("Not enough funds to mint.");
  });

  it("Expect multi mint", async function () {
    await token.batchMint(acc1.address, [1,2,3], {
      value: ethers.utils.parseEther("0.3"),
    });
    expect(await token.ownerOf(1)).to.equal(acc1.address);
    expect(await token.ownerOf(2)).to.equal(acc1.address);
    expect(await token.ownerOf(3)).to.equal(acc1.address);
  });

  it("Expect failed multi mint", async function () {
    expect(token.batchMint(acc1.address, [1,2,3], {
      value: ethers.utils.parseEther("0.2"),
    })).to.be.revertedWith("Not enough funds to mint.")
  });

  it("Expect supportsInterface", async function () {
    expect(await token.supportsInterface("0x00000001"), false);
  });
});

```

### hardhat-boilerplate​

- how to run with frontend and contract?
透過ethers套件，init contract by abi，即可操作合約中的function

![](https://i.imgur.com/YLsWJaV.png)