"""
文件名：message_info_window.py
描述：用户消息信息窗口
"""

from threading import Thread
from PyQt5.QtCore import pyqtSignal, Qt
from PyQt5.QtGui import QIcon
from PyQt5.QtWidgets import QWidget, QApplication, QHeaderView, QAbstractItemView, QTableWidgetItem, QMessageBox, QMenu, QAction
from ui.message_info_user_window import Ui_Form
from util.dbutil import DBHelp
from util.common_util import SYS_STYLE, msg_box, accept_box, DELETE_ICON, get_uuid,\
    get_current_time, MESSAGE_STATUS_MAP
import sys
import traceback


class MessageInfoUserWindow(Ui_Form, QWidget):
    # 自定义信号
    init_data_done_signal = pyqtSignal(list)

    def __init__(self, user_role=None, username=None):
        super(MessageInfoUserWindow, self).__init__()
        self.setupUi(self)
        self.user_role = user_role
        self.username = username
        self.reply_win = None
        self.message_info_list = list()

        self.init_data_done_signal.connect(self.show_info)  # 初始化时信号槽，显示信息
        self.send_pushButton.clicked.connect(self.send_message)  # 信号槽，刷新按钮
        self.refresh_pushButton.clicked.connect(self.init_data)

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
        self.send_pushButton.setProperty('class', 'Aqua')
        self.send_pushButton.setMinimumWidth(60)
        self.tableWidget.setContextMenuPolicy(Qt.CustomContextMenu)  # 设置右击菜单
        self.tableWidget.customContextMenuRequested.connect(self.generate_menu)
        self.tableWidget.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)  # 所有列自动拉伸，充满界面
        self.tableWidget.setEditTriggers(QAbstractItemView.NoEditTriggers)  # 设置不可在界面编辑

    def init_data(self):
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
        del_action = QAction(u'删除')
        del_action.setIcon(QIcon(DELETE_ICON))
        menu.addAction(del_action)
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
        # 普通用户只显示自己发的消息
        db = DBHelp()
        count, res = db.query_user_message(self.username)
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

    def send_message(self):
        """
        用户向管理员发送消息
        :return:
        """
        try:
            content = self.message_lineEdit.text()
            if content == '':
                msg_box(self, '错误', '请输入回复内容!')
                return

            db = DBHelp()
            db.insert_message_info([get_uuid(), self.username, 'admin',
                                    content, get_current_time(), 0])
            db.db_commit()
            db.instance = None
            del db
            self.message_lineEdit.clear()  # 初始化时使搜索文本清空
            self.refresh_pushButton.click()
            msg_box(self, '提示', '发送成功!')

        except Exception as e:
            print(e.args)
            traceback.print_exc()

if __name__ == '__main__':
    try:
        app = QApplication(sys.argv)
        win = MessageInfoUserWindow('普通用户', '1')
        win.show()
        sys.exit(app.exec())
    except Exception as e:
        print(e.args)
        traceback.print_exc()