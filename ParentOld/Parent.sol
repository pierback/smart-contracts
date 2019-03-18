pragma solidity >=0.4.22<0.6.0;

import "./UserController.sol";
import "./UserStorage.sol";

contract Parent {
  mapping(bytes32 => address) public controllers;
  address pubController;

  function createUserController() public {
    UserStorage userStorage = new UserStorage();
    UserController userController = new UserController(address(userStorage));
    pubController = address(userController);
  }

  function getUserController() public view returns (address) {
    return pubController;
  }

  function ready() public view returns (string memory) {
    return UserController(pubController).ready();
  }

  function setTodo(string memory td) public {
    return UserController(pubController).setTodo(td);
  }

  function upgradeOrganisation(bytes32 key_) public {
    address ucAddress = controllers[key_];
    UserController userController = UserController(ucAddress);
    address userStorage = userController.userStorage();

    UserController userControllerNew = new UserController(userStorage);

    //userController.kill(userControllerNew);

    controllers[key_] = address(userControllerNew);
  }
}
