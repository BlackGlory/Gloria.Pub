var path = require('path')
  , webpack = require('webpack')
  , CopyWebpackPlugin = require('copy-webpack-plugin')

module.exports = {
  entry: {
    'app': './src/app.ls'
  }
, output: {
    path: path.join(__dirname, 'build')
  , filename: '[name].js'
  }
, devtool: 'source-map'
, plugins: [
    new CopyWebpackPlugin(
      [
        { from: './src' }
      , { from: './node_modules/codemirror/lib/codemirror.css', to: 'codemirror' }
      , { from: './node_modules/codemirror/theme/monokai.css', to: 'codemirror' }
      , { from: './node_modules/codemirror/lib/codemirror.js', to: 'codemirror' }
      , { from: './node_modules/codemirror/mode/javascript/javascript.js', to: 'codemirror/mode' }
      ]
    , { ignore: ['*.ls', '*.vue', '*.map'] })
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
    // , { test: /\.css$/, loader: 'css' }
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
