<template>
  <div class="pub-login">
    <div class="container">
      <div class="box">
        <form class="control">
          <p class="control has-icon">
            <input type="text" v-model="name" name="name" placeholder="name" class="input"/><i class="fa fa-user"></i>
          </p>
          <p class="control has-icon">
            <input type="password" v-model="password" name="password" placeholder="password" class="input"/><i class="fa fa-lock"></i>
          </p>
          <p class="control">
            <a @click="login" class="button is-success">Login</a><span> or <a v-link="'/signup'" class="is-link align-bottom underline">Sign up</a></span>
          </p>
        </form>
      </div>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! '../utils.ls': { login, get-info, MessageBox }

export
  name: 'pub-login'
  data: ->
    name: ''
    password: ''
  created: ->
    get-info!
    .then ({ name }) ~>
      alert 'you have logged'
      @$router.go '/tasks'
  methods:
    login: ->
      { name, password } = @$data
      login name, password
      .then ~>
        @$dispatch 'session-change'
        @$router.go '/tasks'
      .catch ({ status, status-text }) ->
        MessageBox 'Error', status-text
</script>

<style lang="sass">
.pub-login
  width: 30rem
  margin: 2rem auto
</style>
