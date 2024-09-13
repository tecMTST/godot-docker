FROM ubuntu:24.04 AS installer

ARG GODOT_VERSION=4.3-stable

ENV GODOT_VERSION=$GODOT_VERSION
ENV HOME=/root

WORKDIR /opt

RUN apt-get update \
    && apt-get install -y --no-install-recommends wget unzip \
    && wget -O godot.zip https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}/Godot_v${GODOT_VERSION}_linux.x86_64.zip --no-check-certificate \
    && unzip godot.zip \
    && rm godot.zip \
    && mv Godot_v${GODOT_VERSION}_linux.x86_64 /usr/local/bin/godot \
    && mkdir -p ${HOME}/.local/share/godot/export_templates/${GODOT_VERSION} \
    && wget -O export_templates.tpz https://github.com/godotengine/godot/releases/download/${GODOT_VERSION}/Godot_v${GODOT_VERSION}_export_templates.tpz --no-check-certificate \
    && unzip export_templates.tpz -d ${HOME}/.local/share/godot/export_templates/${GODOT_VERSION} && \
    echo "Done."

FROM ubuntu:24.04

ARG GODOT_VERSION=4.3-stable
ARG EXPORT_TEMPLATES_GLOB=*

ENV EXPORT_TEMPLATES_GLOB=$EXPORT_TEMPLATES_GLOB
ENV GODOT_VERSION=$GODOT_VERSION
ENV HOME=/root

COPY --from=installer /usr/local/bin/godot /usr/local/bin/godot
COPY --from=installer ${HOME}/.local/share/godot/export_templates/${GODOT_VERSION}/templates/${EXPORT_TEMPLATES_GLOB} ${HOME}/.local/share/godot/export_templates/templates/${GODOT_VERSION_DOTTED}/

RUN GODOT_VERSION_DOTTED=$(echo "$GODOT_VERSION" | sed 's/-/./g') && \
  mv ${HOME}/.local/share/godot/export_templates/templates ${HOME}/.local/share/godot/export_templates/${GODOT_VERSION_DOTTED}

ENTRYPOINT ["godot"]
CMD ["--help"]

