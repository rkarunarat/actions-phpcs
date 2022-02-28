FROM php:8.1-cli

LABEL version="1.0"
LABEL repository="https://github.com/chindit/actions-phpcs"
LABEL homepage="https://github.com/chindit/actions-phpcs"
LABEL maintainer="David Lumaye <littletiger58@gmail.com>"

RUN apt-get autoclean

RUN apt-get update

# 1. development packages
RUN git \
    zip \
    unzip \
    nano

RUN curl -L https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -o /phpcs

# Install the WordPress rules
ADD https://github.com/WordPress/WordPress-Coding-Standards/archive/refs/tags/2.3.0.zip /wpcs.zip
RUN unzip /wpcs.zip -d / && \
    phpcs --config-set installed_paths /WordPress-Coding-Standards-2.3.0

COPY "entrypoint.sh" "/entrypoint.sh"

RUN chmod +x /entrypoint.sh && chmod a+x /phpcs
ENTRYPOINT ["/entrypoint.sh"]
