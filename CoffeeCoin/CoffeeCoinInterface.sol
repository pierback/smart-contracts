pragma solidity >=0.4.22<0.6.0;

contract CoffeeCoinInterface {
  function setDataStorage(address _dataStorage) external;
  function getDataStorage() external view returns (address);

  function transfer(bytes32 time, bytes32 _drink, bytes32 _wd) public;
  function transferFrom(address from, address to, uint tokens) public;
  
  function approve(address spender, uint256 tokens) public;
  function kill(address upgradedCoffeeCoin_) public;
  
  function getOwnBalance() external view returns (uint balance);
  function getChairBalance() external view returns (uint balance);
  
  function setWaterPrice(uint256 price) public;
  function setMatePrice(uint256 price) public;
  function setCoffeePrice(uint256 price) public;

  function getWaterPrice() external view returns (uint256);
  function getCoffeePrice() external view returns (uint256);
  function getMatePrice() external view returns (uint256);

  function payCoffee() public returns (bool success);
  function payWater() public returns (bool success);
  function payMate() public returns (bool success);
}
