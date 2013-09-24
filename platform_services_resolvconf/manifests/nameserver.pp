# Version von platform_services_resolvconf::nameserver welche für den Moment funktioniert.
# Die Swisstxt Nameserver - inklusive derjenige von Cloudstack' - delegieren momentan nicht
# an unsere Server.
# Um irgendwie weiter arbeiten zu können: Diese Lösung!

class platform_services_resolvconf::nameserver( $vip,
                                              )
{

  Class['::platform_services_resolvconf::nameserver'] <- Class['::dns::server::service']
  @@resolvconf::nameserver{$vip:
    priority => 1,
    tag => 'front',
  }
  @@resolvconf::nameserver{$::ipaddress:
    priority => 1,
    tag => 'internal'
  }

  if $::platform_services_dns::ipaddress_dns_2nd {
    @@resolvconf::nameserver{$::platform_services_dns::ipaddress_dns_2nd:
      priority => 2,
      tag => 'internal',
    }
  } else {
    $default_nameserver = regsubst(baseip(), '^(\d+)\.(\d+)\.(\d+)\.(\d+)$',  '\1.\2.\3.1')
    if $default_nameserver != $::ipaddress {
      @@resolvconf::nameserver{$default_nameserver:
        priority => 10,
        tag => 'internal',
      }
    }
  }
}
