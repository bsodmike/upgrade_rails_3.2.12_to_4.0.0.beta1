ENV['RAILS_ENV'] = ENV['RAILS_ENV'] || 'development'
require File.expand_path("../config/environment.rb", __FILE__)
require 'rails/generators'
#require 'pry'

class CustomGenerator < Rails::Generators::Base
  source_root File.expand_path(File.dirname(__FILE__), "./")

  def upgrade
    source_url = 'https://raw.github.com/bsodmike/rails_3.2.12_vs_4.0.0.beta1/master'
    get "#{source_url}/update_rails_3.2.12_to_4.0.0.beta1.patch", "upgrade/upgrade.patch", :verbose => true

    if File.exist? "Gemfile"
      copy_file "Gemfile", "upgrade/backups/Gemfile"
      remove_file "Gemfile"
    end

    if File.exist? "Gemfile.lock"
      copy_file "Gemfile.lock", "upgrade/backups/Gemfile.lock"
      remove_file "Gemfile.lock"
    end

    get "#{source_url}/Gemfile", "Gemfile", :verbose => true
    in_root { run("git apply upgrade/upgrade.patch", :verbose => true) }
  end
end

CustomGenerator.new.upgrade
