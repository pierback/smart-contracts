pragma solidity >=0.4.22<0.6.0;

contract DataStorage {
  mapping(address => mapping(bytes32 => bytes32)) private usrBvrgHist;
  // mapping(address => mapping(bytes32 => DrinkData)) private usrBvrgHist;

  struct DrinkData {
    bytes32 drink;
    bytes32 weekday;
  }

  struct DrinkRecord {
    address Address;
    DrinkData dd;
    bytes32 time;
  }

  struct User {
    bool exists;
    bytes32[] timeStamps;
  }

  mapping(bytes32 => uint) UIntStorage;

  function setDrinkData(
    address usr,
    bytes32 time,
    bytes32 drink,
    bytes32 weekday
  ) external {
    // DrinkData memory dd = DrinkData(drink, weekday);
    usrBvrgHist[usr][time] = drink;
  }

  function getDrinkData(address usr, bytes32 time)
    external
    view
    returns (bytes32, bytes32)
  {
    bytes32 data = usrBvrgHist[usr][time];
    return (data, data);
  }
  function getUIntValue(bytes32 record) public view returns (uint) {
    return UIntStorage[record];
  }

  function setUIntValue(bytes32 record, uint value) public {
    UIntStorage[record] = value;
  }

  function deleteUIntValue(bytes32 record) public {
    delete UIntStorage[record];
  }

  mapping(bytes32 => string) StringStorage;

  function getStringValue(bytes32 record) public view returns (string memory) {
    return StringStorage[record];
  }

  function setStringValue(bytes32 record, string memory value) public {
    StringStorage[record] = value;
  }

  function deleteStringValue(bytes32 record) public {
    delete StringStorage[record];
  }

  mapping(bytes32 => address) AddressStorage;

  function getAddressValue(bytes32 record) public view returns (address) {
    return AddressStorage[record];
  }

  function setAddressValue(bytes32 record, address value) public {
    AddressStorage[record] = value;
  }

  function deleteAddressValue(bytes32 record) public {
    delete AddressStorage[record];
  }

  mapping(bytes32 => bytes) BytesStorage;

  function getBytesValue(bytes32 record) public view returns (bytes memory) {
    return BytesStorage[record];
  }

  function setBytesValue(bytes32 record, bytes memory value) public {
    BytesStorage[record] = value;
  }

  function deleteBytesValue(bytes32 record) public {
    delete BytesStorage[record];
  }

  mapping(bytes => bytes32) Bytes32Storage;

  function getBytes32Value(bytes memory record) public view returns (bytes32) {
    return Bytes32Storage[record];
  }

  function setBytes32Value(bytes memory record, bytes32 value) public {
    Bytes32Storage[record] = value;
  }

  function deleteBytes32Value(bytes memory record) public {
    delete Bytes32Storage[record];
  }

  mapping(bytes32 => bytes32[]) Bytes32ArrayStorage;

  function getBytes32ArrayValues(bytes32 record)
    public
    view
    returns (bytes32[] memory)
  {
    return Bytes32ArrayStorage[record];
  }

  function setBytes32ArrayValues(bytes32 record, bytes32 value) public {
    uint length = Bytes32ArrayStorage[record].length;
    Bytes32ArrayStorage[record][length - 1] = value;
  }

  mapping(bytes32 => bool) BooleanStorage;

  function getBooleanValue(bytes32 record) public view returns (bool) {
    return BooleanStorage[record];
  }

  function setBooleanValue(bytes32 record, bool value) public {
    BooleanStorage[record] = value;
  }

  function deleteBooleanValue(bytes32 record) public {
    delete BooleanStorage[record];
  }

  mapping(bytes32 => int) IntStorage;

  function getIntValue(bytes32 record) public view returns (int) {
    return IntStorage[record];
  }

  function setIntValue(bytes32 record, int value) public {
    IntStorage[record] = value;
  }

  function deleteIntValue(bytes32 record) public {
    delete IntStorage[record];
  }
}
