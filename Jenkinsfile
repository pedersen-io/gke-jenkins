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
                dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins') {
                        sh 'make build'
                }
                withDockerRegistry([credentialsId: 'derekpedersen_docker', url: "https://index.docker.io/v1/"]) {
                    dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins') {
                        sh 'publish-docker'
                    }
                }
                withCredentials([[$class: 'StringBinding', credentialsId: 'GCLOUD_PROJECT_ID', variable: 'GCLOUD_PROJECT_ID']]) {
                    dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins') {
                        sh 'make publish-gcloud'
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