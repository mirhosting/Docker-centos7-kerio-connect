FROM centos:7 
MAINTAINER MIRhosting <dev@mirhosting.com> 

ENV container docker 

RUN yum -y swap -- remove fakesystemd -- install systemd systemd-libs
RUN yum -y update; yum clean all;
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
CMD ["/usr/sbin/init"]

RUN yum -y swap -- remove systemd-container systemd-container-libs -- install systemd systemd-libs

RUN yum -y update
RUN yum -y install wget
RUN yum -y install openssh-server
RUN yum -y install sysstat lsof

RUN wget -O /usr/local/src/kerio.rpm http://cdn.kerio.com/dwn/connect/connect-9.1.1-1433/kerio-connect-9.1.1-1433-linux-x86_64.rpm
RUN chmod +x /usr/local/src/kerio.rpm
RUN rpm -ivh /usr/local/src/kerio.rpm

EXPOSE 4040 22 25 465 587 110 995 143 993 119 563 389 636 80 443 5222 5223
VOLUME /opt/kerio/mailserver/store
