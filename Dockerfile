FROM centos/systemd

RUN yum -y update && \
    yum -y install \
        lsof \
        epel-release \
        git \
        inotify-tools \
        sudo \
        httpd \
        mash \
        python-simplejson \
        openssh-server \
        openssh-clients \
        koji; yum clean all

RUN /usr/bin/ssh-keygen -A
ENV USER_CONFIG_DIR /opt/koji-clients/users/kojiadmin
ENV SCRIPT_DIR /usr/share/koji-docker

RUN systemctl enable httpd.service
EXPOSE 80
EXPOSE 22 
ADD bin/ /usr/local/bin/

ENV COMMON_CONFIG /config
RUN chmod +x /usr/local/bin/*
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN mkdir /var/run/sshd
RUN echo 'root:mypassword' | chpasswd
RUN mkdir /root/mash-git
RUN mkdir -p /usr/share/koji-docker
RUN mkdir -p /etc/systemd/system/
RUN mkdir -p /etc/sudoers.d/
RUN echo "kojiadmin  ALL=NOPASSWD: /usr/sbin/hostenv.sh" | tee -a /etc/sudoers.d/visudo
RUN echo "kojiadmin  ALL=NOPASSWD: /usr/bin/systemctl" | tee -a /etc/sudoers.d/visudo
RUN echo "Defaults!/usr/bin/systemctl !requiretty" | tee -a /etc/sudoers.d/visudo

RUN mkdir -p /config/kojiadmin
RUN useradd kojiadmin -d /config/kojiadmin
RUN chown -R kojiadmin.kojiadmin /config/kojiadmin
RUN useradd httpd

#ENTRYPOINT /usr/local/bin/entrypoint.sh
CMD ["/usr/sbin/init"]
