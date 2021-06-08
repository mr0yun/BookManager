"""
文件名：crawl_util.py
描述：爬虫爬取资讯，待定
"""

import requests
import re

url = 'https://news.cnblogs.com/NewsAjax/GetRecommendNews?itemCount=10'


def get_cnblogs_recommend_news():
    res = requests.get(url=url)
    if res.status_code == 200:
        return res.text
    else:
        return False


def parse_news(news):
    news_urls = re.findall("href=\"(.*?)\"", news, re.S)
    news_titles = re.findall("<a .*?>(.*?)</a>", news, re.S)
    return news_titles[:-1], news_urls[:-1]


if __name__ == '__main__':
    news = get_cnblogs_recommend_news()
    content = parse_news(news)
    print(content)

