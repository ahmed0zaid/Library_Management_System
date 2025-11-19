#include "BookingManager.h"
#include <QFile>
#include <QTextStream>
#include <QDateTime>
#include <QDebug>
#include "UserManager.h"

BookingManager::BookingManager(QObject *parent) : QObject(parent), bookcount(0) {}

void BookingManager::storeBooking(const QString &studentId, const QString &bookId) {
    QFile file("bookings.txt");
    if (file.open(QIODevice::Append | QIODevice::Text)) {
        QTextStream out(&file);
        out << "       >>>NEW ORDER:"
            << ", -Book ID: " << bookId
            << ", -Student ID: " << studentId
            << ", -Time: " << QDateTime::currentDateTime().toString()
            << "-Time limit in 3 mounths: " << QDateTime::currentDateTime().addMonths(3).toString()
            << "\n";
        file.close();
        qDebug() << "Booking recorded.";
        bookcount++;
        emit bookingCountChanged();

        UserManager* um = qobject_cast<UserManager*>(parent());
        if (um) {
            emit um->bookingCountChanged();
        }
    } else {
        qWarning() << "error writing.";
    }
}


int BookingManager::bookingcount() const {
    return bookcount;
}

bool BookingManager::isBookBooked(const QString &bookId) const {
    QFile file("bookings.txt");
    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&file);
        while (!in.atEnd()) {
            QString line = in.readLine();
            if (line.contains(bookId)) {
                return true;
            }
        }
    }
    return false;
}

