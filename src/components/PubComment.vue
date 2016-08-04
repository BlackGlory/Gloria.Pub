<template>
  <div class="pub-comment">
    <disqus shortname="gloria-pub"></disqus>
  </div>
</template>

<script lang="livescript">
'use strict'

require! 'vue-disqus': Disqus

export
  name: 'pub-comment'
  components: {
    Disqus
  }
</script>

<style lang="sass">
</style>
