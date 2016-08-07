<template>
  <div class="pub-login" v-loading="isLoading" :loading-options="{ bg: 'transparent' }">
    <div class="container">
      <div class="box">
        <form class="control">
          <p class="control has-icon">
            <input type="text" v-model="name" name="name" placeholder="name" class="input" /><i class="fa fa-user"></i>
          </p>
          <p class="control has-icon">
            <input type="password" v-model="password" name="password" placeholder="password" class="input" /><i class="fa fa-lock"></i>
          </p>
          <p class="control has-icon">
            <input type="text" v-model="captcha" name="captcha" placeholder="captcha" class="input" /><i class="fa fa-picture-o"></i>
            <img :src="captchaImage" @click="updateCaptcha" />
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

require! '../utils.ls': { login, get-info, MessageBox, get-captcha }
require! 'vue-loading': { default: loading }

export
  name: 'pub-login'
  directives: {
    loading
  }
  data: ->
    name: ''
    password: ''
    captcha: ''
    is-loading: false
    captcha-image: get-captcha!
  created: ->
    get-info!
    .then ({ name }) ~>
      @$router.go '/tasks'
    .catch ({ status, status-text }) ->
      if status and status isnt 404
        MessageBox "Error #{status}", status-text, 'error'
      else throw arguments
  methods:
    update-captcha: ->
      @$data.captcha-image = get-captcha!
    login: ->
      @$data.is-loading = true
      { name, password, captcha } = @$data
      login name, password, captcha
      .then ~>
        @$data.is-loading = false
        @$dispatch 'session-change'
        @$router.go '/tasks'
      .catch ({ status, status-text }) ~>
        @$data.is-loading = false
        if status
          MessageBox "Error #{status}", status-text, 'error'
          @update-captcha!
        else throw arguments
</script>

<style lang="sass">
.pub-login
  width: 30rem
  margin: 2rem auto
</style>
