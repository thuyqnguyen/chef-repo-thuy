Chef::Log.info("starting the helper library....")

module Apache
  module Helper

    include Chef::Mixin::ShellOut

    def has_phuong?
      cmd = shell_out!('getent passwd phuong', {:returns => [0,2]})
      cmd.stderr.empty? && (cmd.stdout =~ /^phuong/)
    end
  end
end

Chef::Log.info("ending tyhe helper library....")

