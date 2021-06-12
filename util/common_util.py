"""
文件名：common_util.py
描述：通用工具类
"""

import datetime
import hashlib
from PyQt5.QtCore import QRegExp
from PyQt5.QtGui import QRegExpValidator
from PyQt5.QtWidgets import QMessageBox
import uuid
import frozen_dir

# 当前项目的绝对路径
SUPER_DIR = frozen_dir.app_path()
ROLE_MAP = {'0': '管理员', '1': '普通用户'}

# 图标和图片的绝对路径
APP_ICON = SUPER_DIR + r'/res/img/app-icon.png'
DELETE_ICON = SUPER_DIR + r'/res/img/delete.png'
EDIT_ICON = SUPER_DIR + r'/res/img/edit.png'
BORROW_BOOK = SUPER_DIR + r'/res/img/borrow_book.png'
HOME_PAGE = SUPER_DIR + r'/res/img/home.png'
DELAY_TIME = SUPER_DIR + r'/res/img/delay_time.ico'
RETURN = SUPER_DIR + r'/res/img/return.ico'
DEL_RECORD = SUPER_DIR + r'/res/img/delete.ico'
PUSH_RETURN = SUPER_DIR + r'/res/img/push.ico'
SEND_ICON = SUPER_DIR + r'/res/img/send.png'

BORROW_STATUS_MAP = {'0': '未还', '1': '已还'}
SEARCH_CONTENT_MAP = {'书名': 'book_name', '出版社': 'publish_company', '作者': 'author', '用户': 'borrow_user'}
MESSAGE_STATUS_MAP = {'0': '否', '1': '是', '2': '无需回复'}

# 正则表达式，0. 开头、结尾均是0-9范围内的数字，且是两位数以内
# 1. 大于0的正整数1~9999999999
# 2. 日期yyyy-mm-dd
PATTERS = ['^[0-9]{1,2}$', '[1-9][0-9]{0,9}', '^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-'
'(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$']


def get_md5(data):
    """
    获取md5加密密文
    :param data: 明文
    :return: 加密后的密文
    """
    m = hashlib.md5()
    b = data.encode(encoding='utf-8')
    m.update(b)
    return m.hexdigest()

def get_uuid():
    """
    使用主机ID, 序列号, 和当前时间来生成UUID, 可保证全球范围的唯一性.
    :return: 唯一ID号
    """
    return str(uuid.uuid1()).replace('-', '')


def msg_box(widget, title, msg):
    """
    生成带有确定选项的对话框
    :param widget:
    :param title: 标题
    :param msg: 信息
    :return: 警告对话框
    """
    QMessageBox.warning(widget, title, msg, QMessageBox.Yes)


def accept_box(widget, title, msg):
    return QMessageBox.warning(widget, title, msg, QMessageBox.Yes|QMessageBox.No, QMessageBox.No)


def get_current_time():
    """
    获取当前时间
    :return: 格式化的当前时间
    """
    dt = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    return dt


def read_qss(qss_file):
    """
    读取自定义样式文件
    :param qss_file: 文件路径
    :return: 文件内容
    """
    with open(qss_file, 'r', encoding='utf-8') as f:
        return f.read()


def get_return_day(day):
    """
    获取已知天数后的日期
    :param day: 离当天相差的天数
    :return: 计算后的日期
    """
    return (datetime.datetime.now() + datetime.timedelta(days=day)).strftime('%Y-%m-%d %H:%M:%S')


def set_le_reg(widget, le, pattern):
    """
    给控件添加正则表达式匹配，限制输入
    :param widget:
    :param le: 待设置的控件
    :param pattern: 待匹配的模板
    :return:
    """
    rx = QRegExp()
    rx.setPattern(pattern)
    qrx = QRegExpValidator(rx, widget)
    le.setValidator(qrx)


SYS_STYLE = read_qss(SUPER_DIR + r'/res/style/style.qss')
