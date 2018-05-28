job('Reflections AI PR Builder') {
 properties {
        githubProjectUrl('https://github.com/hjhocker/test')
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
              properties('sonar.projectKey=test\n'+
'sonar.projectName=test\n'+
'sonar.login=${sonarlogin}\n'+
'sonar.sources=test\n'+
'sonar.github.repository=hjhocker/test\n'+
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
                github('hjhocker/test')
                refspec('+refs/pull/*:refs/remotes/origin/pr/*')
                credentials('jenkins-ssh-keys')
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
