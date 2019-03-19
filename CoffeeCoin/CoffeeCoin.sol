pragma solidity >=0.4.22<0.6.0;

import './TokenStorage.sol';

contract CoffeeCoin {
  TokenStorage public tokenStorage;
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

  function setTokenStorage(address _tokenStorage) external {
    tokenStorage = TokenStorage(_tokenStorage);
  }

  function seInitValues(address _chairAddress, uint256 cp, uint256 mp, uint256 wp) external {
    chairAddress = _chairAddress;
    setWaterPrice(wp);
    setCoffeePrice(cp);
    setMatePrice(mp);
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
  
  function initCreditSet() public view returns (bool success) {
      bool initCredit = tokenStorage.getBooleanValue(creaditKey(msg.sender));
      return initCredit;
  }

  function transfer(address to, uint256 tokens) public returns (bool success) {
    uint senderTokenBalance = tokenStorage.getUIntValue(balanceKey(msg.sender));
    uint receiverTokenBalance = tokenStorage.getUIntValue(balanceKey(to));
    
    if (!initCreditSet()) {
      setInitialCredit();
    }

    require(senderTokenBalance >= tokens);

    // accounts[msg.sender].balance -= tokens;
    // accounts[to].balance += tokens;
    uint newSenderBalance = senderTokenBalance - tokens;
    uint newReceiverBalance = receiverTokenBalance + tokens;
    tokenStorage.setUIntValue(balanceKey(msg.sender), newSenderBalance);
    tokenStorage.setUIntValue(balanceKey(to), newReceiverBalance);

    return true;
  }

  function approve(address spender, uint256 tokens)
    public
    returns (bool success)
  {
    // allowed[msg.sender][spender] = tokens;
    tokenStorage.setUIntValue(allowedUsrKey(msg.sender, spender), tokens);
    
    return true;
  }

  function allowedUsrKey(address from, address to) internal pure returns (bytes32) {
    return keccak256(abi.encode(from, to));
  }

  function transferFrom(address from, address to, uint tokens)
    public
    returns (bool success)
  {
    uint fromTokenBalance = tokenStorage.getUIntValue(balanceKey(msg.sender));
    uint receiverTokenBalance = tokenStorage.getUIntValue(balanceKey(to));

    uint allowedTokens = tokenStorage.getUIntValue(allowedUsrKey(from, to));

    if (!initCreditSet()) {
      setInitialCredit();
      approve(msg.sender, initialCredit);
    }

    require(tokens <= fromTokenBalance);
    require(tokens <= allowedTokens);


    //allowed[from][msg.sender] -= tokens;
    uint newAllowedBalance = allowedTokens - tokens;
    tokenStorage.setUIntValue(allowedUsrKey(from, to), newAllowedBalance);

    //accounts[msg.sender].balance -= tokens;
    //accounts[to].balance += tokens;
    uint newFromBalance = fromTokenBalance - tokens;
    uint newReceiverBalance = receiverTokenBalance + tokens;
    tokenStorage.setUIntValue(balanceKey(msg.sender),newFromBalance);
    tokenStorage.setUIntValue(balanceKey(to), newReceiverBalance);

    return true;
  }

  function setInitialCredit() public {
    // accounts[msg.sender].balance = initialCredit;
    // accounts[msg.sender].initialCredit = true;

    tokenStorage.setBooleanValue(creaditKey(msg.sender), true);
    tokenStorage.setUIntValue(balanceKey(msg.sender), initialCredit);
  }

  function balanceKey(address usr) public pure returns (bytes32) {
    bytes32 fromKey = keccak256(abi.encode(usr, 'balance'));
    return fromKey;
  }
  
  function creaditKey(address usr) public pure returns (bytes32) {
    bytes32 fromKey = keccak256(abi.encode(usr, 'credit'));
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
    return tokenStorage.getUIntValue(waterKey());
  }

  function waterKey() internal pure returns (bytes32){
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

  function mateKey() internal pure returns (bytes32){
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
 
  function coffeeKey() internal pure returns (bytes32){
    return keccak256('coffeeprice');
  }
}
