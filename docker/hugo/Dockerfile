FROM busybox

RUN wget https://github.com/gohugoio/hugo/releases/download/v0.60.1/hugo_0.60.1_Linux-64bit.tar.gz
RUN echo '54efec73f8aca18a3fa90e539dbe3b3b53e5d0c802ee724b2cbc63dae2fc17d3  hugo_0.60.1_Linux-64bit.tar.gz' | sha256sum -cw
RUN tar xzvf hugo_0.60.1_Linux-64bit.tar.gz hugo
RUN ./hugo version
RUN rm hugo_0.60.1_Linux-64bit.tar.gz

VOLUME /site
WORKDIR /site

EXPOSE 1313

ENTRYPOINT ["/hugo"]
