<template>
  <div class="pub-tasks">
    <div class="section">
      <div class="container">
        <article class="hero">
          <div class="hero-head">
            <h1 class="title">
              <i class="fa fa-user"></i> {{ name }}
            </h1>
          </div>
          <div class="hero-body">
            <pub-table :items="list"></pub-table>
          </div>
          <div class="hero-foot" v-show="!$route.params.user">
            <h2 class="title">Change password</h2>
            <form class="control">
              <p class="control has-icon">
                <input type="password" v-model="oldPassword" placeholder="old password" class="input"/><i class="fa fa-lock"></i>
              </p>
              <p class="control has-icon">
                <input type="password" v-model="newPassword" placeholder="new password" class="input"/><i class="fa fa-lock"></i>
              </p>
              <p class="control has-icon">
                <input type="password" v-model="confirmPassword" placeholder="new password again" class="input"/><i class="fa fa-lock"></i>
              </p>
              <p class="control">
                <a @click="updatePassword" class="button is-success">Update password</a>
              </p>
            </form>
          </div>
      </div>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! './PubTable.vue': PubTable
require! '../utils.ls': { get-user, MessageBox }

export
  name: 'pub-user'
  data: ->
    list: []
    name: @$route.params.user ? ''
    old-password: ''
    new-password: ''
    confirm-password: ''
  components: {
    PubTable
  }
  methods:
    update-password: ->
      if @$data.old-password
        if @$data.new-password is @$data.confirm-password
          get-info!
          .then ({ name }) ~>
            update-user name, do
              password: @$data.old-password
              new-password: @$data.new-password
          .then ->
            MessageBox 'Excited!', 'Your new password has been available.', 'success'
          .catch ({ status, status-text }) ->
            MessageBox 'Error', status-text, 'error'
        else
          MessageBox 'Error', 'Different password of the two inputs.'
      else
        MessageBox 'Error', 'Old password is required.', 'error'
  created: ->
    get-user @$route.params.user
    .then ({ name, tasks }) ~>
      @$data.list = tasks
      @$data.name = name
    .catch ({ status, status-text }) ~>
      switch status
      | 404 => @$router.go '/'
      | otherwise => MessageBox 'Error', status-text, 'error'
</script>

<style lang="sass">
</style>
