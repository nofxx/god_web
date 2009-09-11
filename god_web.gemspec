# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{god_web}
  s.version = "0.2.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jesse Newland", "Marcos Piccinini"]
  s.date = %q{2009-09-11}
  s.default_executable = %q{god_web}
  s.description = %q{iPhone friendly sinatra web UI for God}
  s.email = %q{see@github.com}
  s.executables = ["god_web"]
  s.files = [
    ".gitignore",
     "Rakefile",
     "Readme.textile",
     "VERSION",
     "bin/god_web",
     "bugs/issue-28789de6ef59a981f26031fdf68030a1474251e8.yaml",
     "bugs/issue-949b87d1535bd55950daf2ec197a25ce2a0de13f.yaml",
     "bugs/issue-9579e138eec0aee906895eefa1cc546bd7d54b0d.yaml",
     "bugs/issue-b13b98759d3cf194cfee1bc00f0245f4b19f6cd2.yaml",
     "bugs/issue-cf27fa73c85d2b7a389cbdcfe669b9703380667c.yaml",
     "bugs/project.yaml",
     "god_web.gemspec",
     "lib/app.rb",
     "lib/environment.rb",
     "lib/god_web.rb",
     "public/.DS_Store",
     "public/app.css",
     "public/app.js",
     "public/icons/big_icon.png",
     "public/icons/bookmark.png",
     "public/icons/cpus.png",
     "public/icons/databases.png",
     "public/icons/gear.png",
     "public/icons/groups.png",
     "public/icons/info.png",
     "public/icons/key.png",
     "public/icons/mem.png",
     "public/icons/monitor.png",
     "public/icons/restart.png",
     "public/icons/ruby.png",
     "public/icons/server.png",
     "public/icons/start.png",
     "public/icons/stop.png",
     "public/icons/terminal.png",
     "public/icons/unmonitor.png",
     "public/icons/unmonitored.png",
     "public/icons/unmonitored_old.png",
     "public/icons/up.png",
     "public/icons/warn.png",
     "public/icons/wrench.png",
     "public/iui/backButton.png",
     "public/iui/blueButton.png",
     "public/iui/cancel.png",
     "public/iui/grayButton.png",
     "public/iui/greenButton.png",
     "public/iui/iui-logo-touch-icon.png",
     "public/iui/iui.css",
     "public/iui/iui.js",
     "public/iui/iuix.css",
     "public/iui/iuix.js",
     "public/iui/listArrow.png",
     "public/iui/listArrowSel.png",
     "public/iui/listGroup.png",
     "public/iui/loading.gif",
     "public/iui/pinstripes.png",
     "public/iui/redButton.png",
     "public/iui/selection.png",
     "public/iui/thumb.png",
     "public/iui/toggle.png",
     "public/iui/toggleOn.png",
     "public/iui/toolButton.png",
     "public/iui/toolbar.png",
     "public/iui/whiteButton.png",
     "public/iui/yellowButton.png",
     "spec/god_web_spec.rb",
     "spec/spec_helper.rb",
     "views/command.erb",
     "views/icon.erb",
     "views/status.erb",
     "views/top.erb",
     "views/watch.erb"
  ]
  s.homepage = %q{http://github.com/nofxx/god_web}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{iPhone friendly web UI for God}
  s.test_files = [
    "spec/spec_helper.rb",
     "spec/god_web_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<god>, [">= 0"])
      s.add_runtime_dependency(%q<sinatra>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<god>, [">= 0"])
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<god>, [">= 0"])
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
