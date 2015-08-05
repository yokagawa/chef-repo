#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
node['users']['add'].each do |u|
  result = shell_out("openssl passwd -1 '#{u['password']}'")
  user u['name'] do
    password result.stdout.chomp
    supports :manage_home => true
    action :create
  end

  directory "/home/#{u[:name]}/.ssh" do
    owner u[:name]
    group u[:name]
    mode 00755
    action :create
  end

  cookbook_file "/home/#{u[:name]}/.ssh/authorized_keys" do
    source "#{u[:name]}_authorized_keys"
    action :create
    owner u[:name]
    group u[:name]
    mode '0600'
  end

  cookbook_file '/etc/sudoers.d/wheel' do
    source 'wheel'
    action :create
    owner 'root'
    group 'root'
    mode '0600'
  end
end

node['users']['delete'].each do |u|
  user u[:name] do
    action :remove
  end
end