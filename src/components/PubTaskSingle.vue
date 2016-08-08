<template>
  <div class="pub-task-single">
    <div class="section">
      <div class="container">
        <article class="hero" v-loading="isLoading" :loading-options="{ bg: 'transparent' }">
          <div class="hero-head">
            <h1 class="title">
              {{ name }}
              <span v-show="editable" class="icon">
                <a @click="edit"><i class="fa fa-pencil-square-o"></i></a>
              </span>
              <span v-show="editable" class="icon">
                <a @click="remove"><i class="fa fa-trash-o"></i></a>
              </span>
            </h1>
            <h2 class="subtitle">
              <i class="fa fa-user"></i>&nbsp;<a class="default-color" v-link="'/user/' + author">{{ author }}</a>
            </h2>
            <h3 class="subtitle">
              {{ description }}
            </h3>
          </div>
          <div class="hero-body">
            <div class="columns">
              <div class="column is-three-quarters">
                <code-mirror :read-only="true" :value="code"></code-mirror>
              </div>
              <div class="column">
                <a class="button is-primary is-large" v-show="!installed" @click="install">Install</a>
                <a class="button is-success is-large" v-show="installed" @click="uninstall">Installed</a>
              </div>
            </div>
          </div>
          <div class="hero-foot">
            <p>Created: {{ created }}</p>
            <p>Updated: {{ updated }}</p>
            <pub-comment></pub-comment>
          </div>
        </article>
      </div>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! './CodeMirror.vue': CodeMirror
require! './PubComment.vue': PubComment
require! '../utils.ls': { get-task, send-to-extension, get-info, MessageBox, remove-task, gen-sign }
require! 'vue-loading': { default: loading }

export
  name: 'pub-task-single'
  directives: {
    loading
  }
  data: ->
    id: ''
    name: ''
    code: ''
    description: ''
    author: ''
    created: ''
    updated: ''
    editable: false
    is-loading: false
    installed: false
  components: {
    CodeMirror
    PubComment
  }
  methods:
    edit: ->
      @$router.go "/task/#{@$route.params.id}/edit"
    install: ->
      send-to-extension do
        type: 'install'
        name: @$data.name
        code: @$data.code
        origin: gen-sign @$route.params.id
      .then ->
        @$data.installed = true
        MessageBox 'Excited!', 'Task installed', 'success'
      .catch ->
        MessageBox 'Bad End', 'Task install fail', 'error'
    uninstall: ->
      MessageBox.confirm 'Are you sure to uninstall this task?'
      .then ~->
        send-to-extension do
          type: 'uninstall'
          origin: gen-sign @$route.params.id
        .then ~>
          @$data.installed = false
          MessageBox 'Excited!', 'Task uninstalled', 'success'
    remove: ->
      MessageBox.confirm 'Are you sure to delete this task?'
      .then ~>
        remove-task @$route.params.id
        .then ~> @$router.go '/user'
        .catch ({ status, status-text }) ->
          if status
            MessageBox "Error #{status}", status-text
          else throw arguments
  created: ->
    @$data.is-loading = true
    get-task @$route.params.id
    .then (task) ~>
      @$data.is-loading = false
      @$data.name = task.name
      @$data.code = task.code
      @$data.description = task.description
      @$data.author = task.author
      @$data.id = task._id
      @$data.created = new Date task._created
      @$data.updated = new Date task._updated
    .catch ({ status, status-text }) ~>
      @$data.is-loading = false
      if status
        switch status
        | 404 => @$router.go '/tasks'
        | otherwise => MessageBox "Error #{status}", status-text, 'error'
      else throw arguments
    .then get-info
    .then ({ name }) ~>
      if name is @$data.author
        @$data.editable = true
    .catch ({ status, status-text }) ~>
      if status
        switch status
        | 404 => @$data.session = {}
        | otherwise => MessageBox "Error #{status}", status-text, 'error'
      else throw arguments
    .then ~>
      send-to-extension do
        type: 'is-exist'
        origin: gen-sign @$route.params.id
      .then ~>
        @$data.installed = true
      /*
      .catch ->
        MessageBox 'Bad End', 'Check status fail, is Gloria enabled?', 'error'
      */
</script>

<style lang="sass">
.default-color
  color: inherit
</style>
