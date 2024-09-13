# Start with a base image with PostgreSQL
FROM debian

RUN apt-get update && apt-get install -y \
    wget \
    gnupg2 \
    lsb-release \
    ca-certificates \
    curl \
    vim

# Set the EDB token as a build argument (replace with your actual token or pass it during build)
ARG EDB_TOKEN=

RUN apt-get install -y debian-keyring  # debian only
RUN apt-get install -y debian-archive-keyring  # debian only
RUN apt-get install -y apt-transport-https
# For Debian Stretch, Ubuntu 16.04 and later
RUN keyring_location=/usr/share/keyrings/enterprisedb-enterprise-archive-keyring.gpg
RUN curl -1sLf 'https://downloads.enterprisedb.com/<<edbtoken>>/enterprise/gpg.E71EB0829F1EF813.key' |  gpg --dearmor > /usr/share/keyrings/enterprisedb-enterprise-archive-keyring.gpg
RUN curl -1sLf 'https://downloads.enterprisedb.com/<<edbtoken>>/enterprise/config.deb.txt?distro=debian&codename=bookworm' > /etc/apt/sources.list.d/enterprisedb-enterprise.list
RUN apt-get update

RUN apt-get -y install edb-lasso

COPY lasso.conf /etc/edb-lasso.conf

RUN chmod 777 /etc/edb-lasso.conf

# Copy the shell script to run commands
COPY ./run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

# Expose PostgreSQL port
EXPOSE 5432

CMD ["/usr/local/bin/run.sh"]
