pipeline {
    agent any

    stages {
        stage ('Build Artifact - Maven') {
            steps {
                sh "mvn clean package -DskipTests=true"
                archive './target/*.jar'
            }
        }
        stage ('Unit Tests - JUnit and Jacoco') {
            steps {
                sh "mvn test"
            }
            post {
               always {
                  junit 'target/surefire-reports/*.xml'
                  jacoco execPattern: 'target/jacoco.exec'
               }
            }
        }
        stage ('Build & Push docker image') {
            steps {
                withDockerRegistry([credentialsId:"dockerhub" , url:""]) {
                    sh 'docker build -t khaledbenfajria/devsecops:4.0 .'
                    sh 'docker push khaledbenfajria/devsecops:4.0'
                }
            }
        }
        stage ("k8s") {
            steps {
                withKubeConfig([credentialsId: "kubeconfig"]){
                    sh 'sed -i "s+replace+khaledbenfajria/devsecops:4.0+g" ./k8s_deployment_service.yaml'
                    sh 'kubectl apply -f k8s_deployment_service.yaml'
                }
            }
        }

    }
}
