<template>
  <div class="pub-tasks-page" v-loading="isLoading" :loading-options="{ bg: 'transparent' }">
    <pub-table :items="list"></pub-table>
    <pub-pagination :pagination="pagination" :base-url="'/tasks' + ($route.params.keyword ? '/' + $route.params.keyword : '')"></pub-pagination>
  </div>
</template>

<script lang="livescript">
'use strict'

require! 'vue': Vue
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
    pagination: {}
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
        @$data.is-loading = false
        @$data.list = list
        @$data.pagination = pagination
      .catch ({ status, status-text }) ~>
        @$data.is-loading = false
        if status
          switch status
          | 404 =>
            @$data.list = []
            @$data.pagination = {}
          | otherwise => MessageBox Vue.t('Error', status), status-text, 'error'
        else throw arguments
      transition.next!
</script>

<style lang="sass">
nav
  margin-bottom: 1rem
</style>
