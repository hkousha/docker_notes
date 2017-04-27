# escape=\ (backslash)
# Setting escape character to \ (that's the default anyway) ^
# Parser directives have to come at the begining.


# format: FROM:TAG
FROM python:2.7 

# Labels are being used to add metadata to an image.
# Docker recommends combining labels into a single LABEL
LABEL version="1.0.0"\
      "description"="Notes and docker reference/cheatsheet."


# Create a new dir 
RUN mkdir /scripts
# Copy print.bash to /scripts/
COPY *.py /scripts/
# Add does the same
#a Add also untar files and can download from urls
ADD dummy_flask.py /home/

# create a new mount for it
VOLUME /scripts
RUN df -h

# install pip and flask 
RUN apt-get -y update && apt-get install -y python-pip
RUN ["pip", "install", "flask"]

# when running docker we can pass argument --build-arg user=<username> in built time
ARG user

# Set DUMMY_DIR to /root
ENV DUMMY_DIR /scripts
# If var doesn't exist then set otherwise keep value
ENV USER_NAME ${user:-"flask"} 

# Informs Docker that container will listen to port 8000
# still need to run the application using -p for the port to be reachable on the host.
EXPOSE 8000

# Create a new user and set user to flask 
RUN useradd --shell /bin/bash --uid 22 $USER_NAME
USER $USER_NAME
#USER 22
RUN whoami

# Change working dir to /scripts
# If the WORKDIR doesn’t exist, it will be created 
WORKDIR $DUMMY_DIR

# make sure we are in /scripts
RUN pwd

# There can only be one CMD instruction. If more than one CMD then last one
# Better way for this is to use ENTRYPOINT and CMD for defaults
# Run a dummy flask
ENTRYPOINT ["./dummy_flask.py"]
CMD ["8000"]
