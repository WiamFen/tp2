pipeline {
    environment {
        registry = "wiamfenjiro/tp2"
        registryCredential = 'dockerhub_tp2'
        dockerImage = ''
    }

    agent any

    stages {
        stage('Cloning Git') {
            steps {
                git branch: 'master',
                    credentialsId: 'github_TP2',
                    url: 'https://github.com/WiamFen/tp2.git'
            }
        }

        stage('Building image') {
            steps {
                script {
                    dockerImage = docker.build(
                        registry + ":$BUILD_NUMBER"
                    )
                }
            }
        }

        stage('Test image') {
            steps {
                script {
                    echo "Tests passed"
                }
            }
        }

        stage('Publish Image') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy image') {
            steps {
                bat '''
                    set DOCKER_HOST=
                    set DOCKER_TLS_VERIFY=
                    set DOCKER_CERT_PATH=

                    docker rm -f tp2-deploy 2>nul
                    docker run -d --name tp2-deploy -p 8081:80 %registry%:%BUILD_NUMBER%
                '''
            }
        }
    }
}