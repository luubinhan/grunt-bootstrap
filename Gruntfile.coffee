module.exports = (grunt) ->
  grunt.initConfig
    serverConf: grunt.file.readJSON("server.json")
    partialPath: 'src/partials/'
    watch:
      options:
        livereload: true
      html:
        files: ['src/**/*.html']
        tasks: ['htmlbuild:main','concat:css']
      css:
        files: ['dist/*.css','src/css/*.css']
      scripts:
        files: ['dist/*.js']        
    htmlbuild:
      options:            
        sections:
          component: 
            slider: '<%= partialPath %>component/slider.html'
            pager: '<%= partialPath %>component/pager.html'
            video: '<%= partialPath %>component/content-video.html'
            product: '<%= partialPath %>component/content-product.html'
            post: '<%= partialPath %>component/19-content-post.html'
            product: '<%= partialPath %>component/26-content-product.html'
            image: '<%= partialPath %>component/content-image.html'
            gallery: '<%= partialPath %>component/content-gallery.html'
            job: '<%= partialPath %>component/content-job.html'
            woo_breadcrumbs: '<%= partialPath %>component/29-woo-breadcrumbs.html'
            related_products: '<%= partialPath %>component/32-woo-related-products.html'
            pagenavi: '<%= partialPath %>component/05-wp-pagenavi.html'
            
          widget: 
            wp_menu: '<%= partialPath %>widget/wp-menu.html'
            product_categories: '<%= partialPath %>widget/woo-product-categories.html'
            top_rated_product: '<%= partialPath %>widget/woo-top-rated-product.html'
            bwr_comments: '<%= partialPath %>widget/100-better-wordpress-recent-comments.html'
            recent_post: '<%= partialPath %>widget/111-wp-recent-post.html'
            pages: '<%= partialPath %>widget/110-wp-pages.html'
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

  require('load-grunt-tasks')(grunt)
  grunt.loadNpmTasks('grunt-contrib-concat')
  grunt.registerTask 'default', ['connect', 'watch']
  grunt.registerTask 'build', ['clean:build', 'copy:build', 'concat:css']
