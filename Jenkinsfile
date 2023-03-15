pipeline {
    agent any
    environment {
    DOCKERHUB_CREDENTIALS = credentials('docker-hub-mrofficialnah')
    }
    stages {
        
        stage('Maven Build package'){
            steps {
                sh '''
                    export MAVEN_HOME=/opt/apache-maven-3.6.3
                    export PATH=$PATH:${MAVEN_HOME}/bin
                    mvn clean package
                '''
            }
        }
        stage('Docker Build '){
            steps{
                sh "docker build . -t mrofficialnah/java-project:${commit_id()} "
                }
            }
        stage('Login') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                }
            }    
        stage ('Docker push') {
            steps {             
                   sh "docker login -u mrofficialnah -p ${hubPwd}"
                   sh "docker push mrofficialnah/java-project:${commit_id()}"   
                  }
            }
        stage('Docker Deploy') {
            steps {
                sshagent(['docker-host']) {
                    sh "ssh -o StrictHostKeyChecking=no docker rm -f java-project"
                    sh "docker run -d -p 8084:8080 --name java-project mrofficialnah/java-project:${commit_id()}"
                }
            }
            
        }
        
    }
}
def commit_id(){
        id = sh returnStdout: true, script: 'git rev-parse --short HEAD'
        return id
 }
