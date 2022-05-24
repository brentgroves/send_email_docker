# send_email_docker
docker run --name send-email-docker --rm -i -t brentgroves/send-email-docker:1 /bin/bash

dig mobexglobal-com.mail.protection.outlook.com

echo "Testing msmtp from ${HOSTNAME} with mail command" | mail -s "test mail 2" bgroves@buschegroup.com

# Get a shell to a running container
kubectl exec --stdin --tty send-email -- /bin/bash
