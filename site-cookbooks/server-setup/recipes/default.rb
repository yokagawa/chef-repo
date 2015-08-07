#
# Cookbook Name:: server-setup
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "yum-update" do
  user "root"
  command "yum -y update"
  action :run
end

# パッケージインストール
pkgs = %w(git gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel libffi-devel libxml2 libxslt libxml2-devel libxslt-devel)
pkgs.each do |p|
  package p do
    action :install
  end
end