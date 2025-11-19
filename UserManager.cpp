#include "UserManager.h"
#include <QFile>
#include <QTextStream>
#include <QDateTime>
#include <QDebug>
#include <QDir>
#include <QFileInfo>

UserManager::UserManager(QObject *parent) : QObject(parent) {}

void UserManager::signUp(const QString &firstName, const QString &lastName,
                         const QString &studentId, const QString &password) {
    QFile file("userssdata.txt");

    qDebug() << "Full path:" << QFileInfo(file).absoluteFilePath();

    if (file.open(QIODevice::Append | QIODevice::Text)) {
        QTextStream out(&file);
        out << "----- New Entry -----\n";
        out << "Time: " << QDateTime::currentDateTime().toString() << "\n";
        out << "First Name: " << firstName << "\n";
        out << "Last Name: " << lastName << "\n";
        out << "Student ID: " << studentId << "\n";
        out << "Password: " << password << "\n\n";
        file.close();
        qDebug() << "Data written to userssdata.txt";
    } else {
        qWarning() << "Failed to open userssdata.txt";
    }
}



bool UserManager::login(const QString &studentId, const QString &password) {
    QFile file("userssdata.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Unable to open userssdata.txt for login.";
        return false;
    }

    QTextStream in(&file);
    bool foundMatch = false;
    QString currentFirstName, currentLastName;

    while (!in.atEnd()) {
        QString line = in.readLine();

        if (line.startsWith("First Name: ")) {
            currentFirstName = line.mid(QString("First Name: ").length()).trimmed();
        } else if (line.startsWith("Last Name: ")) {
            currentLastName = line.mid(QString("Last Name: ").length()).trimmed();
        } else if (line.startsWith("Student ID: ")) {
            QString idInFile = line.mid(QString("Student ID: ").length()).trimmed();

            if (idInFile == studentId) {
                QString nextLine = in.readLine();
                if (nextLine.startsWith("Password: ")) {
                    QString pwdInFile = nextLine.mid(QString("Password: ").length()).trimmed();

                    if (pwdInFile == password) {
                        foundMatch = true;
                        m_studentId = studentId;
                        m_firstName = currentFirstName;
                        m_lastName = currentLastName;
                        break;
                    }
                }
            }
        }
    }

    file.close();

    if (foundMatch) {
        qDebug() << "Login successful for student ID:" << studentId;
        return true;
    } else {
        qDebug() << "Login failed: Incorrect ID or password.";
        return false;
    }
}

QString UserManager::getStudentId() const {
    return m_studentId;
}

QString UserManager::getFirstName() const {
    return m_firstName;
}

QString UserManager::getLastName() const {
    return m_lastName;
}


QStringList UserManager::getBookingHistory() {
    QStringList history;
    QFile file("bookings.txt");

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qWarning() << "Cannot open bookings.txt for reading.";
        return history;
    }

    QTextStream in(&file);
    while (!in.atEnd()) {
        QString line = in.readLine();
        if (line.contains("Student ID: " + m_studentId)) {
            history << line;
        }
    }

    file.close();
    return history;
}

/*void UserManager::storeBooking(const QString &studentId, const QString &bookIdField) {
    QFile file("bookings.txt");
    if (file.open(QIODevice::Append | QIODevice::Text)) {
        QTextStream out(&file);
        out << "Book ID: " << bookIdField
            << ", Student ID: " << studentId
            << ", Time: " << QDateTime::currentDateTime().toString()
            << "\n";
        file.close();
        qDebug() << "Booking recorded.";
    } else {
        qWarning() << "Cannot open bookings.txt for writing.";
    }
}*/

int UserManager::getBookingCount() const {
    QFile file("bookings.txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
        return 0;

    QTextStream in(&file);
    int count = 0;
    while (!in.atEnd()) {
        QString line = in.readLine();
        if (line.contains("Student ID: " + m_studentId)) {
            count++;

        }
    }
    file.close();
    return count;
}
