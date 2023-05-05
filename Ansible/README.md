An Ansible role is a collection of related tasks, templates, files, and variables that are grouped together in a structured way to be reused and shared across multiple playbooks. 
Roles help to organize and simplify complex automation tasks, making it easier to maintain and scale infrastructure deployments. Roles can also be shared with others in the community, making it easier to collaborate and build upon existing automation solutions.

Define the target hosts
This Ansible task installs the required packages from the prompt using the apt package manager.
It sets the state to 'present', meaning that it ensures that these packages are installed on the target system.
The 'become' keyword allows the task to be executed with administrative privileges. 
Install required packages

This task adds the Docker GPG key to the system's APT keyring, which is used for package authentication.
The key can be verified and used to authenticate Docker packages.
Add Docker GPG key

This Ansible task adds the Docker repository to an Ubuntu system by using the `apt_repository` module.
It specifies the URL of the repository, which includes the release name (`bionic`) and package architecture (`amd64`).
The task is conditional on the distribution being Ubuntu.
Add Docker repository for Ubuntu

This Ansible task adds the Docker repository for Debian by defining the repository location and state as "present". 
It is conditional and only executed when the target system is running Debian.
Add Docker repository for Debian

The "update_cache" parameter in the apt module updates the apt package cache 
on the target system to ensure the latest package information is available for installation or upgrade. 
The "become: yes" statement is used to execute the task with root privileges.
Update apt packages

This Ansible task uses the `apt` module to install the `docker-ce` package on the target machine with root privileges, ensuring that it is present and up-to-date.
Install Docker CE

This Ansible task downloads the Docker Compose binary from a specific URL, saves it to the local filesystem at "/usr/local/bin/docker-compose", and sets the execute permission on the file.
Install Docker Compose

The code adds the current user to the `docker` group, allowing them to execute Docker commands without the need for sudo. 
The `user` module is used with `append` set to `yes` to add the user to the group without removing them from any other groups.
Add the current user to the docker group

This adds a tag "docker" to the listed tasks in the playbook, allowing them to be selectively executed during playbook runs.
Tag the tasks
