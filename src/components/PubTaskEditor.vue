<template>
  <div class="pub-task-editor">
    <div class="section">
      <div class="container">
        <form class="control">
          <p class="control">
            <input type="text" v-model="name" name="name" placeholder="name" class="input"/>
          </p>
          <p class="control">
            <input type="text" v-model="description" name="description" placeholder="description" class="input"/>
          </p>
          <p class="control">
            <code-mirror :value.sync="code"></code-mirror>
          </p>
          <p class="control">
            <a @click="save" class="button is-success">Save</a><span> Or <a v-link="'/task/' + $route.params.id" class="is-link align-bottom underline">Cancel</a></span>
          </p>
        </form>
      </div>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! '../utils.ls': { update-task, get-info, get-task, MessageBox }
require! './CodeMirror.vue': CodeMirror

export
  name: 'pub-task-editor'
  data: ->
    name: ''
    code: ''
    description: ''
    id: ''
  components: {
    CodeMirror
  }
  methods:
    save: ->
      update-task @$data.id, @$data.name, @$data.code, @$data.description
      .then ~>
        @$router.go "/task/#{@$data.id}"
      .catch ({ status, status-text }) ~>
        switch status
        | 404 => @$router.go '/tasks'
        | otherwise => MessageBox 'Error', status-text
  ready: ->
    get-info!
    .catch ~>
      alert 'please login'
      @$router.go "/login"
    .then
  created: ->
    get-task @$route.params.id
    .then (task) ~>
      @$data.name = task.name
      @$data.code = task.code
      @$data.description = task.description
      @$data.id = task._id
    .catch ({ status, status-text }) ~>
      switch status
      | 404 => @$router.go '/tasks'
      | otherwise => MessageBox 'Error', status-text
</script>

<style lang="sass">
</style>
