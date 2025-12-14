pipeline {
  agent { label 'gcpagent' } // match your agent node label

  environment {
    IMAGE = "tiny-flask-app:${env.BUILD_NUMBER}"
    CONTAINER = "tiny-flask-app-container"
  }

  stages {
    stage('Checkout') {
      steps {
        git url: 'https://github.com/akshanttyagi/cicd-pro.git', branch: 'main'
      }
    }

    stage('Build Image') {
      steps {
        script {
          sh "docker build -t ${IMAGE} ."
        }
      }
    }

    stage('Push to DockerHub'){
        steps{
            withCredentials([usernamePassword(credentialsId:"dockerhub",passwordVariable:"dockerhubpass",usernameVariable:"dockerhubuser")]){
                sh "docker login -u ${env.dockerhubuser} -p ${env.dockerhubpass}"
                sh "docker image tag tiny-flask-app:${env.BUILD_NUMBER} ${env.dockerhubuser}/tiny-flask-app:${env.BUILD_NUMBER}"
                sh "docker push ${env.dockerhubuser}/tiny-flask-app:${env.BUILD_NUMBER}"
            }
            echo "Docker Push Complete"
        }
    }

    stage('Run Container') {
      steps {
        script {
          // Stop & remove old container if exists, then run new
          sh """
            if [ \$(docker ps -a -q -f name=${CONTAINER}) ]; then
              docker rm -f ${CONTAINER} || true
            fi
            docker run -d --name ${CONTAINER} --network my-network -p 8085:8080 ${IMAGE}
          """
        }
      }
    }
  }

  post {
    always {
      echo "Pipeline finished"
    }
  }
}
