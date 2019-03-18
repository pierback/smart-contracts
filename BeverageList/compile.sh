solc --bin BeverageList.sol -o build --overwrite
solc --abi BeverageList.sol -o build --overwrite
abigen --bin=./build/BeverageList.bin --abi=./build/BeverageList.abi --pkg=beveragelist --out=BeverageList.go
yes | cp -rf /Users/fabianpieringer/Projects/Q-Learning-on-Ethereum-Blockchain/smart-contracts/BeverageList/BeverageList.go /Users/fabianpieringer/Projects/Q-Learning-on-Ethereum-Blockchain/bchain-qlearning/internal/contracts/BeverageList/BeverageList.go
rm -rf /Users/fabianpieringer/Projects/Q-Learning-on-Ethereum-Blockchain/smart-contracts/BeverageList/BeverageList.go