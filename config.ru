require 'rack/protection'
require './app/drum_lesson'

use Rack::Session::Cookie, secret: 'secret_key'
use Rack::Protection, raise: true
#use Rack::Protection::AuthenticityToken

run Drum_lesson

