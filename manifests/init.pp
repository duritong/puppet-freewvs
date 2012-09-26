class freewvs(
  $install_location = '/var/local',
  $repo             = 'git://git.immerda.ch/ifreewvs',
  $config_src       = 'puppet:///modules/freewvs/freewvs_check.conf',
  $template_src     = 'puppet:///modules/freewvs/freewvs_check.erb'
){
    git::clone{"git_clone_freewvs":
      git_repo => 'git://git.immerda.ch/ifreewvs',
      projectroot => "${install_location}/freewvs",
      cloneddir_user => 'root',
      cloneddir_group => 'root',
    }
    file{
      "${install_location}/freewvs_check":
        ensure => file,
        source => 'puppet:///modules/freewvs/freewvs_check',
        owner => root, group => root, mode => 0700;
      "/etc/freewvs":
        ensure => directory;
      "/etc/freewvs/freewvs_check.conf":
        ensure => file,
        source => $config_src,
        owner => root, group => root, mode => 0700;
      "/etc/freewvs/freewvs_check.erb":
        ensure => file,
        source => $template_src,
        owner => root, group => root, mode => 0700;
    } 
    #File["/etc/cron.d/freewvs_run"]{
    #  content => "1 * * * * root $install_location/freewvs_check /\n",
    #}
}
