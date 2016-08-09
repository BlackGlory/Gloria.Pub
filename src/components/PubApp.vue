<template>
  <div class="pub-app">
    <pub-header :session="session"></pub-header>
    <router-view @route-data-loaded="changeTitle"></router-view>
    <pub-footer></pub-footer>
  </div>
</template>

<script lang="livescript">
'use strict'

require! './PubHeader.vue': PubHeader
require! './PubFooter.vue': PubFooter
require! '../utils.ls': { get-info, MessageBox }

export
  name: 'pub-app'
  data: ->
    session: {}
  components: {
    PubHeader
    PubFooter
  }
  methods:
    change-title: ({ page-title = document.title }) ->
      document.title = page-title
  created: ->
    @$dispatch 'session-change'
  events:
    'session-change': ->
      get-info!
      .then (session) ~>
        @$data.session = session
      .catch ({ status, status-text }) ~>
        if status
          switch status
          | 404 => @$data.session = {}
          | otherwise => MessageBox "Error #{status}", status-text, 'error'
        else throw arguments
</script>

<style lang="sass">
$fa-font-path: "~font-awesome/fonts"
@import "~font-awesome/scss/font-awesome"

@import "~bulma/bulma"
</style>
