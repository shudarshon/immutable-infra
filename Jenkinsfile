pipeline {
  agent any

  stages {
    stage ('Start') {
      steps {
        sendNotifications 'STARTED'
      }
    }
    stage('Initialize') {
      steps {
         sh 'make initialize'
      }
    }
    stage('Validate') {
      steps {
         sh 'make validate'
      }
    }
    stage('Build') {
      steps {
         sh 'make build'
      }
    }    
    stage('Apply') {
      steps {
         sh 'make apply'
      }
    }
  }
  post {
    always {
      sendNotifications currentBuild.result
    }
  }
}
