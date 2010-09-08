#!/usr/bin/env macruby
# encoding: utf-8
framework 'Foundation'
require   'raisins'

module Alias
  extend self
  NSURLBookmarkCreationOptionsMap = {
    :minimal                    => NSURLBookmarkCreationMinimalBookmark,
    :for_file                   => NSURLBookmarkCreationSuitableForBookmarkFile,
    :prefer_file_id             => NSURLBookmarkCreationPreferFileIDResolution,
    :minimal_bookmark           => NSURLBookmarkCreationMinimalBookmark,
    :suitable_for_bookmark_file => NSURLBookmarkCreationSuitableForBookmarkFile,
    :prefer_file_id_resolution  => NSURLBookmarkCreationPreferFileIDResolution,
  }

  def data_from_url(url, first_option = :minimal, *more_options)
    options = NSURLBookmarkCreationOptionsMap.values_at(*[first_option].concat(more_options)).inject(0) { |acc, opt| acc | opt }
    raisingNSError { |e| url.bookmarkDataWithOptions(options, includingResourceValuesForKeys:nil, relativeToURL:nil, error:e) }
  end

  def url_from_data(alias_data)
    options = NSURLBookmarkResolutionWithoutUI | NSURLBookmarkResolutionWithoutMounting
    raisingNSError { |e| NSURL.URLByResolvingBookmarkData(alias_data, options:options, relativeToURL:nil, bookmarkDataIsStale:nil, error:e) }
  end

  def data_from_alias_url(alias_url)
    raisingNSError { |e| NSURL.bookmarkDataWithContentsOfURL(alias_url, error:e) }
  end

  # ---

  def data_from_path(path, *args)
    data_from_url(NSURL.fileURLWithPath(path), *args)
  end

  def path_from_data(alias_data)
    url_from_data(alias_data).path
  end

  def path_from_alias_path(alias_path)
    url_from_data(data_from_alias_url(NSURL.fileURLWithPath(alias_path))).path
  end

end
