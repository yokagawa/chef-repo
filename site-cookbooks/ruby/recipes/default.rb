#
# Cookbook Name:: ruby
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# rbenvインストール
git '/usr/local/rbenv' do
  repository 'https://github.com/sstephenson/rbenv.git'
  reference 'master'
  user 'root'
  group 'root'
  action :checkout
end

directory "/usr/local/rbenv/shims" do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end

directory "/usr/local/rbenv/versions" do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end

directory "/usr/local/rbenv/plugins" do
  owner 'root'
  group 'root'
  mode 00755
  action :create
end

cookbook_file "/etc/profile.d/rbenv.sh" do
  source 'rbenv.sh'
  owner 'root'
  group 'root'
  mode 0644
end

# ruby-buildインストール
git '/usr/local/rbenv/plugins/ruby-build' do
  repository 'https://github.com/sstephenson/ruby-build.git'
  reference 'master'
  user 'root'
  group 'root'
  action :checkout
end

# ruby install
execute 'rbnev-install' do
  not_if 'source /etc/profile.d/rbenv.sh; rbenv versions | grep 2.2.2'
  command 'source /etc/profile.d/rbenv.sh; rbenv install 2.2.2'
end

# rubyバージョン設定
execute 'rbnev-global' do
  not_if 'source /etc/profile.d/rbenv.sh; rbenv global | grep 2.2.2'
  command 'source /etc/profile.d/rbenv.sh; rbenv global 2.2.2; rbenv rehash'
end