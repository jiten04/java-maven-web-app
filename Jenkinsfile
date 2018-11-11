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
        stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}
