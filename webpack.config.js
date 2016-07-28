var path = require('path')
  , CopyWebpackPlugin = require('copy-webpack-plugin')

module.exports = {
  entry: {
    'app': './src/app.ls'
  }
, output: {
    path: path.join(__dirname, 'dist')
  , filename: '[name].js'
  }
, devtool: 'source-map'
, plugins: [
    new CopyWebpackPlugin(
      [
        { from: './src' }
      ]
    , { ignore: ['*.ls', '*.vue'] })
  ]
, module: {
    loaders: [
      { test: /\.ls$/, loader: 'livescript' }
    , { test: /\.vue$/, loader: 'vue' }
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
