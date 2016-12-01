node {
  stage("Checkout") {
    checkout scm
  }

  stage("build") {
    def tag = (env.BRANCH_NAME == 'master') ? env.BUILD_NUMBER : "snapshot-${env.BUILD_NUMBER}"

    def image = docker.build "smartcosmos/fluentd-aws-elasticsearch:${tag}"

    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
      image.push()
      image.push("latest")
    }

    // remove the docker image locally
    sh "docker rmi ${image.id}"
  }
}
