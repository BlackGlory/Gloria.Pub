'use strict'

require! 'vue':Vue
require! 'keen-ui':Keen
require! 'vue-router': VueRouter

require! './utils.ls': { heartbeat }

require! './components/PubApp.vue': PubApp
require! './components/PubHome.vue': PubHome
require! './components/PubTaskSingle.vue': PubTaskSingle
require! './components/PubTasks.vue': PubTasks
require! './components/PubTasksPage.vue': PubTasksPage
require! './components/PubLogin.vue': PubLogin
require! './components/PubSignup.vue': PubSignup
require! './components/PubTaskCreator.vue': PubTaskCreator

Vue.use VueRouter
Vue.use Keen

router = new VueRouter!

router.map do
  '/':
    component: PubHome
  '/tasks':
    component: PubTasks
    sub-routes:
      '/':
        component: PubTasksPage
      '/page/:page':
        component: PubTasksPage
      '/:keyword':
        component: PubTasksPage
      '/:keyword/page/:page':
        component: PubTasksPage
  '/task/:id':
    component: PubTaskSingle
  '/login':
    component: PubLogin
  '/signup':
    component: PubSignup
  '/create':
    component: PubTaskCreator

router.start PubApp, '#app'
