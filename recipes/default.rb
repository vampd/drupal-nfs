#
# Author::  Christopher Caldwell (<chrisolof@gmail.com>)
# Cookbook Name:: drupal
# Recipe:: nfs_server
#
# Copyright 2013, Christopher Caldwell.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

Chef::Log.debug "drupal::nfs_server - node[:nfs_exports] = #{node[:nfs_exports].inspect}"

include_recipe "nfs"

# Set up our exports, if we have any
unless node[:nfs_exports].nil?
  # Make sure we have the required package to export NFS shares
  package 'nfs-kernel-server'
  # Iterate through our exports
  node[:nfs_exports].each do |export_directory, export|
    # Iterate through the clients permitted to access this export
    export[:clients].each do |client_network, client|

      options_ary = Array.new
      
      options_ary << client[:options] if client[:options]

      options_ary << "anonuid=#{node['etc']['passwd'][client[:user_map]]['uid']}" if client[:user_map]

      options_ary << "anongid=#{node['etc']['passwd'][client[:group_map]]['gid']}" if client[:group_map]

      nfs_export "#{export_directory}" do
        network "#{client_network}"
        # Add export details if they've been specified (nfs cookbook provides
        # defaults)
        
        writeable client[:writeable] unless client[:writeable].nil?
        
        sync client[:sync] unless client[:sync].nil?
        
        options options_ary unless options_ary.nil?
      end
    end
  end
  # Make NFS server aware of our new export(s)
  execute "exportfs -ra" do
    command "exportfs -ra"
  end
end
