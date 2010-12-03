#
# Author::  Nick Muerdter (<nick.muerdter@nrel.gov>)
# Cookbook Name:: php
# Recipe:: pecl_module
#
# Copyright 2010, NREL
#

define :pecl_module, :version => nil, :enable => true do
  if params[:enable]
    package_name = "#{params[:name]}"
    if(params[:version])
      package_name << "-#{params[:version]}"
    end

    answer_prompt = "yes '#{params[:answer_prompt]}' | " if params[:answer_prompt]

    execute "#{answer_prompt}pecl install --alldeps #{package_name}" do
      not_if "pecl info #{params[:name]} | grep 'Release Version *#{::Regexp.escape(params[:version])} '"
    end
  end
end
