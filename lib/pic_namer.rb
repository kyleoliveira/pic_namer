require 'pic_namer/version'
require 'fileutils'
require 'exifr'

module PicNamer

  DATE_FORMAT = '%d%^b%Y'

  class << self

    # Renames many files
    # @param [String] dir The directory containing the files to rename
    # @param [String] prefix The prefix for the filename
    # @param [String] suffix The suffix for the filename
    def bulk_rename(dir, prefix, suffix='jpg')
      PicNamer::check_arguments(dir, prefix, suffix)

      files = File.join(dir, "*.#{suffix}")

      Dir[files].each do |file|
        rename_file(dir, file, prefix, suffix)
      end
    end

    # Renames a given file
    # @param [String] dir The directory containing the files to rename
    # @param [String] file The filename
    # @param [String] prefix The prefix for the filename
    # @param [String] suffix The suffix for the filename
    def rename_file(dir, file, prefix, suffix)
      metadata = EXIFR::JPEG.new(file)
      creation_date = metadata.date_time.nil? ? Time.now.strftime(DATE_FORMAT) : metadata.date_time.strftime(DATE_FORMAT)
      counter = 0
      filename = "#{dir}/#{PicNamer::build_filename(prefix, creation_date, counter, suffix)}"

      while File.exists?(filename)
        counter += 1
        filename = "#{dir}/#{PicNamer::build_filename(prefix, creation_date, counter, suffix)}"
      end

      FileUtils.mv(file, filename)
    end

    # Builds a new filename
    # @param [String] prefix The prefix for the filename
    # @param [String] creation_date The creation date of the file
    # @param [Integer] counter The count of files with identical prefix, creation_date, and suffix
    # @param [String] suffix The suffix for the filename
    def build_filename(prefix, creation_date, counter, suffix)
      "#{prefix}_#{creation_date}_#{counter.to_s.rjust(4, '0')}.#{suffix}"
    end

    # Checks the arguments
    # @param [String] dir The directory containing the files to rename
    # @param [String] prefix The prefix for the filename
    # @param [String] suffix The suffix for the filename
    def check_arguments(dir, prefix, suffix)
      raise ArgumentError, 'Insufficient number of arguments provided! You need to provide: directory, prefix, suffix' if (dir.nil? && prefix.nil? && suffix.nil?)
      raise ArgumentError, 'You did not specify a directory!' if dir.nil?
      raise ArgumentError, 'You did not specify a prefix!' if prefix.nil?
    end

  end

end
