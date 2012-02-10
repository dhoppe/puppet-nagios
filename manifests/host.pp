class nagios::host {
	$hgroups = hiera_array('hgroups')

	nagios::host::hostgroups { $hgroups: }

	Nagios_host <<||>> {
		notify  => Exec["fix-permissions"],
		require => File["conf.d"],
	}

	Nagios_hostgroup <||> {
		notify  => Exec["fix-permissions"],
		require => File["conf.d"],
	}

	Nagios_hostextinfo <<||>> {
		notify  => Exec["fix-permissions"],
		require => File["conf.d"],
	}
}

# vim: tabstop=3