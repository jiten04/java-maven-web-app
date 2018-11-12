// Jitendra Kumar
// Jenkins file for Build
// invoked by the Pipeline plugin of Jenkins
// This pipeline (1) clones git repo (2) builds the maven project  (3) builds a docker image with the built app
// (4) Pushes the docke image to docker hub.


env.DOCKERHUB_USERNAME='33fd7a2cbe06'
//env.APPBUILD_ID="${BUILD_NUMBER}"
pipeline {
    //agent  any
     agent { 
         node { 
             label 'master' //Jenkins master  
         } 
     }
    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/jiten04/java-maven-web-app.git'
            }
        }
        
        stage('Build') { 
            steps {
                sh 'mvn -B -DskipTests clean package' 
            }
        }
        /*
        stage('Test') { 
            steps {
                sh 'mvn test' 
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml' 
                }
            }
        }
        */
        
        // Build docker iamge 
        stage('BuildDockerImage') {
             steps {
                //sh "docker build -t ${DOCKERHUB_USERNAME}/myapp:${BUILD_NUMBER}  ."
                 sh "docker build -t ${DOCKERHUB_USERNAME}/myapp:latest  ."
            }
        }
        
        // Push the built image
        stage('PushDockerImage') {
            steps {
                 withDockerRegistry([credentialsId: 'b9ae8ad7-0294-47d7-b7e8-bcaae7b61572', url: '']) {
                     //sh "docker push ${DOCKERHUB_USERNAME}/myapp:${BUILD_NUMBER}"
                     sh "docker push ${DOCKERHUB_USERNAME}/myapp:latest"
                 }
            }
        }
     // run the docker image
        stage('RunDockerImage') {
            steps {
                // stop currently running App
                sh "docker stop MyApp"
                // Remove old containers
                sh "docker ps -aq --no-trunc | xargs docker rm"
                // Run the newest image
                sh "docker run -d -p 8081:8080 --name=MyApp 33fd7a2cbe06/myapp:latest  /bin/bash"
            }
        }
    }
}


