pragma solidity >=0.4.22<0.6.0;

contract UserStorage {
  struct UserStruct {
    address ethAddress;
    mapping(uint8 => uint) consumption;
    uint index;
  }

  bytes32[] private userIndex;
  mapping(bytes32 => UserStruct) private users;
  mapping(uint8 => uint) private overallConsumption;

  function insertCoffee(bytes32 _email, uint8 _coffeeCode) public {
    users[_email].consumption[_coffeeCode] += 1;
    overallConsumption[_coffeeCode] += 1;
  }

  function getUserCoffeeCnt(bytes32 _email, uint8 _coffeeCode)
    public
    view
    returns (uint)
  {
    return users[_email].consumption[_coffeeCode];
  }

  function getOverallCoffeeCnt(uint8 _coffeeCode) public view returns (uint) {
    return overallConsumption[_coffeeCode];
  }

  function insertUser(bytes32 _email, address _ethAddress)
    public
    returns (bool, address)
  {
    users[_email].ethAddress = _ethAddress;
    users[_email].index = userIndex.push(_email) - 1;
    return (true, users[_email].ethAddress);
  }

  function isUser(bytes32 _email) public view returns (bool) {
    if (userIndex.length == 0) {
      return false;
    }
    return (userIndex[users[_email].index] == _email);
  }

  function getUser(bytes32 _email) public view returns (address) {
    return (users[_email].ethAddress);
  }

  function userCount() public view returns (uint count) {
    return userIndex.length;
  }

  function getUserAtIndex(uint index) public view returns (bytes32) {
    return userIndex[index];
  }
}
