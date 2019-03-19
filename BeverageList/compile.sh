solc --bin BeverageList.sol -o build --overwrite
solc --abi BeverageList.sol -o build --overwrite
abigen --bin=./build/BeverageList.bin --abi=./build/BeverageList.abi --pkg=beveragelist --out=BeverageList.go
parentdir="$(dirname $(pwd))"
mkdir -p $(dirname $parentdir)/bchain-qlearning/internal/contracts/BeverageList
yes | cp -rf $parentdir/BeverageList/BeverageList.go $(dirname $parentdir)/bchain-qlearning/internal/contracts/BeverageList/BeverageList.go
rm -rf $parentdir/BeverageList/BeverageList.go