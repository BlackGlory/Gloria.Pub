<template>
  <div class="pub-home">
    <section class="hero has-text-centered">
      <div class="hero-body">
        <p id="icon">
          <img src="/assets/images/icon-240.png">
        </p>
        <h1 class="title">Gloria</h1>
        <h2 class="subtitle">
          {{{ $t('Gloria.RawDescription') }}}
        </h2>
        <iframe src="https://ghbtns.com/github-btn.html?user=BlackGlory&repo=Gloria&type=star&size=large" frameborder="0" scrolling="0" width="80px" height="30px"></iframe>
        <iframe src="https://ghbtns.com/github-btn.html?user=BlackGlory&repo=Gloria&type=fork&size=large" frameborder="0" scrolling="0" width="80px" height="30px"></iframe>
        <p class="hero-buttons">
          <a v-show="!installed" class="button is-primary is-large" @click="install">
            <span class="icon">
              <i class="fa fa-download"></i>
            </span>
            <span>{{ $t('InstallExtension') }}</span>
          </a>
          <a v-show="installed && !needUpdate" class="button is-success is-large" href="http://docs.gloria.pub">
            <span class="icon">
              <i class="fa fa-download"></i>
            </span>
            <span>{{ $t('ViewTutorial') }}</span>
          </a>
          <a v-show="installed && needUpdate" class="button is-primary is-large" @click="install">
            <span class="icon">
              <i class="fa fa-download"></i>
            </span>
            <span>{{ $t('UpdateExtension') }}</span>
          </a>
          <a class="button is-large" v-link="'tasks'">
            {{ $t('ViewTasks') }}
          </a>
        </p>
      </div>
    </section>

    <section class="hero is-primary is-bold">
      <div class="hero-body">
        <div class="container">
          <nav class="columns">
            <div class="column is-4 has-text-centered">
              <span class="icon is-large">
                <i class="fa fa-code"></i>
              </span>
              <p class="title"><strong>{{ $t('Programmable') }}</strong></p>
            </div>
            <div class="column is-4 has-text-centered">
              <span class="icon is-large">
                <i class="fa fa-chrome"></i>
              </span>
              <p class="title"><strong>{{ $t('ChromeExtension') }}</strong></p>
            </div>
            <div class="column is-4 has-text-centered">
              <span class="icon is-large">
                <i class="fa fa-github"></i>
              </span>
              <p class="title"><strong>{{ $t('OpenSource') }}</strong></p>
            </div>
          </nav>
        </div>
      </div>
    </section>

    <section class="section">
      <div class="container">
        <h2 class="title">
          {{ $t('NewTask') }}
        </h2>
        <pub-table v-loading="isLoading" :loading-options="{ bg: 'transparent' }" :items="list"></pub-table>
      </div>
    </section>

    <section class="hero is-primary is-bold">
      <div class="hero-body">
        <div class="container has-text-centered">
          <p class="title"><strong><a v-link="'create'">{{ $t('ContributeTask') }}</a></strong></p>
        </div>
      </div>
    </section>
  </div>
</template>

<script lang="livescript">
'use strict'

require! 'vue': Vue
require! './PubTable.vue': PubTable
require! '../utils.ls': { get-tasks, MessageBox, send-to-extension, VERSION }
require! 'vue-loading': { default: loading }

export
  name: 'pub-home'
  directives: {
    loading
  }
  data: ->
    list: []
    is-loading: false
    page-title: ''
    need-update: false
    installed: false
  components: {
    PubTable
  }
  route:
    data: ({ next }) !->
      data = {}

      data.is-loading = true
      send-to-extension do
        type: 'extension.version'
      .then (local-version) ->
        data.installed = true
        if VERSION > local-version # string compare
          data.need-update = true
        else
          data.need-update = false
      .catch ->
        data.installed = false
        data.need-update = false
      .then ->
        get-tasks!
      .then ({ list }) ~>
        data.is-loading = false
        data.list = list
      .catch ({ status, status-text }) ~>
        data.is-loading = false
        if status and status isnt 404
          MessageBox Vue.t('Error', [status]), status-text, 'error'
        else throw arguments
      .then ->
        next {
          ...data
          page-title: "Gloria: #{Vue.t('Gloria.Description')}"
        }
  methods:
    install: ->
      if chrome?.webstore?.install?
        chrome.webstore.install 'https://chrome.google.com/webstore/detail/cnelmenogjgobndnoddckekbojgginbn', ~>
          @$data.installed = true
      else
        window.open 'https://chrome.google.com/webstore/detail/gloria/cnelmenogjgobndnoddckekbojgginbn'
</script>

<style lang="sass">
#icon
  box-shadow: 0 20px 60px rgba(17, 17, 17, 0.05), 0 5px 10px rgba(17, 17, 17, 0.1), 0 1px 1px rgba(17, 17, 17, 0.2)
  display: inline-block
  height: 240px
  margin-bottom: 40px
  vertical-align: top
  width: 240px
</style>
