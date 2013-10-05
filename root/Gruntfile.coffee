module.exports = (grunt) ->
  
  grunt.task.loadNpmTasks 'grunt-contrib-compass'
  grunt.task.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.task.loadNpmTasks 'grunt-contrib-concat'
  grunt.task.loadNpmTasks 'grunt-contrib-uglify'
  grunt.task.loadNpmTasks 'grunt-contrib-copy'
  grunt.task.loadNpmTasks 'grunt-contrib-compress'
  grunt.task.loadNpmTasks 'grunt-contrib-clean'
  grunt.task.loadNpmTasks 'grunt-contrib-ftpush'
  grunt.task.loadNpmTasks 'grunt-contrib-watch'
  grunt.task.loadNpmTasks 'grunt-growl'
  grunt.task.loadNpmTasks 'grunt-shell'

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    ignores: [
      '**/*'
      '!node_modules/**/*'
      '!node_modules'
      '!.git*'
      '!.sass-cache'
      '!.DS_Store'
      '!Thumbs.db'
      '!_notes'
      '!*.mno'
      '!.ftppass'
    ]

    growl:
      ok:
        title: 'Grunt OK'
      css:
        title: 'CSS compiled'
      js:
        title: 'JS compiled'
      build:
        title: 'Build completed'
      deploy:
        title: 'Deploy completed'

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
      archive:
        expand: true
        cwd: './'
        src: '<%= ignores %>'
        dest: 'archive-pre/<%= pkg.name %>-v<%= pkg.version %>'
      archive_htdocs:
        expand: true
        cwd: 'htdocs/'
        src: '<%= ignores %>'
        dest: 'archive-pre/<%= pkg.name %>-v<%= pkg.version %>_htdocs/'

    compress:
      archive:
        options:
          archive: 'archive/<%= pkg.name %>-v<%= pkg.version %>.zip'
        expand: true
        cwd: 'archive-pre/'
        src: [
          '<%= pkg.name %>-v<%= pkg.version %>/**/*'
          '!.DS_Store'
        ]
      archive_htdocs:
        options:
          archive: 'archive/<%= pkg.name %>-v<%= pkg.version %>_htdocs.zip'
        expand: true
        cwd: 'archive-pre/'
        src: [
          '<%= pkg.name %>-v<%= pkg.version %>_htdocs/**/*'
          '!.DS_Store'
        ]

    clean:
      archive:
        src: [
          'archive-pre/**/*'
          '!.gitkeep'
        ]

    ftpush:
      zip:
        auth:
          host: '{%= ftp_host %}'
          port: 21
          authKey: '{%= ftp_authkey %}'
        src: 'archive/'
        exclusions: [
          '.DS_Store'
          '.gitkeep'
        ]
        dest: '{%= ftp_dir %}{%= project_id %}/'
        simple: true

    shell:
      imageOptim:
        command: 'find htdocs/resources/img -name "sprite-*.png" | imageOptim -a -q'
      # TODO JPEGmini に渡すタスク。ディレクトリを渡さないと時間かかる。
      reload:
        command: 'osascript -e \'tell application "Google Chrome" to reload active tab of window 1\''

    watch:
      sass:
        files: [ 'htdocs/_DEVELOP/sass/**/*' ]
        tasks: [
          'compass'
          'copy:css_debug'
          'shell:reload'
          'growl:css'
        ]
      js:
        files: [ 'htdocs/_DEVELOP/js/**/mine/*' ]
        tasks: [
          'concat:js_head_nomin'
          'concat:js_main_nomin'
          'copy:js_debug'
          'shell:reload'
          'growl:js'
        ]

  grunt.registerTask 'archive', [
    'copy:archive'
    'compress:archive'
    'clean:archive'
  ]
  grunt.registerTask 'archive:htdocs', [
    'copy:archive_htdocs'
    'compress:archive_htdocs'
    'clean:archive'
  ]

  grunt.registerTask 'deploy:zip', [
    'build:release'
    'archive'
    # if want htdocs only
    #'archive:htdocs'
    'ftpush:zip'
    'growl:deploy'
  ]

  grunt.registerTask 'build:debug', [
    'compass'
    'concat:js_head_nomin'
    'concat:js_main_nomin'
    'copy:js_debug'
    'copy:css_debug'
    'growl:build'
  ]

  grunt.registerTask 'build:release', [
    'compass'
    'cssmin'
    'uglify'
    'concat'
    'copy:js_release'
    'copy:css_release'
    'shell:imageOptim'
    'growl:build'
  ]

  grunt.registerTask 'default', [
    'build:release'
  ]
