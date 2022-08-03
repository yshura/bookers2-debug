const { environment } = require('@rails/webpacker')

const webpack = require('webpack')

environment.plugins.prepend(
  'Provide',
  webpack.ProvidePlugin({
    $: 'jquery/src/jquery',
    jQuery: 'jquery/src/jquery',
    jquery: 'jquery/src/jquery',
    //Popper: 'popper.js'
  })
)

module.exports = environment
