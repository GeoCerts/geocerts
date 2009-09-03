require 'fakeweb'
FakeWeb.allow_net_connect = false unless use_remote_server?