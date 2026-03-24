#cloud-config
users:
  - name: ${username}
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh_authorized_keys:
      - ${ssh_public_key}

package_update: true
package_upgrade: true

packages:
  - nginx
  - curl
  - htop
  - vim

runcmd:
  - systemctl enable nginx
  - systemctl start nginx
  - echo "<h1>Welcome to ${username} VM</h1>" | sudo tee /var/www/html/index.html