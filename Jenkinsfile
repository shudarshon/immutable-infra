#!/usr/bin/env groovy
@Library('slack-shared@master') _

pipeline {
  agent any

  stages {
    stage ('Start') {
      steps {
        sendNotifications 'STARTED'
      }
    }
    stage('Backup') {
      steps {
         sh 'make backup'
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
    stage('Test') {
      steps {
         sh 'make test'
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
