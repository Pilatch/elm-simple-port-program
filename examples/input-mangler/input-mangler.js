const elm = require('./elm.js')
const elmPorts = elm.Main.worker().ports
let mangleOffset = 0

process.stdout.write(`Ready to mangle text you enter. Press Ctrl + C to stop.\n`)

elmPorts.output.subscribe(mangled => {
  process.stdout.write(`"${mangled.replace('"', '\\"')}"\n\n`)
})
process.stdin.resume()
process.stdin.on('data', chunk => {
  mangleOffset++
  elmPorts.input.send({
    mangleOffset: mangleOffset,
    stringToMangle: chunk.toString('utf8').trim(),
  })
})
