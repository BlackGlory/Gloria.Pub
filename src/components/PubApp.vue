<template>
  <div class="pub-app">
    <pub-header></pub-header>
    <router-view></router-view>
    <pub-footer></pub-footer>
  </div>
</template>

<script lang="livescript">
'use strict'

require! './PubHeader.vue': PubHeader
require! './PubFooter.vue': PubFooter

export
  name: 'pub-app'
  components: {
    PubHeader
    PubFooter
  }
</script>

<style lang="sass">
$fa-font-path: "~font-awesome/fonts"
@import "~font-awesome/scss/font-awesome"

@import "~bulma/bulma"
</style>
