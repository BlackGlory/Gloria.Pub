var path = require('path')
  , webpack = require('webpack')
  , CopyWebpackPlugin = require('copy-webpack-plugin')

module.exports = {
  entry: {
    app: ['es6-promise', 'whatwg-fetch', './src/app.ls']
  }
, output: {
    path: path.join(__dirname, 'build')
  , filename: '[name].js'
  , publicPath: '/'
  }
, plugins: [
    new CopyWebpackPlugin(
      [
        { from: './src' }
      ]
    , { ignore: ['*.ls', '*.vue'] })
  , new webpack.DefinePlugin({
      'process.env': {
        NODE_ENV: '"production"'
      }
    })
  , new webpack.optimize.UglifyJsPlugin({
      compress: {
        warnings: false
      }
    })
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
    ]
  }
, vue: {
    loaders: {
      livescript: 'livescript'
    , sass: 'style!css!sass?indentedSyntax=true'
    }
  }
}
