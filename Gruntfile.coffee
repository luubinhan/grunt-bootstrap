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
        files: ['dist/*.css','src/css/*.css','dist/css/*.css','less/*.less','imports/*.less']
        tasks: ['less:production']
      scripts:
        files: ['dist/*.js']     
        tasks: ['htmlbuild:main']  
    htmlbuild:
      options:            
        sections:
          component: 
            slider: '<%= partialPath %>component/slider.html'
            pager: '<%= partialPath %>component/pager.html'
            video: '<%= partialPath %>component/content_video.html'
            product: '<%= partialPath %>component/content_product.html'
            image: '<%= partialPath %>component/content_image.html'
            gallery: '<%= partialPath %>component/content_gallery.html'
            job: '<%= partialPath %>component/content_job.html'
            wp_comment: '<%= partialPath %>component/comment.html'
            share: '<%= partialPath %>component/share_social.html'
            pagenavi: '<%= partialPath %>component/wp_pagenavi.html'
            subscribe: '<%= partialPath %>component/subscribe_form.html'            
            breadcrumb: '<%= partialPath %>component/bootstrap_breadcrumb.html'            
            bootstrap_pager: '<%= partialPath %>component/bootstrap_pager.html'            
            extra: '<%= partialPath %>component/extra.html'
            faq: '<%= partialPath %>component/faq.html.html'
            contact_form: '<%= partialPath %>component/contact_form_7.html'
            post: '<%= partialPath %>component/content_post.html'
            product: '<%= partialPath %>component/content_product.html'
            woo_breadcrumbs: '<%= partialPath %>component/woo_breadcrumbs.html'
            slider_swiper: '<%= partialPath %>component/slider_swiper.html'
            related_products: '<%= partialPath %>component/woo_related_products.html'
            post_grid: '<%= partialPath %>component/content_post_grid.html'
            wp_pager: '<%= partialPath %>component/wp_pager.html'
            meta: '<%= partialPath %>component/post_meta.html'
            home_hero: '<%= partialPath %>component/home_hero.html'
            page_hero: '<%= partialPath %>component/page_hero.html'
            
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
          'dist/css/concat.css': 'less/concat.less'          
             
  require('load-grunt-tasks')(grunt)
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.loadNpmTasks('assemble-less')
  grunt.registerTask 'default', ['connect', 'watch' ]
  grunt.registerTask 'build', ['clean:build', 'copy:build', 'less:production']
