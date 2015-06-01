FROM centos:7
MAINTAINER "Tolik Litovsky" <tlitovsk@redhat.com>
ENV container docker

RUN yum -y update; yum clean all;
RUN yum -y install yum-utils wget tar

#systemd requirment
VOLUME [ "/sys/fs/cgroup" ]

# installing build utils of engine
RUN yum install -y java-1.7.0-openjdk-devel git maven
RUN mkdir /root/.m2

ADD settings.xml /root/.m2/
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk.x86_64
ENV JBOSS_HOME /usr/share/jboss-as
ENV PATH $HOME/apache-maven-3.0.5/bin:$PATH

RUN cd /usr/share; \
    wget http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz; \
    tar -zxvf jboss-as-7.1.1.Final.tar.gz --no-same-owner; \
    ln -s /usr/share/jboss-as-7.1.1.Final /usr/share/jboss-as; \
    chmod -R 777 /usr/share/jboss-as;

#installing postgre sql
RUN yum install -y postgresql-server \
	postgresql-setup initdb \
	systemctl enable postgresql.service

#getting the code
RUN cd /root;git clone git://gerrit.ovirt.org/ovirt-engine;

CMD ["/usr/sbin/init"]

