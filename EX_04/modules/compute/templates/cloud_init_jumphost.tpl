#cloud-config
package_upgrade: true
packages:
  - ansible
  - git

runcmd:
  - git clone https://github.com/EugeneDimitrov/ipspace-npcd-scripts.git /home/${user}/ipspace-npcd-scripts