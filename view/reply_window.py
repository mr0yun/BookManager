"""
文件名：reply_window.py
描述：回复消息窗口
"""

from PyQt5.QtCore import Qt, pyqtSignal
from PyQt5.QtGui import QIcon
from PyQt5.QtWidgets import QWidget, QApplication
from ui.reply_window import Ui_Form
from util.common_util import msg_box, get_current_time, APP_ICON, SYS_STYLE
from util.dbutil import DBHelp
import sys
import traceback


class ReplyWindow(Ui_Form, QWidget):
    reply_don_signal = pyqtSignal()#自定义信号

    def __init__(self, message_id):
        super(ReplyWindow, self).__init__()
        self.message_id = message_id
        self.setupUi(self)
        self.setWindowModality(Qt.ApplicationModal)
        self.setWindowFlags(Qt.WindowCloseButtonHint)
        self.setWindowTitle('回复用户')
        self.send_pushButton.clicked.connect(self.reply)  # 发送按钮按下之后，启动内置槽函数
        self.setWindowIcon(QIcon(APP_ICON))
        self.send_pushButton.setProperty('class', 'Aqua')
        self.cancel_pushButton.clicked.connect(self.cancel)
        self.cancel_pushButton.setProperty('class', 'Aqua')
        self.setStyleSheet(SYS_STYLE)

    def reply(self):
        """
        获取输入并检查后将其插入数据库
        :return:
        """
        try:
            reply_content = self.textEdit.toPlainText()
            if reply_content == '':
                msg_box(self, '错误', '请输入回复内容!')
                return

            db = DBHelp()
            db.update_message_info([reply_content, get_current_time(), self.message_id])
            db.db_commit()
            db.instance = None
            del db
            self.reply_don_signal.emit() #条件满足时发出回复完成的信号
            self.close()
            msg_box(self, '提示', '回复成功!')
        except Exception as e:
            print(e.args)
            traceback.print_exc()


    def cancel(self):
        self.close()

if __name__ == '__main__':
    app = QApplication(sys.argv)
    win = ReplyWindow('1789aeb6c84d11eba762d7bd2780f224')
    win.show()
    sys.exit(app.exec())