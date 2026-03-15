pipeline {
    agent any 
    tools {
        gradle "gradle" 
    }
    environment {
        PORT = "8050"
        CONTAINER_NAME = "java_gradle"
        IMAGE_NAME = "ahmedkabil/java-gradle"
    }
    stages {
        stage("Cleanup") {
            steps {
                echo "Removing old container..."
                sh "docker container rm -f ${CONTAINER_NAME} || true"
            }  
        }

        stage("Build WAR") {
            steps {
                echo "Building executable WAR with Gradle..."
                sh "gradle clean bootWar -x test"
            }
        }

        stage("Docker Build") {
            steps {
                echo "Building Docker image: ${IMAGE_NAME}"
                sh "docker build --build-arg PORT=${PORT} -t ${IMAGE_NAME} ."
            }
        }

        stage("Deploy") {
            steps {
                echo "Deploying to port ${PORT}..."
                sh "docker container run -d --name ${CONTAINER_NAME} -p ${PORT}:${PORT} ${IMAGE_NAME}"
            }
        }
    }

    post {
        success {
            echo "Deployment successful! Access at http://192.168.50.134:${PORT}"
        }
        failure {
            echo "Deployment failed. Check the Jenkins console output for Gradle or Docker errors."
        }
    }
}