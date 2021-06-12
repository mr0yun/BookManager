"""
文件名：about_window.py
描述：关于页面
"""
from PyQt5.QtWidgets import QWidget
from ui.about_window import Ui_Form


class AboutWindow(Ui_Form, QWidget):

    def __init__(self):
        super(AboutWindow, self).__init__()
        self.setupUi(self)
