https://gist.github.com/movd/7a9e3db63d076f85d16c7dcde62fe401
mobexglobal-com.mail.protection.outlook.com
https://marlam.de/msmtp/
http://manpages.ubuntu.com/manpages/bionic/en/man1/msmtp.1.html

Setting up email with SMTP on Ubuntu/Debian Servers
I used to sift trough my shell history and bookmarks every time I set up a new testing server in order to be able to send mails. So this should help...

Be aware don't use ssmtp anymore. It's unmaintained and has been removed from Debian and Ubuntu will most definitely follow suit.

Install msmtp
First we need the awesome program called msmtp to route all the server's mail through a standard SMTP server.

sudo apt-get install msmtp msmtp-mta mailutils

Set up msmtp
sudo vim /etc/msmtprc

Install and set up mailx
In order to be able to use the mail command wee need to install mailx

mailx is a Unix utility program for sending and receiving mail, also known as a Mail User Agent program. Being a console application with a command syntax similar to ed, it is the POSIX standardized variant of the Berkeley Mail utility.

sudo apt-get install bsd-mailx

Set mail transport agent to use msmtp

sudo vim /etc/msmtprc
append the following:

set mta=/usr/bin/msmtp


Set up aliases
We need to link system users with email addresses in order for system users to receive mails from cronjobs.

vim /etc/aliases

# Send root to Jane
root: bgroves@buschegroup.com
   
# Send everything else to admin
default: bgroves@buschegroup.com


sudo nvim /etc/mail.rc

append:

alias root root<bgroves@buschegroup.com>
Emails are now sent to this address if e.g. a cronjob fails. Also a general fallback address is used if messages don't belong to root. Of course more users can be set.

docker run --name send-email-docker --rm -i -t brentgroves/send-email-docker:1 /bin/bash

docker run --name send-email-hostnetwork --rm -i -t brentgroves/send-email-hostnetwork:1 /bin/bash

echo "Testing msmtp from ${HOSTNAME} with mail command" | mail -s "test mail from hostnetwork" bgroves@buschegroup.com
echo "Testing msmtp from ${HOSTNAME} with mail command" | mail -s "test mail 2" jdavis@buschegroup.com

# send_email_docker
docker run --name send-email-docker --rm -i -t brentgroves/send-email-docker:1 /bin/bash

dig mobexglobal-com.mail.protection.outlook.com

echo "Testing msmtp from ${HOSTNAME} with mail command" | mail -s "test mail 3" bgroves@buschegroup.com

# Get a shell to a running container
kubectl exec --stdin --tty send-email -- /bin/bash


HAVE NOT TRIED THIS BEFORE INSTEAD ADDED THIS TO MSMTPRC FILE.
https://www.thegeekdiary.com/how-to-send-mails-to-an-external-user-with-mailx-on-linux/
You can also edit the mailx config file /etc/mail.rc to add the following configuration to the end of the file, e.g.:

set smtp=mobexglobal-com.mail.protection.outlook.com
set from="mcp@mobexglobal.com"



