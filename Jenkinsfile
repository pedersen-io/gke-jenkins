pipeline {
    agent {
        label 'build-base-stable'
    } 
    dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins') {
        stages {
       
            stage('Checkout') {
                steps{
                    checkout scm
                }
            }
            stage('jenkins-base') {
                steps {
                    dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins') {
                            sh 'make build'
                    }
                    withDockerRegistry([credentialsId: 'derekpedersen_docker', url: "https://index.docker.io/v1/"]) {
                        dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins') {
                            sh 'make publish-docker'
                        }
                    }
                    withCredentials([[$class: 'StringBinding', credentialsId: 'GCLOUD_PROJECT_ID', variable: 'GCLOUD_PROJECT_ID']]) {
                        dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins') {
                            sh 'make publish-gcloud'
                        }
                    }
                }
            }
        }
        
        
        stage('golang') {
            steps {
                dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins/golang') {
                        sh 'make build'
                }
                withDockerRegistry([credentialsId: 'derekpedersen_docker', url: "https://index.docker.io/v1/"]) {
                    dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins/golang') {
                        sh 'make publish-docker'
                    }
                }
                withCredentials([[$class: 'StringBinding', credentialsId: 'GCLOUD_PROJECT_ID', variable: 'GCLOUD_PROJECT_ID']]) {
                    dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins/golang') {
                        sh 'make publish-gcloud'
                    }
                }
            }
        }
        stage('node') {
            steps {
                dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins/node') {
                        sh 'make build'
                }
                withDockerRegistry([credentialsId: 'derekpedersen_docker', url: "https://index.docker.io/v1/"]) {
                    dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins/node') {
                        sh 'make publish-docker'
                    }
                }
                withCredentials([[$class: 'StringBinding', credentialsId: 'GCLOUD_PROJECT_ID', variable: 'GCLOUD_PROJECT_ID']]) {
                    dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins/node') {
                        sh 'make publish-gcloud'
                    }
                }
            }
        }
        stage('dotnetcore') {
            steps {
                dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins/dotnetcore') {
                        sh 'make build'
                }
                withDockerRegistry([credentialsId: 'derekpedersen_docker', url: "https://index.docker.io/v1/"]) {
                    dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins/dotnetcore') {
                        sh 'make publish-docker'
                    }
                }
                withCredentials([[$class: 'StringBinding', credentialsId: 'GCLOUD_PROJECT_ID', variable: 'GCLOUD_PROJECT_ID']]) {
                     dir('/root/workspace/go/src/github.com/derekpedersen/gke-jenkins/dotnetcore') {
                        sh 'make publish-gcloud'
                    }
                }
            }
        }
    }
}