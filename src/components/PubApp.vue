<template>
  <div class="pub-app">
    <pub-header :session="session"></pub-header>
    <router-view></router-view>
    <pub-footer></pub-footer>
  </div>
</template>

<script lang="livescript">
'use strict'

require! './PubHeader.vue': PubHeader
require! './PubFooter.vue': PubFooter
require! '../utils.ls': { get-info }

export
  name: 'pub-app'
  data: ->
    session: {}
  components: {
    PubHeader
    PubFooter
  }
  ready: ->
    @$dispatch 'session-change'
  events:
    'session-change': ->
      get-info!
      .then (session) ~>
        @$data.session = session
      .catch (status) ~>
        switch status
        | 404 => @$data.session = {}
        | otherwise => console.error status
</script>

<style lang="sass">
$fa-font-path: "~font-awesome/fonts"
@import "~font-awesome/scss/font-awesome"

@import "~bulma/bulma"
</style>
