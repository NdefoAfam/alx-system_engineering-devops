# Use Puppet to automate the task of creating a custom HTTP header response

exec { 'update':
  command => '/usr/bin/apt-get update',
}
-> package { 'nginx':
  ensure => 'present',
}
-> file_line { 'http_header':
  path  => '/etc/nginx/nginx.conf',
  line  => "http {\n\tadd_header X-Served-By \"${hostname}\";\n",
  match => 'http {',
  require => Package['nginx'],  # Add this line to ensure the package 'nginx' is installed before making changes to the file.
}
-> exec { 'run':
  command => '/usr/sbin/service nginx restart',
  require => File_line['http_header'],  # Add this line to ensure the file_line resource is applied before restarting Nginx.
}

