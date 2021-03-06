module.exports = (grunt) ->
  conf =
    copy:
      main:
        files: [{
          expand: true
          src: ['assets/**']
          dest: 'public/'
        }
        {
          src: ['src/CNAME']
          dest: 'public/'
        }]
    stylus:
      main:
        options:
          paths: ['src/style']
          compress: true
        files:
          'public/assets/style/main.css':'src/style/main.styl'
    jade:
      main:
        options:
          data:
            debug: false
        files:
          "public/index.html": "src/templates/index.jade"
    'semantic-ui':
      main:
        options:
          config: 'semantic-config.json'
          dest: 'public/assets/semantic/'
    watch:
      main:
        files: [
          'src/**',
          'assets/**'
          'semantic-config.json'
        ],
        tasks: [
          'jade:main'
          'stylus:main'
          'copy:main'
          'semantic-ui:main'
        ],
        options:
          livereload: true
    git_deploy:
      main:
        options:
          url: 'git@github.com:soscet/soscet.github.io'
          branch: 'master'
          message: 'Update'
        src: 'public'

  grunt.loadNpmTasks 'grunt-semantic-ui'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-git-deploy'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jade'

  grunt.initConfig conf

  grunt.registerTask 'default', ['stylus', 'copy', 'semantic-ui', 'jade']
  grunt.registerTask 'w', ['watch:main']
  grunt.registerTask 'deploy', ['git_deploy']

