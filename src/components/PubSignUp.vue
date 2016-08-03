<template>
  <div class="pub-signup">
    <div class="container">
      <div class="box">
        <form class="control">
          <p class="control has-icon">
            <input type="text" v-model="name" placeholder="name" class="input"/><i class="fa fa-user"></i>
          </p>
          <p class="control has-icon">
            <input type="password" v-model="password" placeholder="password" class="input"/><i class="fa fa-lock"></i>
          </p>
          <p class="control">
            <script src="https://www.google.com/recaptcha/api.js"></script>
            <a @click="signup" class="button is-success">Sign up</a><span> or <a v-link="'/login'" class="is-link align-bottom underline">Login</a></span>
          </p>
        </form>
      </div>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! '../utils.ls': { sign-up, login, MessageBox }

export
  name: 'pub-signup'
  data: ->
    name: ''
    password: ''
  methods:
    signup: ->
      { name, password } = @$data
      sign-up name, password
      .catch ({ status, status-text }) ->
        MessageBox 'Error', status-text
      .then login name, password
      .then ~>
        @$dispatch 'session-change'
        @$router.go '/tasks'
      .catch ({ status, status-text }) ->
        MessageBox 'Error', status-text

</script>

<style lang="sass">
.pub-signup
  width: 30rem
  margin: 2rem auto
</style>
