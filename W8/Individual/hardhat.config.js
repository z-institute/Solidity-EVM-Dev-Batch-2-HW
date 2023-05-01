require("@nomicfoundation/hardhat-toolbox");
require("solidity-coverage");
require("dotenv").config();
const chai = require("chai");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.18",
  settings: {
    optimizer: {
      enabled: true,
      runs: 100,
    },
  },
  networks: {
    sepolia: {
      url: `${process.env.ALCHEMY_SEPOLIA_URL}`,
      accounts: [`0x${process.env.SEPOLIA_PRIVATE_KEY}`],
    },
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: `${process.env.ETHERSCAN_KEY}`,
  },
};
