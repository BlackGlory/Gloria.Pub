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
                <a class="button is-primary is-large" v-show="!installed" @click="install">{{ $t('Install') }}</a>
                <a class="button is-success is-large" v-show="installed" @click="uninstall">{{ $t('Installed') }}</a>
                <div v-show="diff">
                  {{ $t('DiffNotice') }}<a @click="sync">{{ $t('SyncCode') }}</a>.
                </div>
              </div>
            </div>
          </div>
          <div class="hero-foot">
            <p>{{ $t('Created') }}: {{ created }}</p>
            <p>{{ $t('Updated') }}: {{ updated }}</p>
            <pub-comment></pub-comment>
          </div>
        </article>
      </div>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! 'vue': Vue
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
    diff: false
    page-title: ''
  components: {
    CodeMirror
    PubComment
  }
  methods:
    edit: ->
      @$router.go "/task/#{@$route.params.id}/edit"
    install: ->
      send-to-extension do
        type: 'task.install'
        name: @$data.name
        code: @$data.code
        origin: gen-sign @$route.params.id
      .then ~>
        @$data.installed = true
        MessageBox @$t('Success'), @$t('TaskInstalled'), 'success'
      .catch (error) ~>
        console.log error
        MessageBox @$t('Fail'), @$t('TaskInstallFail'), 'error'
    uninstall: ->
      MessageBox.confirm @$t('Confirm.UninstallTask')
      .then ~>
        send-to-extension do
          type: 'task.uninstall'
          origin: gen-sign @$route.params.id
      .then ~>
        @$data.installed = false
        MessageBox @$t('Success'), @$t('TaskUninstalled'), 'success'
      .catch (error) ->
        console.log error
    sync: ->
      MessageBox.confirm @$t('Confirm.SyncTaskCode')
      .then ~>
        send-to-extension do
          type: 'task.update'
          code: @$data.code
          origin: gen-sign @$route.params.id
      .then ~>
        @$data.diff = false
      .catch (error) ->
        console.log error

    remove: ->
      MessageBox.confirm @$t('Confirm.RemoveTask')
      .then ~>
        remove-task @$route.params.id
      .then ~>
        @$router.go '/user'
      .catch ({ status, status-text }) ~>
        if status
          MessageBox @$t('ErrorStatus', status), status-text
        else throw arguments
  route:
    data: ({ next }) !->
      data = {}
      data.is-loading = true
      get-task @$route.params.id
      .then (task) ->
        data.is-loading = false
        data.name = task.name
        data.code = task.code
        data.description = task.description
        data.author = task.author
        data.id = task._id
        data.created = new Date task._created
        data.updated = new Date task._updated
      .catch ({ status, status-text }) ~>
        data.is-loading = false
        if status
          switch status
          | 404 => @$router.go '/tasks'
          | otherwise => MessageBox Vue.t('Error', status), status-text, 'error'
        else throw arguments
      .then get-info
      .then ({ name }) ->
        if name is data.author
          data.editable = true
      .catch ({ status, status-text }) ~>
        if status
          if status isnt 404
            MessageBox Vue.t('Error', status), status-text, 'error'
        else throw arguments
      .then ~>
        send-to-extension do
          type: 'task.is-exist'
          origin: gen-sign @$route.params.id
          code: data.code
      .then (status) ->
        if status is 'diff'
          data.installed = true
          data.diff = true
        else
          data.installed = true
      .catch ->
        data.installed = false
      .then ->
        next {
          ...data
          page-title: "#{data.name} by #{data.author} - Gloria"
        }
</script>

<style lang="sass">
.default-color
  color: inherit
</style>
