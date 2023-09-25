# SHELL SCRIPTING

These are the scripts that I wrote for the course "Linux Shell Scripting Projects", https://www.udemy.com/course/linux-shell-scripting-projects .

The scripts have the (intended) effect of making important changes in the system that they are run on (i.e. creating multiple new users). Therefore it is recommended to run this on a virtual machine. Personally I used Vagrant, with the image recommended in the course (jasonc/centos7). To replicate my set-up use:

```console
vagrant box add jasonc/centos7
mkdir [empty_directory]
cd [empty_directory]
vagrant init jasonc/centos7
vagrant up
vagrant ssh
```
