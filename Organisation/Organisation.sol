import "ITokenLedger.sol";

contract Organisation {
  ITokenLedger public tokenLedger;
  address public eternalStorage;

  function setDataStore(address _tokenLedger, address _eternalStorage) {
    tokenLedger = ITokenLedger(_tokenLedger);
    eternalStorage = _eternalStorage;
  }

  function addProposal(bytes32 _name) {
    eternalStorage.addProposal(_name);
  }

  function generateTokens(uint256 _amount) {
    tokenLedger.generateTokens(_amount);
  }

  function getBalance(address _account) constant returns (uint256) {
    return tokenLedger.balanceOf(_account);
  }

  function setTokenLedgerAddress(address _tokenLedger) {
    tokenLedger = ITokenLedger(_tokenLedger);
  }

  function kill(address upgradedOrganisation_) {
    var tokenBalance = tokenLedger.balanceOf(this);
    tokenLedger.transfer(upgradedOrganisation_, tokenBalance);
    selfdestruct(upgradedOrganisation_);
  }
}
