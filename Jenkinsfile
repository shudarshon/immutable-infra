pipeline {
  agent any

  stages {
    stage('Initialize') {
      steps {
         sh 'make init'
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
}
