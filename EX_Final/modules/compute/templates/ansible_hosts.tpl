
[jh]
jumphost ansible_host=${jh_ip_gwc}

[app]
netbox-gwc ansible_host=${app_ip_gwc}
netbox-ne ansible_host=${app_ip_ne}

[db_act]
psql-act ansible_host=${db_ip_gwc}

[db_stb]
psql-stb ansible_host=${db_ip_ne}

[db:children]
db_act
db_stb

[db:vars]
ansible_ssh_pipelining=True

[all:vars]
ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p -q ${admin_user}@${jh_dns_name}"'
ansible_ssh_user=${admin_user}
