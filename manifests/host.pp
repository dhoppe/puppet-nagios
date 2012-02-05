class nagios::host {
	nagios::host::hostgroups { [
		"lenny",
		"squeeze",
		"maverick",
		"natty" ]:
	}

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