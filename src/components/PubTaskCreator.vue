<template>
  <div class="pub-task-creator">
    <div class="section">
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
          <a @click="create" class="button is-success">Create</a><span> Or <a v-link="'/task'" class="is-link align-bottom underline">Cancel</a></span>
        </p>
      </form>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! '../utils.ls': { create, get-uuid }
require! './CodeMirror.vue': CodeMirror

export
  name: 'pub-task-creator'
  data: ->
    name: ''
    code: ''
    description: ''
  components: {
    CodeMirror
  }
  methods:
    create: ->
      create @$data.name, @$data.code, @$data.description
      .then (id) ~>
        @$router.go "/task/#{id}"
      .catch (err) ->
        alert err
</script>

<style lang="sass">
</style>
