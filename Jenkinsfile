env.DOCKERHUB_USERNAME = 'alamgirm'
pipeline {
    //agent  any
     agent { 
         node { 
             label 'jkslave' //Jenkins Slave  
         } 
     }
    stages {
        stage('Clone') {
            steps {
                git 'https://github.com/alamgirm/java-maven-web-app.git'
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
                sh "docker build -t ${DOCKERHUB_USERNAME}_myapp:${BUILD_NUMBER} ."
            }
        }
        
        // Push the built image
        stage('PushDockerImage') {
            steps {
                 withDockerRegistry([credentialsId: 'dockerhub', url: 'hhttps://hub.docker.com/']) {
                     sh "docker push ${DOCKERHUB_USERNAME}_myapp:${BUILD_NUMBER}"
                 }
            }
        }
        
        // push the built image
       /* stage('Push image') {
           steps {
                docker.withRegistry('https://cloud.docker.com/swarm/alamgirm/dashboard/onboarding/cloud-registry', 'dockerhub') {
                    def customImage = docker.build("${env.DOCKERHUB_USERNAME}_myapp:${env.BUILD_ID}")
                    customImage.push()
                }
            }
        }*/
    }
}
