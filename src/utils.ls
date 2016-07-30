const DB_SERVER = 'http://gloria.pub:5984'

function create-form-data kv
  search-params = new URLSearchParams!
  for k, v of kv
    search-params.set k, v
  search-params

function check-status res
  if 200 <= res.status < 300
    res
  else
    res.json!
    .then ({ reason }) ->
      throw new Error reason

function to-json res
  res.json!

function get-uuid
  new Promise (resolve, reject) ->
    fetch "#{DB_SERVER}/_uuids"
    .then check-status
    .then to-json
    .then (x) -> x.uuids[0]
    .then resolve
    .catch reject

export function get-tasks-list
  new Promise (resolve, reject) ->
    fetch "#{DB_SERVER}/gloria/_design/tasks/_view/list"
    .then check-status
    .then to-json
    .then ({ rows }) ->
      resolve rows
    .catch reject

export function get-tasks-by-time
  new Promise (resolve, reject) ->
    fetch "#{DB_SERVER}/gloria/_design/tasks/_view/list"
    .then check-status
    .then to-json
    .then ({ rows }) ->
      resolve rows
    .catch reject

export function get-tasks-by-hot
  new Promise (resolve, reject) ->
    fetch "#{DB_SERVER}/gloria/_design/tasks/_view/list"
    .then check-status
    .then to-json
    .then ({ rows }) ->
      resolve rows
    .catch reject

export function get-task id
  new Promise (resolve, reject) ->
    fetch "#{DB_SERVER}/gloria/#{id}"
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

function get-user-name
  new Promise (resolve, reject) ->
    heartbeat!
    .then to-json
    .then ({ user-ctx: { name } }) -> name
    .then resolve
    .catch reject

export function create name, code, description
  new Promise (resolve, reject) ->
    get-user-name!
    .then (author) ->
      fetch "#{DB_SERVER}/gloria/",
        credentials: 'include'
        headers:
          'Authorization': '""'
          'Content-Type': 'application/json'
        method: 'POST'
        body: JSON.stringify { name, code, author, description }
    .then check-status
    .then to-json
    .then ({ id }) ->
      resolve id
    .catch reject
