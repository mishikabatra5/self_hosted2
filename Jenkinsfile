pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build('my-docker-image', '-f Dockerfile .')
                }
            }
        }
    }
    post {
        success {
            echo 'Build succeeded! Sending email notification...'
            emailext(
                subject: "Jenkins Build Success: ${env.JOB_NAME} [${env.BUILD_NUMBER}]",
                body: "The Jenkins build of ${env.JOB_NAME} [${env.BUILD_NUMBER}] succeeded.",
                to: 'mishikabatra5@gmail.com'
            )
        }
        failure {
            echo 'Build failed! Sending email notification...'
            emailext(
                subject: "Jenkins Build Failure: ${env.JOB_NAME} [${env.BUILD_NUMBER}]",
                body: "The Jenkins build of ${env.JOB_NAME} [${env.BUILD_NUMBER}] failed.\n\nConsole output:\n${currentBuild.rawBuild.getLog(100)}",
                to: 'mishikabatra5@gmail.com'
            )
        }
    }
}
