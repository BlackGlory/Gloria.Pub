<template>
  <div class="pub-task-list">
    <div class="section">
      <nav>
        <p class="control has-addons">
          <input class="input" type="text" placeholder="Find a task">
          <a class="button is-info">Search</a>
        </p>
        <a v-link="'/create'" class="button">Create</a>
      </nav>
      <pub-table :items="tasks"></pub-table>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! './PubTable.vue': PubTable
require! './PubTaskCreator.vue': PubTaskCreator
require! '../utils.ls': { get-tasks-list }

export
  name: 'pub-task-list'
  data: ->
    tasks: []
  components: {
    PubTable
    PubTaskCreator
  }
  created: ->
    get-tasks-list!
    .then (list) ~>
      @$data.tasks = list
</script>

<style lang="sass">
nav
  margin-bottom: 1rem
</style>
