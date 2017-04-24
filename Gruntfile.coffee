module.exports = (grunt) ->
  grunt.initConfig
    serverConf: grunt.file.readJSON("server.json")
    partialPath: 'src/partials/'
    watch:
      options:
        livereload: true
      html:
        files: ['src/**/*.html']
        tasks: ['htmlbuild:main']
      css:
        files: ['less/*.less','imports/*.less']
        tasks: ['less:production']
      scripts:
        files: ['dist/*.js']     
        tasks: ['htmlbuild:main']  
    htmlbuild:
      options:            
        sections:
          component: 
            meta: '<%= partialPath %>component/post_meta.html'
          widget: 
            wp_menu: '<%= partialPath %>widget/wp_menu.html'
            mystyle_contact: '<%= partialPath %>widget/mystyle_contact.html'
            mystyle_social: '<%= partialPath %>widget/mystyle_social.html'
            mystyle_blog: '<%= partialPath %>widget/mystyle_blog.html'
            mystyle_subscribe: '<%= partialPath %>widget/mystyle_subscribe.html'
          layout:
            header: '<%= partialPath %>layout/header.html'
            footer: '<%= partialPath %>layout/footer.html'
        data:
          version: '<%= grunt.template.today("yyyymmddHH") %>'
        relative: true
        beautify: true
      main:
        dest: 'dist/'
        src: ['**/*.html','!partials/*.html']
        expand: true
        cwd: 'src'
    clean:
      build: ['dist/*.html','!css/**','!js/**']    
      options:
        force: true
    copy:
      build:
        dest: 'dist/'
        src: ['**', '!data.json']
        expand: true
        cwd: 'dist/'
    concat:      
      css:
        src: ['src/css/*.css'] 
        dest: 'dist/css/concat.css'         
    connect:
      server:
        options:
          base: 'dist'
          hostname: '<%= serverConf.hostname %>'
          port: '<%= serverConf.port %>'
          livereload: true
    less:
      production:
        options:
          paths: ['imports']
          imports:
            reference: ['variables.less', 'mixins.less']               
        files:          
          'dist/css/main.css': 'less/main.less'
          'dist/editor-style.css': 'less/editor-style.less'
          'dist/css/style-responsive.css': 'less/style-responsive.less' 
  require('load-grunt-tasks')(grunt)
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('assemble-less')
  grunt.registerTask 'default', ['connect', 'watch' ]
  grunt.registerTask 'build', ['clean:build', 'copy:build', 'less:production']
