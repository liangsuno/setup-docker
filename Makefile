
##########################################
# Lifecycle
##########################################

# install stage will install the software and bring it live
install: prepare

# prepare stage is to setup all the necessary basic software or configurations 
# required for the next stage >> install
prepare: setup-docker

##########################################
# Commands
##########################################

setup-ansible:
	[ -f /usr/bin/ansible ] || sudo yum install ansible

ping:
	ansible all -i hosts -m ping

setup-docker: setup-ansible
	service docker status >/dev/null || ansible-galaxy install -r requirements.yml
	service docker status >/dev/null || sudo ansible-playbook -i hosts setup-docker.yml
	sudo usermod -a -G docker ${USER}

setup-docker-force: setup-ansible
	ansible-galaxy install -r requirements.yml
	sudo ansible-playbook -i hosts setup-docker.yml
	sudo usermod -a -G docker ${USER}
