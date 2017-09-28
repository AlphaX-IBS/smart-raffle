pragma solidity ^0.4.11;

contract Raffle {
  struct Ticket {
    string fullname;
    string email;
  }

 // State
  address public owner;
  string public ownerName;

  Ticket[] public tickets;
  Ticket[] public drawnTickets;

  function Raffle(string _name) {
    owner = msg.sender;
    ownerName = _name;
  }

  // Sell a ticket. Validate that the email associated to the buyer doesn't have a ticket already
  function buyTicket(string fullname, string email) {
    bool exists = false;
    for (uint i = 0; !exists && i < tickets.length; i++) {
      Ticket memory ticket = tickets[i];

      if (sha3(email) == sha3(ticket.email)) {
        exists = true;
      }
    }

    if (!exists) {
      Ticket memory newTicket = Ticket(fullname, email);
      tickets.push(newTicket);
    }
  }

  function currentWinner() constant returns (string fullname) {
    return drawnTickets[drawnTickets.length - 1].fullname;
  }

  function drawTicket() {
    require(msg.sender == owner);

    uint idx = randomTicketIndex();
    drawnTickets.push(tickets[idx]);
    removeTicket(idx);
  }

  function removeTicket(uint idx) {
    for (uint i = idx; i + 1 < tickets.length; i++) {
      tickets[i] = tickets[i+1];
    }

    delete tickets[tickets.length - 1];
    tickets.length--;
  }

  function randomTicketIndex() constant returns (uint) {
    uint idx = random() % tickets.length;
    return idx;
  }

  function random() constant returns (uint) {
    uint seed = block.number;

    uint a = 1103515245;
    uint c = 12345;
    uint m = 2 ** 32;

    return (a * seed + c) % m;
  }
}
