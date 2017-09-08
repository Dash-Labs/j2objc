Pod::Spec.new do |s|
  s.name         = "J2ObjC"
  s.version      = "0.9.8.1"
  s.license      = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  s.summary      = "J2ObjC's JRE emulation library, emulates a subset of the Java runtime library."
  s.homepage     = "https://github.com/google/j2objc"
  s.author       = "Google Inc."
  s.source       = { :git => "https://github.com/cunqi/j2objc.git", :tag => "v#{s.version}-lib" }

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  s.requires_arc = false
  s.default_subspec = 'lib/jre'

  # Top level attributes can't be specified by subspecs.
  s.header_mappings_dir = 'dist/include'
  #s.prepare_command = <<-CMD
  #  scripts/download_distribution.sh
  #CMD

  s.subspec 'lib' do |lib|
    lib.frameworks = 'Security'
    lib.osx.frameworks = 'ExceptionHandling'
    lib.xcconfig = { 'LIBRARY_SEARCH_PATHS' => '"$(PODS_ROOT)/J2ObjC/dist/lib"',
    'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/J2ObjC/dist/include"',
    'FRAMEWORK_SEARCH_PATHS' => '"${PODS_ROOT}/J2ObjC/dist/frameworks"' }

    lib.subspec 'jre' do |jre|
      jre.preserve_paths = 'dist'
      jre.libraries = 'jre_emul', 'iconv', 'z'
      # jre.xcconfig = { 'OTHER_LDFLAGS' => '-force_load ${PODS_ROOT}/J2ObjC/dist/lib/libjre_emul.a' }
    end

    lib.subspec 'jsr305' do |jsr305|
      jsr305.dependency 'J2ObjC/lib/jre'
      jsr305.libraries = 'jsr305'
    end

    lib.subspec 'guava' do |guava|
      guava.dependency 'J2ObjC/lib/jre'
      guava.libraries = 'guava'
    end
  end
end
