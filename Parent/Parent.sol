pragma solidity >=0.4.22<0.6.0;

import "./BeverageListInterface.sol";
import "./DataStorage.sol";

contract Parent {
  event BeverageListCreated(address beverageList, uint now);
  event BeverageListUpgraded(address beverageList, uint now);

  mapping(bytes32 => address) public beverageLists;

  function registerBeverageList(bytes32 key_, address bvgrlAddress) external {
    DataStorage dataStorage = new DataStorage();
    // Set the calling user as the first colony admin

    BeverageListInterface(bvgrlAddress).setDataStorage(address(dataStorage));

    beverageLists[key_] = bvgrlAddress;
    // BeverageListCreated(bvgrlAddress, now);
  }

  function getBeverageList(bytes32 key_) private view returns (address) {
    return beverageLists[key_];
  }

  function upgradeBeverageList(bytes32 key_, address newOrgAddress) external {
    address dataStorage = BeverageListInterface(
      getBeverageList(key_)
    ).getDataStorage();

    BeverageListInterface(newOrgAddress).setDataStorage(dataStorage);

    // beverageList.kill(newOrgAddress);

    beverageLists[key_] = newOrgAddress;
    // BeverageListUpgraded(newOrgAddress, now);
  }
}
