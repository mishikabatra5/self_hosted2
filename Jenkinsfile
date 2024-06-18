pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'self_hosted2/nginx-docker'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/mishikabatra5/self_hosted2.git'
            }
        }
        stage('Build') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    docker.run("${DOCKER_IMAGE}:${env.BUILD_NUMBER}", "-d -p 80:80")
                }
            }
        }
    }

    post {
        success {
            emailext (
                subject: "Jenkins Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' Succeeded",
                body: """
                    <p>Good news! Jenkins Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' Succeeded.</p>
                    <p>Check the details at: <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                """,
                recipientProviders: [[$class: 'DevelopersRecipientProvider']],
                to: 'mishikabatra5@gmail.com'
            )
        }
        failure {
            emailext (
                subject: "Jenkins Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' Failed",
                body: """
                    <p>Bad news! Jenkins Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' Failed.</p>
                    <p>Check the details at: <a href="${env.BUILD_URL}">${env.BUILD_URL}</a></p>
                """,
                recipientProviders: [[$class: 'DevelopersRecipientProvider']],
                to: 'mishikabatra5@gmail.com'
            )
        }
    }
}
