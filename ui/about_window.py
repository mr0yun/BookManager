# -*- coding: utf-8 -*-

# Form implementation generated from reading ui file 'about_window.ui'
#
# Created by: PyQt5 UI code generator 5.9.2
#
# WARNING! All changes made in this file will be lost!

from PyQt5 import QtCore, QtGui, QtWidgets

class Ui_Form(object):
    def setupUi(self, Form):
        Form.setObjectName("Form")
        Form.resize(685, 462)
        self.tabWidget = QtWidgets.QTabWidget(Form)
        self.tabWidget.setGeometry(QtCore.QRect(20, 10, 651, 441))
        sizePolicy = QtWidgets.QSizePolicy(QtWidgets.QSizePolicy.Expanding, QtWidgets.QSizePolicy.Expanding)
        sizePolicy.setHorizontalStretch(0)
        sizePolicy.setVerticalStretch(0)
        sizePolicy.setHeightForWidth(self.tabWidget.sizePolicy().hasHeightForWidth())
        self.tabWidget.setSizePolicy(sizePolicy)
        font = QtGui.QFont()
        font.setFamily("宋体")
        font.setPointSize(12)
        font.setBold(True)
        font.setWeight(75)
        self.tabWidget.setFont(font)
        self.tabWidget.setObjectName("tabWidget")
        self.tab_help = QtWidgets.QWidget()
        self.tab_help.setObjectName("tab_help")
        self.textEdit = QtWidgets.QTextEdit(self.tab_help)
        self.textEdit.setGeometry(QtCore.QRect(10, 10, 631, 391))
        self.textEdit.setFrameShape(QtWidgets.QFrame.NoFrame)
        self.textEdit.setLineWidth(0)
        self.textEdit.setReadOnly(True)
        self.textEdit.setObjectName("textEdit")
        self.tabWidget.addTab(self.tab_help, "")
        self.tab_about = QtWidgets.QWidget()
        self.tab_about.setObjectName("tab_about")
        self.textEdit_2 = QtWidgets.QTextEdit(self.tab_about)
        self.textEdit_2.setGeometry(QtCore.QRect(10, 10, 631, 401))
        self.textEdit_2.setFrameShape(QtWidgets.QFrame.NoFrame)
        self.textEdit_2.setLineWidth(0)
        self.textEdit_2.setObjectName("textEdit_2")
        self.tabWidget.addTab(self.tab_about, "")

        self.retranslateUi(Form)
        self.tabWidget.setCurrentIndex(1)
        QtCore.QMetaObject.connectSlotsByName(Form)

    def retranslateUi(self, Form):
        _translate = QtCore.QCoreApplication.translate
        Form.setWindowTitle(_translate("Form", "Form"))
        self.textEdit.setHtml(_translate("Form", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n"
"<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"</style></head><body style=\" font-family:\'宋体\'; font-size:12pt; font-weight:600; font-style:normal;\">\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:\'SimSun\'; font-weight:400;\">一.使用帮助<br />1.先进行注册，注册时电话号码可以作为找回密码的依据</span></p>\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:\'SimSun\'; font-weight:400;\"><br />2.注册完毕后，使用自己的账号进行登录</span></p>\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:\'SimSun\'; font-weight:400;\"><br />3.登陆后，需要手动刷新界面，显示当前账户的联系人</span></p>\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:\'SimSun\'; font-weight:400;\"><br />4.然后可以对当前账户的联系人进行管理，其中添加联系人时，姓名为必填项<br /></span></p>\n"
"<p align=\"justify\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:\'SimSun\'; font-weight:400;\">二.常见问题帮助<br />1.注册不成功的原因可能是：当前电话号码已经注册过，当前用户已经存在</span></p>\n"
"<p align=\"justify\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:\'SimSun\'; font-weight:400;\"><br />2.登陆不成功的原因可能是：当前用户不存在，当前用户名与密码不匹配</span></p>\n"
"<p align=\"justify\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:\'SimSun\'; font-weight:400;\"><br />3.添加不成功的原因可能是：该联系人已存在</span></p>\n"
"<p align=\"justify\" style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px; font-family:\'SimSun\'; font-weight:400;\"><br /></p>\n"
"<p align=\"justify\" style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:\'SimSun\'; font-weight:400;\">4.找回密码不成功的原因可能是当前用户名与手机号不匹配</span></p></body></html>"))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.tab_help), _translate("Form", "使用帮助"))
        self.textEdit_2.setHtml(_translate("Form", "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0//EN\" \"http://www.w3.org/TR/REC-html40/strict.dtd\">\n"
"<html><head><meta name=\"qrichtext\" content=\"1\" /><style type=\"text/css\">\n"
"p, li { white-space: pre-wrap; }\n"
"</style></head><body style=\" font-family:\'宋体\'; font-size:12pt; font-weight:600; font-style:normal;\">\n"
"<p style=\"-qt-paragraph-type:empty; margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><br /></p>\n"
"<p style=\" margin-top:0px; margin-bottom:0px; margin-left:0px; margin-right:0px; -qt-block-indent:0; text-indent:0px;\"><span style=\" font-family:\'SimSun\'; font-weight:400;\">1.版本号：简易版本1.0<br /><br />2.开发时间：2021/06/01-2021/06/12<br /><br />3.开发者信息：<br />    学校：南昌大学<br />    学院：软件学院<br />    专业：软件工程<br />    班级：18级9班<br />    姓名：王盼、朱青云<br />    学号：8002118223、8002118<br />    </span></p></body></html>"))
        self.tabWidget.setTabText(self.tabWidget.indexOf(self.tab_about), _translate("Form", "版本信息"))

