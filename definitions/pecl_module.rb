#
# Author::  Nick Muerdter (<nick.muerdter@nrel.gov>)
# Cookbook Name:: php
# Recipe:: pecl_module
#
# Copyright 2010, NREL
#

define :pecl_module, :version => nil, :enable => true do
  # PEAR needs to be installed before PECL is available.
  include_recipe "php::pear"

  if params[:enable]
    package_name = "#{params[:name]}"
    if(params[:version])
      package_name << "-#{params[:version]}"
    end

    answer_prompt = "yes '#{params[:answer_prompt]}' | " if params[:answer_prompt]

    execute "#{answer_prompt}pecl install --alldeps #{package_name}" do
      not_if "pecl info #{params[:name]} | grep 'Release Version *#{::Regexp.escape(params[:version])} '"
    end

    if(params[:ini])
      file "#{node[:php][:confd_path]}/#{params[:name]}.ini" do
        content params[:ini]
        owner "root"
        group "root"
        mode "0644"

        if(node.recipe?("apache2"))
          notifies :reload, "service[apache2]"
        end
      end
    end
  end
end
