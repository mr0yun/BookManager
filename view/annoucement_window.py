"""
文件名：annoucement.py
描述：发布公告窗口
"""

from PyQt5.QtCore import Qt, pyqtSignal
from PyQt5.QtGui import QIcon
from PyQt5.QtWidgets import QWidget, QApplication
from ui.annouce_window import Ui_Form
from util.common_util import msg_box, get_current_time, APP_ICON, SYS_STYLE,get_uuid
from util.dbutil import DBHelp
import sys
import traceback


class AnnouceWindow(Ui_Form, QWidget):
    annouce_don_signal = pyqtSignal()#自定义信号

    def __init__(self):
        super(AnnouceWindow, self).__init__()
        self.setupUi(self)
        self.setWindowModality(Qt.ApplicationModal)
        self.setWindowFlags(Qt.WindowCloseButtonHint)
        self.setWindowTitle('发布公告')
        self.cancel_pushButton.setMinimumWidth(60)
        self.send_pushButton.setMinimumWidth(60)
        self.send_pushButton.clicked.connect(self.send_annouce)  # 发送按钮按下之后，启动内置槽函数
        self.setWindowIcon(QIcon(APP_ICON))
        self.send_pushButton.setProperty('class', 'Aqua')
        self.cancel_pushButton.clicked.connect(self.cancel) # 取消按钮按下之后，启动内置槽函数
        self.cancel_pushButton.setProperty('class', 'Aqua')
        self.setStyleSheet(SYS_STYLE)

    def send_annouce(self):
        """
        获取输入并检查后将其插入数据库
        :return:
        """
        try:
            annouce_content = self.textEdit.toPlainText()
            annouce_title=self.annouce_title_lineEdit.text()
            if  annouce_title == '':
                msg_box(self, '错误', '请输入公告标题!')
                return
            if annouce_content == '' :
                msg_box(self, '错误', '请输入公告内容!')
                return

            db = DBHelp()
            db.insert_annouce_info([get_uuid(),annouce_title,annouce_content, get_current_time()])
            db.db_commit()
            db.instance = None
            del db
            self.annouce_don_signal.emit() #条件满足时发出回复完成的信号
            self.close()
            msg_box(self, '提示', '发布成功!')
        except Exception as e:
            print(e.args)
            traceback.print_exc()


    def cancel(self):
        self.close()

if __name__ == '__main__':
    app = QApplication(sys.argv)
    win = AnnouceWindow()
    win.show()
    sys.exit(app.exec())