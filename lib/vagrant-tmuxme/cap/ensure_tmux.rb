module VagrantPlugins
  module Tmuxme
    module Cap
      class EnsureTmux
 
        def self.ensure_tmux(machine, env)
          return unless machine.communicate.ready?
 
          if tmux_installed?(machine)
            env.ui.info I18n.t('vagrant_tmux.tmux_installed')
          else
            env.ui.info I18n.t('vagrant_tmux.installing_tmux')
            install_tmux!(machine)
          end
        end
 
        def self.tmux_installed?(machine)
          machine.communicate.execute("tmux -V") rescue false
        end
 
        def self.install_tmux!(machine)
          machine.communicate.tap do |comm|
            case machine.guest.name
            when :debian, :ubuntu
              comm.sudo "apt-get update"
              comm.sudo "apt-get install tmux"
            when :fedora, :centos, :redhat
              comm.sudo "yum install tmux"
            when :suse
              comm.sudo "yast2 -i tmux"
            when :gentoo
              comm.sudo "emerge tmux"
            when :arch
              comm.sudo "pacman -s tmux"
            else
              raise Errors::TmuxNotAvailableError, guest: machine.guest.name
            end
          end
        end
 
      end
    end
  end
end
