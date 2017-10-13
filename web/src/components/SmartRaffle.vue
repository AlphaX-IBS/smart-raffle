<template>
  <v-app class="smart-raffle">
    <v-container grid-list-md text-xs-center>
      <v-layout row wrap>
        <v-flex xs12>
          <v-form v-model="valid">
            <v-text-field
              label="Name"
              v-model="fullname"
              :rules="[required('Name')]"
              required>
            </v-text-field>
            <v-text-field
              label="E-mail"
              v-model="email"
              :rules="[required('E-mail')]"
              required>
            </v-text-field>
            <v-btn type="submit" @click.prevent="buyTicket(fullname, email)">Buy ticket</v-btn>
          </v-form>

          <br>

          <v-card>
            <v-toolbar color="purple" dark>
              <v-toolbar-title>Tickets sold</v-toolbar-title>
            </v-toolbar>
            <v-list>
              <template v-for="(ticket, index) in tickets">
                <v-list-tile >
                  <v-list-tile-content>
                    <v-list-tile-title>{{ ticket[0] }}</v-list-tile-title>
                    <v-list-tile-sub-title>{{ ticket[1] }}</v-list-tile-sub-title>
                  </v-list-tile-content>
                </v-list-tile>
                <v-divider v-if="index + 1 < tickets.length" :key="ticket[1]"></v-divider>
              </template>
            </v-list>
          </v-card>
        </v-flex>
      </v-layout>
    </v-container>
  </v-app>
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
      email: '',
      required: label => x => !!x || `${label} is required`,
      valid: false
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
              this.fullname = ''
              this.email = ''
            })
        });
    },
  }
}
</script>

<style></style>
