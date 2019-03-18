solc --bin Parent.sol -o build --overwrite
solc --abi Parent.sol -o build --overwrite
abigen --bin=./build/Parent.bin --abi=./build/Parent.abi --pkg=parent --out=Parent.go
yes | cp -rf /Users/fabianpieringer/Projects/Q-Learning-on-Ethereum-Blockchain/smart-contracts/Parent/Parent.go /Users/fabianpieringer/Projects/Q-Learning-on-Ethereum-Blockchain/bchain-qlearning/internal/contracts/Parent/Parent.go
rm -rf /Users/fabianpieringer/Projects/Q-Learning-on-Ethereum-Blockchain/smart-contracts/Parent/Parent.go