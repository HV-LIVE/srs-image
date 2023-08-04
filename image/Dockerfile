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
ENV HV_RTMP_PORT=1935
ENV HV_API_PORT=1985
ENV HV_API_PASSWORD=admin
ENV HV_API_USERNAME=admin
ENV HV_HTTP_PORT=8080
ENV HV_HLS_FRAGMENT=2
ENV HV_HLS_WINDOW=10
ENV HV_DASH_FRAGMENT=2

ENTRYPOINT [ "/opt/launcher/launch.sh" ]
