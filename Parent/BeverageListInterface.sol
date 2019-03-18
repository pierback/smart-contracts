pragma solidity >=0.4.22<0.6.0;
contract BeverageListInterface {
  function setDataStorage(address _dataStorage) public;

  function getDataStorage() external view returns (address);

  function setDrinkData(bytes32 time, bytes32 _drink, bytes32 _wd) public;

  function kill(address upgradedBeverageList_) public;
}
