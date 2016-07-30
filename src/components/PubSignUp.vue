<template>
  <div class="pub-sign-up">
    <div class="box">
      <form class="control">
        <p class="control has-icon">
          <input type="text" v-model="name" placeholder="name" class="input"/><i class="fa fa-user"></i>
        </p>
        <p class="control has-icon">
          <input type="password" v-model="password" placeholder="password" class="input"/><i class="fa fa-lock"></i>
        </p>
        <p class="control">
          <a @click="signUp" class="button is-success">Sign up</a><span> or <a v-link="'/login'" class="is-link align-bottom underline">Login</a></span>
        </p>
      </form>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! '../utils.ls': { sign-up, login }

export
  name: 'pub-sign-up'
  data: ->
    name: ''
    password: ''
  methods:
    sign-up: ->
      { name, password } = @$data
      sign-up name, password
      .then ~>
        login name, password
        .then ~>
          @$router.go '/task'
</script>

<style lang="sass">
</style>
