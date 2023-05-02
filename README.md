# PAMnotify - Telegram Notifier via PAM Sessions

PAMnotify is a tool that sends real-time notifications to a specified Telegram group when certain PAM (Pluggable Authentication Modules) events occur on a Linux server, such as user logins and logouts. By using PAM to monitor these events, PAMnotify can provide a simple yet powerful way to stay informed about important system activity in real-time.

## Setup Telegram Bot
To set up your Telegram bot, you can use Bot Father, and to find your Chat ID, you can use @RawDataBot. Simply Google it!

## Setup PAMnotify
First, download the script using this command:
```
curl -sSL https://raw.githubusercontent.com/yuyudhn/PAMnotify/main/pam-notify.sh | \
sudo tee /usr/local/bin/pam-notify.sh >/dev/null
```
Then, change the script's permissions:
```
sudo chmod +x /usr/local/bin/pam-notify.sh
```
Dont forget to change the value of **TELEGRAM_API_TOKEN** and **TELEGRAM_GROUP_ID**.

Next, edit the PAM configuration.
```
sudo nano /etc/pam.d/common-session
```
Add the following line and save it:
```
# PAM Notification to Telegram
session optional pam_exec.so /usr/local/bin/telegram-notify.sh
```
Done!

You don't have to restart anything. At this point you should receive an Telegram notification when you log in, whether through SSH, the login prompt on the physical system or when using sudo.

## Screenshot
This is example of the Telegram notification:
![PAMnotify](https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEjQWDuWbPxuKL5YM-kOpSHhnpLrb-UEGTD_c8Bunp85a18lk5ulsFKVj6DiLUbaZ-hrb7KoAGY_Fis2enCP9BzhhK_0tcPY-YzVbNSRHf7zQHzXAGsOue745F0emGdQQey3Wi9hPqROfF7bMMXkIKrzX0SaMye5l8YXBoIXr2E4IaMFcUoqHcpRI-4ELA/s809/ssh_notify.png "PAMnotify")

If you have any suggestions for improving PAMnotify, feel free to submit a pull request. Your contributions are greatly appreciated!