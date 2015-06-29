# sauce gem requires this file directly so we need to require any
# used gems here even though spec_helper already requires them.

require 'sauce_platforms'

Sauce.config do |config|
  config[:start_local_application]    = false
  config[:start_tunnel]               = false
  # Set default screen res for all platforms
  # https://docs.saucelabs.com/reference/test-configuration/#specifying-the-screen-resolution
  config['screen-resolution']         = '1280x1024'

  # https://saucelabs.com/platforms/
  config[:browsers]                   = [
    Platform.windows_8.firefox.v37,
    # Can override / add new caps
    Platform.mac_10_10.safari.v8 + ['screen-resolution' => '1024x768']
  ]
end
