FROM apache/airflow:2.8.0

COPY config_scripts/ config_scripts

RUN pip install --user --upgrade pip
RUN pip install -r config_scripts/requirements.txt

USER root
RUN apt-get update && \
    apt-get install -y vim && \
    apt-get install -y git && \
    apt-get install -y tmux && \
    apt-get install -y neovim && \
    apt-get install -y tree && \
    apt-get install -y mc && \
    apt-get install -y ranger && \
    apt-get install -y vifm

# Assuming these files are in the context of your Docker build
COPY config_scripts/.vimrc /root/.vimrc
COPY config_scripts/.vimrc /root/.config/nvim/init.vim
COPY config_scripts/.tmux.conf /root/.tmux.conf

# Clean up APT when done to keep the image size small
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    sed -i 's/\r$//' /root/.vimrc && \
    sed -i 's/\r$//' /root/.tmux.conf && \
    sed -i 's/\r$//' /root/.config/nvim/init.vim
