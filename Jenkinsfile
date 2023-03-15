pipeline {
    agent any
    stages {
        
        stage('Maven Build package'){
            tools {
                maven 'Maven 3.6.3'
            }
            steps {
                sh "mvn clean package"
            }
        }
        stage('Docker Build '){
            steps{
                sh " docker build . -t mrofficialnah/Java-project:${commit_id()} "
                }
            }
        stage ('Docker push') {
            steps {
               withCredentials([string(credentialsId: 'Docker-Hub', variable: 'hubPwd')])
                   {             
                   sh "docker login -u mrofficialnah -p ${hubPwd}"
                   sh "docker push mrofficialnah/Java-project:${commit_id()}"
                }    
            }
        }
        stage('Docker Deploy') {
            steps {
                sshagent(['docker-host']) {
                    sh "ssh -o StrictHostKeyChecking=no docker rm -f Java-project"
                    sh " docker run -d -p 8084:8080 --name Java-project mrofficialnah/Java-project:${commit_id()}"
                }
            }
            
        }
        
    }
}
def commit_id(){
        id = sh returnStdout: true, script: 'git rev-parse --short HEAD'
        return id
 }
