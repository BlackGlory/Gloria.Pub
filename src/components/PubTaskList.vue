<template>
  <div class="pub-task-list">
    <a v-link="'/create'" class="button">Create</a>
    <pub-table :items="tasks"></pub-table>
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
    .then (lis1t) ~>
      @$data.tasks = list
</script>

<style lang="sass">
</style>
