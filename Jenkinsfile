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
                withDockerRegistry([credentailsId:"dockerhub" , url:""]) {
                    sh 'docker build -t khaledbenfajria/devsecops:2.0 .'
                    sh 'docker push khaledbenfajria/devsecops:2.0'
                }
            }
        }
        stage ("k8s") {
            steps {
                sh 'sed -i "s+replace+khaledbenfajria/devsecops:1.0+g" ' ./k8s_deployment_service.yaml
                sh 'kubectl apply -f k8s_deployment_service.yaml'
            }
        }

    }
}
