<template>
  <div class="pub-task-single">
    <div class="section">
      <div class="container">
        <article class="hero">
          <div class="hero-head">
            <h1 class="title">
              {{ name }}
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
                <a class="button is-primary is-large">Install</a>
              </div>
            </div>
          </div>
          <div class="hero-foot">
          </div>
        </article>
      </div>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! './CodeMirror.vue': CodeMirror
require! '../utils.ls': { get-task }

export
  name: 'pub-task-single'
  data: ->
    id: ''
    name: ''
    code: ''
    description: ''
    author: ''
  components: {
    CodeMirror
  }
  created: ->
    get-task @$route.params.id
    .then (task) ~>
      @$data.name = task.name
      @$data.code = task.code
      @$data.description = task.description
      @$data.author = task.author
      @$data.id = task._id
</script>

<style lang="sass">
</style>
