pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Checkout source code from repository
                checkout scm

                // Build Maven application
                sh 'mvn clean install'
            }
        }

        stage('Test') {
            steps {
                // Run tests
                sh 'mvn test'
            }
        }

        stage('Build and Push Docker Image') {
            environment {
                DOCKER_REGISTRY = 'neroxxpips'
                DOCKER_IMAGE_NAME = 'oe-maven-app'
                DOCKER_IMAGE_TAG = 'latest'
            }

            steps {
                // Authenticate with Docker
                withDockerRegistry([credentialsId: 'your-docker-credentials-id', url: 'https://hub.docker.com/']) {
                    // Build Docker image
                    sh 'docker build -t $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG .'

                    // Push Docker image
                    sh 'docker push $DOCKER_REGISTRY/$DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            environment {
                KUBECONFIG = credentials('your-kubeconfig-credentials')
            }

            steps {
                // Set kubeconfig file for kubectl
                sh 'echo "$KUBECONFIG" > kubeconfig.yaml'

                // Apply Kubernetes deployment and service manifests
                sh 'kubectl apply -f deployment.yaml -f service.yaml --kubeconfig=kubeconfig.yaml'
            }
        }
    }
}
