# Basic Sample Hardhat Project

This project demonstrates a basic Hardhat use case. It comes with a sample contract, a test for that contract, a sample script that deploys that contract, and an example of a task implementation, which simply lists the available accounts.

Try running some of the following tasks:

```shell
npx hardhat accounts
npx hardhat compile
npx hardhat clean
npx hardhat test
npx hardhat node
node scripts/sample-script.js
npx hardhat help
```



-- Deploy contract
npx hardhat run scripts/sample-script.js --network eth-rinkeby


-- verify contract: voi address, hien tai van phai vào [scanhttps://rinkeby.etherscan.io/](https://rinkeby.etherscan.io/) de lay address token mới tạo: 0x9E78687995Ca88E7a0f0ff1749576AAE8738B707
npx hardhat verify --network eth-rinkeby --constructor-args arguments.js 0x9E78687995Ca88E7a0f0ff1749576AAE8738B707
