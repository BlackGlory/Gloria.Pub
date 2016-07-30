{
  "_id": "_design/tasks",
  "views": {
    "list": {
      "map": "
        function(doc) {
          emit(doc.created_at, {
            name: doc.name
          , description: doc.description
          , author: doc.author
          , created_at: doc.created_at
          })
        }
      "
    }
  },
  "validate_doc_update": "
    function(newDoc, oldDoc, userCtx) {
      if (newDoc._deleted === true) {
        if ((userCtx.roles.indexOf('_admin') !== -1) || userCtx.name === oldDoc.author) {
          return
        } else {
          throw ({ forbidden: 'Only admins or owner may delete tasks.' })
        }
      }

      if (oldDoc) {
        if (userCtx.name !== oldDoc.author) {
          throw ({ forbidden: 'Only owner can modify task' })
        }

        if (newDoc.author !== oldDoc.author) {
          throw ({ forbidden: 'you cannot modify task author' })
        }
      } else {
        if (!userCtx.name) {
          throw ({ forbidden: 'you must login'})
        } else if (userCtx.name !== newDoc.author){
          throw ({ forbidden: 'doc.author must be your account name' })
        }

        if (newDoc._id.length !== 32) {
          throw ({ forbidden: 'custom doc._id is deny' })
        }

        if (!newDoc.author) {
          throw ({ forbidden: 'doc.author is required' })
        }

        if (userCtx.name !== newDoc.author) {
          throw ({ forbidden: 'you cannot create task use other name as author' })
        }

        if (!newDoc.code) {
          throw ({ forbidden: 'doc.code is required' })
        }

        if (!newDoc.name) {
          throw ({ forbidden: 'doc.name is required' })
        }

        if (!newDoc.description) {
          throw ({ forbidden: 'doc.description is required' })
        }
      }
    }
  "
}
