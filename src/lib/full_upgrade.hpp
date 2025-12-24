#ifndef GENTOO_UPDATE_FULL_UPGRADE_H
#define GENTOO_UPDATE_FULL_UPGRADE_H

#include <string>

namespace GentooUpdate {
	class FullUpgrade {
	public:
		static void run_interactive_update();
		static void run_automatic_update();
		static void perform_pre_update_checks();
		static void perform_update();
		static void perform_post_update_checks();
		static bool confirm_update();
	};
}

#endif // GENTOO_UPDATE_FULL_UPGRADE_H
