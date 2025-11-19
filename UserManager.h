#ifndef USERMANAGER_H
#define USERMANAGER_H

#include <QObject>

class UserManager : public QObject {
    Q_OBJECT
public:
    explicit UserManager(QObject *parent = nullptr);

    Q_INVOKABLE void signUp(const QString &firstName, const QString &lastName,
                            const QString &studentId, const QString &password);

    Q_INVOKABLE bool login(const QString &studentId, const QString &password);
    Q_PROPERTY(int bookingCount READ getBookingCount NOTIFY bookingCountChanged)
    Q_INVOKABLE QStringList getBookingHistory();


    Q_INVOKABLE QString getStudentId() const;
    Q_INVOKABLE QString getFirstName() const;
    Q_INVOKABLE QString getLastName() const;
    Q_INVOKABLE int getBookingCount() const;

signals:
    void bookingCountChanged();


private:
    QString m_studentId;
    QString m_firstName;
    QString m_lastName;
};


#endif
