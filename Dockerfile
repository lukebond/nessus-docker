FROM debian:9-slim
ADD Nessus-7.1.2-debian6_amd64.deb /tmp
RUN apt install /tmp/Nessus-7.1.2-debian6_amd64.deb && rm /tmp/Nessus-7.1.2-debian6_amd64.deb
CMD /opt/nessus/sbin/nessus-service -q
