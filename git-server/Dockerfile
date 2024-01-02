FROM alpine:3.19

WORKDIR /projects

# Install openssh server, copy sshd config, generate keys
RUN apk add --update --no-cache openssh git 
RUN ssh-keygen -A
COPY sshd_config /etc/ssh/sshd_config

# Needed to share user permissions on files
ARG GIT_USER_UID
ARG GIT_USER_GID

# Create and configure user
RUN addgroup -g "${GIT_USER_GID}" git
RUN adduser --ingroup git \
    --uid "${GIT_USER_UID}" \
    --disabled-password \ 
    --shell "$(which git-shell)" \
    git
RUN echo "git:12345" | chpasswd
RUN mkdir /home/git/.ssh
RUN chown git: /home/git/ -R
RUN chown git: /projects/ -R


# Remove alpine motd
RUN rm /etc/motd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-e"]

