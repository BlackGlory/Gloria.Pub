const API_SERVER = 'http://127.0.0.1:8080'

function check-status res
  if 200 <= res.status < 300
    res
  else
    throw res.status

function to-json res
  res.json!

export function get-tasks
  new Promise (resolve, reject) ->
    fetch "#{API_SERVER}/tasks",
      credentials: 'include'
    .then check-status
    .then to-json
    .then resolve
    .catch reject

export function get-task id
  new Promise (resolve, reject) ->
    fetch "#{API_SERVER}/task/#{id}",
      credentials: 'include'
    .then check-status
    .then to-json
    .then resolve
    .catch reject

export function login name, password
  new Promise (resolve, reject) ->
    fetch "#{API_SERVER}/session",
      credentials: 'include'
      method: 'POST'
      headers:
        'Content-Type': 'application/json'
      body: JSON.stringify { name, password }
    .then check-status
    .then resolve
    .catch reject

export function sign-up name, password
  new Promise (resolve, reject) ->
    fetch "#{API_SERVER}/user",
      credentials: 'include'
      method: 'POST'
      headers:
        'Content-Type': 'application/json'
      body: JSON.stringify { name, password }
    .then check-status
    .then resolve
    .catch reject

export function logout
  new Promise (resolve, reject) ->
    fetch "#{API_SERVER}/session",
      credentials: 'include'
      method: 'DELETE'
    .then check-status
    .then resolve
    .catch reject

export function get-info
  new Promise (resolve, reject) ->
    fetch "#{API_SERVER}/session",
      credentials: 'include'
    .then check-status
    .then to-json
    .then resolve
    .catch reject

export function create-task name, code, description
  new Promise (resolve, reject) ->
    fetch "#{API_SERVER}/task/",
      method: 'POST'
      headers:
        'Content-Type': 'application/json'
      body: JSON.stringify { name, code, description }
    .then check-status
    .then to-json
    .then ({ id }) -> resolve id
    .catch reject
