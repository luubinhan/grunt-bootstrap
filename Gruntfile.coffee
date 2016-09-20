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
            image: '<%= partialPath %>component/content-image.html'
            gallery: '<%= partialPath %>component/content-gallery.html'
            job: '<%= partialPath %>component/content-job.html'
            wp_comment: '<%= partialPath %>component/comment.html'
            share: '<%= partialPath %>component/share-social.html'
            pagenavi: '<%= partialPath %>component/wp-pagenavi.html'
            subscribe: '<%= partialPath %>component/subscribe-form.html'            
            breadcrumb: '<%= partialPath %>component/bootstrap-breadcrumb.html'            
            extra: '<%= partialPath %>component/extra.html'
            faq: '<%= partialPath %>component/faq.html.html'
            contact_form: '<%= partialPath %>component/contact-form-7.html'
            post: '<%= partialPath %>component/content-post.html'
            product: '<%= partialPath %>component/content-product.html'
            woo_breadcrumbs: '<%= partialPath %>component/woo-breadcrumbs.html'
            slider_swiper: '<%= partialPath %>component/slider-swiper.html'
            related_products: '<%= partialPath %>component/woo-related-products.html'
            post_grid: '<%= partialPath %>component/content-post-grid.html'
            wp_pager: '<%= partialPath %>component/wp-pager.html'
            meta: '<%= partialPath %>component/post-meta.html'
            home_hero: '<%= partialPath %>component/home-hero.html'
            page_hero: '<%= partialPath %>component/page-hero.html'
            
          widget: 
            wp_menu: '<%= partialPath %>widget/wp-menu.html'
            product_categories: '<%= partialPath %>widget/woo-product-categories.html'
            top_rated_product: '<%= partialPath %>widget/woo-top-rated-product.html'
            bwr_comments: '<%= partialPath %>widget/better-wordpress-recent-comments.html'
            recent_post: '<%= partialPath %>widget/wp-recent-post.html'
            pages: '<%= partialPath %>widget/wp-pages.html'
            archieve: '<%= partialPath %>widget/wp-archieve.html'
            categories: '<%= partialPath %>widget/wp-categories.html'
            menu: '<%= partialPath %>widget/wp-menu.html'
            meta: '<%= partialPath %>widget/wp-meta.html'
            recent_post_extend: '<%= partialPath %>widget/recent-post-extended.html'
            mystyle_contact: '<%= partialPath %>widget/mystyle-contact.html'
            mystyle_social: '<%= partialPath %>widget/mystyle-social.html'
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
