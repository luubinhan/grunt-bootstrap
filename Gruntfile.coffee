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
        files: ['dist/*.css','src/css/*.css','dist/css/*.css']
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
            post_grid: '<%= partialPath %>component/33-content-post-grid.html'
            wp_pager: '<%= partialPath %>component/34-wp-pager.html'
            share: '<%= partialPath %>component/04-share-social.html'
            wp_comment: '<%= partialPath %>component/01-comment.html'
            contact_form: '<%= partialPath %>component/18-contact-form-7.html'            
            slider_swiper: '<%= partialPath %>component/31-slider-swiper.html'            
            subscribe: '<%= partialPath %>component/07-subscribe-form.html'            
            meta: '<%= partialPath %>component/35-post-meta.html'            
                        
          widget: 
            wp_menu: '<%= partialPath %>widget/wp-menu.html'
            product_categories: '<%= partialPath %>widget/woo-product-categories.html'
            top_rated_product: '<%= partialPath %>widget/woo-top-rated-product.html'
            bwr_comments: '<%= partialPath %>widget/100-better-wordpress-recent-comments.html'
            recent_post: '<%= partialPath %>widget/111-wp-recent-post.html'
            pages: '<%= partialPath %>widget/110-wp-pages.html'
            archieve: '<%= partialPath %>widget/106-wp-archieve.html'
            categories: '<%= partialPath %>widget/107-wp-categories.html'
            menu: '<%= partialPath %>widget/108-wp-menu.html'
            meta: '<%= partialPath %>widget/109-wp-meta.html'
            recent_post_extend: '<%= partialPath %>widget/102-recent-post-extended.html'
            mystyle_contact: '<%= partialPath %>widget/36-mystyle-contact.html'
            mystyle_social: '<%= partialPath %>widget/115-mystyle-social.html'
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
