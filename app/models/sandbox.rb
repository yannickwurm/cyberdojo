
class Sandbox

  def initialize(avatar)
    @disk   = Thread.current[:disk]   || fatal("no disk")
    @git    = Thread.current[:git]    || fatal("no git")
    @runner = Thread.current[:runner] || fatal("no runner")
    @avatar = avatar
  end

  def dir
    @disk[path]
  end

  def path
    @avatar.path + 'sandbox' + @disk.dir_separator
  end

  def write(delta, visible_files)
    delta[:changed].each do |filename|
      dir.write(filename, visible_files[filename])
    end
    delta[:new].each do |filename|
      dir.write(filename, visible_files[filename])
      @git.add(path, filename)
    end
    delta[:deleted].each do |filename|
      @git.rm(path, filename)
    end
  end

  def test(max_duration = 15)
    output = @runner.run(path, "./cyber-dojo.sh", max_duration)
    output.encode('utf-8', 'binary', :invalid => :replace, :undef => :replace)
  end

private

  def fatal(diagnostic)
    raise diagnostic
  end

end
