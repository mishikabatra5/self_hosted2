pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'  // Replace with your Docker credentials ID if using Docker Hub
        DOCKER_IMAGE = 'self_hosted2/nginx-docker'  // Docker image name and tag
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/mishikabatra5/self_hosted2.git'  // Ensure the correct branch is specified
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
            emailext (
                subject: "Jenkins Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' Succeeded",
                body: """<p>Good news! Jenkins Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' Succeeded.</p>
                         <p>Check the details at: <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>""",
                recipientProviders: [[$class: 'CulpritsRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                to: 'mishikabatra5@gmail.com'
            )
        }
        failure {
            echo 'Build failed :('
            emailext (
                subject: "Jenkins Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' Failed",
                body: """<p>Bad news! Jenkins Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' Failed.</p>
                         <p>Check the details at: <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>""",
                recipientProviders: [[$class: 'CulpritsRecipientProvider'], [$class: 'RequesterRecipientProvider']],
                to: 'mishikabatra5@gmail.com'
            )
        }
    }
}
