import sys

from PyQt5.QtWidgets import QApplication, QDialog, QMainWindow

from Query import Query
from View_login import Ui_View_login
from View_myreservation import Ui_View_myreservation
from View_register import Ui_View_reg
from View_reservation import Ui_View_reservation
from View_reservationManage import Ui_View_manageReservation
from View_system import Ui_LabManagerSystem


if __name__ == '__main__':
    query = Query()

    app = QApplication(sys.argv)
    # 初始化登陆窗口
    loginWindow = QDialog()
    # 初始化注册窗口
    registerWindow = QMainWindow()
    # 初始化系统界面
    systemWindow = QMainWindow()
    # 初始化预约表界面
    reservationWindow = QMainWindow()
    # 初始化预约表处理界面
    processWindow = QMainWindow()
    # 初始化我的预约界面
    myreservationWindow = QMainWindow()

    # 设置系统界面ui
    systemView = Ui_LabManagerSystem()
    systemView.setupUi(systemWindow)

    # 设置预约表界面ui
    reservationView = Ui_View_reservation()
    reservationView.setupUi(reservationWindow, systemView)
    # 链接
    systemView.reservationButton.clicked.connect(reservationWindow.show)
    systemView.reservationButton.clicked.connect(reservationView.setdata)
    systemView.produceButton.clicked.connect(processWindow.show)
    reservationView.pushButton.clicked.connect(reservationWindow.close)

    # 设置预约表处理界面
    processView = Ui_View_manageReservation()
    processView.setupUi(processWindow)
    # 链接
    processView.pushButton.clicked.connect(processWindow.close)
    processView.pushButton.clicked.connect(systemView.setdata)
    processView.pushButton_2.clicked.connect(processView.admitReservation)
    systemView.produceButton.clicked.connect(processView.setdata)

    # 设置我的预约界面
    myreservationView = Ui_View_myreservation()
    myreservationView.setupUi(myreservationWindow, systemView)
    # 链接
    myreservationView.pushButton.clicked.connect(myreservationWindow.close)
    systemView.myreserButton.clicked.connect(myreservationWindow.show)
    systemView.myreserButton.clicked.connect(myreservationView.setdata)

    # 设置登陆界面ui
    loginView = Ui_View_login()
    loginView.setupUi(loginWindow, systemWindow, systemView)
    # 链接“注册”按钮事件
    loginView.pushButton_2.clicked.connect(loginWindow.close)
    loginView.pushButton_2.clicked.connect(registerWindow.show)
    loginView.pushButton.clicked.connect(systemView.checkUser)

    # 设置注册界面ui
    registerView = Ui_View_reg()
    registerView.setupUi(registerWindow)

    # 链接“返回”按钮事件
    registerView.pushButton_2.clicked.connect(loginWindow.show)
    registerView.pushButton_2.clicked.connect(registerWindow.close)

    # 显示登陆界面
    loginWindow.show()

    sys.exit(app.exec_())

