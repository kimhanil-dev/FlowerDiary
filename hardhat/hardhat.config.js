require("@nomicfoundation/hardhat-toolbox");
//require('hardhat-ethernal');
require("hardhat-gas-reporter");
require('dotenv');

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.20",
  ethernal: {
      apiToken: process.env.ETHERNAL_API_TOKEN
  },
  gasReporter: {
    currency: 'CHF',
    gasPrice: 21
  }
};
