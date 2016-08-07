<template>
  <div class="pub-signup" v-loading="isLoading">
    <div class="container">
      <div class="box">
        <form class="control">
          <p class="control has-icon">
            <input type="text" v-model="name" placeholder="name" class="input"/><i class="fa fa-user"></i>
          </p>
          <p class="control has-icon">
            <input type="password" v-model="password" placeholder="password" class="input"/><i class="fa fa-lock"></i>
          </p>
          <p class="control has-icon">
            <input type="text" v-model="captcha" name="captcha" placeholder="captcha" class="input" /><i class="fa fa-picture-o"></i>
            <img :src="captchaImage" @click="updateCaptcha" />
          </p>
          <p class="control">
            <a @click="signup" class="button is-success">Sign up</a><span> or <a v-link="'/login'" class="is-link align-bottom underline">Login</a></span>
          </p>
        </form>
      </div>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! '../utils.ls': { sign-up, login, MessageBox, get-captcha, is-user-name, is-password }
require! 'vue-loading': { default: loading }

export
  name: 'pub-signup'
  directives: {
    loading
  }
  data: ->
    name: ''
    password: ''
    captcha: ''
    is-loading: false
    captcha-image: get-captcha!
  methods:
    update-captcha: ->
      @$data.captcha-image = get-captcha!
    signup: ->
      { name, password, captcha } = @$data

      unless is-user-name name
        MessageBox 'Error', 'Name must be 6-16 characters, only number, word, - and _ available.', 'error'
        return

      unless is-password password
        MessageBox 'Error', 'Password must be 8-16 characters.', 'error'
        return

      @$data.is-loading = true
      sign-up name, password, captcha
      .catch ({ status, status-text }) ~>
        if status
          MessageBox "Error #{status}", status-text, 'error'
          @$data.is-loading = false
          @update-captcha!
        else throw arguments
      .then login name, password
      .then ~>
        @$dispatch 'session-change'
        @$router.go '/login'
        @$data.is-loading = false
      .catch ({ status, status-text }) ~>
        if status
          MessageBox "Error #{status}", status-text, 'error'
          @$data.is-loading = false
          @update-captcha!
        else throw arguments

</script>

<style lang="sass">
.pub-signup
  width: 30rem
  margin: 2rem auto
</style>
