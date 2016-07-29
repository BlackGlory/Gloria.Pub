<template>
  <div class="pub-home">
    <section class="hero has-text-centered">
      <div class="hero-body">
        <p id="icon">
          <img src="/assets/images/logo.png" alt="Bulma: a modern CSS framework based on Flexbox">
        </p>
        <h1 class="title">Gloria</h1>
        <h2 class="subtitle">
          A <strong>programmable</strong> website notifications aggregator in <strong>Chrome</strong>
        </h2>
        <iframe src="https://ghbtns.com/github-btn.html?user=BlackGlory&repo=Gloria&type=star&size=large" frameborder="0" scrolling="0" width="80px" height="30px"></iframe>
        <iframe src="https://ghbtns.com/github-btn.html?user=BlackGlory&repo=Gloria&type=fork&size=large" frameborder="0" scrolling="0" width="80px" height="30px"></iframe>
        <p class="hero-buttons">
          <a class="button is-primary is-large" href="#">
            <span class="icon">
              <i class="fa fa-download"></i>
            </span>
            <span>Install Extension</span>
          </a>
          <a class="button is-large" v-link="'task'">
            View tasks
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
              <p class="title"><strong>Programmable</strong></p>
            </div>
            <div class="column is-4 has-text-centered">
              <span class="icon is-large">
                <i class="fa fa-chrome"></i>
              </span>
              <p class="title"><strong>Chrome Extension</strong></p>
            </div>
            <div class="column is-4 has-text-centered">
              <span class="icon is-large">
                <i class="fa fa-github"></i>
              </span>
              <p class="title"><strong>Open Source</strong></p>
            </div>
          </nav>
        </div>
      </div>
    </section>

    <section class="section">
      <div class="container">
        <h2 class="title">
          Hot task
        </h2>
        <pub-table :items="newList"></pub-table>
      </div>
    </section>

    <hr class="is-marginless">

    <section class="section">
      <div class="container">
        <h2 class="title">
          New task
        </h2>
        <pub-table :items="hotList"></pub-table>
      </div>
    </section>

    <section class="hero is-primary is-bold">
      <div class="hero-body">
        <div class="container has-text-centered">
          <p class="title"><strong><a href="">Click to contribute your task</a></strong></p>
        </div>
      </div>
    </section>
  </div>
</template>

<script lang="livescript">
'use strict'

require! './PubTable.vue': PubTable
require! '../utils.ls': { get-tasks-by-time, get-tasks-by-hot }

export
  name: 'pub-home'
  data: ->
    hot-list: []
    new-list: []
  components: {
    PubTable
  }
  created: ->
    get-tasks-by-time!
    .then (new-list) ~>
      @$data.new-list = new-list

    get-tasks-by-hot!
    .then (hot-list) ~>
      @$data.hot-list = hot-list
</script>

<style lang="sass">
#icon
  border-radius: 20px
  box-shadow: 0 20px 60px rgba(17, 17, 17, 0.05), 0 5px 10px rgba(17, 17, 17, 0.1), 0 1px 1px rgba(17, 17, 17, 0.2)
  display: inline-block
  height: 240px
  margin-bottom: 40px
  vertical-align: top
  width: 240px
</style>