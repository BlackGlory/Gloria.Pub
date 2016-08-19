<template>
  <div class="pub-login" v-loading="isLoading" :loading-options="{ bg: 'transparent' }">
    <div class="container">
      <div class="box">
        <form class="control">
          <p class="control has-icon">
            <input type="text" v-model="name" name="name" :placeholder="$t('Users.Name')" class="input" /><i class="fa fa-user"></i>
          </p>
          <p class="control has-icon">
            <input type="password" v-model="password" name="password" :placeholder="$t('Users.Password')" class="input" /><i class="fa fa-lock"></i>
          </p>
          <p class="control has-icon">
            <input type="text" v-model="captcha" name="captcha" :placeholder="$t('Users.Captcha')" class="input" /><i class="fa fa-picture-o"></i>
            <img :src="captchaImage" @click="updateCaptcha" />
          </p>
          <p class="control">
            <a @click="login" class="button is-success">{{ $t('Login') }}</a><span> {{ $t('Or') }} <a v-link="'/signup'" class="is-link align-bottom underline">{{ $t('Signup') }}</a></span>
          </p>
        </form>
      </div>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! 'vue': Vue
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
    page-title: ''
  route:
    data: ({ next }) !->
      get-info!
      .then ({ name }) ~>
        @$router.go '/tasks'
      .catch ({ status, status-text }) ~>
        if status and status isnt 404
          MessageBox Vue.t('Error', status), status-text, 'error'
        else throw arguments
      .then ~>
        next page-title: "Vue.t('Login') - Gloria"
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
          MessageBox @$t('Error', status), status-text, 'error'
          @update-captcha!
        else throw arguments
</script>

<style lang="sass">
.pub-login
  width: 30rem
  margin: 2rem auto
</style>
