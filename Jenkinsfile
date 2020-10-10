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
                docker.withRegistry('https://registry.example.com', 'credentials-id') {

                        /* def customImage = docker.build("my-image:${env.BUILD_ID}") */

                        /* Push the container to the custom Registry */
                        /* customImage.push() */
                        sh 'make publish-docker'
                    }
                    withCredentials([[$class: 'StringBinding', credentialsId: 'GCLOUD_PROJECT_ID', variable: 'GCLOUD_PROJECT_ID']]) {
                        sh 'make publish-gcloud'
                }
            }
        }
        stage('golang') {
            steps {
                withCredentials([[$class: 'StringBinding', credentialsId: 'GCLOUD_PROJECT_ID', variable: 'GCLOUD_PROJECT_ID']]) {
                    dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins/golang') {
                        sh 'make build && make publish'
                    }
                }
            }
        }
        stage('node') {
            steps {
                withCredentials([[$class: 'StringBinding', credentialsId: 'GCLOUD_PROJECT_ID', variable: 'GCLOUD_PROJECT_ID']]) {
                    dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins/node') {
                        sh 'make build && make publish'
                    }
                }
            }
        }
        stage('dotnetcore') {
            steps {
                withCredentials([[$class: 'StringBinding', credentialsId: 'GCLOUD_PROJECT_ID', variable: 'GCLOUD_PROJECT_ID']]) {
                     dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins/dotnetcore') {
                        sh 'make build && make publish'
                    }
                }
            }
        }
    }
}