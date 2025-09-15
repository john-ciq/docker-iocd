##FROM codercom/code-server:1.621
FROM codercom/code-server:latest

RUN mkdir -p /home/coder/project && touch /home/coder/project/index.php && mkdir -p /home/coder/.local
RUN mkdir -p /home/coder/.local/share/code-server/User/workspaceStorage

RUN chmod a+w /home/coder/project/
RUN chmod a+w -R /home/coder/.local
COPY index.php /home/coder/project/index.php

## Need to make this dir so perms are correct when the directory is mounted in
VOLUME [ "/home/coder/project" ]
VOLUME [ "/home/coder/.local" ]
