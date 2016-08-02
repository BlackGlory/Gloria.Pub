<template>
  <div class="pub-pagination">
    <nav class="pagination">
      <a class="button" v-show="pagination.previous" v-link="baseUrl + '/page/' + pagination.previous">Previous</a>
      <a class="button" v-show="pagination.next" v-link="baseUrl + '/page/' + pagination.next">Next page</a>
      <ul>
        <li>
          <a class="button" v-show="pagination.first" v-link="baseUrl + '/page/' + pagination.first">{{ pagination.first }}</a>
        </li>
        <li>
          <span>...</span>
        </li>
        <li>
          <a class="button" v-show="pagination.previous !== pagination.first" v-link="baseUrl + '/page/' + pagination.previous">{{ pagination.previous }}</a>
        </li>
        <li>
          <a class="button is-primary" v-show="pagination.current" v-link="baseUrl + '/page/' + pagination.current">{{ pagination.current }}</a>
        </li>
        <li>
          <a class="button" v-show="pagination.next" v-link="baseUrl + '/page/' + pagination.next">{{ pagination.next }}</a>
        </li>
        <li>
          <span>...</span>
        </li>
        <li>
          <a class="button" v-show="pagination.next !== pagination.last" v-link="baseUrl + '/page/' + pagination.last">{{ pagination.last }}</a>
        </li>
      </ul>
    </nav>
  </div>
</template>

<script lang="livescript">
'use strict'

export
  name: 'pub-pagination'
  props:
    base-url:
      type: String
      default: ''
    pagination:
      type: Object
      default: -> {}
</script>

<style lang="sass">
</style>
