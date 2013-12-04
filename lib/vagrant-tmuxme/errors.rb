module VagrantPlugins
  module Tmuxme
    module Errors
      class TmuxNotAvailableError < Vagrant::Errors::VagrantError
        error_key(:tmux_not_available)
      end
    end
  end
end
