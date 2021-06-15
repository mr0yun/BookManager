"""
文件名：frozen_dir.py
描述：获取当前项目路径
"""
import sys
import os


def app_path():
    if hasattr(sys, 'frozen'):
        return os.path.dirname(sys.executable)
        # 返回python解释器的路径
    return os.path.dirname(__file__)
    # 返回本项目的绝对路径
