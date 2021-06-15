"""
文件名：crawl_util.py
描述：爬虫豆瓣图书前250
注意事项：因为数据量较大，需要主要ip被封的问题，我已经使用cookie解决
"""
import requests  # 获取网页内容
from bs4 import BeautifulSoup  # 解析网页内容
import pymysql
import time,random


def get_html(url):
    ua_list=['Mozilla/5.0 (compatible; U; ABrowse 0.6; Syllable) AppleWebKit/420+ (KHTML, like Gecko)',
             'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; Acoo Browser; .NET CLR 1.1.4322; .NET CLR 2.0.50727)',
             'Mozilla/5.0 (compatible; MSIE 9.0; AOL 9.7; AOLBuild 4343.19; Windows NT 6.1; WOW64; Trident/5.0; FunWebProducts)',
             'Mozilla/4.0 (compatible; MSIE 7.0; AOL 9.5; AOLBuild 4337.36; Windows NT 6.0; SLCC1; .NET CLR 2.0.50727; Media Center PC 5.0; .NET CLR 3.5.30729; .NET CLR 3.0.30618)',
             'Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.20) Gecko/20081217 Firefox/2.0.0.21',
             'Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/532.0 (KHTML, like Gecko) Chrome/3.0.195.4 Safari/532.0',
             'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.28 (KHTML, like Gecko) Version/3.2.2 Safari/525.28.1']

    #解决豆瓣的反爬虫机制
    headers = {
        'User-Agent':ua_list[random.randint(0,6)],
        'Cookie':
            'bid = lCM6tvEsTpg;ll = "118209";__utmz = 81379588.1623327097.1.1.utmcsr = link.csdn.net | utmccn = (referral) |' \
    ' utmcmd = referral | utmcct = /; gr_user_id = d332ab05 - 8b29 - 4418 - a8f0 - ab0020f095ed;' \
    '_vwo_uuid_v2 = D1D1E9707B502DF8D109349BBEC52350D | d5edf50a06c6fa39efe4caf8892982be;push_noty_num = 0;' \
    'push_doumail_num = 0;__utmv = 30149280.23977;dbcl2 = "239773870:4eQH8zB46vs";ck = N0tw;' \
    'ap_v = 0, 6.0;_pk_ref.100001.3ac3 = % 5B % 22 % 22 % 2C % 22 % 22 % 2C1623683759 % 2C % 22' \
    'https % 3A % 2F % 2Flink.csdn.net % 2F % 3Ftarget % 3Dhttps % 253A % 252F % 252Fbook.douban.com % 252Fsubject % 252' \
    'Fbookid % 252F % 22 % 5D;__utma = 30149280.357655616.1622443786.1623489900.1623683759.7;' \
    '__utmc = 30149280;__utmz = 30149280.1623683759' \
    '.7.5.utmcsr = link.csdn.net | utmccn = (referral) | utmcmd = referral | utmcct = /;' \
    ' __utma = 81379588.1985094735.1623327097.1623491586.1623684542' \
    '.5;__utmc = 81379588;_pk_id.100001.3ac3 = 3ca65ccec4598e03.1623327097.6.1623684544.1623491589.'
    }

    res = requests.get(url, headers=headers)
    res.encoding = res.apparent_encoding  # 设置编码，防止乱码

    print(res.cookies)

    return res.text  # 返回网页的内容


# 通过bs4解析，主要是标签选择器
def ana_by_bs4(html):
    soup = BeautifulSoup(html, 'html.parser')  # 注意需要添加html.parser解析
    tables = soup.find_all("table")  # 选择table标签
    # 或者通过tr的class属性定位
    # trs = soup.find_all('tr', class_='item')
    data_list = []
    for table in tables:
        img = table.find('img')['src']  # 图片链接
        # title = table.find('div', class_='pl2').text.strip()  # 正标题
        title = table.find('div', class_='pl2').find('a')['title']  # 去除多余换行
        strInfo = table.find('p', class_='pl').text.strip()  # 作者、出版社、年份、价格等信息

        infos = strInfo.strip().split('/')  # 有多作者的可能
        author_list = infos[:-3]
        author = ''
        try:
            for item in author_list:
                author += '/' + item.strip().replace('\n', '')  # 作者
            author = author[1:]  # 因为多了一个/，所以第一个/不输出，优化输出效果
            pub = infos[-3].strip()  # 出版社
            year = infos[-2].strip()  # 年份
            price = infos[-1].strip()  # 价格
            rating = table.find('span', class_='rating_nums').text.strip()  # 评分
            remark_num = table.find('span', class_='pl').text.replace('\n', '').strip()[20:-3]  # 评分人数
        except:  # 名言可能不存在
            print('异常')
        try:
            quote = table.find('span', class_='inq').text.replace('\n', '')  # 名言
        except:  # 名言可能不存在
            quote = ''

        # 优化输出模式
        print('---------------------------------华丽的分割线--------------------------------------')
        # print('图片封面链接', '书名', '作者', '出版社', '年份', '价格', '评分', '评分人数', '名言')
        print('图片封面链接：', img)
        print('书名:', title)
        print('作者:', author)
        print('出版社：', pub)
        print('出版年份:', year)
        print('售价:', price)
        print('评分：', rating)
        print('评价人数:', remark_num)
        print('名言或评注:', quote)
        # print(img, title, author,pub, year, price, rating,remark_num, quote)
        data_list.append((img, title, author, pub, year, price, rating, remark_num, quote))
    return data_list


# 存储数据
def insert_data(data_list):
    conn = pymysql.connect(host='127.0.0.1', port=3306, user='root', password='', db='book',
                           charset='utf8')  # 连接数据库
    cur = conn.cursor()  # 用于访问和操作数据库中的数据（一个游标，像一个指针）
    # 首先得保证存在book数据库，然后库中有douban_book表，属性和下面的对应
    sql = 'insert into douban_book(img_href, title, author,pub, pub_year, price, grade,remark_num, quote) values(%s,%s,%s,%s,%s,%s,%s,%s,%s)'  # 插入多条
    cur.executemany(sql, data_list)  # data_list类型是列表中嵌套多个元组比如[(),(),()]
    conn.commit()  # 提交事务,执行了这一步数据才真正存到数据库
    cur.close()  # 关闭游标
    conn.close()  # 关闭数据库连接


if __name__ == '__main__':
    for page in range(10):
        print('第{}页'.format(page + 1))
        single_url = 'https://book.douban.com/top250?start={}'.format(page * 25)  # 图书每一页的url，有多页的时候需要观察url的规律
        text = get_html(single_url)  # 获取网页内容
        print(text)
        time.sleep(random.random() * 5)#伪装成用户,多停留几秒
        dataList = ana_by_bs4(text)  # bs4方式解析
        insert_data(dataList)  # 数据存入数据库

