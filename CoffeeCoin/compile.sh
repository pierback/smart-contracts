solc --bin CoffeeCoin.sol -o build --overwrite
solc --abi CoffeeCoin.sol -o build --overwrite
abigen --bin=./build/CoffeeCoin.bin --abi=./build/CoffeeCoin.abi --pkg=coffeecoin --out=CoffeeCoin.go
parentdir="$(dirname $(pwd))"
mkdir -p $(dirname $parentdir)/bchain-qlearning/internal/contracts/CoffeeCoin
yes | cp -rf $parentdir/CoffeeCoin/CoffeeCoin.go $(dirname $parentdir)/bchain-qlearning/internal/contracts/CoffeeCoin/CoffeeCoin.go
rm -rf $parentdir/CoffeeCoin/CoffeeCoin.go

solc --bin CoffeeCoinParent.sol -o build/parent --overwrite
solc --abi CoffeeCoinParent.sol -o build/parent --overwrite
abigen --bin=./build/parent/CoffeeCoinParent.bin --abi=./build/parent/CoffeeCoinParent.abi --pkg=coffeecoinparent --out=CoffeeCoinParent.go
parentdir="$(dirname $(pwd))"
mkdir -p $(dirname $parentdir)/bchain-qlearning/internal/contracts/CoffeeCoinParent
yes | cp -rf $parentdir/CoffeeCoin/CoffeeCoinParent.go $(dirname $parentdir)/bchain-qlearning/internal/contracts/CoffeeCoinParent/CoffeeCoinParent.go
rm -rf $parentdir/CoffeeCoin/CoffeeCoinParent.go