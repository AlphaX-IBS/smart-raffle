<template>
  <div class="smart-raffle">
    <form>
      <label>
        Name
        <input type="text" v-model="fullname">
      </label>
      <label>
        Email
        <input type="email" v-model="email">
      </label>
      <button type="submit" @click.prevent="buyTicket(fullname, email)">Buy ticket</button>
    </form>
    <hr>
    Tickets sold:
    <ul>
      <li v-for="ticket in tickets">{{ ticket[0] }} ({{ ticket[1] }})</li>
    </ul>
    <div>
      Owner name: <strong>{{ ownerName }}</strong>
    </div>
  </div>
</template>

<script>
import RaffleContract from '@/contracts/raffle.js'

export default {
  name: 'SmartRaffle',
  data () {
    return {
      ownerName: 'unknown',
      tickets: [],
      fullname: '',
      email: ''
    }
  },
  created () {
    RaffleContract.setProvider(this.$web3.currentProvider)

    RaffleContract
      .deployed()
      .then((raffle) => {
        this.getOwnerName(raffle);
        this.getTickets(raffle);
      }, this.handleDeployError)
  },
  methods: {
    handleDeployError(err) {
      window.alert('deploy error', err)
    },
    getOwnerName(raffle) {
      return raffle.ownerName()
        .then(ownerName => this.ownerName = ownerName);
    },
    getTickets(raffle) {
      return raffle
        .size()
        .then((sizeBigNumber) => {
          const size = sizeBigNumber.toNumber()

          const promises = [...Array(size)]
            .map((x, i) => raffle.tickets(i))

          return Promise.all(promises)
        })
        .then(tickets => this.tickets = tickets);
    },
    buyTicket(fullname, email) {
      RaffleContract
        .deployed()
        .then((raffle) => {
          this.$web3.eth.getAccounts()
            .then(accounts => accounts[0])
            .then((account) => {
              raffle.buyTicket(fullname, email, { from: account })
            })
        });
    },
  }
}
</script>

<style></style>
