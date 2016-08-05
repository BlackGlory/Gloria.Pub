<template>
  <div class="pub-task-single">
    <div class="section">
      <div class="container">
        <article class="hero">
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
              <i class="fa fa-user"></i> {{ author }}
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
                <a class="button is-primary is-large" @click="install">Install</a>
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
require! '../utils.ls': { get-task, send-to-extension, get-info, MessageBox, remove-task }

export
  name: 'pub-task-single'
  data: ->
    id: ''
    name: ''
    code: ''
    description: ''
    author: ''
    created: ''
    updated: ''
    editable: false
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
    remove: ->
      MessageBox.confirm 'Are you sure to delete this task?'
      .then ~>
        remove-task @$route.params.id
        .then ~> @$router.go '/user'
        .catch ({ status, status-text }) ->
          MessageBox "Error #{status}", status-text
  created: ->
    get-task @$route.params.id
    .then (task) ~>
      @$data.name = task.name
      @$data.code = task.code
      @$data.description = task.description
      @$data.author = task.author
      @$data.id = task._id
      @$data.created = new Date task._created
      @$data.updated = new Date task._updated
    .catch ({ status, status-text }) ~>
      switch status
      | 404 => @$router.go '/tasks'
      | otherwise => MessageBox "Error #{status}", status-text, 'error'
    .then get-info
    .then ({ name }) ~>
      if name is @$data.author
        @$data.editable = true
    .catch ({ status, status-text }) ~>
      switch status
      | 404 => @$data.session = {}
      | otherwise => MessageBox "Error #{status}", status-text, 'error'
</script>

<style lang="sass">
</style>
