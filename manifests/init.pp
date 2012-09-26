class freewvs(
  $install_location = '/var/local',
  $repo             = 'git://git.immerda.ch/ifreewvs',
  $config_src       = 'puppet:///modules/freewvs/freewvs_check.conf',
  $template_src     = 'puppet:///modules/freewvs/freewvs_check.erb'
){
    git::clone{"git_clone_freewvs":
      git_repo        => $repo,
      projectroot     => "${freewvs::install_location}/freewvs",
      cloneddir_user  => 'root',
      cloneddir_group => 'root',
    }
    file{
      "${freewvs::install_location}/freewvs_check":
        ensure  => file,
        source  => 'puppet:///modules/freewvs/freewvs_check',
        owner   => root, group => root, mode => 0700;
      "/etc/freewvs":
        ensure  => directory;
      "/etc/freewvs/freewvs_check.conf":
        ensure  => file,
        source  => $freewvs::config_src,
        owner   => root, group => root, mode => 0600;
      "/etc/freewvs/freewvs_check.erb":
        ensure  => file,
        source  => $freewvs::template_src,
        owner   => root, group => root, mode => 0600;
      "/etc/cron.d/freewvs_run":;
    } 
    File["/etc/cron.d/freewvs_run"]{
      content => "14 3 * * * root ${freewvs::install_location}/freewvs_check /\n",
    }
}
