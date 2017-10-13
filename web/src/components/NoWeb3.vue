<template>
  <v-app class="no-web3">
    <v-container grid-list-md text-xs-center>
      <v-layout row wrap>
        <v-flex xs12>
          <v-card>
            <v-card-text>
              <strong>
                Please use <a href="https://github.com/ethereum/mist" target="_blank">Mist</a>
                or <a href="https://metamask.io/" target="_blank">MetaMask</a>
              </strong>
            </v-card-text>
          </v-card>
        </v-flex>
      </v-layout>
    </v-container>
  </v-app>
</template>

<script>
export default {
  name: 'NoWeb3'
}
</script>

<style></style>
