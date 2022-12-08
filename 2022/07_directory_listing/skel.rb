# frozen_string_literal: true

class Skel
  MAXSIZE = 70_000_000
  def initialize
    @input = File.open('input.txt', 'r')
    @filesystem = {}
    @pwd = ''
    @last_command = ''
  end

  attr_reader :filesystem, :input

  attr_accessor :last_command, :pwd

  def parsed
    @parsed ||= input.map(&:chomp)
  end

  def add_or_update_directory(name)
    return if self.filesystem.key?(name)

    @filesystem[name] = {
      type: :directory,
      name: name,
      size: 0
    }
  end

  def run(line)
    self.last_command = line.gsub('$ ', '')
    if last_command == 'cd /'
      self.pwd = '/'
      add_or_update_directory(pwd)
    elsif last_command == 'cd ..'
      self.pwd = pwd.sub(/\/\w+$/, '')
    elsif (tokenizer = last_command.match(/cd (?<dirname>\w+)/))
      self.pwd = File.join(pwd, tokenizer[:dirname])
      add_or_update_directory(pwd)
    end
    p line
    p "pwd #{self.pwd}"
  end

  def add_file(line)
    p "line from add_line #{line}"
    size, name = line.split(' ')
    @filesystem[File.join(pwd, name)] = {
      type: size == 'dir' ? :directory : :file,
      name: name,
      size: size.to_i
    }
    curdir = pwd.dup
    while curdir != ''
      puts "adding to directory #{curdir}"

      filesystem[curdir][:size] = filesystem[curdir][:size] + size.to_i
      break if curdir.size == 1

      curdir = curdir.count('/') == 1 ? '/' : curdir.sub(/\/\w+$/, '')
    end
  end

  def resolve
    parsed.each do |line|
      if line.match?(/^\$ /)
        run(line)
        next
      end
      add_file(line)
    end
  end

  def list_lte(value)
    filesystem.select {|key, d| d[:size] <= value && d[:type] == :directory }
  end

  def sum_lte(value)
    list_lte(value).sum { |k,v|  v[:size] }
  end

  def list_gte(value)
    filesystem.select { |_key, d| d[:size] >= value && d[:type] == :directory }
  end

  def remaining_space
    MAXSIZE - filesystem['/'][:size]
  end
end

if $PROGRAM_NAME == __FILE__
  skel = Skel.new
  skel.resolve
  p "fs:"
  p skel.filesystem
  p "lte"
  p skel.sum_lte(100_000)
  p skel.remaining_space
  p x = (skel.list_gte(30000000 - skel.remaining_space)).min_by { |_k, f| f[:size] }
end
