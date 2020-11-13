const express = require('express')
const bodyParser = require('body-parser')
const morganBody = require('morgan-body')

const APP_PORT = 4000 

const app = express()

app.use(bodyParser.urlencoded({ extended : false }))
app.use(bodyParser.json())


//morganBody(app)

app.get('/', (req, res)=>{
  res.status(200).json({
    statusCode: 200,
    message: 'Healthcheck passed'
  })
})

app.get('/api/ping', (req, res)=>{
  res.status(200).json({ statusCode: 200, message: 'PONG'})
})

app.listen(APP_PORT, ()=>{
  console.log(`App is running on ${APP_PORT}`)
})
