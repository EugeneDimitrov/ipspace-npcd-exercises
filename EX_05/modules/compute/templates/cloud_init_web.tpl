#cloud-config
package_upgrade: true
packages:
  - nginx

write_files:
  - path: /var/www/html/index.html
    owner: '${user}:${user}'
    permissions: '0644'
    content: |
      <html>
      <head>
       <title>Nginx Server</title>
      </head>
      <body>
       <h1>Static page</h1>
       <p>Server name: <b>${server_name}</b>, IP address: <b>${server_ip}</b>, IPv6 address: <b>${server_ipv6}</b></p>
      </body>
      </html>