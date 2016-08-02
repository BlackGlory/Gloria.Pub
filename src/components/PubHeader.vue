<template>
  <div class="pub-header">
    <header class="nav">
      <div class="container">
        <div class="nav-left">
          <a class="nav-item" v-link="'/'">
            <img src="/assets/images/logo.png" alt="Gloria logo">
            Gloria
          </a>
        </div>

        <span class="nav-toggle">
          <span></span>
          <span></span>
          <span></span>
        </span>

        <div class="nav-right nav-menu">
          <a class="nav-item" v-link="'/'">
            Home
          </a>
          <a class="nav-item" v-link="'/tasks'">
            Tasks
          </a>
          <a v-show="session.name" class="nav-item" v-link="'/user'">
            <i class="fa fa-user"></i>{{ session.name }}
          </a>
          <a v-show="session.name" class="nav-item" @click="logout">
            Logout
          </a>
          <a v-show="!session.name" class="nav-item" v-link="'/login'">
            Login
          </a>
          <a v-show="!session.name" class="nav-item" v-link="'/signup'">
            Sign up
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

require! '../utils.ls': { logout, get-info }

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
</script>

<style lang="sass">
</style>
