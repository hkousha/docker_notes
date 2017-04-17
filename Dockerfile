# escape=\ (backslash)
# Setting escape character to \ (that's the default anyway) ^
# Parser directives have to come at the begining.


# format: FROM:TAG
FROM ubuntu:\
16.04 

# Labels are being used to add metadata to an image.
# Docker recommends combining labels into a single LABEL
LABEL version="1.0.0"\
      "description"="Notes and docker reference/cheatsheet."

# Copy print.bash to /tmp/
COPY print /tmp/

# install fortunes and print the version 
RUN apt-get -y update && apt-get install -y fortunes
RUN ["apt-cache", "madison", "fortunes"]

# Set ROOT_DIR to /root
ENV ROOT_DIR /bar
# If var doesn't exist then set otherwise keep value
ENV EXIST ${NOT_EXIST:-"exist now"} 
# There can only be one CMD instruction. If more than one CMD then last one
# Print ROOT_DIR & NOT_EXIST
CMD /tmp/print
