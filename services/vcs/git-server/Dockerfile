FROM alpine:3.19

# Install openssh server, copy sshd config, generate keys
RUN apk add --update --no-cache openssh git bash
RUN ssh-keygen -A
COPY sshd_config /etc/ssh/sshd_config

# Create and configure user
RUN addgroup  git
RUN adduser --ingroup git \
    --disabled-password \ 
    -h /git \
    --shell "$(which git-shell)" \
    git

RUN echo "git:12345" | chpasswd
RUN mkdir /git/.ssh
RUN mkdir /git/git-shell-commands
COPY repo.sh /git/git-shell-commands/repo
RUN chmod +x /git/git-shell-commands/repo

RUN mkdir /git/projects
RUN mkdir /git/projects/.private
RUN chown git: /git/ -R

# Remove alpine motd
RUN rm /etc/motd

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D", "-e"]

