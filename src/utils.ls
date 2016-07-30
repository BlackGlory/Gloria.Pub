const DB_SERVER = 'http://gloria.pub:5984'

function create-form-data kv
  /*
  fd = new FormData()
  for k, v of kv
    fd.append k, v
  fd
  */
  search-params = new URLSearchParams!
  for k, v of kv
    search-params.set k, v
  search-params

function check-status res
  if 200 <= res.status < 300
    res
  else
    throw new Error res.status-text

function to-json res
  res.json!

export function get-tasks-list
  new Promise (resolve, reject) ->
    fetch "#{DB_SERVER}/database/_design/tasks/_view/list",
      credentials: 'include'
    .then check-status
    .then to-json
    .then ({ rows }) ->
      resolve rows
    .catch reject

export function get-tasks-by-time
  new Promise (resolve, reject) ->
    fetch "#{DB_SERVER}/database/_design/tasks/_view/list",
      credentials: 'include'
    .then check-status
    .then to-json
    .then ({ rows }) ->
      resolve rows
    .catch reject

export function get-tasks-by-hot
  new Promise (resolve, reject) ->
    fetch "#{DB_SERVER}/database/_design/tasks/_view/list",
      credentials: 'include'
    .then check-status
    .then to-json
    .then ({ rows }) ->
      resolve rows
    .catch reject

export function get-task id
  new Promise (resolve, reject) ->
    fetch "#{DB_SERVER}/database/#{id}",
      credentials: 'include'
    .then check-status
    .then to-json
    .then resolve
    .catch reject

export function login name, password
  new Promise (resolve, reject) ->
    fetch "#{DB_SERVER}/_session",
      credentials: 'include'
      method: 'POST'
      body: create-form-data { name, password }
    .then check-status
    .then resolve
    .catch reject

export function sign-up name, password
  new Promise (resolve, reject) ->
    fetch "#{DB_SERVER}/_users/org.couchdb.user:#{name}",
      credentials: 'include'
      method: 'PUT'
      headers:
        Authorization: '""'
      body: JSON.stringify { name, password, roles: [], type: 'user', '_id': "org.couchdb.user:#{name}" }
    .then check-status
    .then resolve
    .catch reject

export function logout
  new Promise (resolve, reject) ->
    fetch "#{DB_SERVER}/_session",
      credentials: 'include'
      headers:
        Authorization: '""'
      method: 'DELETE'
    .then check-status
    .then resolve
    .catch reject

export function heartbeat
  fetch "#{DB_SERVER}/_session",
    credentials: 'include'
  .then check-status
  .then (x) -> console.log x
