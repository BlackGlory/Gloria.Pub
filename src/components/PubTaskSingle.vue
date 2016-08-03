<template>
  <div class="pub-task-single">
    <div class="section">
      <div class="container">
        <article class="hero">
          <div class="hero-head">
            <h1 class="title">
              {{ name }}
              <span v-show="editable" class="icon">
                <a @click="edit"><i class="fa fa-pencil-square-o"></i></a>
              </span>
            </h1>
            <h2 class="subtitle">
              <i class="fa fa-user"></i> {{ author }}
            </h2>
            <h3 class="subtitle">
              {{ description }}
            </h3>
          </div>
          <div class="hero-body">
            <div class="columns">
              <div class="column is-three-quarters">
                <code-mirror :read-only="true" :value="code"></code-mirror>
              </div>
              <div class="column">
                <a class="button is-primary is-large" @click="install">Install</a>
              </div>
              <div id="disqus_thread"></div>
              <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
            </div>
          </div>
          <div class="hero-foot">
            <p>Created: {{ created }}</p>
            <p>Updated: {{ updated }}</p>
          </div>
        </article>
      </div>
    </div>
  </div>
</template>

<script lang="livescript">
'use strict'

require! './CodeMirror.vue': CodeMirror
require! '../utils.ls': { get-task, send-to-extension, get-info, MessageBox }

export
  name: 'pub-task-single'
  data: ->
    id: ''
    name: ''
    code: ''
    description: ''
    author: ''
    created: ''
    updated: ''
    editable: false
  components: {
    CodeMirror
  }
  methods:
    edit: ->
      @$router.go "/task/#{@$route.params.id}/edit"
    install: ->
      send-to-extension do
        method: 'install'
        name: @$data.name
        code: @$data.code
  created: ->
    get-task @$route.params.id
    .then (task) ~>
      @$data.name = task.name
      @$data.code = task.code
      @$data.description = task.description
      @$data.author = task.author
      @$data.id = task._id
      @$data.created = new Date task._created
      @$data.updated = new Date task._updated
    .catch ({ status, status-text }) ~>
      switch status
      | 404 => @$router.go '/tasks'
      | otherwise => MessageBox 'Error', status-text
    .then get-info
    .then ({ name }) ~>
      if name is @$data.author
        @$data.editable = true
    .catch ({ status, status-text }) ~>
      switch status
      | 404 => @$data.session = {}
      | otherwise => MessageBox 'Error', status-text
    /*
    var disqus_config = function () {
        this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
        this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
    };
    (function() { // DON'T EDIT BELOW THIS LINE
        var d = document, s = d.createElement('script');
        s.src = '//gloria-pub.disqus.com/embed.js';
        s.setAttribute('data-timestamp', +new Date());
        (d.head || d.body).appendChild(s);
    })();
    */
</script>

<style lang="sass">
</style>
