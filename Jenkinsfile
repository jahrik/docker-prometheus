#!/usr/bin/env groovy

node('aarch64') {

    try {

        stage('build') {
            deleteDir()
            checkout scm
            sh "make"
        }

        stage('push') {
            // Push to Dockerhub
            sh "make push"
        }

    } catch(error) {
        throw error

    } finally {
        deleteDir()

    }
}


node('manager') {

  try {
    stage('scm') {
        deleteDir()
        checkout scm
    }

    stage('deploy') {
        sh "make deploy"
    }

  } catch(error) {
      throw error

  } finally {
      deleteDir()
  }
}
