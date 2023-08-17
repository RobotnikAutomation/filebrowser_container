ARG img_version=v2.24.2
FROM filebrowser/filebrowser:$img_version as filebrowser


COPY docker.json /.filebrowser.json

COPY chown.sh /
RUN chmod +x /chown.sh
RUN /filebrowser config init
RUN /filebrowser config set --auth.method=noauth
RUN /filebrowser cmds add "after_upload" /chown.sh
RUN /filebrowser cmds add "after_copy" /chown.sh
RUN /filebrowser cmds add "after_create" /chown.sh
RUN /filebrowser users add admin admin
RUN /filebrowser config set --branding.name "Robotnik"


ENTRYPOINT ["/filebrowser", "--config=/.filebrowser.json"]
