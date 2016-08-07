<template>
  <div class="code-mirror">
    <div v-el:container></div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! 'codemirror/lib/codemirror.css'
require! 'codemirror/theme/monokai.css'
require! 'codemirror/lib/codemirror.js': CodeMirror
require! 'codemirror/mode/javascript/javascript.js'

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
      if @value isnt @$data.editor.get-value!
        @$data.editor.set-value @value
    ), immediate: true

    @$data.editor.on 'change', (cm) ~>
      @value = cm.get-value!
</script>

<style lang="sass">
.CodeMirror
  height: auto !important
  border: 1px solid #eee
</style>
