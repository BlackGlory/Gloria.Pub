const path = require('path')
const webpack = require('webpack')
const CopyWebpackPlugin = require('copy-webpack-plugin')
const Dashboard = require('webpack-dashboard')
const DashboardPlugin = require('webpack-dashboard/plugin')

const dashboard = new Dashboard()

module.exports = {
  entry: {
    app: ['es6-promise', 'whatwg-fetch', './src/app.ls']
  }
, output: {
    path: path.join(__dirname, 'build')
  , filename: '[name].js'
  , publicPath: '/'
  }
, devtool: 'source-map'
, plugins: [
    new CopyWebpackPlugin(
      [
        { from: './src' }
      ]
    , { ignore: ['*.ls', '*.vue'] })
  , new DashboardPlugin(dashboard.setData)
  ]
, module: {
    loaders: [
      { test: /\.ls$/, loader: 'livescript' }
    , { test: /\.vue$/, loader: 'vue' }
    , { test: /\.css$/, loader: 'style!css' }
    , { test: /\.woff(\?v=\d+\.\d+\.\d+)?$/, loader: "file" }
    , { test: /\.woff2(\?v=\d+\.\d+\.\d+)?$/, loader: "file" }
    , { test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/, loader: "file" }
    , { test: /\.eot(\?v=\d+\.\d+\.\d+)?$/, loader: "file" }
    , { test: /\.svg(\?v=\d+\.\d+\.\d+)?$/, loader: "file" }
    , { test: /\.json$/, loader: 'json' }
    ]
  }
, vue: {
    loaders: {
      livescript: 'livescript'
    , sass: 'style!css!sass?indentedSyntax=true'
    }
  }
}
