<template>
  <div class="pub-task-list">
    <div class="section">
      <div class="container">
        <nav>
          <p class="control has-addons">
            <input class="input" type="text" placeholder="Find a task">
            <a class="button is-info">Search</a>
          </p>
          <a v-link="'/create'" class="button">Create</a>
        </nav>
        <pub-table :items="list"></pub-table>
        <pub-pagination :pagination="pagination" base="'/tasks'"></pub-pagination>
      </div>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! './PubTable.vue': PubTable
require! './PubTaskCreator.vue': PubTaskCreator
require! './PubPagination.vue': PubPagination
require! '../utils.ls': { get-tasks }

export
  name: 'pub-task-list'
  data: ->
    list: []
  components: {
    PubTable
    PubTaskCreator
    PubPagination
  }
  created: ->
    get-tasks!
    .then ({ pagination, list }) ~>
      @$data.list = list
      @$data.pagination = pagination
    .catch (status) ~>
      switch status
      | 404 =>
        @$data.list = []
        @$data.pagination = {}
      | otherwise =>
        console.error status
</script>

<style lang="sass">
nav
  margin-bottom: 1rem
</style>
