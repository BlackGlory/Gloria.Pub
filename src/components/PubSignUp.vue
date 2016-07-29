<template>
  <div class="pub-sign-up">
    <form method="post" class="control">
      <p class="control has-icon">
        <input type="text" :value.sync="name" name="name" placeholder="name" class="input"/><i class="fa fa-user"></i>
      </p>
      <p class="control has-icon">
        <input type="password" :value.sync="name" name="password" placeholder="password" class="input"/><i class="fa fa-lock"></i>
      </p>
      <p class="control">
        <button :click="signUp" class="button is-success">Sign up</button><span> Or <a v-link="'/login'" class="is-link align-bottom underline">Login</a></span>
      </p>
    </form>
  </div>
</template>

<script lang="livescript">
'use strict'

require! '../utils.ls': { sign-up }

export
  name: 'pub-sign-up'
  data: ->
    name: ''
    password: ''
  methods:
    sign-up: ->
      sign-up @$data.name, @$data.password
      .then ~>
        $router.go '/task'
</script>

<style lang="sass">
</style>
