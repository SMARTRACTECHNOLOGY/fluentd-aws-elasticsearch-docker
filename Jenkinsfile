node {

  deleteDir()

  stage("Checkout") {
    checkout scm
  }


  def image

  sh "git rev-parse HEAD > .git/commit-id"
  def commit_id = readFile('.git/commit-id').trim()

  stage("build") {
    image = docker.build "smartcosmos/fluentd-aws-elasticsearch"
  }

  if (env.BRANCH_NAME == "master") {
    stage("publish") {
      docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
        image.push()
        image.push("master")
      }
    }
  }

  // remove the docker image locally
  sh "docker rmi ${image.id}"
}
