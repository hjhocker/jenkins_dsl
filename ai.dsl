job('Reflections AI PR Builder') {
 properties {
        githubProjectUrl('https://github.com/hjhocker/reflections_ai')
    }

    publishers {
        buildDescription('example', '${BRANCH}')
    }

      parameters {
        stringParam('sha1', '', 'GitHub PR Sha1 Value')
    }

      steps {
        shell('ls')
          sonarRunnerBuilder {
              project('')
              properties('sonar.projectKey=reflections_ai\n'+
'sonar.projectName=reflections_ai\n'+
'sonar.login=${sonarlogin}\n'+
'sonar.sources=reflections_ai\n'+
'sonar.github.repository=hjhocker/reflections_ai\n'+
'sonar.github.pullRequest=${ghprbPullId}\n'+
'sonar.projectVersion=1.0\n'+
'sonar.github.oauth=${githuboauth}\n'+
'sonar.analysis.mode=preview\n'+
'sonar.github.disableInlineComments=false\n'+
'sonar.github.endpoint=https://api.github.com\n')
              javaOpts('')
              additionalArguments('')
              jdk('')
              task('')
          }
    }
    scm {
        git {
            remote {
                github('hjhocker/reflections_ai')
                refspec('+refs/pull/*:refs/remotes/origin/pr/*')
                credentials('e97609df-6575-4a89-bcf3-6bd2c7e41b84')
            }
            branch('${sha1}')
        }
    }
    triggers {
        githubPullRequest {
            admin('hjhocker')
            useGitHubHooks()
            orgWhitelist(['hjhocker'])
            cron('H/5 * * * *')
            triggerPhrase('build me')
            extensions {
                commitStatus {
                }
            }
        }
    }
}
