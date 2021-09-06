pipelineJob('DSL_Pipeline') {

  def repo = 'https://github.com/cronjevh/java-jenkins-techdemo'

  triggers {
    scm('15 * * * *')
  }
  description("Pipeline for $repo")

  definition {
    cpsScm {
      scm {
        git {
          remote { url(repo) }
          branches('extra-time')
          scriptPath('./src/Jenkinsfile')
          extensions { }  // required as otherwise it may try to tag the repo, which you may not want
        }
      }
    }
  }
}