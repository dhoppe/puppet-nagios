class nagios::service {
	$sgroups = hiera_array('sgroups')

	nagios::service::servicegroups { $sgroups: }

	Nagios_service <<||>> {
		notify  => Exec["fix-permissions"],
		require => File["conf.d"],
	}

	Nagios_servicegroup <||> {
		notify  => Exec["fix-permissions"],
		require => File["conf.d"],
	}
}

# vim: tabstop=3