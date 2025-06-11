pipeline {
    agent any
    environment {
        IMAGE_NAME = "totywan/wayshub-backend13alpine"
    }
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/hermanto-cpu/wayshub-backend.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(IMAGE_NAME)
                }
            }
        }
        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'totywan-dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                    sh "docker push $IMAGE_NAME"
                }
            }
        }
        stage('Deploy Container') {
            steps {
                sh 'docker stop wayshub-be || true && docker rm wayshub-be || true'
                sh 'docker run -d --name wayshub-be -p 5000:5000 --env DB_HOST=host.docker.internal --env DB_USER=user --env DB_PASSWORD=password --env DB_NAME=wayshub totywan/wayshub-backend13alpine'
            }
        }
    }
}
