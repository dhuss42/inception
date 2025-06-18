FROM debian:bookworm

# usr/local/bin
# -> best practice for user-installed software
# -> is included in PATH 


# tar extracts file from an archive
	# -what is an archive?
# tar packs/unpacks .tar archives
# -x extracts file from archive
# -z filter the archieve through gzip
# -f specifies the name of the file to operate on
# portainer.tar.gz is the input file
# -C changes to the directory before extracting
# --strip-components=1 removes first level of directory in path
RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y \
		curl \
		tar && \
	curl -L -o portainer.tar.gz https://github.com/portainer/portainer/releases/download/2.27.6/portainer-2.27.6-linux-amd64.tar.gz && \
	mkdir -p /usr/local/bin && \
	tar -xzf portainer.tar.gz -C /usr/local/bin --strip-components=1 && \
	chmod +x /usr/local/bin/portainer && \
    rm portainer.tar.gz

# runs portainer, 
# --data /data tells portrainer where to store its persistent data (mounted in compose)
# last to strings are password configuration
# CMD ["portainer", "--data", "/data", "--admin-password-file", "/run/secrets/portainer_admin_pw"]
CMD ["portainer", "--data", "/data"]