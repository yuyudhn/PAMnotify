#!/bin/bash

# Telegram API Token and Group ID
TELEGRAM_API_TOKEN="<your token>"
TELEGRAM_GROUP_ID="<your group ID>"

telegram_push() {
    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_API_TOKEN/sendMessage" \
        -d chat_id="$TELEGRAM_GROUP_ID" \
        -d text="$1" \
        -d parse_mode="Markdown" \
        -d disable_notification="true" \
        -d disable_web_page_preview="true" > /dev/null
}

# Variable
_date=$(TZ="Asia/Jakarta" date +"%d/%m/%Y %T")
_host=$(hostname -f)
_addr=$(hostname -I | awk '{print $1}')

# Login Notification
if [ "$PAM_TYPE" = "open_session" ]; then
    message=$(printf "User *%s* logged in from %s (%s).\nMore details:\n*Time*: %s\n*IP*: %s\n*Service*: %s\n*tty*: %s" "$PAM_USER" "$_host" "$_addr" "$_date" "$PAM_RHOST" "$PAM_SERVICE" "$PAM_TTY")
    telegram_push "$message"
fi

# Logout Notification
if [ "$PAM_TYPE" = "close_session" ]; then
    message=$(printf "User *%s* logged out from %s (%s).\nMore details:\n*Time*: %s\n*IP*: %s\n*Service*: %s\n*tty*: %s" "$PAM_USER" "$_host" "$_addr" "$_date" "$PAM_RHOST" "$PAM_SERVICE" "$PAM_TTY")
    telegram_push "$message"
fi

exit 0