from PyQt5.QtWidgets import QWidget
from ui.home_window import Ui_Form


class HomeWindow(Ui_Form, QWidget):

    def __init__(self):
        super(HomeWindow, self).__init__()
        self.setupUi(self)
