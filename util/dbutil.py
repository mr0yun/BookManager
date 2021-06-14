"""
文件名：dbutil.py
描述：数据库辅助类，封装了Mysql数据库的连接以及相应的增删改查操作
注意事项：检查数据库连接参数是否正确
"""

import pymysql


class DBHelp:
    instance = None

    def __init__(self, host='127.0.0.1', port=3306, user='root', pwd='wp20000206', db='book', charset='utf8'):
        self._conn = pymysql.connect(host=host, port=port, user=user, passwd=pwd, db=db, charset=charset)
        self._cur = self._conn.cursor()

    @classmethod
    def get_instance(cls):
        if cls.instance:
            return cls.instance
        else:
            cls.instance = DBHelp()
            return cls.instance

    # 查询指定表所有列所有记录
    def query_all(self, table_name):
        sql = 'select * from {}'.format(table_name)
        count = self._cur.execute(sql)
        res = self._cur.fetchall()
        return count, res

    # 按条件查询指定表的指定列
    def query_super(self, table_name, column_name, condition):
        sql = "select * from {} where {}='{}'".format(table_name, column_name, condition)
        count = self._cur.execute(sql)
        res = self._cur.fetchall()
        return count, res

    # 用户注册，往user表中插入1条记录
    def add_user(self, data):
        sql = "insert into user (id, username, password, role, create_time, delete_flag, current_login_time) " \
              "values (%s, %s, %s, %s, %s, %s, %s)"
        self._cur.execute(sql, data)

    # 新建书籍，往book表中插入1条记录
    def add_book(self, data):
        sql = "insert into book (id, book_name,author,publish_company,store_number,borrow_number,create_time," \
              "publish_date) values (%s, %s, %s, %s, %s, %s, %s, %s)"
        self._cur.execute(sql, data)

    # 管理员修改图书信息
    def update_super(self, table_name, column_name, condition, data):
        sql = "update {} set book_name='{}', author='{}', publish_company='{}',  publish_date='{}', store_number={}" \
              " where {}='{}'".format(table_name, data[0], data[1], data[2], data[3], data[4], column_name, condition)
        self._cur.execute(sql)

    # 按条件删除指定表的指定行
    def delete(self, table_name, column_name, condition):
        sql = "delete from {} where {}='{}'".format(table_name, column_name, condition)
        self._cur.execute(sql)

    # 借书后自动修改该书籍的库存数量和借出数量
    def update_borrow(self, book_id):
        sql = "update book set store_number=store_number-1 where id='{}'".format(book_id)
        self._cur.execute(sql)
        sql = "update book set borrow_number=borrow_number+1 where id='{}'".format(book_id)
        self._cur.execute(sql)

    # 还书后自动修改该书籍的库存数量和借出数量
    def update_borrow_return(self, book_id):
        sql = "update book set store_number=store_number+1 where id='{}'".format(book_id)
        self._cur.execute(sql)
        sql = "update book set borrow_number=borrow_number-1 where id='{}'".format(book_id)
        self._cur.execute(sql)

    # 还书后修改读者的借书状态为“已还”
    def update_borrow_statue(self, book_id):
        sql = "update borrow_info set return_flag=1 where id='{}'".format(book_id)
        self._cur.execute(sql)

    # 有人借书，往borrow_info中插入1条记录
    def insert_borrow_info(self, data):
        sql = "insert into borrow_info (id, book_id, book_name, borrow_user, borrow_num, borrow_days, borrow_time," \
              "return_time, return_flag) values (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
        self._cur.execute(sql, data)

    # 续借书籍时修改应还日期
    def update_renew(self, data):
        sql = "update borrow_info set borrow_days=borrow_days+{}, return_time='{}' where id='{}'".format(data[0],
                                                                                                        data[1],
                                                                                                        data[2])
        self._cur.execute(sql)

    # 新增消息，往message表中插入1条记录
    def insert_message_info(self, data):
        sql = "insert into message (id , sender_name, receiver_name, send_content, send_time, is_replied) values(%s, %s, %s, %s, %s, %s)"
        self._cur.execute(sql, data)

    # 回复消息
    def update_message_info(self, data):
        sql = "update message set is_replied=1, reply_content='{}', reply_time='{}' where id='{}'".format(data[0],
                                                                                                          data[1],
                                                                                                          data[2])
        self._cur.execute(sql)

    # 删除消息
    def del_message_info(self, id):
        sql = "delete from message where id = '{}'".format(id)
        self._cur.execute(sql)

    # 按发送时间倒序查询消息
    def query_message_super(self, column_name, condition):
        sql = "select * from message where {}='{}' order by send_time desc".format(column_name, condition)
        count = self._cur.execute(sql)
        res = self._cur.fetchall()
        return count, res

    # 查询用户发送和接收的消息
    def query_user_message(self, username):
        sql = "select * from message where sender_name='{}' or receiver_name='{}' order by send_time desc".format(username, username)
        count = self._cur.execute(sql)
        res = self._cur.fetchall()
        return count, res


    #将公告插入数据库
    def insert_annouce_info(self, data):
        sql = "insert into annoucement (id ,annouce_title, annouce_content, annouce_time) values(%s, %s, %s, %s)"
        self._cur.execute(sql, data)


    def update_annouce_info(self, data):
        sql = "update annoucement set is_replied=1, reply_content='{}', reply_time='{}' where id='{}'".format(data[0],
                                                                                                          data[1],
                                                                                                          data[2])
        self._cur.execute(sql)



    def del_annouce_info(self, id):
        sql = "delete from annoucement where id = '{}'".format(id)
        self._cur.execute(sql)



    def query_annouce(self):
        sql = "select * from annoucement  order by annouce_time desc"
        count = self._cur.execute(sql)
        res = self._cur.fetchall()
        return count, res





    # 提交事务
    def db_commit(self):
        self._conn.commit()

    # 回滚事务
    def db_rollback(self):
        self._conn.rollback()
