'use strict'

require! 'vue':Vue
require! 'keen-ui':Keen
require! 'vue-router': VueRouter
require! './components/PubApp.vue': PubApp
require! './components/PubHome.vue': PubHome
require! './components/PubTask.vue': PubTask

Vue.use VueRouter
Vue.use Keen

router = new VueRouter!

router.map do
  '/':
    component: PubHome
  '/task/:id':
    component: PubTask

router.start PubApp, '#app'
