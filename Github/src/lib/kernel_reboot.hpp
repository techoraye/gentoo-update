#ifndef GENTOO_UPDATE_KERNEL_H
#define GENTOO_UPDATE_KERNEL_H

#include <string>
#include <vector>

namespace GentooUpdate {
	struct KernelInfo {
		std::string current;
		std::string latest;
		bool update_available;
		bool reboot_required;
	};

	class KernelReboot {
	public:
		static void check_kernel();
		static KernelInfo get_kernel_info();
		static bool needs_reboot();
		static void offer_reboot();
	};
}

#endif // GENTOO_UPDATE_KERNEL_H
