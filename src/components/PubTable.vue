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
            <td><a v-link="'/task/' + item._id">{{ item.name }}</a></td>
            <td>{{ item.description }}</td>
            <td>{{ item.author }}</td>
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
      default: -> []
</script>

<style lang="sass">
</style>
