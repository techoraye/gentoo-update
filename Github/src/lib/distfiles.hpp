#ifndef GENTOO_UPDATE_DISTFILES_H
#define GENTOO_UPDATE_DISTFILES_H

#include <string>
#include <vector>

namespace GentooUpdate {
	struct DistFile {
		std::string filename;
		std::string size;
		bool is_orphan;
	};

	class Distfiles {
	public:
		static void check_distfiles();
		static std::vector<DistFile> find_orphan_distfiles();
		static bool has_orphan_distfiles();
		static void clean_distfiles(bool interactive = true);
	};
}

#endif // GENTOO_UPDATE_DISTFILES_H
