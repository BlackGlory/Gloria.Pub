<template>
  <div class="pub-header">
    <header class="nav">
      <div class="container">
        <div class="nav-left">
          <a class="nav-item" v-link="'/'">
            <img src="/assets/images/icon-240.png" alt="Gloria logo">&nbsp;
            <span>Gloria</span>
          </a>
        </div>

        <div class="nav-right nav-menu">
          <a class="nav-item" v-link="'/'">
            {{ $t('Home') }}
          </a>
          <a class="nav-item" v-link="'/tasks'">
            {{ $t('Tasks') }}
          </a>
          <a v-show="session.name" class="nav-item" v-link="'/user'">
            <span class="icon">
              <i class="fa fa-user"></i>
            </span>
            {{ session.name }}
          </a>
          <a v-show="session.name" class="nav-item" @click="logout">
            {{ $t('Logout') }}
          </a>
          <a v-show="!session.name" class="nav-item" v-link="'/login'">
            {{ $t('Login') }}
          </a>
          <a v-show="!session.name" class="nav-item" v-link="'/signup'">
            {{ $t('Signup') }}
          </a>
          <span class="nav-item">
            <a class="button is-info" href="//github.com/BlackGlory/Gloria">
              <span class="icon">
                <i class="fa fa-github"></i>
              </span>
              <span>Github</span>
            </a>
          </span>
        </div>
      </div>
    </nav>
  </div>
</template>

<script lang="livescript">
'use strict'

require! 'vue': Vue
require! '../utils.ls': { logout, get-info, MessageBox }

export
  name: 'pub-header'
  props:
    session: {}
  methods:
    logout: ->
      logout!
      .then (x) ~>
        @$dispatch 'session-change'
        @$router.go '/login'
      .catch ({ status, status-text }) ->
        if status
          MessageBox Vue.t('ErrorStatus', status), status-text, 'error'
        else throw arguments
</script>

<style lang="sass">
</style>
