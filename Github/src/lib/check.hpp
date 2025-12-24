#ifndef GENTOO_UPDATE_CHECK_H
#define GENTOO_UPDATE_CHECK_H

#include <string>
#include <vector>

namespace GentooUpdate {
	struct UpdateInfo {
		std::string package;
		std::string current_version;
		std::string new_version;
		std::string repository;
	};

	class Checker {
	public:
		static bool check_updates();
		static std::vector<UpdateInfo> get_available_updates();
		static bool check_sync();
		static bool check_preserved_rebuild();
		static bool check_kernel_updates();
		static bool check_config_files();
		static bool check_distfiles();
		static int count_updates();
	};
}

#endif // GENTOO_UPDATE_CHECK_H
