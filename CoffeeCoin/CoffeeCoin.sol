pragma solidity >=0.4.22<0.6.0;

import './TokenStorage.sol';

contract CoffeeCoin {
  uint constant initialCredit = 1000000000000000;

  struct Account {
    uint256 balance;
    bool initialCredit;
  }

  address private chairAddress;

  uint256 private coffeePrice;
  uint256 private matePrice;
  uint256 private waterPrice;

  mapping(address => Account) public accounts;
  mapping(address => mapping(address => uint256)) public allowed;

  TokenStorage public tokenStorage;

  constructor(address _chairAddress, uint256 cp, uint256 mp, uint256 wp)
    public
    payable
  {
    chairAddress = _chairAddress;
    setWaterPrice(cp);
    setCoffeePrice(mp);
    setMatePrice(wp);
  }

  function setTokenStorage(address _tokenStorage) external {
    dataStorage = TokenStorage(_tokenStorage);
  }

  function getTokenStorage() external view returns (address) {
    return address(tokenStorage);
  }

  function payCoffee() public returns (bool success) {
    return transfer(chairAddress, coffeePrice);
  }

  function payWater() public returns (bool success) {
    return transfer(chairAddress, waterPrice);
  }

  function payMate() public returns (bool success) {
    return transfer(chairAddress, matePrice);
  }

  function transfer(address to, uint256 tokens) public returns (bool success) {
    bool initialCredit = tokenStorage.getBooleanValue(balanceKey(msg.sender));
    uint senderTokenBalance = TokenStorage.getUIntValue(balanceKey(msg.sender));
    uint receiverTokenBalance = TokenStorage.getUIntValue(balanceKey(to));
    
    if (!initialCredit) {
      setInitialCredit();
    }

    require(senderTokenBalance >= tokens);

    // accounts[msg.sender].balance -= tokens;
    // accounts[to].balance += tokens;
    tokenStorage.setUIntValue(balanceKey(msg.sender), sednderTokenBalance-tokens);
    tokenStorage.setUIntValue(balanceKey(to), receiverTokenBalance+tokens);

    return true;
  }

  function approve(address spender, uint256 tokens)
    public
    returns (bool success)
  {
    // allowed[msg.sender][spender] = tokens;
    tokenStorage.setUIntValue(allowedUsrKey(), tokens);
    
    return true;
  }

  function allowedUsrKey(address from, address to) internal pure returns (bytes32) {
    return keccak256(from, to);
  }

  function transferFrom(address from, address to, uint tokens)
    public
    returns (bool success)
  {
    bool initialCredit = tokenStorage.getBooleanValue(balanceKey(msg.sender));
    uint fromTokenBalance = tokenStorage.getUIntValue(balanceKey(msg.sender));
    uint receiverTokenBalance = tokenStorage.getUIntValue(balanceKey(to));

    uint allowedTokens = tokenStorage.getUIntValue(allowedUsrKey());

    if (!initialCredit) {
      setInitialCredit();
      approve(msg.sender, initialCredit);
    }

    require(tokens <= fromTokenBalance);
    require(tokens <= allowedTokens);


    //allowed[from][msg.sender] -= tokens;
    tokenStorage.setUIntValue(allowedUsrKey(), allowedTokens-tokens);

    //accounts[msg.sender].balance -= tokens;
    //accounts[to].balance += tokens;
    tokenStorage.setUIntValue(balanceKey(msg.sender), fromTokenBalance-tokens);
    tokenStorage.setUIntValue(balanceKey(to), receiverTokenBalance+tokens);

    return true;
  }

  function setInitialCredit() internal {
    // accounts[msg.sender].balance = initialCredit;
    // accounts[msg.sender].initialCredit = true;

    tokenStorage.setBooleanValue(balanceKey(msg.sender), true);
    tokenStorage.setUIntValue(balanceKey(msg.sender), initialCredit);
  }

  function balanceKey(address usr) internal pure returns (bytes32) {
    bytes32 fromKey = keccak256(abi.encodePacked(usr, 'balance'));
    return fromKey;
  }

  function balanceOf(address tokenOwner) external view returns (uint balance) {
    return accounts[tokenOwner].balance;
  }

  function getOwnBalance() external view returns (uint balance) {
    // return accounts[msg.sender].balance;
    return tokenStorage.getUIntValue(balanceKey(msg.sender));
  }

  function getChairBalance() public view returns (uint balance) {
    // return balanceOf(chairAddress);
    return tokenStorage.getUIntValue(balanceKey(chairAddress));
  }

  function setWaterPrice(uint256 price) public {
    // waterPrice = price;
    tokenStorage.setUIntValue(waterKey(), price);
  }

  function getWaterPrice() public view returns (uint256) {
    // return waterPrice;
    return tokenStorage.setUIntValue(waterKey());
  }

  function waterKey() interanl pure returns (bytes32){
    return keccak256('waterprice');
  }

  function setMatePrice(uint256 price) public {
    // matePrice = price;
    tokenStorage.setUIntValue(mateKey(), price);
  }

  function getMatePrice() public view returns (uint256) {
    // return matePrice;
    return tokenStorage.getUIntValue(mateKey());
  }

  function mateKey() interanl pure returns (bytes32){
    return keccak256('mateprice');
  }

  function setCoffeePrice(uint256 price) public {
    // coffeePrice = price;
    tokenStorage.setUIntValue(coffeeKey(), price);
  }

  function getCoffeePrice() public view returns (uint256) {
    // return coffeePrice;
    return tokenStorage.getUIntValue(coffeeKey());
  }
 
  function coffeeKey() interanl pure returns (bytes32){
    return keccak256('coffeeprice');
  }
}
