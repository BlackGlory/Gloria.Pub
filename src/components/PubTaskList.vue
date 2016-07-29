<template>
  <div class="pub-task-list">
    <pub-table :items="tasks"></pub-table>
  </div>
</template>

<script lang="livescript">
'use strict'

require! './PubTable.vue': PubTable
require! '../utils.ls': { get-tasks-list }

export
  name: 'pub-task-list'
  data: ->
    tasks: []
  components: {
    PubTable
  }
  created: ->
    get-tasks-list!
    .then (lis1t) ~>
      @$data.tasks = list
</script>

<style lang="sass">
</style>
