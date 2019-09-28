#ifndef WIDGET_H
#define WIDGET_H

#include <QWidget>

namespace Ui {
class Widget;
}

class Widget : public QWidget
{
    Q_OBJECT

public:
    explicit Widget(QWidget *parent = 0);
    ~Widget();
static bool createConnection();

private slots:
void on_pushButton_clicked();

private:
    Ui::Widget *ui;
};

#endif // WIDGET_H











#include "widget.h"
#include "ui_widget.h"
#include<QMessageBox>
#include<QSqlDatabase>
#include<QSqlQuery>
#include<QtDebug>



Widget::Widget(QWidget *parent) :
    QWidget(parent)
   ,ui(new Ui::Widget)
{



    ui->setupUi(this);
}

Widget::~Widget()
{
    delete ui;
}
 bool Widget::createConnection()
{
     QSqlDatabase db=QSqlDatabase::addDatabase("QSQLITE");
     db.setDatabaseName(":memory:");
     if(!db.open()){
     QMessageBox::critical(0,qApp->tr("Cannot open database"),qApp->tr("Unable to establish a database connection."),QMessageBox::Cancel);
     return false;
     }
     QSqlQuery query;
     query.exec("create table student (id int primary key,""name varchar(20))");
     query.exec("insert into student values(0,'first')");
     query.exec("insert into student values(1,'second')");
     query.exec("insert into student values(2,'third')");
     query.exec("insert into student values(3,'fourth')");
     query.exec("insert into student values(4,'fifth')");
     return true;


}


void Widget::on_pushButton_clicked()
{
    QSqlQuery query;
    query.exec("select * from student");
    while(query.next())
    {
        qDebug()<<query.value(0).toInt()<<query.value(1).toString();
    }
}













#include "widget.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);







    Widget w;
  if  (!w.createConnection())
      return 1;


    w.show();

    return a.exec();
}

