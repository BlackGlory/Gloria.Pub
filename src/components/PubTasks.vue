<template>
  <div class="pub-tasks">
    <div class="section">
      <div class="container">
        <nav>
          <p class="control has-addons">
            <input class="input" type="text" v-model="keyword" placeholder="Find a task">
            <a class="button is-info" @click="search">Search</a>
            <span>&nbsp;or&nbsp;<a v-link="'/create'" class="button">Create</a></span>
          </p>
        </nav>
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! './PubTaskCreator.vue': PubTaskCreator

export
  name: 'pub-tasks'
  data: ->
    keyword: ''
  methods:
    search: ->
      @$router.go "/tasks/#{@$data.keyword}"
</script>

<style lang="sass">
nav
  margin-bottom: 1rem
</style>
