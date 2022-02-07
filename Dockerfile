FROM archlinux/archlinux:latest

ENV ANSIBLE_INVALID_TASK_ATTRIBUTE_FAILED=False

COPY docker/etc/ssh/sshd_config /etc/ssh/sshd_config
COPY docker/etc/subuid /etc/subuid
COPY docker/etc/subgid /etc/subgid

RUN sed -i '/CheckSpace/d' /etc/pacman.conf && \
  pacman --noconfirm -Sy && \
  pacman --noconfirm -S kubectl ansible mg python-jinja terraform \
    git python-netaddr tmux bonnie++ openssh mc p7zip zip vi tar jq \
    nano inetutils curl wget diffutils python-pip iputils net-tools \
    traceroute bind-tools bash-completion podman skopeo buildah kustomize\
    git-lfs awk go-yq && \
  echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
  locale-gen && \
  echo "LANG=en_US.UTF-8" >/etc/locale.conf && \
  useradd -m isb && \
  echo "source <(kubectl completion bash)" >> ~/.bashrc && \
  /usr/bin/ssh-keygen -A
    

EXPOSE 22

CMD ["/usr/bin/sshd","-D"]
