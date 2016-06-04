FROM redis:alpine

RUN apk update; apk add --upgrade wget tar 
    
ENV CONTAINERPILOT_VER 2.1.4
ENV CONTAINERPILOT file:///etc/containerpilot.json 

RUN wget -O containerpilot.tar.gz --no-check-certificate "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VER}/containerpilot-${CONTAINERPILOT_VER}.tar.gz" ;\
        tar  zxvf containerpilot.tar.gz -C /bin/; \
        rm containerpilot.tar.gz;

COPY containerpilot.json /etc

ENV TERM xterm

EXPOSE 6379
ENV HOME /root
WORKDIR /root

CMD ["/bin/containerpilot", "/usr/local/bin/redis-server", "--appendonly", "yes"]




