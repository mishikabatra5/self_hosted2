pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'  // Replace with your Docker credentials ID if using Docker Hub
        DOCKER_IMAGE = 'self_hosted2/nginx-docker'  // Docker image name and tag
    }

    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/mishikabatra5/self_hosted2.git'  // Replace with your GitHub repository URL
            }
        }

        stage('Build') {
            steps {
                script {
                    def dockerImage = docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                    dockerImage.push()
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    sh 'docker run -d -p 8080:80 self_hosted2/nginx-docker:1'  // Use a different port on the host
                }
            }
        }
    }

    post {
        success {
            echo 'Build succeeded!'
        }
        failure {
            echo 'Build failed :('
        }
    }
}
