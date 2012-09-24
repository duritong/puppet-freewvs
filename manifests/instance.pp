define freewvs::instance(
  $install_location = '/var/local'
){
    file{
      "${install_location}/freewvs":
        ensure => directory,
        source => 'puppet:///modules/site_freewvs/freewvs',
        owner => 'root', group => $name, mode => 0400,
        recurse => true;
      "${install_location}/freewvs_check":
        ensure => file,
        source => 'puppet:///modules/site_freewvs/freewvs_check',
        owner => root, group => root, mode => 0700;
    } 
    #File["/etc/cron.d/freewvs_run"]{
    #  content => "1 * * * * root $install_location/freewvs_check /\n",
    #}
}
