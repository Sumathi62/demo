pipeline {
    agent any
    environment {
        IMAGE_NAME = "sumathi18/html"
        CONTAINER_REGISTRY = "docker.io" // Change if using a private registry
    }
    options {
        timestamps() // Adds timestamps to logs
    }
    stages {
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
        stage('Run Container') {
            steps {
                echo 'Running Docker container...'
                sh 'docker run -d -p 3535:80 $IMAGE_NAME'
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
