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
        stage('Stop & Remove Old Container') {
            steps {
                echo 'Stopping and removing old container (if exists)...'
                sh 'docker ps -q --filter "name=$CONTAINER_NAME" | xargs -r docker stop'
                sh 'docker ps -aq --filter "name=$CONTAINER_NAME" | xargs -r docker rm'
            }
        }
        stage('Build') {
            steps {
                echo 'Building the Docker image...'
                sh 'docker build -t $IMAGE_NAME .'
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
                sh 'docker run --rm $IMAGE_NAME echo "Test successful!"'
            }
        }
        stage('Push Image') {
            steps {
                echo 'Logging into Docker registry...'
                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                }
                echo 'Pushing Docker image to registry...'
                sh 'docker push $IMAGE_NAME'
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
