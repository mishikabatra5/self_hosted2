pipeline {
    agent any

    environment {
        DOCKER_CREDENTIALS_ID = 'your-docker-credentials-id'
        DOCKER_IMAGE = 'your-dockerhub-username/nginx-docker'
    }

    stages {
        stage('Build') {
            steps {
                script {
                    def dockerImage = docker.build("${DOCKER_IMAGE}:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', DOCKER_CREDENTIALS_ID) {
                        dockerImage.push("${env.BUILD_NUMBER}")
                        dockerImage.push('latest')
                    }
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
                to: 'your-email@example.com'
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
