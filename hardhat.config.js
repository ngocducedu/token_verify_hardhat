require('dotenv').config();
require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-etherscan");

const PrivateKeyProvider = require("truffle-privatekey-provider");

// const HDWalletProvider = require('@truffle/hdwallet-provider');

const binanceMnemonic = process.env["BINANCE_MNEMONIC"];
const ropstenMnemonic = process.env["ETHEREUM_ROPSTEN_MNEMONIC"];
const rinkebyMnemonic = process.env["ETHEREUM_RINKEBY_MNEMONIC"];

const infuraKey = process.env["INFURA_KEY"];

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  paths: {
    sources: './contracts',
    tests: './test',
    cache: './cache',
    artifacts: './artifacts',
  },
  solidity: {
    version: '0.8.6',
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    // Useful for testing. The `development` name is special - truffle uses it by default
    // if it's defined here and no other network is specified at the command line.
    // You should run a client (like ganache-cli, geth or parity) in a separate terminal
    // tab if you use this network and you must also set the `host`, `port` and `network_id`
    // options below to some value.
    //
    // dev: {
    //     host: '127.0.0.1',
    //     port: 8545,
    //     network_id: '*',
    // },
    // 'bsc-local-testnet': {
    //     host: '127.0.0.1',
    //     port: 8545,
    //     network_id: '97',
    // },
    // 'bsc-local-mainnet': {
    //     host: '127.0.0.1',
    //     port: 8545,
    //     network_id: '56',
    // },
   //  'bsc-testnet': {
   //      provider: () => new HDWalletProvider(binanceMnemonic, `https://data-seed-prebsc-1-s1.binance.org:8545`),
   //      network_id: 97,
   //      confirmations: 2,
   //      timeoutBlocks: 1000,
   //      skipDryRun: true,
   //  },
  //   'bsc-testnet': {
  //      provider: () => new PrivateKeyProvider(process.env["ADMIN_BSC_PRIVKEY"], `https://data-seed-prebsc-1-s2.binance.org:8545`),
  //      network_id: 97,
  //      confirmations: 2,
  //      timeoutBlocks: 1000,
  //      skipDryRun: true,
  //  },
    // 'bsc-mainnet': {
    //     provider: () => new HDWalletProvider(binanceMnemonic, `https://bsc-dataseed.binance.org/`),
    //     network_id: 56,
    //     confirmations: 10,
    //     timeoutBlocks: 200,
    //     skipDryRun: true,
    // },
    // 'eth-local-ropsten': {
    //     host: '127.0.0.1',
    //     port: 8545,
    //     network_id: 3,
    //     skipDryRun: true,
    // },
    // 'eth-ropsten': {
    //     provider: () =>
    //     new HDWalletProvider(ropstenMnemonic, `https://ropsten.infura.io/v3/${infuraKey}`),
    //     network_id: 3,
    //     gas: 5500000,
    //    //  gasPrice: 15000000000,
    //     confirmations: 2,
    //     timeoutBlocks: 200,
    //     skipDryRun: true,
    // },
   //   'eth-rinkeby': {
   //     provider: () =>
   //         new HDWalletProvider(rinkebyMnemonic, `https://rinkeby.infura.io/v3/${infuraKey}`),
   //     network_id: 4,
   //     gas: 5500000,
   //   //  gasPrice: 15000000000,
   //     confirmations: 2,
   //     timeoutBlocks: 1000,
   //     skipDryRun: true,
   // },
  //  'eth-rinkeby': {
  //      provider: () => new PrivateKeyProvider(process.env.ADMIN_ETH_PRIVKEY, `https://rinkeby.infura.io/v3/${infuraKey}`),
  //      network_id: 4,
  //      gas: 5500000,
  //    //  gasPrice: 15000000000,
  //      confirmations: 2,
  //      timeoutBlocks: 1000,
  //      skipDryRun: true,
  //  },
   'eth-rinkeby': {
    url: "https://rinkeby.infura.io/v3/992c21228e694d0898f3ff894bc3d86e",
    // accounts: [process.env.ADMIN_ETH_PRIVKEY],
    accounts: {
      mnemonic: "vague search original fit dish equip arch junior fluid size three shaft",
    },
    gas: 2100000,
    gasPrice: 8000000000,
    saveDeployments: true,
},
    // 'eth-local-mainnet': {
    //     host: '127.0.0.1',
    //     port: 8545,
    //     network_id: 1,
    //     skipDryRun: true,
    // },
    // 'eth-mainnet': {
    //     provider: () =>
    //         new HDWalletProvider(ropstenMnemonic, `https://mainnet.infura.io/v3/${infuraKey}`),
    //     network_id: 3,
    //     gas: 5500000,
    //     gasPrice: 15000000000,
    //     confirmations: 2,
    //     timeoutBlocks: 200,
    // },
  },
  etherscan: {
    // Your API key for Etherscan
    // Obtain one at https://etherscan.io/
    apiKey: process.env.ETHERSCAN_API_KEY
  }
};
