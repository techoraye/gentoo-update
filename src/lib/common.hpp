#ifndef GENTOO_UPDATE_COMMON_H
#define GENTOO_UPDATE_COMMON_H

#include <string>
#include <vector>
#include <iostream>
#include <cstdlib>
#include <unistd.h>
#include <sys/types.h>

// Color codes
extern const std::string BOLD;
extern const std::string RED;
extern const std::string GREEN;
extern const std::string YELLOW;
extern const std::string BLUE;
extern const std::string CYAN;
extern const std::string NC;

// Version information
extern const std::string VERSION;
extern const std::string AUTHOR;
extern const std::string AUTHOR_EMAIL;
extern const std::string PROJECT_URL;

namespace GentooUpdate {
	// User and privilege management
	inline bool check_root() {
		return geteuid() == 0;
	}
	
	std::string check_su_cmd();
	int run_sudo(const std::vector<std::string>& cmd);
	std::string detect_init_system();
	bool is_init_system(const std::string& init_type);
	
	// Notifications
	void send_notification(const std::string& title, const std::string& message);
	bool is_notification_available();
	
	// Color and output functions
	std::string colorize(const std::string& text, const std::string& color);
	void print_info(const std::string& msg);
	void print_success(const std::string& msg);
	void print_warning(const std::string& msg);
	void print_error(const std::string& msg);
	void print_debug(const std::string& msg, bool debug = true);
	
	// System commands
	int execute_command(const std::string& cmd);
	std::string execute_and_capture(const std::string& cmd);
	bool command_exists(const std::string& cmd);
	
	// File operations
	bool file_exists(const std::string& path);
	bool is_directory(const std::string& path);
	std::string read_file(const std::string& path);
	void write_file(const std::string& path, const std::string& content);
	
	// String utilities
	std::string trim(const std::string& str);
	std::vector<std::string> split(const std::string& str, char delimiter);
	std::string to_lowercase(const std::string& str);
	std::string to_uppercase(const std::string& str);
	bool starts_with(const std::string& str, const std::string& prefix);
	bool ends_with(const std::string& str, const std::string& suffix);
	std::string replace_all(std::string str, const std::string& from, const std::string& to);
}

#endif // GENTOO_UPDATE_COMMON_H
