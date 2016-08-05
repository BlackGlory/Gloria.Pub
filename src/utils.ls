const API_SERVER = 'http://localhost:8080'# 'http://api.gloria.pub'
const EXTENSION_ID = 'cnelmenogjgobndnoddckekbojgginbn'

require! 'vue-msgbox': { default: MessageBox }
require! 'vue-msgbox/lib/vue-msgbox.css'

function check-status res
  if 200 <= res.status < 300
    res
  else
    res.text()
    .then (message) ->
      throw status: res.status, status-text: message

function to-json res
  res.json!

export function is-user-name val
  /^[\d\w\-_]{6,16}$/.test val

export function is-task-name val
  1 <= val.length <= 30

export function is-password val
  8 <= val.length <= 16

export function is-description val
  0 <= val.length <= 300

export function is-code val
  (val.indexOf 'commit') isnt -1

export MessageBox

export function get-tasks page = 1, keyword = ''
  fetch "#{API_SERVER}/tasks?page=#{page}&keyword=#{keyword}",
    credentials: 'include'
  .then check-status
  .then to-json

export function get-task id
  fetch "#{API_SERVER}/task/#{id}",
    credentials: 'include'
  .then check-status
  .then to-json

export function login name, password, captcha
  fetch "#{API_SERVER}/session",
    credentials: 'include'
    method: 'POST'
    headers:
      'Content-Type': 'application/json'
    body: JSON.stringify { name, password, captcha }
  .then check-status

export function get-user name
  if name
    fetch "#{API_SERVER}/user/#{name}",
      credentials: 'include'
    .then check-status
    .then to-json
  else
    get-info!
    .then ({ name }) ->
      fetch "#{API_SERVER}/user/#{name}",
        credentials: 'include'
    .then check-status
    .then to-json

export function sign-up name, password, captcha
  fetch "#{API_SERVER}/user",
    credentials: 'include'
    method: 'POST'
    headers:
      'Content-Type': 'application/json'
    body: JSON.stringify { name, password, captcha }
  .then check-status

export function logout
  fetch "#{API_SERVER}/session",
    credentials: 'include'
    method: 'DELETE'
  .then check-status

export function get-info
  fetch "#{API_SERVER}/session",
    credentials: 'include'
  .then check-status
  .then to-json

export function create-task name, code, description
  fetch "#{API_SERVER}/task/",
    credentials: 'include'
    method: 'POST'
    headers:
      'Content-Type': 'application/json'
    body: JSON.stringify { name, code, description }
  .then check-status
  .then to-json
  .then ({ id }) -> resolve id

export function update-task id, name, code, description
  fetch "#{API_SERVER}/task/#{id}",
    credentials: 'include'
    method: 'PUT'
    headers:
      'Content-Type': 'application/json'
    body: JSON.stringify { name, code, description }
  .then check-status

export function send-to-extension message
  chrome.runtime.send-message EXTENSION_ID, message, (response) ->
    MessageBox 'Excited!', 'Task Installed', 'success'

export function remove-task id
  fetch "#{API_SERVER}/task/#{id}",
    credentials: 'include'
    method: 'DELETE'

export function update-user name, info
  fetch "#{API_SERVER}/user/#{name}",
    credentials: 'include'
    method: 'PUT'
    headers:
      'Content-Type': 'application/json'
    body: JSON.stringify info
  .then check-status

export function get-captcha
  "#{API_SERVER}/captcha?t=#{Date.now!}"
