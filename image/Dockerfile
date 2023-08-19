FROM ossrs/srs:v5.0.166

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt/*

ADD ./launcher /opt/launcher
RUN chmod +x /opt/launcher/launch.sh
RUN pip install -r /opt/launcher/requirements.txt --no-cache-dir --index-url https://pypi.tuna.tsinghua.edu.cn/simple/

ENV HV_RELEASE=true
ENV HV_RTMP_PORT=11935
ENV HV_API_PORT=11985
ENV HV_API_USERNAME=admin
ENV HV_API_PASSWORD=kGT1ypLN
ENV HV_HTTP_PORT=18080
ENV HV_HLS_FRAGMENT=2
ENV HV_HLS_WINDOW=10
ENV HV_DASH_FRAGMENT=2

EXPOSE 11935
EXPOSE 11985
EXPOSE 18080

ENTRYPOINT [ "/opt/launcher/launch.sh" ]
