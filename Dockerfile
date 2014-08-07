FROM debian:wheezy
MAINTAINER Olivier Ligot <oligot@gmail.com>

RUN apt-get -qq update
RUN apt-get -qq install wget bzip2 git libgtk2.0-dev libxtst-dev

# Add user docker
RUN useradd docker
RUN mkdir -p /home/docker/src /home/docker/bin
RUN chown -R docker:docker /home/docker/
USER docker
ENV HOME /home/docker
WORKDIR /home/docker/src

# Download and install EiffelStudio
RUN wget --no-check-certificate -q https://ftp.eiffel.com/pub/download/14.05/Eiffel_14.05_gpl_95417-linux-x86-64.tar.bz2 && \
 tar xfj Eiffel_14.05_gpl_95417-linux-x86-64.tar.bz2 && \
 rm Eiffel_14.05_gpl_95417-linux-x86-64.tar.bz2
RUN ln -s Eiffel_14.05/ Eiffel

# Define Eiffel environment variables
ENV ISE_EIFFEL $HOME/src/Eiffel
ENV ISE_PLATFORM linux-x86-64
ENV ISE_LIBRARY $ISE_EIFFEL
ENV EIFFEL_LIBRARY $HOME/eiffel
ENV PATH $PATH:$ISE_EIFFEL/studio/spec/$ISE_PLATFORM/bin

# Clone EWF repository
RUN git clone https://github.com/EiffelWebFramework/EWF.git

# Compile filter example
WORKDIR EWF/examples/filter
RUN ec -config filter-safe.ecf -c_compile -finalize && \
 mv EIFGENs/filter/F_code/filter $HOME/bin && \
 rm -r EIFGENs
USER root
RUN ln -s /home/docker/bin/filter /usr/local/bin
