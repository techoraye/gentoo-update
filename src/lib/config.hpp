#ifndef GENTOO_UPDATE_CONFIG_H
#define GENTOO_UPDATE_CONFIG_H

#include <string>
#include <map>
#include <fstream>
#include <filesystem>

namespace fs = std::filesystem;

namespace GentooUpdate {
	struct Config {
		bool no_color = false;
		bool always_show = false;
		int news_num = 5;
		int keep_old_packages = 3;
		int keep_installed_packages = 0;
		std::string diff_prog = "vimdiff";
		int check_interval = 3600;
		bool auto_sync = true;
		bool check_preserved_rebuild = true;
		bool check_kernel_updates = true;
		bool check_config_files = true;
		bool check_distfiles = true;
	};

	class ConfigManager {
	public:
		static Config load_config();
		static void save_config(const Config& config);
		static void generate_default_config();
		static std::string get_config_path();
		static void edit_config();
		static void show_config();
	};
}

#endif // GENTOO_UPDATE_CONFIG_H
