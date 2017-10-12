<template>
  <div id="app">
    <Dapp>
      <SmartRaffle slot="ok"></SmartRaffle>
      <div slot="no-web3">Please use Mist or MetaMask</div>
    </Dapp>
  </div>
</template>

<script>
import Dapp from '@/components/Dapp'
import SmartRaffle from '@/components/SmartRaffle'

export default {
  name: 'app',
  components: {
    Dapp,
    SmartRaffle
  }
}
</script>

<style></style>
