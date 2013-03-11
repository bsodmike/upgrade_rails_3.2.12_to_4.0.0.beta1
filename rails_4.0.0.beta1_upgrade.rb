ENV['RAILS_ENV'] = ENV['RAILS_ENV'] || 'development'
require File.expand_path("../config/environment.rb", __FILE__)
require 'rails/generators'
#require 'pry'

class CustomGenerator < Rails::Generators::Base
  attr_accessor :git_apply
  source_root File.expand_path(File.dirname(__FILE__), "./")

  def upgrade
    source_url = 'https://raw.github.com/bsodmike/rails_3.2.12_vs_4.0.0.beta1/master'
    get "#{source_url}/update_rails_3.2.12_to_4.0.0.beta1.patch", "upgrade/upgrade.patch", :verbose => true unless File.exist? "upgrade/upgrade.patch"

    if argv && self.git_apply == "check"
      in_root { run("git apply --check upgrade/upgrade.patch", :verbose => true) }
    elsif argv && self.git_apply == "apply"
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
    else
      puts "Usage: ruby rails_4.0.0.beta1_upgrade.rb [FLAGS]\n\n"
      puts "== Flags\n\n"
      puts "--check\t\t:: Check if the upgrade applies.\n"
      puts "--apply\t\t:: Apply the upgrade.\n"
    end
  end

  private
  def argv(argv = ARGV)
    return false unless ARGV.any?
    match = argv.first.match(/\A--([a-z]+)/)
    return false unless match.to_a.any?
    case match[1].downcase
    when "check"
      self.git_apply = "check"
      true
    when "apply"
      self.git_apply = "apply"
      true
    end
  end
end

CustomGenerator.new.upgrade
