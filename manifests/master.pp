class nagios::master inherits nagios {
	include nagios::command
	include nagios::contact
	include nagios::host
	include nagios::service

	exec { "external-commands":
		command => "dpkg-statoverride --update --add nagios nagios 751 /var/lib/nagios3 && dpkg-statoverride --update --add nagios www-data 2710 /var/lib/nagios3/rw",
		unless  => "dpkg-statoverride --list nagios nagios 751 /var/lib/nagios3 && dpkg-statoverride --list nagios www-data 2710 /var/lib/nagios3/rw",
		notify  => Service["nagios3"],
	}

	# Bug: 3299
	exec { "fix-permissions":
		command     => "chmod -R go+r /etc/nagios3/conf.d",
		refreshonly => true,
		notify      => Service["nagios3"],
	}

	file { "/etc/nagios3":
		recurse => true,
		owner   => root,
		group   => root,
		mode    => 0644,
		alias   => "configs",
		notify  => Service["nagios3"],
		source  => "puppet:///modules/nagios/${::lsbdistcodename}/etc/nagios3",
		require => Package["nagios3"],
	}

	file { "/etc/nagios3/htpasswd.users":
		owner   => root,
		group   => root,
		mode    => 0644,
		source  => "puppet:///modules/nagios/common/etc/nagios3/htpasswd.users",
		require => Package["nagios3"],
	}

	file { "/etc/nagios3/conf.d":
		recurse => true,
		owner   => root,
		group   => root,
		mode    => 0644,
		alias   => "conf.d",
		notify  => Service["nagios3"],
		source  => "puppet:///modules/nagios/common/etc/nagios3/objects",
		require => Package["nagios3"],
	}

	package { [
		"nagios3",
		"nagios-nrpe-plugin" ]:
		ensure => present,
	}

	service { "nagios3":
		enable     => true,
		ensure     => running,
		hasrestart => true,
		hasstatus  => true,
		require    => [
			File["configs"],
			File["conf.d"],
			Package["nagios3"]
		],
	}
}

# vim: tabstop=3