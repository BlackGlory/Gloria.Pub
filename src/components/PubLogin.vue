<template>
  <div class="pub-login">
    <form method="post" class="control">
      <p class="control has-icon">
        <input type="text" :value.sync="name" name="name" placeholder="name" class="input"/><i class="fa fa-user"></i>
      </p>
      <p class="control has-icon">
        <input type="password" :value.sync="name" name="password" placeholder="password" class="input"/><i class="fa fa-lock"></i>
      </p>
      <p class="control">
        <button :click="login" class="button is-success">Login</button><span> Or <a v-link="'/signup'" class="is-link align-bottom underline">Sign up</a></span>
      </p>
    </form>
  </div>
</template>

<script lang="livescript">
'use strict'

require! '../utils.ls': { login }

export
  name: 'pub-login'
  data: ->
    name: ''
    password: ''
  methods:
    login: ->
      login @$data.name, @$data.password
      .then ~>
        $router.go '/task'
</script>

<style lang="sass">
</style>
