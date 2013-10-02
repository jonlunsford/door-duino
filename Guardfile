guard 'livereload', :apply_css_live => true, :apply_js_live => false do
  watch(%r{(views/).+\.(css|js|html|haml)})
end

guard 'compass' do
  watch(/^sass\/(.*)\.s[ac]ss/)
end

guard 'coffeescript', :input => 'coffeescript', :output => 'public/js', :bare => %w{}
