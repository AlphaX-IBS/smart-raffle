pragma solidity ^0.4.4;

contract Raffle {
  struct Ticket {
        uint number;
        bool drawn;
        string fullname;
        string email;
  }

 // State
  address owner;
  string ownerName;
  
  // Key: email address
  mapping(string => Ticket) private tickets;

  function Raffle(string _name) {
    owner = msg.sender;
    name = _name;
  }

  // Sell a ticket. Validate that the email associated to the buyer 
  // doesn't have a ticket already
  function buyTicket(string fullname, string email) {
  }
}
