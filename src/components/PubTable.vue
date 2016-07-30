<template>
  <div class="pub-table">
    <table class="table is-bordered">
      <thead>
        <tr>
          <th>Name</th>
          <th>Description</th>
          <th>Author</th>
        </tr>
      </thead>
      <tbody>
        <template v-for="item in items">
          <tr>
            <td><a v-link="'/task/' + item.id">{{ item.value.name }}</a></td>
            <td>{{ item.value.description }}</td>
            <td>{{ item.value.author }}</td>
          </tr>
        </template>
      </tbody>
    </table>
  </div>
</template>

<script lang="livescript">
'use strict'

export
  name: 'pub-table'
  props:
    items:
      type: Array
      default: []
</script>

<style lang="sass">
</style>
