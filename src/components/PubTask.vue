<template>
  <div class="pub-task">
    <div class="section">
      <div class="container">
        <article class="hero">
          <div class="hero-head">
            <h1 class="title">
              知乎者也
            </h1>
            <h2 class="subtitle">
              Cool, Cooler, Coolest的通知任务.
            </h2>
          </div>
          <div class="hero-body">
            <div class="columns">
              <div class="column is-three-quarters">
                <code-mirror class="editor" :read-only="true" :value="code"></code-mirror>
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

export
  name: 'pub-task'
  data: ->
    code: 'function() {}'
  components: {
    CodeMirror
  }
</script>

<style lang="sass">
</style>
