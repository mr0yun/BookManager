"""
文件名：borrow_info_window.py
描述：借阅信息窗口
"""

from threading import Thread
from PyQt5.QtCore import pyqtSignal, Qt
from PyQt5.QtGui import QColor, QIcon
from PyQt5.QtWidgets import QWidget, QHeaderView, QAbstractItemView, QTableWidgetItem, QMessageBox, QMenu, QAction
from ui.book_borrow_info_window import Ui_Form
from util.dbutil import DBHelp
from util.common_util import BORROW_STATUS_MAP, SYS_STYLE, SEARCH_CONTENT_MAP, msg_box, RETURN, DELAY_TIME, accept_box, \
    DELETE_ICON, PUSH_RETURN, get_current_time, get_uuid
from view.renew_window import RenewWindow
import traceback


class BorrowInfoWindow(Ui_Form, QWidget):
    #自定义信号
    init_data_done_signal = pyqtSignal(list)
    return_book_done_signal = pyqtSignal()

    def __init__(self, user_role=None, username=None):
        super(BorrowInfoWindow, self).__init__()
        self.setupUi(self)
        self.user_role = user_role
        self.username = username
        self.renew_win = None
        self.borrow_info_list = list()
        self.init_data_done_signal.connect(self.show_info)#初始化时信号槽，显示信息
        self.refresh_pushButton.clicked.connect(self.init_data)#信号槽，刷新按钮
        self.search_borrow_user_pushButton.clicked.connect(self.search_borrow_info)#信号槽连接，搜索按钮
        self.tableWidget.setContextMenuPolicy(Qt.CustomContextMenu)#设置右击菜单
        self.tableWidget.customContextMenuRequested.connect(self.generate_menu)
        self.return_flag = []#归还状态
        self.borrow_info_id = []
        self.init_ui()
        self.init_data()

    def generate_menu(self, pos):
        """
        借阅信息书籍列表界面，针对不同角色生成不同菜单
        :param pos:
        :return:
        """
        row_num = -1
        for i in self.tableWidget.selectionModel().selection().indexes():
            row_num = i.row()
        if row_num == -1:
            return
        if self.user_role == '普通用户':
            menu = QMenu()
            return_action = QAction(u'还书')
            return_action.setIcon(QIcon(RETURN))
            menu.addAction(return_action)

            delay_borrow_action = QAction(u'续借')
            delay_borrow_action.setIcon(QIcon(DELAY_TIME))
            menu.addAction(delay_borrow_action)

            # 如果当前条目为已还则菜单栏为不可点击状态
            if self.return_flag[row_num] == 1:
                return_action.setEnabled(False)
                delay_borrow_action.setEnabled(False)
            action = menu.exec_(self.tableWidget.mapToGlobal(pos))

            if action == return_action:
                if accept_box(self, '提示', '确实归还当前书本吗？') == QMessageBox.Yes:
                    th = Thread(target=self.return_book, args=(self.borrow_info_id[row_num],))
                    th.start()

            if action == delay_borrow_action:
                self.renew_win = RenewWindow(borrow_id=self.borrow_info_id[row_num])
                self.renew_win.show()
        else:
            menu = QMenu()
            del_record_action = QAction(u'删除记录')
            del_record_action.setIcon(QIcon(DELETE_ICON))
            menu.addAction(del_record_action)

            ask_return_action = QAction(u'催还')
            ask_return_action.setIcon(QIcon(PUSH_RETURN))
            menu.addAction(ask_return_action)

            # 根据是否已经归还来判断菜单是否为可点击状态
            if self.return_flag[row_num] == 1:
                ask_return_action.setEnabled(False)
            else:
                del_record_action.setEnabled(False)

            action = menu.exec_(self.tableWidget.mapToGlobal(pos))

            if action == del_record_action:
                rep = accept_box(self, '警告', '确定删除该条记录吗?')
                if rep == QMessageBox.Yes:
                    # 删除该信息
                    db = DBHelp()
                    db.delete(table_name='borrow_info', column_name='id', condition=self.borrow_info_id[row_num])
                    db.db_commit()
                    db.instance = None
                    del db
                    self.refresh_pushButton.click()
                    msg_box(self, '提示', '删除记录操作成功!')

            if action == ask_return_action:
                # 催还时所做措施（发消息？）
                try:
                    username = self.tableWidget.item(row_num, 0).text()
                    bookname = self.tableWidget.item(row_num, 1).text()
                    print(username, " ", bookname)
                    content = "亲爱的" + username + "同学，你借的书籍《" + bookname + \
                                      "》未还。请尽快还书，如逾期未还你的账号可能被冻结。"
                    db = DBHelp()
                    db.insert_message_info([get_uuid(), self.username, username,
                                            content, get_current_time(), 2])
                    db.db_commit()
                    db.instance = None
                    del db
                    msg_box(self, '提示', '催还成功!')
                except Exception as e:
                    print(e.args)
                    traceback.print_exc()

    def return_book(self, borrow_id):
        """
        归还图书，更新借还状态
        :param borrow_id:
        :return:
        """
        db = DBHelp()
        db.update_borrow_statue(borrow_id)
        db.db_commit()
        db.instance = None
        del db
        self.init_data()

    def search_borrow_info(self):
        """
        搜索框依据搜索类型和输入内容查询数据库
        :return:
        """
        if self.borrow_user_search_lineEdit.text() == '':
            msg_box(self, '提示', '请输入需要搜索的内容!')
            return
        if self.user_role == '管理员':
            search_type = self.comboBox.currentText()
            search_content = self.borrow_user_search_lineEdit.text()
            db = DBHelp()
            count, res = db.query_super(table_name='borrow_info', column_name=SEARCH_CONTENT_MAP.get(search_type),
                                        condition=search_content)
            if count == 0:
                msg_box(widget=self, title='提示', msg='未找到相关记录!')
                return
            self.get_data_from_database(db, res=res)

    def init_ui(self):
        """
        初始化ui界面
        :return:
        """
        self.setWindowFlags(Qt.WindowCloseButtonHint)
        self.setStyleSheet(SYS_STYLE)
        self.refresh_pushButton.setProperty('class', 'Aqua')
        self.search_borrow_user_pushButton.setProperty('class', 'Aqua')
        self.refresh_pushButton.setMinimumWidth(60)
        self.search_borrow_user_pushButton.setMinimumWidth(60)
        self.tableWidget.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)#所有列自动拉伸，充满界面
        self.tableWidget.setEditTriggers(QAbstractItemView.NoEditTriggers)#设置不可在界面编辑

    def init_data(self):
        self.borrow_user_search_lineEdit.clear()#初始化时使搜索文本清空
        th = Thread(target=self.book_info_th)
        th.start()

    def show_info(self, infos):
        """
        显示信息
        :param infos:
        :return:
        """
        for i in range(self.tableWidget.rowCount()):
            self.tableWidget.removeRow(0)
        for info in infos:
            self.tableWidget.insertRow(self.tableWidget.rowCount())
            current_time = get_current_time()
            color = '#A8F5AC'  # 绿色
            if info[7] == '未还':
                if info[6] < current_time:
                    # 逾期未还
                    color = '#FF7E57'  # 红色
                    info[7] = '逾期'
                else:
                    color = '#F9F9CD'  # 淡黄色

            for i in range(len(info)):
                item = QTableWidgetItem(str(info[i]))
                if i == 7:
                    item.setBackground(QColor(color))
                item.setTextAlignment(Qt.AlignVCenter | Qt.AlignHCenter)
                self.tableWidget.setItem(self.tableWidget.rowCount() - 1, i, item)

    def book_info_th(self):
        """
        书本信息线程槽函数，使得用户和管理员显示的借阅界面不同，用户只显示自己借的，管理员显示所有
        :return:
        """
        if self.user_role == '管理员':
            db = DBHelp()
            count, res = db.query_all(table_name='borrow_info')
            self.get_data_from_database(db, res)
        else:
            # 普通用户只显示自己的借阅记录
            db = DBHelp()
            count, res = db.query_super(table_name='borrow_info', column_name='borrow_user', condition=self.username)
            self.get_data_from_database(db, res)

    def get_data_from_database(self, db, res):
        """
        从数据库中读取数据，并分列组合成要显示的数据
        :param db:
        :param res:
        :return:
        """
        self.return_flag = []
        self.borrow_info_id = []
        self.borrow_info_list.clear()
        for record in res:
            book_id = record[1]
            self.borrow_info_id.append(record[0])
            count, book_info = db.query_super(table_name='book', column_name='id', condition=book_id)
            sub_info = [record[3], record[2], book_info[0][3], book_info[0][-1], record[4], str(record[6]),
                        str(record[7]), BORROW_STATUS_MAP.get(str(record[-1]))]
            self.return_flag.append(record[-1])
            self.borrow_info_list.append(sub_info)
        self.init_data_done_signal.emit(self.borrow_info_list)
