#
#   ref https://github.com/tebeka/pythonwise/blob/master/docker-miniconda/Dockerfile
#
#   miniconda vers: http://repo.continuum.io/miniconda
#   sample variations:
#     Miniconda3-latest-Linux-armv7l.sh
#     Miniconda3-latest-Linux-x86_64.sh
#     Miniconda3-py38_4.10.3-Linux-x86_64.sh
#     Miniconda3-py37_4.10.3-Linux-x86_64.sh
#
#   py vers: https://anaconda.org/anaconda/python/files
#   tf vers: https://anaconda.org/anaconda/tensorflow/files
#   tf-mkl vers: https://anaconda.org/anaconda/tensorflow-mkl/files
# https://hub.docker.com/_/ubuntu?tab=tags&page=1&name=20.04

# ARG UBUNTU_VER=18.04
ARG UBUNTU_VER=20.04
ARG CONDA_VER=latest
ARG OS_TYPE=x86_64
ARG PY_VER=3.10
ARG TF_VER=2.5.0
ARG ZEEP_VER=4.1.0
ARG PYODBC_VER=4.0.32 
ARG PANDAS_VER=1.4.2
FROM ubuntu:${UBUNTU_VER}
# FROM ubuntu:20.04


# https://futurestud.io/tutorials/ubuntu-debian-fix-sudo-command-not-found
# Open question.  Do I need to run as non-root user
# https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user#:~:text=Many%20Docker%20images%20use%20root,that%20you%20should%20know%20about.
# RUN apt-get install sudo -y 

# had problems installing all of this on one layer.
RUN apt-get update && apt-get install -yq \
  software-properties-common \
  wget \
  dnsutils \
  iputils-ping \
  netcat \
  tree \
  curl \
  vim \
  msmtp \
  msmtp-mta \
  mailutils \ 
  bsd-mailx \
  && rm -rf /var/lib/apt/lists/*


COPY ./msmtprc /etc/msmtprc
COPY ./mail.rc /etc/mail.rc
COPY ./aliases /etc/aliases

WORKDIR /app


# https://blog.yaakov.online/kubernetes-getting-pods-to-talk-to-the-internet/#:~:text=If%20you%20install%20this%20with,make%20connections%20to%20the%20Internet.
# some devs like to let it hang https://stackoverflow.com/a/42873832/868736
# ENTRYPOINT ["tail", "-f", "/dev/null"]
# CMD [ "python", "soapTest.py" ]
