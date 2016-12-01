node {

  deleteDir()

  stage("Checkout") {
    checkout scm
  }


  def image

  sh "grep  FROM Dockerfile | cut -d ':' -f 2 | cut -d '-' -f 1 > .tag"
  def tag = readFile('.tag').trim()

  stage("build") {
    image = docker.build "smartcosmos/fluentd-aws-elasticsearch"
  }

  if (env.BRANCH_NAME == "master") {
    stage("publish") {
      docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
        image.push(tag)
        image.push("master")
      }
    }
  }

  // remove the docker image locally
  sh "docker rmi ${image.id}"
}
