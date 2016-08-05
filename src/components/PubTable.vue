<template>
  <div class="pub-table">
    <table class="table is-bordered">
      <thead>
        <tr>
          <th>Name</th>
          <th>Description</th>
          <th>Author</th>
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
            <td>{{ item.author }}</td>
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
      switch status
      | 404 => @$data.session = {}
      | otherwise => MessageBox "Error #{status}", status-text, 'error'
</script>

<style lang="sass">
</style>
