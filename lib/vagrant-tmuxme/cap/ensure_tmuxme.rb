module VagrantPlugins
  module Tmuxme
    module Cap
      class EnsureTmuxme
 
        def self.ensure_tmuxme(machine, env)
          return unless machine.communicate.ready?
 
          if tmuxme_installed?(machine)
            env.ui.info I18n.t('vagrant_tmuxme.tmuxme_installed')
          else
            env.ui.info I18n.t('vagrant_tmuxme.installing_tmuxme')
            install_tmuxme!(machine)
          end
        end
 
        def self.tmuxme_installed?(machine)
          machine.communicate.execute("tmuxme") rescue false
        end
 
        def self.install_tmuxme!(machine)
          machine.communicate.tap do |comm|
            comm.sudo "gem install tmuxme"
          end
        end
 
      end
    end
  end
end
