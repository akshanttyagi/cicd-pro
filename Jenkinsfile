pipeline{
    agent{label 'jenkins-agent'}

    stages{
        stage("Clone"){
            steps{
                echo "Now cloning github repo"
                git url:'https://github.com/akshanttyagi/cicd-pro.git', branch:'main'
                echo "Git clone successful"
            }
        }

        stage("Build"){
            steps{
                script {
                    dockerImage = docker.build("myapp:latest")
                }
                echo "Build Successful"
            }
        }
        stage("Test"){
            steps{
                echo "We will test using tools like MAVEN"
            }
        }

        stage("Deploy & Run"){
            steps{
                echo "Deploying Code"
               script {
                    sh """
                        # Stop old container if exists
                        if [ \$(docker ps -a -q -f name=myapp-container) ]; then
                            docker rm -f myapp-container
                        fi

                        # Run new container
                        docker run -d --name myapp-container --network my-network -p 8085:8080 myapp:latest
                    """
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline execution completed!!"
        }
    }
}