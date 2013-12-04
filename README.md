# Vagrant-Tmuxme

Start tmuxme sessions in a running vagrant instance. The safe way to pair with
tmuxme.

## Installation

Build the gem locally

    rake build

Install the built gem in vagrant

    vagrant plugin install pkg/vagrant-tmuxme-0.0.1.gem

## Usage

A new tmuxme session can be started in a running vagrant instance by running
the following:

    vagrant tmuxme [tmuxme user]

**Note** the directory that you start vagrant in is automatically shared with
the vm and will be accessible to any tmuxme guest.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
=======
