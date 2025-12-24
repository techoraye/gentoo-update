#ifndef GENTOO_UPDATE_PACKAGES_CACHE_H
#define GENTOO_UPDATE_PACKAGES_CACHE_H

#include <string>
#include <vector>

namespace GentooUpdate {
	struct CacheFile {
		std::string filename;
		std::string size;
		bool is_orphan;
	};

	class PackagesCache {
	public:
		static void check_cache();
		static std::vector<CacheFile> find_old_packages();
		static bool has_old_packages();
		static void remove_old_packages(bool interactive = true);
	};
}

#endif // GENTOO_UPDATE_PACKAGES_CACHE_H
