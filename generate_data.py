"""
文件名：generate_data.py
描述：使用mysql在本地连接，新建数据库book及相关表
"""
import pymysql
import traceback
host = '127.0.0.1'
port = 3306
user = 'root'
password = 'wp20000206'  # 这是我的密码，如需使用请进行更改

# 手动输入参数方式
# print('Starting the create database operation, please enter the information required for the database.')
# print('------------------------------------')
# host = input('please input database host:')
# port = input('please input database port:')
# user = input('please input database user:')
# password = input('please input database password:')
# print('------------------------------------')
try:
    conn = pymysql.connect(host=host, port=int(port), user=user, password=password)

    print('create database...')
    cur = conn.cursor()
    cur.execute('create database if not exists book')
    print('database created done.')
    print('------------------------------------')
    conn.select_db('book')

    print('create user table...')
    cur.execute("CREATE TABLE IF NOT EXISTS user ("
                "id varchar(50) PRIMARY KEY,"
                "username varchar(255),"
                "password varchar(255),"
                "role int(11),"
                "create_time datetime,"
                "delete_flag int(11),"
                "current_login_time datetime)")
    print('user table created done.')
    print('------------------------------------')

    print('create book table...')
    cur.execute("CREATE TABLE IF NOT EXISTS book("
                "id varchar(50) PRIMARY KEY,"
                "book_name varchar(255),"
                "author varchar(255),"
                "publish_company varchar(255),"
                "store_number int(11),"
                "borrow_number int(11),"
                "create_time datetime,"
                "publish_date date)")
    print('book table created done.')
    print('------------------------------------')

    print('create borrow_info table...')
    cur.execute("CREATE TABLE IF NOT EXISTS borrow_info ("
                "id varchar(50) PRIMARY KEY,"
                "book_id varchar(50),"
                "book_name varchar(255),"
                "borrow_user varchar(255),"
                "borrow_num int(11),"
                "borrow_days int(11),"
                "borrow_time datetime,"
                "return_time datetime,"
                "return_flag int(11))")
    print('borrow_info table created done.')
    print('------------------------------------')

    print('create message table...')
    cur.execute("create table if not exists message ("
                "id varchar(50) PRIMARY KEY,"
                "sender_name varchar(255) NOT NULL,"
                "receiver_name varchar(255) NOT NULL,"
                "send_content varchar(255) NOT NULL,"
                "send_time datetime,"
                "is_replied int(11),"
                "reply_content varchar(255),"
                "reply_time datetime)")
    print('message table created done.')
    print('-'*30)
    print('operate done.')
    print('create database successfully.')
except Exception as e:
    print('the require information of database is correct, please check it and retry.')
    print(e.args)
    traceback.print_exc()
    print('create database failed.')

print('Is insert some sample data into the database?')
print('1. insert')
print('2. exit')
insert_tag = input('please select the option:')
if insert_tag == '1':
    # 新建两个用户，管理员admin和普通用户张三
    print('------------------------------------')
    print('starting the insert data operation...')
    admin_data = ['12644064935811ea9063d8c497639e37', 'admin', '21232f297a57a5a743894a0e4a801fc3', 0,
                  '2021-06-06 15:23:12', 0, '2020-06-06 15:24:23']
    user_data = ['99477a9e935811ea8171d8c497639e37', 'zhangsan', 'e10adc3949ba59abbe56e057f20f883e', 1,
                 '2020-06-06 15:23:12', 0, '2020-06-06 15:24:23']
    sql = 'insert into user (id, username, password, role, create_time, delete_flag, current_login_time) values(%s,%s,'\
          '%s,%s,%s,%s,%s)'
    cur.execute(sql, admin_data)
    cur.execute(sql, user_data)
    conn.commit()
    cur.close()
    conn.close()
    print('insert operation done.')
    print('------------------------------------')
    print('Now you can use admin account login with username="admin" password="admin" or use the normal account login'
          'with username="zhangsan" password="123456".')
else:
    print('system exit.')
