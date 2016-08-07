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
          <div class="hero-foot" v-show="!$route.params.name" v-loading="isLoading" :loading-options="{ bg: 'transparent' }">
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
require! '../utils.ls': { get-user, MessageBox, is-password }
require! 'vue-loading': { default: loading }

export
  name: 'pub-user'
  directives: {
    loading
  }
  data: ->
    list: []
    name: @$route.params.user ? ''
    old-password: ''
    new-password: ''
    confirm-password: ''
    is-loading: false
  components: {
    PubTable
  }
  methods:
    update-password: ->
      { old-password, new-password, confirm-password } = @$data

      unless is-password new-password
        MessageBox "Error", 'Password must be 8-16 characters.', 'error'
        return

      if old-password
        if new-password is confirm-password
          @$data.is-loading = true
          get-info!
          .then ({ name }) ~>
            update-user name, do
              password: old-password
              new-password: new-password
          .then ->
            @$data.is-loading = false
            MessageBox 'Excited!', 'Your new password has been available.', 'success'
          .catch ({ status, status-text }) ->
            @$data.is-loading = false
            if status
              MessageBox "Error #{status}", status-text, 'error'
            else throw arguments
        else
          MessageBox "Error #{status}", 'Different password of the two inputs.'
      else
        MessageBox "Error #{status}", 'Old password is required.', 'error'
  created: ->
    get-user @$route.params.name
    .then ({ name, tasks }) ~>
      @$data.list = tasks
      @$data.name = name
    .catch ({ status, status-text }) ~>
      if status
        switch status
        | 404 => @$router.go '/'
        | otherwise => MessageBox "Error #{status}", status-text, 'error'
      else throw arguments
</script>

<style lang="sass">
</style>
