<template>
  <div class="pub-tasks-page">
    <pub-table :items="list"></pub-table>
    <pub-pagination :pagination="pagination" base="'/tasks'"></pub-pagination>
  </div>
</template>

<script lang="livescript">
'use strict'

require! './PubTable.vue': PubTable
require! './PubTaskCreator.vue': PubTaskCreator
require! './PubPagination.vue': PubPagination
require! '../utils.ls': { get-tasks }

export
  name: 'pub-tasks-page'
  data: ->
    list: []
  components: {
    PubTable
    PubTaskCreator
    PubPagination
  }
  route:
    data: (transition) ->
      get-tasks @$route.params.page, @$route.params.keyword
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
      transition.next!
</script>

<style lang="sass">
nav
  margin-bottom: 1rem
</style>
