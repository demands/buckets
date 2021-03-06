express = require 'express'

config = require '../../config'

Template = require('../../lib/template')(config.buckets?.templatePath)

module.exports = app = express()

app.route('/templates')
  .get (req, res) ->
    Template.find (err, files) ->
      if err
        res.send err, 500
      else
        res.send files

  .post (req, res) ->
    
    Template.write req.body.filename, req.body.contents, (err) ->
      console.log arguments
      if err
        res.send err, 500
      else
        res.send {}, 201

app.route('/templates/:filename')
  .get (req, res) ->
    Template.read req.params.filename, (err, contents) ->
      if err
        if err.code == 'ENOENT'
          res.send err, 404
        else
          res.send err, 500
      else
        res.send filename: req.params.filename, contents: contents

  .delete (req, res) ->
    Template.remove req.params.filename, (err) ->
      if err
        res.send err, 500
      else
        res.send {}, 201

  .put (req, res) ->
    throw "filename mismatch" unless req.params.filename is req.body.filename
    Template.write req.params.filename, req.body.contents, (err) ->
      if err
        res.send err, 500
      else
        res.send {}, 201