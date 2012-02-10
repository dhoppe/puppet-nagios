class nagios::contact {
	$user = hiera('user')
	$group = hiera('group')

	nagios::contact::contacts { "$user":
		alias => hiera('calias'),
		email => hiera('email'),
		group => hiera('group'),
	}

	nagios::contact::contactgroups { "$group":
		alias => hiera('galias'),
	}

	Nagios_contact <||> {
		notify  => Exec["fix-permissions"],
		require => File["conf.d"],
	}

	Nagios_contactgroup <||> {
		notify  => Exec["fix-permissions"],
		require => File["conf.d"],
	}
}

# vim: tabstop=3