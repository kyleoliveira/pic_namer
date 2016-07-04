#!/usr/bin/env ruby

require 'pic_namer'

dir = ARGV[0]
prefix = ARGV[1]
suffix = ARGV[2]

PicNamer::bulk_rename dir, prefix, suffix
