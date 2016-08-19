<template>
  <div class="pub-tasks">
    <div class="section">
      <div class="container">
        <nav>
          <p class="control has-addons">
            <input class="input" type="text" v-model="keyword" :placeholder="$t('FindTask')">
            <a class="button is-info" @click="search">{{ $t('Search') }}</a>
            <span>&nbsp;{{ $t('Or') }}&nbsp;<a v-link="'/create'" class="button">{{ $t('Create') }}</a></span>
          </p>
        </nav>
        <router-view></router-view>
      </div>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! 'vue': Vue
require! './PubTaskCreator.vue': PubTaskCreator

export
  name: 'pub-tasks'
  data: ->
    keyword: ''
    page-title: ''
  route:
    data: ({ next }) !~>
      next page-title: "#{ Vue.t('Tasks') } - Gloria"
  methods:
    search: ->
      @$router.go "/tasks/#{@$data.keyword}"
</script>

<style lang="sass">
nav
  margin-bottom: 1rem
</style>
