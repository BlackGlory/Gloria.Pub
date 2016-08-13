<template>
  <div class="pub-task-editor" v-loading="isLoading" :loading-options="{ bg: 'transparent' }">
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

require! '../utils.ls': { update-task, get-info, get-task, MessageBox, is-task-name, is-code, is-description }
require! './CodeMirror.vue': CodeMirror
require! 'vue-loading': { default: loading }

export
  name: 'pub-task-editor'
  directives: {
    loading
  }
  data: ->
    name: ''
    code: ''
    description: ''
    id: ''
    is-loading: false
    page-title: ''
  components: {
    CodeMirror
  }
  methods:
    save: ->
      { id, name, code, description } = @$data

      unless is-task-name name
        MessageBox 'Error', 'Name must be 1-30 characters.', 'error'
        return

      unless is-code code
        MessageBox 'Error', 'Code must contains "commit".', 'error'
        return

      unless is-description description
        MessageBox 'Error', 'description must be 0-300 characters.', 'error'
        return

      @$data.is-loading = true
      update-task id, name, code, description
      .then ~>
        @$data.is-loading = false
        @$router.go "/task/#{id}"
      .catch ({ status, status-text }) ~>
        @$data.is-loading = false
        if status
          switch status
          | 404 => @$router.go '/tasks'
          | otherwise => MessageBox "Error #{status}", status-text, 'error'
        else throw arguments
  route:
    data: ({ next }) !->
      data = {}

      get-info!
      .catch ({ status, status-text }) ~>
        if status
          alert 'please login'
          @$router.go "/login"
        else throw arguments
      .then ~>
        data.is-loading = true
        get-task @$route.params.id
      .then (task) ->
        data.is-loading = false
        data.name = task.name
        data.code = task.code
        data.description = task.description
        data.id = task._id
      .catch ({ status, status-text }) ~>
        data.is-loading = false
        if status
          switch status
          | 404 => @$router.go '/tasks'
          | otherwise => MessageBox "Error #{status}", status-text, 'error'
        else throw arguments
      .then ->
        next {
          ...data
          page-title: 'Edit - Gloria'
        }
</script>

<style lang="sass">
</style>
