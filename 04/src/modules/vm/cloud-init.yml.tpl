#cloud-config
users:
  - name: ${username}
    groups: sudo
    shell: /bin/bash
    sudo: ['ALL=(ALL) NOPASSWD:ALL']
    ssh_authorized_keys:
      - ${ssh_public_key}

packages:
  - nginx
  - curl
  - htop

package_update: true
package_upgrade: true

runcmd:
  - systemctl enable nginx
  - systemctl start nginx
  - echo "Welcome to ${username} VM - nginx is running on port ${nginx_port}" | sudo tee /var/www/html/index.html
  - echo "Server: $(hostname)" | sudo tee -a /var/www/html/index.html
  - echo "IP: $(hostname -I)" | sudo tee -a /var/www/html/index.html