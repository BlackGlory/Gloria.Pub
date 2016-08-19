<template>
  <div class="pub-table">
    <table class="table is-bordered">
      <thead>
        <tr>
          <th>{{ $t('Task.Name') }}</th>
          <th>{{ $t('Task.Description') }}</th>
          <th>{{ $t('Task.Author') }}</th>
        </tr>
      </thead>
      <tbody>
        <template v-for="item in items">
          <tr>
            <td>
              <a v-link="'/task/' + item._id">{{ item.name }}</a>
              <span v-show="item.author === session.name" class="icon">
                <a @click="$router.go(`/task/${item._id}/edit`)"><i class="fa fa-pencil-square-o"></i></a>
              </span>
            </td>
            <td>{{ item.description }}</td>
            <td>
              <a v-link="'/user/' + item.author">{{ item.author }}</a>
            </td>
          </tr>
        </template>
      </tbody>
    </table>
  </div>
</template>

<script lang="livescript">
'use strict'

require! '../utils.ls': { get-info, MessageBox }

export
  name: 'pub-table'
  data: ->
    session: {}
  props:
    items:
      type: Array
      default: -> []
  created: ->
    get-info!
    .then (session) ~>
      @$data.session = session
    .catch ({ status, status-text }) ~>
      if status
        switch status
        | 404 => @$data.session = {}
        | otherwise => MessageBox @$t('Error', status), status-text, 'error'
      else throw arguments
</script>

<style lang="sass">
</style>
