require "vagrant"

module VagrantPlugins
  module Tmuxme
    class Plugin < Vagrant.plugin("2")
      name "Vagrant Tmuxme"
      description "Create a tmuxme session the safe way"

      command "tmuxme" do
        require_relative "tmuxme_command"
        TmuxmeCommand
      end

      config "tmuxme" do
        require_relative "config"
        Config
      end
    end
  end
end
