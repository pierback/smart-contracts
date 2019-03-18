pragma solidity >=0.4.22<0.6.0;

import "./CoffeeCoinInterface.sol";
import "./TokenStorage.sol";

contract Parent {
  event CoffeCoinCreated(address coffeeCoin, uint now);
  event CoffeCoinUpgraded(address coffeeCoin, uint now);

  mapping(bytes32 => address) public coffeeCoins;

  function registerCoffeCoin(bytes32 key_, address bvgrlAddress) external {
    TokenStorage tokenStorage = new TokenStorage();
    // Set the calling user as the first colony admin

    CoffeCoinInterface(bvgrlAddress).setTokenStorage(address(tokenStorage));

    coffeeCoins[key_] = bvgrlAddress;
    // CoffeCoinCreated(bvgrlAddress, now);
  }

  function getCoffeCoin(bytes32 key_) private view returns (address) {
    return coffeeCoins[key_];
  }

  function upgradeCoffeCoin(bytes32 key_, address newOrgAddress) external {
    address tokenStorage = CoffeCoinInterface(
      getCoffeCoin(key_)
    ).getTokenStorage();

    CoffeCoinInterface(newOrgAddress).setTokenStorage(tokenStorage);

    // coffeeCoin.kill(newOrgAddress);

    coffeeCoins[key_] = newOrgAddress;
    // CoffeCoinUpgraded(newOrgAddress, now);
  }
}
