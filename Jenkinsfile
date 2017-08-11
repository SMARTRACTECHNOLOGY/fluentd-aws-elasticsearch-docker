node {

  deleteDir()
  stage("Checkout") {
    checkout scm
  }

  def image
  def tag = sh script: "grep  FROM Dockerfile | cut -d ':' -f 2 | cut -d '-' -f 1", returnStdout: true
  tag = tag.trim()

  stage("build") {
    image = docker.build "smartcosmos/fluentd-aws-elasticsearch"
  }

  if (env.BRANCH_NAME == "master") {
    stage("publish") {
      docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
        image.push(tag)
      }
    }
  }

  sh "docker image rm ${image.id}"
}
