begin
  require "vagrant"
rescue LoadError
  raise "The Vagrant Tmuxme plugin must be run within Vagrant."
end

# This is a sanity check to make sure no one is attempting to install
# this into an early Vagrant version.
if Vagrant::VERSION < "1.1.0"
  raise "The Vagrant Tmuxme plugin is only compatible with Vagrant 1.1+"
end

# Add our custom translations to the load path
I18n.load_path << File.expand_path("../../../locales/en.yml", __FILE__)

module VagrantPlugins
  module Tmuxme
    class Plugin < Vagrant.plugin("2")
      name "Vagrant Tmuxme"
      description "Create a tmuxme session the safe way"

      command "tmuxme" do
        require_relative "tmuxme_command"
        TmuxmeCommand
      end

      guest_capability("linux", "ensure_tmux") do
        require_relative "cap/ensure_tmux"
        Cap::EnsureTmux
      end

      guest_capability("linux", "ensure_tmuxme") do
        require_relative "cap/ensure_tmuxme"
        Cap::EnsureTmuxme
      end
    end
  end
end
