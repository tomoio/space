fs = require('fs')
path = require('path')
module.exports = class Space
  @makeSpace : (num) ->
    if num is 0
      return ''
    else
      spaces = (' ' for v in [0..(num - 1)])
      return spaces.join('')
  @modSpace : (opts, cb) ->
    fs.readFile(path.resolve(opts.file), 'utf8', (err, body) =>
      if err?
        cb({err : err})
      else
        spaces = []
        min = false
        lines = body.split('\n')
        for v in lines
          len = v.match(/^\s*/)[0].length
          if len isnt 0
            spaces.push(len)
            if min is false
              min = len
            else
              min = Math.min(min, len)
        broken = false
        if min isnt  false
          for v in spaces
            if (v % min) isnt 0
              broken = true
        if min isnt false and broken is false
          newlines = []
          for v in lines
            len = v.match(/^\s*/)[0].length
            newlines.push(Space.makeSpace((len / min) * opts.num) + v.replace(/^\s*/, ''))
          if opts.save
            fs.writeFile(path.resolve(opts.file), newlines.join('\n'), (err) =>
              cb({err : null, body : newlines.join('\n')})
            )
          else
            cb({err : null, body : newlines.join('\n')})
        else if broken
          cb({err : true, body : lines.join('\n')})
        else
          cb({err : null, body : lines.join('\n')})
    )
    