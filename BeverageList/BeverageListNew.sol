pragma solidity >=0.4.22<0.6.0;

import "./DataStorage.sol";

contract BeverageList {
  DataStorage public dataStorage;

  event NewDrink(address Address, bytes32 time, bytes32 drink, bytes32 weekday);

  function setDataStorage(address _dataStorage) external {
    dataStorage = DataStorage(_dataStorage);
  }

  function getDataStorage() external view returns (address) {
    return address(dataStorage);
  }

  function setDrinkData(bytes32 time, bytes32 _drink, bytes32 _wd) external {
    /* if (!isUser(msg.sender)) {
      createUser(msg.sender);
    }
 */
    dataStorage.setDrinkData(msg.sender, bytes32("time"), _drink, _wd);

    emit NewDrink(msg.sender, time, _drink, _wd);
  }

  function drinkKey(address userAddr, bytes32 time)
    internal
    pure
    returns (bytes memory)
  {
    bytes memory key = abi.encodePacked(userAddr, time, ("dk"));
    return key;
  }

  function wdKey(address userAddr, bytes32 time)
    internal
    pure
    returns (bytes memory)
  {
    bytes memory key = abi.encodePacked(userAddr, time, ("wd"));
    return key;
  }

  function getDrinkData(bytes32 time) external view returns (bytes32, bytes32) {
    return dataStorage.getDrinkData(msg.sender, bytes32("time"));
  }

  function lastUserDrink() public view returns (bytes32, bytes32) {
    bytes32[] memory tmStmps = dataStorage.getBytes32ArrayValues(
      timestampKey(msg.sender)
    );
    bytes32 lastTm = tmStmps[tmStmps.length - 1];

    bytes32 drink = dataStorage.getBytes32Value(drinkKey(msg.sender, lastTm));
    bytes32 weekday = dataStorage.getBytes32Value(wdKey(msg.sender, lastTm));

    return (drink, weekday);
  }

  function timestampKey(address userAddr) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(userAddr, "timeStamps"));
  }

  function userKey(address userAddr) public pure returns (bytes32 userID) {
    return keccak256(abi.encodePacked(userAddr));
  }

  function isUser(address userAddr) public view returns (bool isIndeed) {
    bytes32 usrExistsKey = keccak256(abi.encodePacked(userAddr, "exists"));
    return dataStorage.getBooleanValue(usrExistsKey);
  }

  function createUser(address userAddr) public returns (bool success) {
    require(!isUser(userAddr));

    bytes32 usrExistsKey = keccak256(abi.encodePacked(msg.sender, "exists"));
    dataStorage.setBooleanValue(usrExistsKey, true);
    dataStorage.setAddressValue(userKey(userAddr), userAddr);

    return true;
  }

  function toBytes(address a) public pure returns (bytes memory) {
    return abi.encodePacked(a);
  }

  function bytesToBytes32(bytes memory b, uint offset)
    private
    pure
    returns (bytes32)
  {
    bytes32 out;

    for (uint i = 0; i < 32; i++) {
      out |= bytes32(b[offset + i] & 0xFF) >> (i * 8);
    }
    return out;
  }

  function stringToBytes32(string memory source)
    internal
    pure
    returns (bytes32 result)
  {
    bytes memory tempEmptyStringTest = bytes(source);
    if (tempEmptyStringTest.length == 0) {
      return 0x0;
    }

    assembly {
      result := mload(add(source, 32))
    }
  }
}
