#ifndef BOOKINGMANAGER_H
#define BOOKINGMANAGER_H


#include <QObject>
class BookingManager : public QObject {
    Q_OBJECT


public:
    explicit BookingManager(QObject *parent = nullptr);

     void setUserManager(QObject *manager);

    Q_INVOKABLE void storeBooking(const QString &studentId, const QString &bookId);
    Q_INVOKABLE bool isBookBooked(const QString &bookId) const;
    Q_PROPERTY(int bookingcount READ bookingcount NOTIFY bookingCountChanged)

    int bookingcount() const;

signals:
    void bookingCountChanged();

public:
    int bookcount = 0;
};

#endif


