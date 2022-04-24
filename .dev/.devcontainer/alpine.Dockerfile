FROM alpine

RUN apk --update add git less openssh  libstdc++  which && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/cache/apk/*

# Timezone
RUN apk add -q --update --no-cache tzdata
ENV TZ=Europe/Kiev

WORKDIR /workspace

#################     Common Setting      ######################
# UserName
ARG USERNAME=root

#################    🚀Install         #######################
RUN apk update \
    && apk add --no-cache \
    make \
    tree \
    python3 \
    py3-pip \
    ansible \
    && rm -rf /var/lib/apt/lists/* \
    && rm /var/cache/apk/*

#################   scripts   #######################
COPY ./build /tmp/build
RUN  \
    # ✔️ bash Install
    /bin/ash /tmp/build/scripts/bash.sh && \
    # ✔️ Common
    /bin/ash /tmp/build/scripts/common-alpine.sh "$USERNAME" && \
    # ✔️ Clean up
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/cache/apk/*

USER ${USERNAME}

CMD /bin/ash -c "while sleep 1000; do :; done"
