"""
文件名：main_window.py
描述：实现主窗口的交互
"""

from PyQt5.QtGui import QIcon
from PyQt5.QtWidgets import QMainWindow, QMessageBox
from ui.main_window import Ui_MainWindow
from util.common_util import ROLE_MAP, APP_ICON, SYS_STYLE
from view.home_window import HomeWindow
from view.book_manage_window import BookManageWindow
from view.borrow_info_window import BorrowInfoWindow
from view.about_window import AboutWindow
from view.message_info_window import MessageInfoWindow
from view.message_info_user_window import MessageInfoUserWindow


class MainWindow(Ui_MainWindow, QMainWindow):

    def __init__(self, login=None, username=None, role=None):
        super(MainWindow, self).__init__()
        self.setupUi(self)
        self.is_change_user = False#进入主页之后，用户不是登出状态
        self.username = username
        self.login_win = login
        self.role = ROLE_MAP.get(str(role))#获取用户的角色是管理员还是普通用户
        self.init_slot()
        self.init_ui()

    def init_ui(self):
        self.pushButton.setProperty('class', 'Aqua')
        self.pushButton.setMinimumWidth(60)
        self.setStyleSheet(SYS_STYLE)
        self.setWindowIcon(QIcon(APP_ICON))
        self.setWindowTitle('NCU图书管理系统')
        self.listWidget.setCurrentRow(0)#默认选中当前为主页
        self.current_username_label.setText(self.username)
        self.current_role_label.setText(self.role)
        self.stackedWidget.removeWidget(self.page)#将布局器中拖的两页删除，然后自己新加了三页0,1,2
        self.stackedWidget.removeWidget(self.page_2)
        self.stackedWidget.addWidget(HomeWindow(user_role=self.role))
        self.stackedWidget.addWidget(BorrowInfoWindow(user_role=self.role, username=self.username))
        self.stackedWidget.addWidget(BookManageWindow(self.role, self.username))
        if self.role == '管理员':
            self.stackedWidget.addWidget(MessageInfoWindow(user_role=self.role, username=self.username))
        else:
            self.stackedWidget.addWidget(MessageInfoUserWindow(user_role=self.role, username=self.username))
        self.stackedWidget.addWidget(AboutWindow())

    def init_slot(self):
        """
        主窗口信号槽连接
        :return:
        """
        self.listWidget.currentItemChanged.connect(self.item_changed)#当左侧导航发生改变时，进行连接右侧stacked窗口
        self.pushButton.clicked.connect(self.log_out)

    def item_changed(self):
        """
        与list导航窗口进行同步右侧显示stacked窗口
        :return:
        """
        self.stackedWidget.setCurrentIndex(self.listWidget.currentRow())

    def log_out(self):
        """
        登出时设置用户是否登出状态
        :return:
        """
        self.is_change_user = True
        self.close()

    def closeEvent(self, event):
        """
        登出时提示语，健壮性处理
        :param event:
        :return:
        """
        if self.is_change_user:
            reply = QMessageBox.question(self, '消息', '确定退出当前账号吗?',
                                         QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
        else:
            reply = QMessageBox.question(self, '消息', '确定退出系统吗?',
                                         QMessageBox.Yes | QMessageBox.No, QMessageBox.No)
        if reply == QMessageBox.Yes:
            event.accept()
            if self.is_change_user:
                self.login_win.show()
        else:
            event.ignore()
            self.is_change_user = False
