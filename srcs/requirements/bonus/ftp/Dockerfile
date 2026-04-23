FROM alpine:3.21


RUN apk add --no-cache vsftpd linux-pam

COPY conf/vsftpd.conf /etc/vsftpd.conf

RUN printf "auth required pam_unix.so\naccount required pam_unix.so\n" > /etc/pam.d/vsftpd

COPY tools/init.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh


CMD ["/usr/local/bin/setup.sh"]
