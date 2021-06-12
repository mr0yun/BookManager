"""
文件名：add_book_window.py
描述：添加书籍
"""

from PyQt5.QtCore import Qt, pyqtSignal
from PyQt5.QtGui import QIcon
from PyQt5.QtWidgets import QWidget
from ui.add_book_window import Ui_Form
from util.common_util import msg_box, get_current_time, get_uuid, APP_ICON, SYS_STYLE, set_le_reg, PATTERS
from util.dbutil import DBHelp


class AddBookWindow(Ui_Form, QWidget):
    add_book_don_signal = pyqtSignal()#自定义信号

    def __init__(self):
        super(AddBookWindow, self).__init__()
        self.setupUi(self)
        self.setWindowModality(Qt.ApplicationModal)
        self.setWindowFlags(Qt.WindowCloseButtonHint)
        self.setWindowTitle('添加新图书')
        self.add_book_pushButton.clicked.connect(self.add)#添加按钮按下之后，启动内置槽函数
        self.setWindowIcon(QIcon(APP_ICON))
        self.add_book_pushButton.setProperty('class', 'Aqua')
        self.setStyleSheet(SYS_STYLE)
        set_le_reg(widget=self, le=self.store_num_lineEdit, pattern=PATTERS[1])
        set_le_reg(widget=self, le=self.publish_date_lineEdit, pattern=PATTERS[2])

    def add(self):
        """
        获取输入并检查后将其插入数据库
        :return:
        """
        book_name = self.book_name_lineEdit.text()
        author = self.author_lineEdit.text()
        publish_company = self.publish_company_lineEdit.text()
        publish_date = self.publish_date_lineEdit.text()
        #store_num = self.store_num_lineEdit.text()
        store_num = int(self.store_num_lineEdit.text())
        if '' in [book_name, author, publish_company, publish_date, store_num]:
            msg_box(self, '错误', '请输入图书的关键信息!')
            return
        db = DBHelp()
        # 看是否已经有添加过同名的书籍
        count, res = db.query_super(table_name='book', column_name='book_name', condition=book_name)
        if count:
            msg_box(self, '错误', '已存在同名书籍!')
            return
        book_info = [get_uuid(), book_name, author, publish_company, store_num, 0, get_current_time(), publish_date]
        db.add_book(data=book_info)
        db.db_commit()
        db.instance = None
        del db
        self.add_book_don_signal.emit()#条件满足时发出添加图书的信号
        self.close()
        msg_box(self, '提示', '添加新图书成功!')
