module.exports = (grunt) ->
  grunt.initConfig
    serverConf: grunt.file.readJSON("server.json")
    partialPath: 'src/template/partials/'
    watch:
      options:
        livereload: true
      html:
        files: ['src/template/**/*.html']
        tasks: ['htmlbuild:main']
    htmlbuild:
      options:            
        sections:
          the_header: '<%= partialPath %>header.html'
          the_footer: '<%= partialPath %>footer.html'
        data:
          version: '<%= grunt.template.today("yyyymmddHH") %>'
      main:
        dest: 'dist/html/'
        src: ['**/*.html','!partials/*.html']
        expand: true
        cwd: 'src/template/'
    clean:
      build: ['../htdocs/html/**']   
      options:
        force: true
    copy:
      build:
        dest: '../htdocs/html/'
        src: ['**', '!data.json']
        expand: true
        cwd: 'dist/html/'
    connect:
      server:
        options:
          base: 'dist'
          hostname: '<%= serverConf.hostname %>'
          port: '<%= serverConf.port %>'

  require('load-grunt-tasks')(grunt)
  grunt.registerTask 'default', ['connect', 'watch']
  grunt.registerTask 'build', ['clean:build', 'copy:build']
