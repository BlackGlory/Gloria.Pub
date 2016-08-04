<template>
  <div class="pub-task-creator" v-loading="isLoading">
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
            <a @click="create" class="button is-success">Create</a><span> Or <a v-link="'/tasks'" class="is-link align-bottom underline">Cancel</a></span>
          </p>
        </form>
      </div>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! '../utils.ls': { create-task, get-info, MessageBox }
require! './CodeMirror.vue': CodeMirror
require! 'vue-loading': { default: loading }

export
  name: 'pub-task-creator'
  directives: {
    loading
  }
  data: ->
    name: ''
    code: ''
    description: ''
    is-loading: false
  components: {
    CodeMirror
  }
  ready: ->
    get-info!
    .catch ~>
      alert 'please login'
      @$router.go "/login"
  methods:
    create: ->
      @$data.is-loading = true
      create-task @$data.name, @$data.code, @$data.description
      .then (id) ~>
        @$router.go "/task/#{id}"
        @$data.is-loading = false
      .catch ({ status, status-text }) ~>
        MessageBox 'Error', status-text, 'error'
        @$data.is-loading = false
</script>

<style lang="sass">
</style>
