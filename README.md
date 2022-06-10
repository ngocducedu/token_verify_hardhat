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
Code hardhat script: 
./scripts/ sample-script.js


Theo thứ tự: deploy CommonTokenCreate.sol  => được address của contract tạo token này


=> tiếp theo deploy TokenFactory.sol  (truyền address của contract CommonTokenCreate)

  await tokenFactory.setCommonTokenContract("0x31503d3E379352E5FB1c1d5644c44cb30075274a");
  
 => Tạo thử 1 token từ: await tokenFactory.factoryCommonToken("HKTHardhat Token","HKTHH",18,10000);
 => tiêp theo phải lấy đc address của token mới tạo
 => lưu arguments vào ./arguments.js
 
 Rồi sử dụng command verify ở dưới
 
 


-- Deploy contract
npx hardhat run scripts/sample-script.js --network eth-rinkeby


-- verify contract: voi address, hien tai van phai vào [scanhttps://rinkeby.etherscan.io/](https://rinkeby.etherscan.io/) de lay address token mới tạo: 
npx hardhat verify --network eth-rinkeby --constructor-args arguments.js 0x9E78687995Ca88E7a0f0ff1749576AAE8738B707
