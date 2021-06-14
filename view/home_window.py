"""
文件名：home_window.py
描述：主页
"""

from threading import Thread
from PyQt5.QtCore import pyqtSignal, Qt
from PyQt5.QtGui import QIcon
from PyQt5.QtWidgets import QWidget, QApplication, QHeaderView, QAbstractItemView, QTableWidgetItem, QMessageBox, QMenu, \
    QAction
from ui.home_window import Ui_Form
from util.dbutil import DBHelp
from util.common_util import SYS_STYLE, msg_box, accept_box, DELETE_ICON, get_uuid, \
    get_current_time, MESSAGE_STATUS_MAP
from view.annoucement_window import AnnouceWindow
import sys
import traceback


class HomeWindow(Ui_Form, QWidget):
    init_annouce_done_signal = pyqtSignal(list)

    def __init__(self, user_role=None):
        super(HomeWindow, self).__init__()
        self.setupUi(self)
        self.user_role = user_role
        self.add_annou_win = None
        self.init_ui()
        self.get_annouce_info()

        self.init_annouce_done_signal.connect(self.show_annouce)  # 信号槽,显示公告
        # print('8888')
        self.add_annou_pushButton.clicked.connect(self.add_annou)
        self.refresh_pushButton.clicked.connect(self.get_annouce_info)

    def init_ui(self):
        self.annou_info_tableWidget.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)  # 所有列自动拉伸，充满界面
        self.annou_info_tableWidget.setEditTriggers(QAbstractItemView.NoEditTriggers)  # 设置不可编辑
        self.book_recommend_tableWidget.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)  # 所有列自动拉伸，充满界面
        self.book_recommend_tableWidget.setEditTriggers(QAbstractItemView.NoEditTriggers)  # 设置不可编辑

        self.add_annou_pushButton.setProperty('class', 'Aqua')
        self.add_annou_pushButton.setMinimumWidth(60)
        self.refresh_pushButton.setVisible(False)
        if self.user_role == '普通用户':
            self.add_annou_pushButton.setVisible(False)


    def show_annouce(self,annouce_info_result):
        """
        将数据显示到页面上
        :param db:
        :param res:
        :return:
        """
        # print('\n33333\n')
        # 先把原来显示的公告信息删除
        for i in range(self.annou_info_tableWidget.rowCount()):
            self.annou_info_tableWidget.removeRow(0)

        count, res = annouce_info_result[0],annouce_info_result[1]

        self.totol_annouce_label.setText('本图书馆共有公告' + str(count) + '条')

        for record in res:
            self.annou_info_tableWidget.insertRow(self.annou_info_tableWidget.rowCount())
            # self.annouce_info_id.append(record[0])
            for i in range(1,4):
                item = QTableWidgetItem(str(record[i]))
                item.setTextAlignment(Qt.AlignVCenter | Qt.AlignHCenter)
                self.annou_info_tableWidget.setItem(self.annou_info_tableWidget.rowCount() - 1, i-1, item)

    def add_annou(self):
        '''
        添加公告槽函数，跳出窗口
        :return:
        '''
        self.add_annou_win = AnnouceWindow()
        self.add_annou_win.annouce_don_signal.connect(self.add_annou_done)
        self.add_annou_win.show()

    def add_annou_done(self):
        '''
        发公告按钮点击结束,启动刷新按钮
        :return:
        '''
        self.refresh_pushButton.click()

    def get_annouce_info(self):
        '''
        线程，一直监听是否有新的数据
        :return:
        '''
        th = Thread(target=self.annouce_info_th)
        th.start()

    def annouce_info_th(self):
        '''
        获取公告信息，并发出信号
        :return:
        '''
        db = DBHelp()
        count, res = db.query_annouce()

        self.init_annouce_done_signal.emit([count, res])
        # print(res)
        # return count, res


if __name__ == '__main__':
    try:
        app = QApplication(sys.argv)
        win = HomeWindow('管理员')
        win.show()
        sys.exit(app.exec())
    except Exception as e:
        print(e.args)
        traceback.print_exc()
