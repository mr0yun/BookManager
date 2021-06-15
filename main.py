"""
文件名：main.py
描述：项目入口，想要演示本项目，运行本文件即可
注意事项：在运行本文件之前确保已启动了Mysql服务，并且已成功运行过generate_data.py文件
"""
from view.login_window import LoginWindow
from PyQt5.QtWidgets import QApplication
import sys


if __name__ == '__main__':
    app = QApplication(sys.argv)  # 创建QT Application对象
    win = LoginWindow()           # 创建登录窗口
    win.show()
    sys.exit(app.exec_())         # 运行主循环，开始事件处理，当退出应用程序时将状态码返回给父进程
