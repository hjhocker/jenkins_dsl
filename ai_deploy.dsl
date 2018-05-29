job('Reflections AI Deploy') {

    properties {
        githubProjectUrl('https://github.com/hjhocker/test')
    }

    publishers {
        buildDescription('example', '${BRANCH}')
    }

    parameters {
        stringParam('branch', 'master', 'Branch to Build')
    }

    steps {
        shell('ls')
    }

    scm {
        git {
            remote {
                github('hjhocker/test')
                credentials('jenkins-ssh-keys')
            }
            branch('*/${branch}')
        }
    }

    triggers {
      githubPush()
    }

}
