Encoding.default_internal = Encoding.default_external = 'UTF-8' if RUBY_VERSION >= '1.9'
require ::File.expand_path('../autoforme_demo',  __FILE__)
run AutoFormeDemo::App.app
