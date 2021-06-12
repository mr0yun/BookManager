"""
文件名：book_edit_window.py
描述：图书编辑
"""

from threading import Thread
from PyQt5.QtCore import Qt, pyqtSignal
from PyQt5.QtGui import QIcon
from PyQt5.QtWidgets import QWidget
from ui.add_book_window import Ui_Form
from util.dbutil import DBHelp
from util.common_util import msg_box, APP_ICON, SYS_STYLE, set_le_reg, PATTERS

class BookEditWindow(Ui_Form, QWidget):
    """
    继承添加书本的ui界面框，不改变布局，只是将一些控件进行文字的修改。
    """
    init_book_info_done_signal = pyqtSignal()#自定义编辑书本信息的信号

    def __init__(self, book_info=None):
        super(BookEditWindow, self).__init__()
        self.setupUi(self)
        self.book_info = book_info
        self.init_ui()
        self.current_book_info = list()
        self.init_book_info_done_signal.connect(self.init_data)#信号槽连接，当点击要改时，获取当前选中书本的信息
        self.add_book_pushButton.clicked.connect(self.update_book_info)#信号槽连接，修改完成时，启动更新书籍信息
        set_le_reg(widget=self, le=self.store_num_lineEdit, pattern=PATTERS[1])
        set_le_reg(widget=self, le=self.publish_date_lineEdit, pattern=PATTERS[2])
        th = Thread(target=self.get_book_info)
        th.start()

    def init_ui(self):
        self.setWindowTitle('编辑图书')
        self.setWindowModality(Qt.ApplicationModal)
        self.add_book_pushButton.setText('保存信息')
        self.setWindowIcon(QIcon(APP_ICON))
        self.setWindowFlags(Qt.WindowCloseButtonHint)
        self.add_book_pushButton.setProperty('class', 'Aqua')
        self.setStyleSheet(SYS_STYLE)
        self.add_book_pushButton.setMinimumWidth(60)

    def init_data(self):
        self.book_name_lineEdit.setText(self.current_book_info[1])
        self.author_lineEdit.setText(self.current_book_info[2])
        self.publish_company_lineEdit.setText(self.current_book_info[3])
        self.publish_date_lineEdit.setText(str(self.current_book_info[-1]))
        self.store_num_lineEdit.setText(str(self.current_book_info[4]))

    def get_book_info(self):
        """
        管理员右键菜单选择编辑书本时，获取书本的信息，并发出初始化书本信息成功的信号
        :return:
        """
        db = DBHelp()
        count, res = db.query_super(table_name='book', column_name='book_name', condition=self.book_info)
        self.current_book_info = list(res[0])
        self.init_book_info_done_signal.emit()#发出书本信息编辑完成的信号
        db.instance = None
        del db

    def update_book_info(self):
        book_name = self.book_name_lineEdit.text()
        author = self.author_lineEdit.text()
        publish_company = self.publish_company_lineEdit.text()
        publish_time = self.publish_date_lineEdit.text()
        store_num = int(self.store_num_lineEdit.text())
        new_book_info = [book_name, author, publish_company, publish_time, store_num]
        is_update = False
        if '' in new_book_info:
            msg_box(self, '错误', '图书的关键信息不能为空!')
            return
        for new_info in new_book_info:
            if new_info not in self.current_book_info:
                db = DBHelp()
                db.update_super(table_name='book', column_name='id', condition=self.current_book_info[0],
                                data=new_book_info)
                db.db_commit()
                db.instance = None
                del db
                self.close()
                is_update = True
                break
        if is_update:
                msg_box(self, '提示', '图书信息更新成功!')
        self.close()
