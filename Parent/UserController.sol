pragma solidity >=0.4.22<0.6.0;

import "./UserStorage.sol";

contract UserController {
  enum CoffeeSize {SMALL, BIG}
  enum CoffeeStrength {MILD, Normal, STRONG}

  address public userStorage;

  constructor(address _userStorage) public {
    userStorage = _userStorage;
    //userStorage = UserStorage(_userStorage);
  }

  string private todo;

  function ready() public view returns (string memory) {
    return todo;
  }

  function setTodo(string memory td) public {
    todo = td;
  }

  function getUserCoffeeCnt(
    bytes32 _email,
    CoffeeSize _size,
    CoffeeStrength _strength
  ) public view returns (uint) {
    uint8 coffee = getCoffeeCode(uint8(_size), uint8(_strength));
    UserStorage us = UserStorage(userStorage);
    return us.getUserCoffeeCnt(_email, coffee);
  }

  function insertCoffee(
    bytes32 _email,
    CoffeeSize _size,
    CoffeeStrength _strength
  ) public {
    uint8 coffee = getCoffeeCode(uint8(_size), uint8(_strength));
    UserStorage us = UserStorage(userStorage);
    us.insertCoffee(_email, coffee);
  }

  function getOverallCoffeeCnt(CoffeeSize _size, CoffeeStrength _strength)
    public
    view
    returns (uint)
  {
    uint8 coffee = getCoffeeCode(uint8(_size), uint8(_strength));
    UserStorage us = UserStorage(userStorage);
    return us.getOverallCoffeeCnt(coffee);
  }

  function insertUser(bytes32 _email, address _ethAddress)
    public
    returns (bool, address)
  {
    UserStorage us = UserStorage(userStorage);
    if (us.isUser(_email)) {
      revert();
    }
    return us.insertUser(_email, _ethAddress);
  }

  function getUser(bytes32 _email) public view returns (address) {
    UserStorage us = UserStorage(userStorage);
    if (!us.isUser(_email)) {
      revert();
    }
    return us.getUser(_email);
  }

  function getUserCount() public view returns (uint count) {
    UserStorage us = UserStorage(userStorage);
    return us.userCount();
  }

  function getUserAtIndex(uint _index) public view returns (bytes32) {
    UserStorage us = UserStorage(userStorage);
    return us.getUserAtIndex(_index);
  }

  function getCoffeeCode(uint8 x, uint8 y) private pure returns (uint8) {
    return (x * 10 + y);
  }

  /* function kill(address upgradedOrganisation_) {
        var tokenBalance = tokenLedger.balanceOf(this);
        tokenLedger.transfer(upgradedOrganisation_, tokenBalance);
        selfdestruct(upgradedOrganisation_);
    } */

}
