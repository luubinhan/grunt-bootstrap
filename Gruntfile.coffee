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
            product_categories: '<%= partialPath %>widget/woo_product_categories.html'
            top_rated_product: '<%= partialPath %>widget/woo_top_rated_product.html'
            bwr_comments: '<%= partialPath %>widget/better_wordpress_recent_comments.html'
            recent_post: '<%= partialPath %>widget/wp_recent_post.html'
            pages: '<%= partialPath %>widget/wp_pages.html'
            archieve: '<%= partialPath %>widget/wp_archieve.html'
            categories: '<%= partialPath %>widget/wp_categories.html'
            menu: '<%= partialPath %>widget/wp_menu.html'
            meta: '<%= partialPath %>widget/wp_meta.html'
            recent_post_extend: '<%= partialPath %>widget/recent_post_extended.html'
            mystyle_contact: '<%= partialPath %>widget/mystyle_contact.html'
            mystyle_social: '<%= partialPath %>widget/mystyle_social.html'
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
