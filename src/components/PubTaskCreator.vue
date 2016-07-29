<template>
  <div class="pub-task-creator">
    <form method="post" class="control">
      <p class="control">
        <input type="text" :value.sync="name" name="name" placeholder="name" class="input"/>
      </p>
      <p class="control">
        <input type="text" :value.sync="description" name="description" placeholder="description" class="input"/>
      </p>
      <p class="control">
        <code-mirror :read-only="true" :value="code"></code-mirror>
      </p>
      <p class="control">
        <button :click="create" class="button is-success">Create</button><span> Or <a v-link="'/task'" class="is-link align-bottom underline">Cancel</a></span>
      </p>
    </form>
  </div>
</template>

<script lang="livescript">
'use strict'

require! '../utils.ls': { create }

export
  name: 'pub-task-creator'
  data: ->
    name: ''
    code: ''
    description: ''
  methods:
    create: ->
      create @$data.name, @$data.code, @$data.description
      .then (id) ~>
        @$router.go "/task/#{id}"
</script>

<style lang="sass">
</style>
