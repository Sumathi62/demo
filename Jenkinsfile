pipeline {
    agent any
    environment {
        IMAGE_NAME = "sumathi18/html"
        CONTAINER_NAME = "html_container"
        CONTAINER_REGISTRY = "docker.io"
    }
    options {
        timestamps()
    }
    stages {
        stage('Clean Up') {
            steps {
                echo 'Stopping and removing old container (if exists)...'
                sh 'docker stop $CONTAINER_NAME || true'
                sh 'docker rm $CONTAINER_NAME || true'
                echo 'Removing old Docker image...'
                sh 'docker rmi -f $IMAGE_NAME || true'
            }
        }
        stage('Build') {
            steps {
                echo 'Building a fresh Docker image...'
                sh 'docker build --no-cache -t $IMAGE_NAME .'
            }
        }
        stage('Run Updated Container') {
            steps {
                echo 'Running new Docker container on port 3535...'
                sh 'docker run -d --name $CONTAINER_NAME -p 3535:80 $IMAGE_NAME'
                echo "Application is accessible at: http://localhost:3535"
            }
        }
    }
    post {
        success {
            echo 'Pipeline executed successfully! 🎉'
        }
        failure {
            echo 'Pipeline execution failed! ❌'
        }
    }
}
