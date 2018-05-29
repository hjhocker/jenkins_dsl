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
      githubPush()
    }
}
