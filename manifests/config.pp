# spacewalk::config
#
# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include spacewalk::config
class spacewalk::config inherits spacewalk {
  # default parameters
  Exec {
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    unless      => 'spacewalk-channel --list',
    refreshonly => true,
  }
  # subscribe to master server
  exec {
    'rhnreg_ks':
      command => "rhnreg_ks --serverUrl=${spacewalk::server}/${spacewalk::api} --activationkey=${spacewalk::activationkey} --force",
      notify  => Exec['spacewalk-channel'];
    'spacewalk-channel':
      command => "spacewalk-channel --add -c ${spacewalk::channel_str} --user ${spacewalk::user} --password ${spacewalk::password}",
  }
}
