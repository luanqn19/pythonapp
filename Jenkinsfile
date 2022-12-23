node {
    def application = "pythonapp"
    def dockerhubaccountid = "luanqn20"
    stage('Clone repository') {
        checkout scm
    }

    stage('Pull image') {
        withDockerRegistry([ credentialsId: "dockerHub", url: "" ]) {
        sh("docker pull ${dockerhubaccountid}/${application}:latest")
    }
    }

    stage('Build image') {
        // app = docker.build("${dockerhubaccountid}/${application}:${BUILD_NUMBER} --cache-from docker.io/${dockerhubaccountid}/${application}:latest")
        app = sh("docker build -t ${dockerhubaccountid}/${application}:${BUILD_NUMBER} --cache-from ${dockerhubaccountid}/${application}:latest .")
    }

    stage('Push image') {
        withDockerRegistry([ credentialsId: "dockerHub", url: "" ]) {
        sh("docker tag ${dockerhubaccountid}/${application} ${dockerhubaccountid}/${application}:${BUILD_NUMBER}")
        sh("docker push ${dockerhubaccountid}/${application}:${BUILD_NUMBER}")
        sh("docker tag ${dockerhubaccountid}/${application} ${dockerhubaccountid}/${application}:latest")
        sh("docker push ${dockerhubaccountid}/${application}:latest")
        // app.push("${BUILD_NUMBER}")
        // app.push("latest")
    }
    }

    stage('Deploy') {
        // deloy docker
        sh ("docker run -d -p 3333:3333 ${dockerhubaccountid}/${application}:${BUILD_NUMBER}")
    }

    stage('Remove old images') {
        // remove old docker images
        sh("docker rmi ${dockerhubaccountid}/${application}:latest -f")
   }
}
