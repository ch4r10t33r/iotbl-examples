pragma solidity ^0.4.0;

contract Artefact {
  address owner;
  string ARTEFACT_NAME;
  string ARTEFACT_SIGNATURE;
  //we have assumed a simple commission structure for this contract
  address commReceiver;
  uint commAmount;

  modifier onlyOwner {
      if (msg.sender != owner)
          throw;
      _;
  }

  function Aretfact(string _name,string _hash,address _receiver,uint _commAmount) {
    owner = msg.sender;
    ARTEFACT_NAME = _name;
    ARTEFACT_SIGNATURE = _hash;
    commReceiver = _receiver;
    commAmount = _commAmount;
  }

  function getArtefactName() returns (string) {
    return ARTEFACT_NAME;
  }

  function transferOwner(address _newOwner) onlyOwner {
    if(msg.sender != owner) {
      throw;
    }
    owner = _newOwner;
  }

  function payout() payable returns (bool){
    if(msg.sender.balance != commAmount) {
      throw;
    }
    return commReceiver.send(msg.value);
  }
}
