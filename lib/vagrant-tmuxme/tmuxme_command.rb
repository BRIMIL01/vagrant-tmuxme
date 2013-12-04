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

        with_target_vms(argv) do |vm|
          raise Vagrant::Errors::VMNotCreatedError if vm.state.id == :not_created
          raise Vagrant::Errors::VMInaccessible if vm.state.id == :inaccessible
        end

        with_target_vms("default") do |vm|
          vm.guest.capability(:ensure_tmux, @env)
          vm.guest.capability(:ensure_tmuxme, @env)
          vm.action(:ssh_run, ssh_run_command: "tmuxme #{argv[0..-1]}")
        end
      end
    end
  end
end
