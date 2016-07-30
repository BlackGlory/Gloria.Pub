<template>
  <div class="code-mirror">
    <div v-el:container></div>
  </div>
</template>

<script lang="livescript">
'use strict'

export
  name: 'code-mirror'
  props:
    value:
      type: String
      default: ''
    read-only:
      type: Boolean
      default: false
  ready: ->
    @$data.editor = CodeMirror @$els.container, do
      line-numbers: true
      mode: 'javascript'
      viewport-margin: Infinity
      read-only: @read-only

    @$watch 'value', (->
      @$data.editor.set-value @value
    ), immediate: true

    @$data.editor.on 'change', (cm) ~>
      @value = cm.get-value!
</script>

<style lang="sass">
.CodeMirror
  height: auto
  border: 1px solid #eee
</style>
