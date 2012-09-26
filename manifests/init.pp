class freewvs(
  $install_location = '/var/local'
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
    } 
    #File["/etc/cron.d/freewvs_run"]{
    #  content => "1 * * * * root $install_location/freewvs_check /\n",
    #}
}
