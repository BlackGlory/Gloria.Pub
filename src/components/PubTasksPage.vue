<template>
  <div class="pub-tasks-page" v-loading="isLoading">
    <pub-table :items="list"></pub-table>
    <pub-pagination :pagination="pagination" base="'/tasks'"></pub-pagination>
  </div>
</template>

<script lang="livescript">
'use strict'

require! './PubTable.vue': PubTable
require! './PubTaskCreator.vue': PubTaskCreator
require! './PubPagination.vue': PubPagination
require! '../utils.ls': { get-tasks, MessageBox }
require! 'vue-loading': { default: loading }

export
  name: 'pub-tasks-page'
  directives: {
    loading
  }
  data: ->
    list: []
    is-loading: false
  components: {
    PubTable
    PubTaskCreator
    PubPagination
  }
  route:
    data: (transition) ->
      @$data.is-loading = true
      get-tasks @$route.params.page, @$route.params.keyword
      .then ({ pagination, list }) ~>
        @$data.list = list
        @$data.pagination = pagination
        @$data.is-loading = false
      .catch ({ status, status-text }) ~>
        switch status
        | 404 =>
          @$data.list = []
          @$data.pagination = {}
        | otherwise => MessageBox "Error #{status}", status-text, 'error'
        @$data.is-loading = false
      transition.next!
</script>

<style lang="sass">
nav
  margin-bottom: 1rem
</style>
