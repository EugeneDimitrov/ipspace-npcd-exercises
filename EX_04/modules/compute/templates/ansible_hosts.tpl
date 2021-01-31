[web]
${web_name}     ansible_host=${web_ip}
[db]
${db_name}      ansible_host=${db_ip}
[jh]
${jh_name}      ansible_host=${jh_ip}

[all:vars]
ansible_user=${user}