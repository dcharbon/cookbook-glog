include_recipe 'build-essential'

version = node[:glog][:version]
source = node[:glog][:source]
checksum = node[:glog][:checksum]

unless File.exists?("/usr/local/lib/libglog.so")
  remote_file "/tmp/glog-#{version}.tar.gz" do
    source "#{source}glog-#{version}.tar.gz"
    mode "0644"
    checksum "#{checksum}"
  end

  execute "ungzip-glog" do
    command "tar xzf /tmp/glog-#{version}.tar.gz"
    creates "/tmp/glog-#{version}/README"
    cwd "/tmp"
    action :run
  end

  execute "make-install-glog" do
    command "./configure && make && make check && make install && ldconfig"
    cwd "/tmp/glog-#{version}"
    action :run
  end
end
