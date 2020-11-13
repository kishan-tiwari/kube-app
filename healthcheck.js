var http = require('http')

var options = {
  host: 'localhost',
  port: 4000,
  timeout: 2000
}

var request = http.request(options, (res)=>{
  console.log(`STATUS: ${res.statusCode}`)
  if(res.statusCode == 200){
    process.exit(0)
  }
  else {
    process.exit(1)
  }
})

request.on('error', (err)=>{
  console.log(`problem with request: ${err.message}`)
  process.exit(1)
})

request.end()
