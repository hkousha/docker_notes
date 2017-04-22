# escape=\ (backslash)
# Setting escape character to \ (that's the default anyway) ^
# Parser directives have to come at the begining.


# format: FROM:TAG
FROM python:2.7 

# Labels are being used to add metadata to an image.
# Docker recommends combining labels into a single LABEL
LABEL version="1.0.0"\
      "description"="Notes and docker reference/cheatsheet."

# Copy print.bash to /tmp/
COPY *.py /tmp/
# Add does the same
#a Add also untar files and can download from urls
ADD dummy_flask.py /home/

# install pip and flask 
RUN apt-get -y update && apt-get install -y python-pip
RUN ["pip", "install", "flask"]

# Set ROOT_DIR to /root
ENV ROOT_DIR /bar
# If var doesn't exist then set otherwise keep value
ENV EXIST ${NOT_EXIST:-"exist now"} 

# Informs Docker that container will listen to port 8000
# still need to run the application using -p for the port to be reachable on the host.
EXPOSE 8000

# There can only be one CMD instruction. If more than one CMD then last one
# Better way for this is to use ENTRYPOINT and CMD for defaults
# Run a dummy flask
ENTRYPOINT ["/tmp/dummy_flask.py"]
CMD ["--p=8000"]

