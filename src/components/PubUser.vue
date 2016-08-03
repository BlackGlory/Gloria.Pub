<template>
  <div class="pub-tasks">
    <div class="section">
      <div class="container">
        <article class="hero">
          <div class="hero-head">
            <h1 class="title">
              <i class="fa fa-user"></i> {{ name }}
            </h1>
          </div>
          <div class="hero-body">
            <pub-table :items="list"></pub-table>
          </div>
      </div>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! './PubTable.vue': PubTable
require! '../utils.ls': { get-user, MessageBox }

export
  name: 'pub-user'
  data: ->
    list: []
    name: @$route.params.user ? ''
  components: {
    PubTable
  }
  created: ->
    get-user @$route.params.user
    .then ({ name, tasks }) ~>
      @$data.list = tasks
      @$data.name = name
    .catch ({ status, status-text }) ~>
      switch status
      | 404 => @$router.go '/'
      | otherwise => MessageBox 'Error', status-text
</script>

<style lang="sass">
</style>
