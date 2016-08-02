'use strict'

require! 'vue':Vue
require! 'keen-ui':Keen
require! 'vue-router': VueRouter

require! './utils.ls': { heartbeat }

require! './components/PubApp.vue': PubApp
require! './components/PubHome.vue': PubHome
require! './components/PubTaskSingle.vue': PubTaskSingle
require! './components/PubTaskList.vue': PubTaskList
require! './components/PubLogin.vue': PubLogin
require! './components/PubSignup.vue': PubSignup
require! './components/PubTaskCreator.vue': PubTaskCreator

Vue.use VueRouter
Vue.use Keen

router = new VueRouter!

router.map do
  '/':
    component: PubHome
  '/task':
    component: PubTaskList
  '/task/:id':
    component: PubTaskSingle
  '/login':
    component: PubLogin
  '/signup':
    component: PubSignup
  '/create':
    component: PubTaskCreator

router.start PubApp, '#app'
