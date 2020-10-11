pipeline {
    agent {
        label 'build-base-stable'
    }
    stages {
        stage('Checkout') {
            steps{
                dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins') {
                    checkout scm
                }
            }
        }
        stage('jenkins-base') {
            steps {
                withDockerRegistry([credentialsId: 'derekpedersen_docker', url: "https://hub.docker.com/"]) {
                    dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins') {
                        sh 'make build && make publish-docker'
                    }
                }
            }
        }
        stage('golang') {
            steps {
                withCredentials([[$class: 'StringBinding', credentialsId: 'GCLOUD_PROJECT_ID', variable: 'GCLOUD_PROJECT_ID']]) {
                    dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins/golang') {
                        sh 'make build && make publish-gcloud'
                    }
                }
            }
        }
        stage('node') {
            steps {
                withCredentials([[$class: 'StringBinding', credentialsId: 'GCLOUD_PROJECT_ID', variable: 'GCLOUD_PROJECT_ID']]) {
                    dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins/node') {
                        sh 'make build && make publish-gcloud'
                    }
                }
            }
        }
        stage('dotnetcore') {
            steps {
                withCredentials([[$class: 'StringBinding', credentialsId: 'GCLOUD_PROJECT_ID', variable: 'GCLOUD_PROJECT_ID']]) {
                     dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins/dotnetcore') {
                        sh 'make build && make publish-gcloud'
                    }
                }
            }
        }
    }
}