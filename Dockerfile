FROM ubuntu:18.04
LABEL maintainer="sakaki333"

ARG github_account
ARG locale="ja_JP.UTF-8"
ARG timezone="Asia/Tokyo"

ENV LC_ALL=${locale}
ENV LANG=${locale}
ENV LANGUAGE=${locale}
ENV LC_LANG=${locale}
ENV DEBIAN_FRONTEND=noninteractive
COPY sources.list /etc/apt/sources.list
RUN apt-get update && \
    apt-get -y install python3 python3-dev python3-venv build-essential tzdata git locales
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8 && \
    locale-gen ${locale} && \
    update-locale LANG=${locale}
RUN python3 -c "assert '${github_account}' is not '', 'Please set --build-arg github_account=YOUR_ACCOUNT_NAME to docker build command.'"
RUN git clone https://github.com/${github_account}/django.git /django
RUN python3 -m venv /venv && \
    /venv/bin/python -m pip install -U pip && \
    /venv/bin/pip install tblib && \
    /venv/bin/pip install -e /django/
RUN useradd -m --shell /bin/bash test
RUN echo "source /venv/bin/activate" | tee /root/.bashrc /home/test/.bashrc > /dev/null

CMD /bin/bash
