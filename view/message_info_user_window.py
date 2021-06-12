"""
文件名：message_info_window.py
描述：用户消息信息窗口
"""

from threading import Thread
from PyQt5.QtCore import pyqtSignal, Qt
from PyQt5.QtGui import QColor, QIcon
from PyQt5.QtWidgets import QWidget, QHeaderView, QAbstractItemView, QTableWidgetItem, QMessageBox, QMenu, QAction
from ui.message_info_user_window import Ui_Form
from util.dbutil import DBHelp
from util.common_util import BORROW_STATUS_MAP, SYS_STYLE, SEARCH_CONTENT_MAP, msg_box, RETURN, DELAY_TIME, accept_box, \
    SEND_ICON, DELETE_ICON, get_current_time


class MessageInfoUserWindow:
    #自定义信号
    init_data_done_signal = pyqtSignal(list)
    return_book_done_signal = pyqtSignal()

    def __init__(self, user_role=None, username=None):
        super(MessageInfoUserWindow, self).__init__()
        self.setupUi(self)
        self.user_role = user_role
        self.username = username
        self.reply_win = None
        self.message_info_list = list()
        self.init_data_done_signal.connect(self.show_info)  # 初始化时信号槽，显示信息
        self.refresh_pushButton.clicked.connect(self.init_data)  # 信号槽，刷新按钮
        self.search_borrow_user_pushButton.clicked.connect(self.search_borrow_info)  # 信号槽连接，搜索按钮
        self.tableWidget.setContextMenuPolicy(Qt.CustomContextMenu)  # 设置右击菜单
        self.tableWidget.customContextMenuRequested.connect(self.generate_menu)
        self.reply_flag = []  # 归还状态
        self.borrow_info_id = []
        self.init_ui()
        self.init_data()