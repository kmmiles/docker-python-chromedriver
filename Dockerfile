# see: https://github.com/AlexZaharchuk/python-selenium-docker/blob/master/Dockerfile

FROM python:3.9-slim
ENV IS_DOCKER 1

# install packages
RUN set -ex; \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    curl \
    unzip \
    binutils \
    gnupg \
    && \
  curl -sS https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" \
    >> /etc/apt/sources.list.d/google-chrome.list' && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    google-chrome-stable && \
  pip install --upgrade pip && \
  pip install pipenv 

# install chromedriver
RUN set -ex; \
  chromedriver_version="$(curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE)" && \
  chromedriver_url="http://chromedriver.storage.googleapis.com/$chromedriver_version/chromedriver_linux64.zip" && \
  curl -sfL -o /tmp/chromedriver.zip "$chromedriver_url" && \
  unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/ && \
  rm -f /tmp/chromedriver.zip

# cleanup
RUN set -ex; \
  apt-get clean && \
  dpkg --clear-avail && \
  rm -rf /var/tmp/* && \
  rm -rf /var/lib/apt/lists/* && \
  find /var/cache -type f -exec rm -rf {} \; && \
  find /var/log -type f | while read f; do /bin/echo -ne "" > $f; done
