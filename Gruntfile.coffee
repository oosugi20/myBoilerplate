module.exports = (grunt) ->

  grunt.task.loadNpmTasks 'grunt-contrib-clean'
  grunt.task.loadNpmTasks 'grunt-contrib-copy'

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    clean: [
      'root/htdocs/_DEVELOP/js/**/libs/*.js'
    ]

    copy:
      components_nomin:
        files:
          'root/htdocs/_DEVELOP/js/main/libs/jquery.js': 'components/jquery/dist/jquery.js'
          'root/htdocs/_DEVELOP/js/head/libs/modernizr.js': 'components/Modernizr/modernizr.js'
      components_min:
        files:
          'root/htdocs/_DEVELOP/js/main/libs/jquery.min.js': 'components/jquery/dist/jquery.min.js'
          'root/htdocs/_DEVELOP/js/head/libs/modernizr.min.js': 'components/Modernizr/modernizr.min.js'

  grunt.registerTask 'default', [
    'clean'
    'copy'
  ]
