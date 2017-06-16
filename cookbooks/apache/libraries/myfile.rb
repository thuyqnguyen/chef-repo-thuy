class Chef::Recipe::MyFile
    def self.file_exists?(myfile)
        ::File.exists?(myfile)
    end
end

