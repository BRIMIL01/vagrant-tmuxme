require 'optparse'

module VagrantPlugins
  module Tmuxme
    class TmuxmeCommand < Vagrant.plugin("2", :command)
      def execute
        options = {}

        opts = OptionParser.new do |opt|
          opt.banner = "Usage: vagrant tmuxme [username]"
        end

        argv = parse_options(opts)

        with_target_vms("default") do |vm|
          vm.action(:ssh_run, ssh_run_command: "apt-get install tmux")
          vm.action(:ssh_run, ssh_run_command: "gem install tmuxme")
          vm.action(:ssh_run, ssh_run_command: "tmuxme #{argv[0..-1]}")
        end
      end
    end
  end
end
