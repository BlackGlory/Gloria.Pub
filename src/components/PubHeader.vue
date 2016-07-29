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
          <a class="nav-item" v-link="'/task'">
            Task
          </a>
          <a class="nav-item" v-link="'/docs'">
            Documentation
          </a>
          <a class="nav-item" href="//blog.gloria.pub">
            Blog
          </a>
          <a class="nav-item" v-link="'/login'">
            Login
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

export
  name: 'pub-header'
</script>

<style lang="sass">
</style>
