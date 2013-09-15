module.exports = (grunt) ->
  
  grunt.task.loadNpmTasks 'grunt-contrib-compass'
  grunt.task.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.task.loadNpmTasks 'grunt-contrib-concat'
  grunt.task.loadNpmTasks 'grunt-contrib-uglify'
  grunt.task.loadNpmTasks 'grunt-contrib-copy'
  grunt.task.loadNpmTasks 'grunt-contrib-watch'

  grunt.initConfig

    compass:
      dist:
        options:
          config: 'config.rb'

    cssmin:
      main:
        src: 'htdocs/_DEVELOP/css/common.css'
        dest: 'htdocs/_DEVELOP/css/common.min.css'

    uglify:
      head:
        files:
          'htdocs/_DEVELOP/js/head/mine/ua.min.js': 'htdocs/_DEVELOP/js/head/mine/ua.js'
      main:
        files:
          'htdocs/_DEVELOP/js/main/mine/setup.min.js': 'htdocs/_DEVELOP/js/main/mine/setup.js'
          'htdocs/_DEVELOP/js/main/mine/ga.min.js': 'htdocs/_DEVELOP/js/main/mine/ga.js'

    concat:
      js_head_nomin:
        src: [
          'htdocs/_DEVELOP/js/head/libs/modernizr.js'
          'htdocs/_DEVELOP/js/head/mine/ua.js'
        ]
        dest: 'htdocs/_DEVELOP/js/head/all.js'
      js_main_nomin:
        src: [
          'htdocs/_DEVELOP/js/main/libs/jquery-1.10.2.js'
          'htdocs/_DEVELOP/js/main/mine/setup.js'
          'htdocs/_DEVELOP/js/main/mine/ga.js'
        ]
        dest: 'htdocs/_DEVELOP/js/main/all.js'

      js_head_min:
        src: [
          'htdocs/_DEVELOP/js/head/libs/modernizr.min.js'
          'htdocs/_DEVELOP/js/head/mine/ua.min.js'
        ]
        dest: 'htdocs/_DEVELOP/js/head/all.min.js'
      js_main_min:
        src: [
          'htdocs/_DEVELOP/js/main/libs/jquery-1.10.2.min.js'
          'htdocs/_DEVELOP/js/main/mine/setup.min.js'
          'htdocs/_DEVELOP/js/main/mine/ga.min.js'
        ]
        dest: 'htdocs/_DEVELOP/js/main/all.min.js'

    copy:
      js_debug:
        files:
          'htdocs/resources/js/head.js': 'htdocs/_DEVELOP/js/head/all.js'
          'htdocs/resources/js/main.js': 'htdocs/_DEVELOP/js/main/all.js'
      css_debug:
        files:
          'htdocs/resources/css/common.css': 'htdocs/_DEVELOP/css/common.css'
      js_release:
        files:
          'htdocs/resources/js/head.js': 'htdocs/_DEVELOP/js/head/all.min.js'
          'htdocs/resources/js/main.js': 'htdocs/_DEVELOP/js/main/all.min.js'
      css_release:
        files:
          'htdocs/resources/css/common.css': 'htdocs/_DEVELOP/css/common.min.css'

    watch:
      sass:
        files: [ 'htdocs/_DEVELOP/sass/**/*' ]
        tasks: [
          'compass'
          'copy:css_debug'
        ]
      js:
        files: [ 'htdocs/_DEVELOP/js/**/*' ]
        tasks: [
          'concat'
          'copy:js_debug'
        ]

  grunt.registerTask 'build_debug', [
    'compass'
    'concat'
    'copy:js_debug'
    'copy:css_debug'
  ]

  grunt.registerTask 'build_release', [
    'compass'
    'cssmin'
    'uglify'
    'concat'
    'copy:js_release'
    'copy:css_release'
  ]

  grunt.registerTask 'default', [
    'build_debug'
  ]
