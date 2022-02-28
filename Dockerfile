FROM php:8.1-cli

LABEL version="1.0"
LABEL repository="https://github.com/chindit/actions-phpcs"
LABEL homepage="https://github.com/chindit/actions-phpcs"
LABEL maintainer="David Lumaye <littletiger58@gmail.com>"

RUN curl -L https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar -o /phpcs

# Install the WordPress rules
ENV WPCS_VERSION 0.10.0
ADD https://github.com/WordPress-Coding-Standards/WordPress-Coding-Standards/archive/${WPCS_VERSION}.zip /wpcs.zip
RUN unzip /wpcs.zip -d / && \
    phpcs --config-set installed_paths /WordPress-Coding-Standards-${WPCS_VERSION}

COPY "entrypoint.sh" "/entrypoint.sh"

RUN chmod +x /entrypoint.sh && chmod a+x /phpcs
ENTRYPOINT ["/entrypoint.sh"]
