#ifndef GENTOO_UPDATE_CONFIG_FILES_H
#define GENTOO_UPDATE_CONFIG_FILES_H

#include <string>
#include <vector>

namespace GentooUpdate {
	struct ConfigFile {
		std::string path;
		std::string type; // .etc-update, .replaced, etc
		bool needs_action;
	};

	class ConfigFiles {
	public:
		static void check_config_files();
		static std::vector<ConfigFile> find_config_changes();
		static bool has_config_changes();
		static void process_config_files(bool interactive = true);
	};
}

#endif // GENTOO_UPDATE_CONFIG_FILES_H
