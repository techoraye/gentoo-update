#ifndef GENTOO_UPDATE_NOTIFICATION_H
#define GENTOO_UPDATE_NOTIFICATION_H

#include <string>

namespace GentooUpdate {
	class Notification {
	public:
		static void send(const std::string& title, const std::string& body, 
		                 const std::string& icon = "system-software-update");
		static bool is_available();
		static void notify_updates_available(int count);
		static void notify_update_complete();
	};
}

#endif // GENTOO_UPDATE_NOTIFICATION_H
