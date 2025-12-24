#ifndef GENTOO_UPDATE_LIST_H
#define GENTOO_UPDATE_LIST_H

#include <string>
#include <vector>
#include "check.hpp"

namespace GentooUpdate {
	class ListPackages {
	public:
		static void display_updates();
		static void display_packages(const std::vector<UpdateInfo>& updates);
		static std::string format_package_info(const UpdateInfo& update);
	};
}

#endif // GENTOO_UPDATE_LIST_H
