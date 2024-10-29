FROM ubuntu:22.04

# - **texlive-latex-extra** accounts for ~500MB or so, and installs hundreds of LaTeX
#   packages. ugh. But doesn't seem worth trying to split out exactly what might be needed.
#
# - **getnonfreefonts** requires **unzip**, though this is not well documented. It's in the
#   getnonfreefonts man page (which hardly anyone will read and isn't easily accessible anyway
#   in a docker container), and not on https://www.tug.org/fonts/getnonfreefonts/, the normal
#   place people look for documentation on it.
#
# - the entirety of the non-free fonts is only ~ 17MB, so we may as well install all of them.

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
      apt-get install -y --no-install-recommends \
        bash-completion           \
        bsdextrautils             \
        bsdutils                  \
        ca-certificates           \
        cm-super                  \
        curl                      \
        fonts-cmu                 \
        git                       \
        latexmk                   \
        less                      \
        lmodern                   \
        make                      \
        sudo                      \
        texlive-base              \
        texlive-fonts-recommended \
        texlive-font-utils        \
        texlive-latex-extra       \
        texlive-luatex            \
        texlive-xetex             \
        unzip                     \
        vim                       \
        wget                      \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    cd /tmp && \
    wget https://www.tug.org/fonts/getnonfreefonts/install-getnonfreefonts && \
    texlua ./install-getnonfreefonts && \
    rm ./install-getnonfreefonts && \
    getnonfreefonts -v --sys -a


ARG USER_NAME=user
ARG USER_ID=1001
ARG USER_GID=1001

RUN : "adding user" && \
  set -x; \
  addgroup --gid ${USER_GID} ${USER_NAME} && \
  adduser --home /home/${USER_NAME} --disabled-password --shell /bin/bash --gid ${USER_GID} --uid ${USER_ID} --gecos '' ${USER_NAME} && \
  echo "%${USER_NAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER ${USER_NAME}

RUN mkdir -p ~/.local/bin

ENV PATH="/home/${USER_NAME}/.local/bin:${PATH}"

