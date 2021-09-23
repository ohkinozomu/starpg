FROM debian:bullseye-slim

RUN apt update \
&& apt install -y curl gnupg \
&& curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
&& echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
&& apt update \
&& apt install -y golang yarn make

WORKDIR /usr/local/src

COPY . . 

RUN make editor-install-deps \
&& make editor-build \
&& make install-deps \
&& go install

ENTRYPOINT ["/root/go/bin/starpg"]