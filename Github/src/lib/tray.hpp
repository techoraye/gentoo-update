#ifndef GENTOO_UPDATE_TRAY_H
#define GENTOO_UPDATE_TRAY_H

#include <string>
#include <vector>
#include "check.hpp"

namespace GentooUpdate {
	class Tray {
	public:
		static void start_tray();
		static void stop_tray();
		static bool is_running();
		static void enable_autostart();
		static void disable_autostart();
		static bool is_autostart_enabled();
		static void update_tray_icon(const std::vector<UpdateInfo>& updates);
	};
}

#endif // GENTOO_UPDATE_TRAY_H
