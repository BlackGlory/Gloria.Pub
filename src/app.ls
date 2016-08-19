'use strict'

require! 'vue': Vue
require! 'vue-i18n': VueI18n
require! 'vue-router': VueRouter

require! './components/PubApp.vue': PubApp
require! './components/PubHome.vue': PubHome
require! './components/PubTaskSingle.vue': PubTaskSingle
require! './components/PubTasks.vue': PubTasks
require! './components/PubTasksPage.vue': PubTasksPage
require! './components/PubLogin.vue': PubLogin
require! './components/PubSignup.vue': PubSignup
require! './components/PubTaskCreator.vue': PubTaskCreator
require! './components/PubTaskEditor.vue': PubTaskEditor
require! './components/PubUser.vue': PubUser

require! './locales/index.ls': locales

Vue.use VueI18n

function browser-language
  if locales[navigator.language]
    return navigator.language
  else
    for , lang of navigator.languages
      return lang if locales[lang]
  return Object.keys(locales)[0]

Vue.config.lang = browser-language!

for lang, locale of locales
  Vue.locale lang, locale

Vue.use VueRouter

router = new VueRouter history: true

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
  '/task/:id/edit':
    component: PubTaskEditor
  '/login':
    component: PubLogin
  '/signup':
    component: PubSignup
  '/create':
    component: PubTaskCreator
  '/user':
    component: PubUser
  '/user/:name':
    component: PubUser

router.start PubApp, '#app'
