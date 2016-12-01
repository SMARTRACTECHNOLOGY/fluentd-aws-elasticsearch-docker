node {
  stage("Checkout") {
    scm checkout
  }

  stage("build") {
    def tag = (env.BRANCH_NAME == 'master') ? env.BUILD_NUMBER : "snapshot-${env.BUILD_NUMBER}"

    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
      def image = docker.build "smartcosmos/fluentd-aws-elasticsearch:${tag}"
      image.push()
      image.push("latest")
    }

    // remove the docker image locally
    sh "docker rmi ${image.id}"
  }
}
