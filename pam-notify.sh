#!/bin/bash
# Telgram notifier @yuyudhn

TELEGRAM_API_TOKEN=""
TELEGRAM_GROUP_ID=""

telegram_push() {
    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_API_TOKEN/sendMessage" \
        -d chat_id="$TELEGRAM_GROUP_ID" \
        -d text="$1" \
        -d parse_mode="Markdown" \
        -d disable_notification="true" \
        -d disable_web_page_preview="true" > /dev/null
}

# Variable
var_date=$(TZ="Asia/Jakarta" date +"%d/%m/%Y %T")
var_host=$(hostname -f)
var_addr=$(hostname -I | awk '{print $1}')

# Login Notification
if [ "$PAM_TYPE" = "open_session" ]; then
    message=$(printf "*%s* logged in to %s (%s).\nMore details:\n*Time*: %s\n*IP*: %s\n*Service*: %s\n*tty*: %s\nRequester: %s" "$PAM_USER" "$var_host" "$var_addr" "$var_date" "$PAM_RHOST" "$PAM_SERVICE" "$PAM_TTY" "$PAM_RUSER")
    telegram_push "$message"
fi

# Logout Notification
if [ "$PAM_TYPE" = "close_session" ]; then
    message=$(printf "*%s* logged out from %s (%s).\nMore details:\n*Time*: %s\n*IP*: %s\n*Service*: %s\n*tty*: %s\nRequester: %s" "$PAM_USER" "$var_host" "$var_addr" "$var_date" "$PAM_RHOST" "$PAM_SERVICE" "$PAM_TTY" "$PAM_RUSER")
    telegram_push "$message"
fi

exit 0
