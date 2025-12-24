#ifndef GENTOO_UPDATE_LIST_NEWS_H
#define GENTOO_UPDATE_LIST_NEWS_H

#include <string>
#include <vector>

namespace GentooUpdate {
	struct NewsItem {
		std::string title;
		std::string date;
		std::string summary;
		bool is_new;
	};

	class ListNews {
	public:
		static void display_news(int num = 5);
		static std::vector<NewsItem> fetch_news();
		static bool has_new_news();
		static void mark_news_as_read();
	};
}

#endif // GENTOO_UPDATE_LIST_NEWS_H
