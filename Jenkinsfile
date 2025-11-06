pipeline {
    agent any
    environment {
        REMOTE_USER = "ec2-user"       
        REMOTE_HOST = "13.62.86.188"    // Change to your EC2 Public IP/DNS
        APP_NAME = "4thtask"
        IMAGE_TAG = "canary-${BUILD_NUMBER}"
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
stage('Build Docker Image') {
    steps {
        timeout(time: 20, unit: 'MINUTES') {  // increase from default 10 min if needed
            sh "docker build -t $APP_NAME:$IMAGE_TAG ."
        }
    }
}
        stage('Push Docker Image') {
            steps {
                 sh "echo Deploy step here"
                // Optional: If using a Docker registry (ECR/DockerHub)
                // sh "docker tag ${APP_NAME}:${IMAGE_TAG} <your_registry>/<your_repo>:${IMAGE_TAG}"
                // sh "docker push <your_registry>/<your_repo>:${IMAGE_TAG}"
            }
        }
        stage('Deploy Canary Release') {
            steps {
                sh "scp -i /path/to/your/key.pem deploy.sh ${REMOTE_USER}@${REMOTE_HOST}:/home/${REMOTE_USER}/"
                sh "scp -i /path/to/your/key.pem Dockerfile ${REMOTE_USER}@${REMOTE_HOST}:/home/${REMOTE_USER}/"
                sh "ssh -i /path/to/your/key.pem ${REMOTE_USER}@${REMOTE_HOST} 'chmod +x deploy.sh && ./deploy.sh ${IMAGE_TAG}'"
            }
        }
    }
}
