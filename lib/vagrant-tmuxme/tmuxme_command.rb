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
          raise Vagrant::Errors::VMNotCreatedError if vm.state.id == :not_created
          raise Vagrant::Errors::VMInaccessible if vm.state.id == :inaccessible
        end

        with_target_vms("default") do |vm|
          vm.guest.capability(:ensure_tmux, @env)
          vm.guest.capability(:ensure_tmuxme, @env)
          @env.ui.info "Starting pair session with #{argv.join(" ")}"
          vm.action(:ssh, ssh_opts: { extra_args: ["-t", ". /etc/profile; . ~/.profile; tmuxme #{argv.join(" ")}"], subprocess: true })
        end
      end
    end
  end
end
