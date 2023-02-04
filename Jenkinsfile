pipeline {
    agent any

    stages {
        stage ('Build Artifact') {
            steps {
                sh "mvn clean package -DskipTests=true"
                archive './target/*.jar'
            }
        }
        stage ('test2stage') {
            steps {
                sh "mvn test"
            }
        }
        stage ('docker build and push') {
            steps {
                withDockerRegistry([credentialsId:"dockerhub" , url:""]) {
                    sh 'docker build -t khaledbenfajria/devsecops:3.0 .'
                    sh 'docker push khaledbenfajria/devsecops:3.0'
                }
            }
        }
        stage ("k8s") {
            steps {
                sh 'sed -i "s+replace+khaledbenfajria/devsecops:3.0+g" ./k8s_deployment_service.yaml'
                sh 'kubectl apply -f /home/bob/k/k8s_deployment_service.yaml'
            }
        }

    }
}
