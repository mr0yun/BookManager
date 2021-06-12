"""
文件名：message_info_window.py
描述：管理员消息信息窗口
"""

from threading import Thread
from PyQt5.QtCore import pyqtSignal, Qt
from PyQt5.QtGui import QIcon
from PyQt5.QtWidgets import QWidget, QApplication, QHeaderView, QAbstractItemView, QTableWidgetItem, QMessageBox, QMenu, QAction
from ui.message_info_window import Ui_Form
from util.dbutil import DBHelp
from util.common_util import SYS_STYLE, msg_box, accept_box, SEND_ICON, DELETE_ICON, MESSAGE_STATUS_MAP
from view.reply_window import ReplyWindow
import sys
import traceback



class MessageInfoWindow(Ui_Form, QWidget):
    #自定义信号
    init_data_done_signal = pyqtSignal(list)

    def __init__(self, user_role=None, username=None):
        super(MessageInfoWindow, self).__init__()
        self.setupUi(self)
        self.user_role = user_role
        self.username = username
        self.reply_win = None
        self.message_info_list = list()

        self.init_data_done_signal.connect(self.show_info)  # 初始化时信号槽，显示信息
        self.refresh_pushButton.clicked.connect(self.init_data)  # 信号槽，刷新按钮
        self.search_sender_pushButton.clicked.connect(self.search_message_info)  # 信号槽连接，搜索按钮
        self.noreply_pushButton.clicked.connect(self.search_noreply)


        self.reply_flag = []  # 回复状态
        self.message_info_id = []
        self.init_ui()
        self.init_data()

    def init_ui(self):
        """
        初始化ui界面
        :return:
        """
        self.setWindowFlags(Qt.WindowCloseButtonHint)
        self.setStyleSheet(SYS_STYLE)
        self.refresh_pushButton.setProperty('class', 'Aqua')
        self.search_sender_pushButton.setProperty('class', 'Aqua')
        self.noreply_pushButton.setProperty('class', 'Aqua')
        self.refresh_pushButton.setMinimumWidth(60)
        self.search_sender_pushButton.setMinimumWidth(60)
        self.noreply_pushButton.setMinimumWidth(60)
        self.tableWidget.setContextMenuPolicy(Qt.CustomContextMenu)  # 设置右击菜单
        self.tableWidget.customContextMenuRequested.connect(self.generate_menu)
        self.tableWidget.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)  # 所有列自动拉伸，充满界面
        self.tableWidget.setEditTriggers(QAbstractItemView.NoEditTriggers)  # 设置不可在界面编辑


    def init_data(self):
        self.sender_search_lineEdit.clear()  # 初始化时使搜索文本清空
        th = Thread(target=self.message_info_th)
        th.start()

    def generate_menu(self, pos):
        """
        消息列表界面，生成管理员右键菜单
        :param pos:
        :return:
        """
        row_num = -1
        for i in self.tableWidget.selectionModel().selection().indexes():
            row_num = i.row()
        if row_num == -1:
            return

        # 添加菜单
        menu = QMenu()
        reply_action = QAction(u'回复')
        reply_action.setIcon(QIcon(SEND_ICON))
        menu.addAction(reply_action)

        del_action = QAction(u'删除')
        del_action.setIcon(QIcon(DELETE_ICON))
        menu.addAction(del_action)

        # 根据是否回复来判断菜单是否为可点击状态
        if self.reply_flag[row_num] == 1:
            reply_action.setEnabled(False)
        else:
            del_action.setEnabled(False)
        action = menu.exec_(self.tableWidget.mapToGlobal(pos))

        if action == del_action:
            rep = accept_box(self, '警告', '确定删除该条消息吗?')
            if rep == QMessageBox.Yes:
                db = DBHelp()
                db.delete(table_name='message', column_name='id', condition=self.message_info_id[row_num])
                db.db_commit()
                db.instance = None
                del db
                self.refresh_pushButton.click()
                msg_box(self, '提示', '删除消息操作成功!')

        if action == reply_action:
            try:
                self.reply_win = ReplyWindow(self.message_info_id[row_num])
                self.reply_win.reply_don_signal.connect(self.reply_done)
                self.reply_win.show()
            except Exception as e:
                print(e.args)
                traceback.print_exc()


    def search_message_info(self):
        """
        搜索框依据搜索类型和输入内容查询数据库
        :return:
        """
        if self.sender_search_lineEdit.text() == '':
            msg_box(self, '提示', '请输入需要搜索的内容!')
            return
        search_content = self.sender_search_lineEdit.text()
        db = DBHelp()
        count, res = db.query_super(table_name='message', column_name='sender_name',
                                    condition=search_content)
        if count == 0:
            msg_box(widget=self, title='提示', msg='未找到相关记录!')
            return
        self.get_data_from_database(res=[count, res])

    def search_noreply(self):
        """
        搜索未回复的消息
        :return:
        """
        db = DBHelp()
        count, res = db.query_message_super(column_name='is_replied', condition=0)
        if count == 0:
            msg_box(widget=self, title='提示', msg='不存在未回复的消息!')
            return
        self.get_data_from_database(res=[count, res])

    def show_info(self, infos):
        """
        显示信息
        :param infos:
        :return:
        """
        for i in range(self.tableWidget.rowCount()):
            self.tableWidget.removeRow(0)
        count = infos[0]
        self.message_total_label.setText('您共有' + str(count) + '条消息')
        message_info = infos[1]
        for info in message_info:
            self.tableWidget.insertRow(self.tableWidget.rowCount())
            for i in range(len(info)):
                item = QTableWidgetItem(str(info[i]))
                item.setTextAlignment(Qt.AlignVCenter | Qt.AlignHCenter)
                self.tableWidget.setItem(self.tableWidget.rowCount() - 1, i, item)

    def message_info_th(self):
        """
        消息信息线程槽函数，使得用户和管理员显示的借阅界面不同，用户只显示自己发出的，管理员显示所有
        :return:
        """
        db = DBHelp()
        count, res = db.query_message_super(column_name='receiver_name', condition=self.username)
        self.get_data_from_database([count, res])

    def get_data_from_database(self, res):
        """
        从数据库中读取数据，并分列组合成要显示的数据
        :param db:
        :param res:
        :return:
        """
        self.reply_flag = []
        self.message_info_id = []
        self.message_info_list.clear()
        for record in res[1]:
            self.message_info_id.append(record[0])
            self.reply_flag.append(record[-3])
            sub_info = [record[1]]
            for re in record[3:-3]:
                sub_info.append(re)
            sub_info.append(MESSAGE_STATUS_MAP.get(str(record[-3])))
            for re in record[-2:]:
                sub_info.append(re)
            self.message_info_list.append(sub_info)
        self.init_data_done_signal.emit([res[0], self.message_info_list])

    def reply_done(self):
        self.refresh_pushButton.click()

if __name__ == '__main__':
    try:
        app = QApplication(sys.argv)
        win = MessageInfoWindow('管理员', 'admin')
        win.show()
        sys.exit(app.exec())
    except Exception as e:
        print(e.args)
        traceback.print_exc()