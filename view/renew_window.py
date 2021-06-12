"""
文件名：renew_window.py
描述：书籍续借
"""

from threading import Thread
from PyQt5.QtCore import Qt, pyqtSignal
from PyQt5.QtGui import QIcon
from PyQt5.QtWidgets import QWidget, QApplication
import sys
from ui.renew_window import Ui_Form
from util.common_util import SYS_STYLE, APP_ICON, msg_box, PATTERS, set_le_reg
from util.dbutil import DBHelp
import datetime


class RenewWindow(Ui_Form, QWidget):
    renew_done_signal = pyqtSignal(int)#自定义信号

    def __init__(self, borrow_id=None):
        super(RenewWindow, self).__init__()
        self.setupUi(self)
        self.borrow_id = borrow_id
        self.setStyleSheet(SYS_STYLE)
        self.renew_done_signal.connect(self.renew_done)#信号槽连接，续借
        self.setWindowFlags(Qt.WindowCloseButtonHint)
        self.setWindowModality(Qt.ApplicationModal)
        self.renew_pushButton.setProperty('class', 'Aqua')
        self.renew_pushButton.setMinimumWidth(55)
        self.setWindowTitle('书籍续借')
        self.setWindowIcon(QIcon(APP_ICON))
        self.renew_pushButton.clicked.connect(self.renew)
        self.renew_days_lineEdit.textChanged.connect(self.modify_return_date)#信号槽连接，当续借日子改变时，使得对应的日期发生改变
        self.origin_return_time = None
        self.origin_borrow_day = 0
        set_le_reg(widget=self, le=self.renew_days_lineEdit, pattern=PATTERS[0])#给控件添加正则表达式匹配，限制输入，PATTERS = ['^[0-9]{1,2}$']
        th = Thread(target=self.init_data())
        th.start()

    def init_data(self):
        try:
            db = DBHelp()
            count, res = db.query_super(table_name='borrow_info', column_name='id', condition=self.borrow_id)
            self.origin_return_time = res[0][7]
            self.origin_borrow_day = res[0][5]
            self.book_name_label.setText('书籍《'+res[0][2]+'》续借')
            self.return_date_lineEdit.setText(str(res[0][7]))
            db.instance = None
            del db

        except:
            self.renew_done_signal.emit(0)

    def renew(self):
        if self.renew_days_lineEdit.text() == '':
            msg_box(self, '提示', '请输入续借的天数!')
            return
        try:
            th = Thread(target=self.execute_renew)
            th.start()
        except:
            import traceback
            traceback.print_exc()

    def execute_renew(self):
        """
        修改数据库中的归还日期
        :return:
        """
        try:
            day = int(self.renew_days_lineEdit.text())
            return_time = self.return_date_lineEdit.text()
            db = DBHelp()
            db.update_renew([day, return_time, self.borrow_id])
            db.db_commit()
            db.instance = None
            del db
            self.renew_done_signal.emit(1)
        except:
            self.renew_done_signal.emit(0)

    def modify_return_date(self):
        """
        修改显示日期的文本框的内容，为依据输入天数计算得出的日期
        :return:
        """
        if self.renew_days_lineEdit.text() == '':
            day = 0
        else:
            day = int(self.renew_days_lineEdit.text())
        self.return_date_lineEdit.setText(str(self.origin_return_time+datetime.timedelta(days=day)))

    def renew_done(self, tag):
        """
        是否续借成功
        :param tag:
        :return:
        """
        if tag:
            msg_box(self, '提示', self.book_name_label.text()+'成功!')
            self.close()
        else:
            msg_box(self, '提示', self.book_name_label.text()+'失败!')
            self.close()


# 测试
if __name__ == '__main__':
    app = QApplication(sys.argv)
    win = RenewWindow(borrow_id='53ee8f80b20d11ea9f9ed8c497639e37')
    win.show()
    sys.exit(app.exec_())
