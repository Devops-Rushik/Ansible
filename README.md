# Ansible
Ansible is an open source IT automation engine and configuration management tool to automate tasks such as provisioning, applicaiton deploying and managing infrastrucure across different environments.

Ansible is an agentless architecture that means no need to install any package or agent on the managed nodes.

For automating Linux and Windows servers, Ansible connects to the managed nodes through SSH and pushes out Ansible modules to them. These modules are written to be resource models of the desired state of the system. Ansible then executes these modules over SSH and deletes them when finished. These modules are designed to be idempotent so that they only make changes to a system when necessary.

For automating network devices and other IT appliances where modules cannot be executed, Ansible runs on the control node. Since Ansible is agentless, it can still communicate with devices without requiring an application or service to be installed on the managed node.

# Inventory
Ansible inventory file is a file that contins information about the hosts that going to be managed by Ansible. It contains hostnames, Ip addresses, variables and the servers are grouped if required.

# Playbook
Playbooks are the automation scripts in the ansible. They are writtem in YAML. Playbooks contain set of tasks that need to be executed on specified hosts remotely.

# Play
A Play is a single, complete execution unit within a playbook. It specifies which hosts to target and what tasks to execute on those hosts. Plays are used to group related tasks and execute them in a specific order.

# Modules
Modules are the building blocks of Ansible tasks. They are used to perform specific tasks on managed nodes.

# Tasks
Tasks are individual actions within a play that use modules to perform operations on managed nodes. Each task is executed in order and can include conditionals, loops, and handlers.

# Collections
Collections are a distribution format for Ansible content. They bundle together multiple roles, modules, plugins, and other Ansible artifacts. Collections make it easier to share and reuse Ansible content.

# Roles
Ansible role provides structured way to organize and resue Ansible Automation code. It helps in reuse of tasks in any number of playbooks by just calling the roles and it helps in simplyfing the complex configuration for easy understanding.

# Ansible Galaxy
Ansible Galaxy is a platform providing the features of sharing and downloading ansible roles. We can create ansible role using ansible galaxy                                                                                 ansible-galaxy init role_name
We can import the Galaxy from the git hub usingt the command:                                                                                                                                                                 ansible-galaxy role import <your_github_username> <role-name>
