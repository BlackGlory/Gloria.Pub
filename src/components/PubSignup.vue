<template>
  <div class="pub-signup" v-loading="isLoading" :loading-options="{ bg: 'transparent' }">
    <div class="container">
      <div class="box">
        <form class="control">
          <p class="control has-icon">
            <input type="text" v-model="name" :placeholder="$t('Users.Name')" class="input"/><i class="fa fa-user"></i>
          </p>
          <p class="control has-icon">
            <input type="password" v-model="password" :placeholder="$t('Users.Password')" class="input"/><i class="fa fa-lock"></i>
          </p>
          <p class="control has-icon">
            <input type="text" v-model="captcha" name="captcha" :placeholder="$t('Users.Captcha')" class="input" /><i class="fa fa-picture-o"></i>
            <img :src="captchaImage" @click="updateCaptcha" />
          </p>
          <p class="control">
            <a @click="signup" class="button is-success">{{ $t('Signup') }}</a><span> {{ $t('Or') }} <a v-link="'/login'" class="is-link align-bottom underline">{{ $t('Login') }}</a></span>
          </p>
        </form>
      </div>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! 'vue': Vue
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
    page-title: ''
  route:
    data: ({ next }) !->
      next page-title: "#{ Vue.t('Signup') } - Gloria"
  methods:
    update-captcha: ->
      @$data.captcha-image = get-captcha!
    signup: ->
      { name, password, captcha } = @$data

      unless is-user-name name
        MessageBox @$t('Error'), @$t('Validate.UserName'), 'error'
        return

      unless is-password password
        MessageBox @$t('Error'), @$t('Validate.Password'), 'error'
        return

      @$data.is-loading = true
      sign-up name, password, captcha
      .catch ({ status, status-text }) ~>
        @$data.is-loading = false
        if status
          MessageBox @$t('ErrorStatus', status), status-text, 'error'
          @update-captcha!
        else throw arguments
      .then ~>
        @$data.is-loading = false
        MessageBox @$t('Success'), @$t('SignupSuccess')
        .then ~>
          @$router.go '/login'

</script>

<style lang="sass">
.pub-signup
  width: 30rem
  margin: 2rem auto
</style>
