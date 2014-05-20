Model = require 'lib/model'

module.exports = class Field extends Model
  defaults:
    name: ''
    instructions: ''
    slug: ''
  
  urlRoot: '/api/fields'