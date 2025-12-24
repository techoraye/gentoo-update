#ifndef GENTOO_UPDATE_RESTART_SERVICES_H
#define GENTOO_UPDATE_RESTART_SERVICES_H

#include <string>
#include <vector>

namespace GentooUpdate {
	struct Service {
		std::string name;
		std::string init_system; // systemd or openrc
		bool needs_restart;
	};

	class RestartServices {
	public:
		static void check_services();
		static std::vector<Service> find_services_to_restart();
		static bool has_services_to_restart();
		static void restart_services(bool interactive = true);
	};
}

#endif // GENTOO_UPDATE_RESTART_SERVICES_H
